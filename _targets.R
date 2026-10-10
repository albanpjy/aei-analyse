# =============================================================================
# _targets.R — Pipeline reproductible du projet aei-analyse
#
# {targets} est un « make » pour R : chaque cible (target) est un résultat
# intermédiaire mis en cache dans `_targets/`. Quand on relance `tar_make()`,
# seules les cibles dont le code, les données ou les dépendances ont changé
# sont recalculées.
#
# Chaîne de traitement :
#
#   versions épinglées
#        │
#        ├─► inventaire des fichiers (aei_files)          ─┐
#        ├─► téléchargement des CSV (aei_download)         │  une branche
#        ├─► harmonisation du schéma + Parquet (arrow)     │  par version
#        │                                                ─┘  (tar_map)
#        ├─► tables « marché du travail » (non datées) ─► Parquet
#        ├─► base DuckDB (vues sur les Parquet)
#        ├─► dictionnaire de données (docs/dictionnaire_donnees.md)
#        ├─► tables d'analyse (4 sujets)
#        └─► rendus Quarto : site, dashboard, rapport PDF
#
# Commandes utiles :
#   targets::tar_make()          # exécuter (ou mettre à jour) le pipeline
#   targets::tar_visnetwork()    # graphe des dépendances
#   targets::tar_manifest()      # liste des cibles et de leurs commandes
#   targets::tar_read(nom)       # lire le résultat d'une cible
#   Sys.setenv(AEI_MODE = "fixtures"); targets::tar_make()  # sans réseau
#
# RAPPEL : données d'USAGE de Claude, pas données d'emploi.
# =============================================================================

library(targets)
library(tarchetypes)

# Toutes les fonctions du projet sont dans R/ : on les charge ici. {targets}
# suit leur code. Modifier une fonction invalide les cibles qui l'utilisent.
tar_source("R")

tar_option_set(
  packages = c("dplyr", "tidyr", "purrr", "stringr", "tibble", "arrow",
               "duckdb", "DBI", "aieconindex"),
  # qs serait plus rapide, mais rds évite une dépendance de plus.
  format = "rds",
  # En cas d'erreur, on garde les autres branches calculées (utile quand une
  # seule version de l'AEI pose problème).
  error = "continue"
)

# Le cache d'{aieconindex} est redirigé vers data/raw/ : les CSV téléchargés
# restent dans le projet (ignorés par git) et peuvent être mis en cache par
# GitHub Actions entre deux exécutions.
options(aieconindex.cache_dir = normalizePath(chemins()$brut, mustWork = FALSE))

# Table des versions, connue AVANT l'exécution du pipeline : tar_map() en a
# besoin pour créer une branche statique par version (noms lisibles du type
# `parquet_2025_09_15`).
versions <- aei_versions_epinglees()

# -----------------------------------------------------------------------------
# 1. Ingestion : une branche par version épinglée
# -----------------------------------------------------------------------------
cibles_par_version <- tar_map(
  values = dplyr::transmute(
    versions,
    release,
    schema_attendu,
    suffixe = gsub("-", "_", release)
  ),
  names = "suffixe",

  # Inventaire exhaustif des fichiers publiés pour la version (chemin, type,
  # taille). Sert à choisir les fichiers ET à documenter ce qui existe.
  # cue = "always" en mode réel : on revérifie la liste à chaque exécution,
  # car Anthropic peut corriger une version en place.
  tar_target(
    inventaire,
    inventorier_fichiers(release, mode = mode_execution()),
    cue = tar_cue(mode = if (mode_execution() == "reel") "always" else "thorough")
  ),

  # Téléchargement (ou copie des fixtures) des fichiers retenus. On renvoie
  # les CHEMINS locaux, déclarés `format = "file"` : {targets} surveille alors
  # le contenu des fichiers (empreinte), pas seulement l'objet R.
  tar_target(
    fichiers_bruts,
    telecharger_fichiers(inventaire, release, mode = mode_execution()),
    format = "file"
  ),

  # Harmonisation du schéma (wide / long / monthly) vers une table longue
  # commune, puis écriture Parquet partitionnée `release=AAAA-MM-JJ`.
  tar_target(
    parquet,
    convertir_en_parquet(
      fichiers_bruts,
      release = release,
      schema_attendu = schema_attendu,
      dossier = file.path(chemins()$parquet, "usage")
    ),
    format = "file"
  )
)

# -----------------------------------------------------------------------------
# 2. Tables complémentaires (non datées)
# -----------------------------------------------------------------------------
cibles_complementaires <- list(
  # Tables « labor market impacts » : exposition des métiers (SOC) et
  # pénétration des tâches (O*NET). Le dossier n'est PAS daté côté Anthropic :
  # on enregistre la date de téléchargement dans le Parquet.
  tar_target(
    marche_travail,
    importer_marche_travail(
      dossier = file.path(chemins()$parquet, "marche_travail"),
      mode = mode_execution()
    ),
    format = "file"
  )
)

# -----------------------------------------------------------------------------
# 3. Stockage analytique : base DuckDB de VUES sur les Parquet
# -----------------------------------------------------------------------------
cibles_stockage <- list(
  # Requêtes SQL nommées : suivies comme fichiers pour que toute modification
  # d'une requête invalide la base et les analyses qui en dépendent.
  tar_target(fichiers_sql, list.files(chemins()$sql, "\\.sql$", full.names = TRUE),
             format = "file"),

  tar_target(
    base_duckdb,
    construire_duckdb(
      parquet = c(!!!rlang::syms(paste0("parquet_", gsub("-", "_", versions$release))),
                  marche_travail),
      fichiers_sql = fichiers_sql,
      chemin = chemins()$duckdb
    ),
    format = "file"
  ),

  # Table harmonisée multi-versions (release, date, pays, facette, variable,
  # valeur) : petite projection de la vue DuckDB, rapatriée en R pour les
  # analyses et les tests.
  tar_target(harmonise, lire_table_harmonisee(base_duckdb)),

  # Dictionnaire de données généré à partir de l'inventaire et des valeurs
  # RÉELLEMENT observées (facettes, variables). Aucun nom n'est supposé.
  tar_target(
    dictionnaire,
    ecrire_dictionnaire(
      inventaire = dplyr::bind_rows(
        !!!rlang::syms(paste0("inventaire_", gsub("-", "_", versions$release)))
      ),
      base = base_duckdb,
      chemin = "docs/dictionnaire_donnees.md"
    ),
    format = "file"
  )
)

# -----------------------------------------------------------------------------
# 4. Tables d'analyse (phase 3) et 5. Rendus Quarto (phases 4 à 6)
# -----------------------------------------------------------------------------
# Ces cibles sont ajoutées par les fichiers R/cibles_*.R au fur et à mesure que
# les analyses et les documents Quarto existent. Chacun définit une fonction
# `cibles_<bloc>()` renvoyant une liste de cibles.
cibles_aval <- purrr::map(
  intersect(c("cibles_analyses", "cibles_rendus"), ls()),
  \(f) get(f)()
)

# Le script doit se terminer par la liste de toutes les cibles.
list(
  cibles_par_version,
  cibles_complementaires,
  cibles_stockage,
  cibles_aval
)
