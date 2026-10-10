# =============================================================================
# R/config.R — Paramètres centraux du projet
#
# POURQUOI un fichier unique ? Tous les choix « politiques » du projet (versions
# épinglées, pays comparés, chemins, palette) sont ici. Changer un paramètre ici
# suffit : {targets} détecte la modification et ne recalcule que ce qui en
# dépend.
#
# RAPPEL MÉTHODOLOGIQUE : l'Anthropic Economic Index mesure l'USAGE de Claude
# (conversations classées par tâche O*NET), pas l'emploi.
# =============================================================================

#' Versions de l'Anthropic Economic Index épinglées pour l'analyse
#'
#' On n'utilise JAMAIS `"latest"` dans le pipeline : une nouvelle publication
#' d'Anthropic ne doit pas changer silencieusement les résultats. Pour intégrer
#' une nouvelle version, on l'ajoute ici explicitement (et on vérifie son schéma
#' dans `docs/dictionnaire_donnees.md`).
#'
#' L'époque de schéma (`wide`, `long`, `monthly`) reprend la classification du
#' code d'{aieconindex} (`.aei_release_schema()`). Elle est revérifiée sur les
#' données réelles par `detecter_schema()` (R/harmonisation.R).
#'
#' @return Un tibble : `release` (date ISO), `release_id` (nom du dossier
#'   Hugging Face), `schema_attendu`, `geo_disponible`.
#' @export
aei_versions_epinglees <- function() {
  tibble::tibble(
    release = c("2025-02-10", "2025-03-27", "2025-09-15",
                "2026-01-15", "2026-03-24", "2026-06-26"),
    release_id = paste0("release_", gsub("-", "_", release)),
    # Époques de schéma : voir docs/diagnostic_env.md, § 5.
    schema_attendu = c("wide", "wide", "long", "long", "long", "monthly"),
    # Les données géographiques n'existent qu'à partir de 2025-09-15.
    geo_disponible = as.Date(release) >= as.Date("2025-09-15")
  )
}

#' Sources de trafic proposées par {aieconindex}
#'
#' `claude_ai` : produit grand public Claude.ai ; `1p_api` : API « first-party »
#' d'Anthropic. Toutes les versions ne publient pas les deux sources : le
#' pipeline consigne ce qui est réellement disponible (inventaire des fichiers).
#' @export
aei_sources <- function() c("claude_ai", "1p_api")

#' Pays de comparaison (codes ISO 3166-1 alpha-3)
#'
#' La France et ses principaux voisins européens, plus les États-Unis comme
#' référence (premier marché de Claude). Codes au format des colonnes `geo_id`
#' de l'AEI (ISO-3, d'après la documentation d'{aieconindex}).
#' @export
pays_comparaison <- function() {
  c(FRA = "France", DEU = "Allemagne", GBR = "Royaume-Uni", ESP = "Espagne",
    ITA = "Italie", BEL = "Belgique", NLD = "Pays-Bas", USA = "États-Unis")
}

#' Chemins du projet
#'
#' Centraliser les chemins évite les chaînes en dur dispersées dans le code.
#' `here`-like sans dépendance : tout est relatif à la racine du projet, qui est
#' le répertoire de travail de {targets} et de Quarto.
#' @export
chemins <- function() {
  list(
    brut     = "data/raw",           # copies locales des CSV (ignoré par git)
    parquet  = "data/parquet",       # jeu Parquet partitionné (ignoré par git)
    duckdb   = "data/aei.duckdb",    # base de vues DuckDB (ignorée par git)
    sql      = "sql",                # requêtes nommées
    fixtures = "tests/fixtures"      # données fictives pour tests et dév. local
  )
}

#' Mode d'exécution du pipeline : données réelles ou fixtures
#'
#' - `"reel"` (défaut) : téléchargement depuis Hugging Face via {aieconindex}.
#' - `"fixtures"` : jeu FICTIF de `tests/fixtures/`, utilisé quand le réseau est
#'   bloqué (conteneur de développement) et pour les tests. Les résultats
#'   produits dans ce mode n'ont AUCUNE valeur analytique.
#'
#' Se règle avec la variable d'environnement `AEI_MODE`.
#' @export
mode_execution <- function() {
  mode <- Sys.getenv("AEI_MODE", unset = "reel")
  rlang::arg_match0(mode, c("reel", "fixtures"), arg_nm = "AEI_MODE")
}

# -----------------------------------------------------------------------------
# Palette graphique commune (site, dashboard, rapport)
# -----------------------------------------------------------------------------
# Palette catégorielle à 8 couleurs VALIDÉE par calcul (séparation pour les
# daltonismes deutéranopie/protanopie/tritanopie, plancher en vision normale,
# bande de luminosité) — voir docs/SYNTHESE_TECHNIQUES.md. Une couleur suit
# toujours la même entité (un pays garde sa couleur partout), jamais son rang.
# L'ORDRE des emplacements fait partie de la validation : ne pas le permuter.
# Trois couleurs (aqua, jaune, magenta) ont un contraste < 3:1 sur fond clair :
# règle de compensation = étiquettes directes ou tableau associé.

#' Couleurs fixes par pays (ISO-3), mode clair
#' @export
palette_pays <- function() {
  c(FRA = "#2a78d6", DEU = "#eb6834", GBR = "#1baf7a", ESP = "#eda100",
    ITA = "#e87ba4", BEL = "#008300", NLD = "#6250d6", USA = "#e34948")
}

#' Couleurs des trois familles de métiers du chiffre (sujet 3), reprises des
#' trois premières teintes validées de `palette_pays()`
#' @export
palette_familles <- function() {
  p <- unname(palette_pays())
  c(`Budget et pilotage` = p[1], `Comptabilité et paie` = p[2],
    `Analyse, contrôle et fiscalité` = p[3])
}

#' Les mêmes teintes, pas ajustés pour le fond sombre
#' @export
palette_pays_sombre <- function() {
  c(FRA = "#3987e5", DEU = "#d95926", GBR = "#199e70", ESP = "#c98500",
    ITA = "#d55181", BEL = "#008300", NLD = "#9085e9", USA = "#e66767")
}

#' Couleurs des familles de collaboration (sujet 2)
#'
#' Paire opposée chaud/froid : orange = automatisation, bleu = augmentation.
#' @export
palette_collaboration <- function() {
  c(automatisation = "#eb6834", augmentation = "#2a78d6", `hors champ` = "#898781")
}

#' Rampe séquentielle (une seule teinte, clair -> foncé) pour les heatmaps
#' @export
rampe_sequentielle <- function() {
  c("#cde2fb", "#9ec5f4", "#6da7ec", "#3987e5", "#256abf", "#184f95", "#0d366b")
}

#' Paire divergente bleu <-> rouge, milieu gris neutre
#' @export
palette_divergente <- function() {
  c(bas = "#2a78d6", milieu = "#f0efec", haut = "#e34948")
}

#' Encres et surfaces (partagées avec le thème Quarto, _brand / SCSS)
#' @export
palette_interface <- function() {
  c(accent = "#2a78d6", texte = "#0b0b0b", texte_2 = "#52514e", discret = "#898781",
    grille = "#e1e0d9", axe = "#c3c2b7", surface = "#fcfcfb", fond = "#f9f9f7",
    contexte = "#c3c2b7")
}

# -----------------------------------------------------------------------------
# Fichiers retenus par version (établi après inspection : docs/exploration/)
# -----------------------------------------------------------------------------

#' Expressions régulières des fichiers utiles, par version
#'
#' Chemins RELATIFS au dossier de la version sur Hugging Face. Choix motivés
#' dans docs/dictionnaire_donnees.md :
#' - 2025-02-10 : parts des tâches et modes de collaboration (rapport 1) ;
#' - 2025-03-27 : fichiers « v2 » (Claude 3.7 Sonnet) ; les « v1 » sont des
#'   copies de 2025-02-10 et sont écartés pour éviter les doublons ;
#' - 2025-09-15 : fichier ENRICHED pour Claude.ai (codes pays ISO-3, parts SOC,
#'   indice d'usage par habitant), RAW pour l'API (seul publié), et
#'   référentiels (tâches O*NET, structure SOC, codes ISO, population) ;
#' - 2026-01-15 et 2026-03-24 : seuls des fichiers RAW sont publiés (codes
#'   pays ISO-2) ;
#' - 2026-06-26 : schéma mensuel, un fichier par source.
#' @export
fichiers_par_version <- function() {
  c(
    "2025-02-10" = "^(onet_task_mappings|automation_vs_augmentation)\\.csv$",
    "2025-03-27" = paste0("^(task_pct_v2|automation_vs_augmentation_v2",
                          "|automation_vs_augmentation_by_task)\\.csv$"),
    "2025-09-15" = paste0(
      "^(data/output/aei_enriched_claude_ai_.*\\.csv|data/intermediate/aei_raw_1p_api_.*\\.csv",
      "|data/intermediate/(onet_task_statements|soc_structure|iso_country_codes",
      "|working_age_pop_2024_country)\\.csv|data_documentation\\.md)$"),
    "2026-01-15" = paste0("^(data/intermediate/aei_raw_(claude_ai|1p_api)_.*\\.csv",
                          "|data_documentation\\.md)$"),
    "2026-03-24" = "^(data/aei_raw_(claude_ai|1p_api)_.*\\.csv|data_documentation\\.md)$",
    "2026-06-26" = "^(data/aei_(claude_ai|1p_api)_.*\\.csv|data_documentation\\.md)$"
  )
}

#' Fichiers « référentiels » (pas des données d'usage)
#'
#' Repérés par leur nom : ils sont écrits à part (data/parquet/referentiels).
#' @export
motif_referentiels <- function() {
  "(onet_task_statements|soc_structure|iso_country_codes|working_age_pop_2024_country)\\.csv$"
}

#' Grands groupes de la nomenclature SOC 2018 (codes à 2 chiffres)
#'
#' Libellés anglais tels qu'ils figurent dans les données (facette
#' `soc_occupation`), et traduction française PROPOSÉE par le projet (ce n'est
#' pas une nomenclature officielle française). Le groupe 55 (métiers militaires)
#' existe dans la SOC mais n'a pas de tâches dans O*NET : il n'apparaît pas
#' dans les données d'usage.
#' @export
groupes_soc <- function() {
  tibble::tribble(
    ~soc_majeur, ~libelle_en, ~libelle_fr,
    "11", "Management", "Direction et encadrement",
    "13", "Business and Financial Operations", "Gestion, finance et affaires",
    "15", "Computer and Mathematical", "Informatique et mathématiques",
    "17", "Architecture and Engineering", "Architecture et ingénierie",
    "19", "Life, Physical, and Social Science", "Sciences (vie, physique, sociales)",
    "21", "Community and Social Service", "Action sociale",
    "23", "Legal", "Droit",
    "25", "Educational Instruction and Library", "Enseignement et documentation",
    "27", "Arts, Design, Entertainment, Sports, and Media", "Arts, design, médias et sport",
    "29", "Healthcare Practitioners and Technical", "Professions de santé",
    "31", "Healthcare Support", "Aide aux soins",
    "33", "Protective Service", "Sécurité et protection",
    "35", "Food Preparation and Serving Related", "Restauration",
    "37", "Building and Grounds Cleaning and Maintenance", "Entretien des locaux et espaces",
    "39", "Personal Care and Service", "Services à la personne",
    "41", "Sales and Related", "Vente",
    "43", "Office and Administrative Support", "Soutien administratif",
    "45", "Farming, Fishing, and Forestry", "Agriculture, pêche et forêt",
    "47", "Construction and Extraction", "Construction et extraction",
    "49", "Installation, Maintenance, and Repair", "Installation, maintenance, réparation",
    "51", "Production", "Production industrielle",
    "53", "Transportation and Material Moving", "Transport et manutention",
    "55", "Military Specific", "Métiers militaires"
  )
}

#' Modes de collaboration humain–IA et leur regroupement
#'
#' Définition d'Anthropic (data_documentation.md de 2025-09-15) :
#' automatisation = directive + feedback loop ; augmentation = task iteration
#' + learning + validation. `none` et `not_classified` sont hors champ (la part
#' d'automatisation est calculée sur les conversations classables).
#' @export
modes_collaboration <- function() {
  tibble::tribble(
    ~mode, ~libelle_fr, ~famille,
    "directive", "Directive", "automatisation",
    "feedback loop", "Boucle de rétroaction", "automatisation",
    "task iteration", "Itération sur la tâche", "augmentation",
    "learning", "Apprentissage", "augmentation",
    "validation", "Validation", "augmentation",
    "none", "Aucun", "hors champ",
    "not_classified", "Non classé", "hors champ"
  )
}

#' Dernière version épinglée (référence des analyses « en coupe »)
#' @export
derniere_version <- function() utils::tail(aei_versions_epinglees()$release, 1)
