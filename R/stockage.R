# =============================================================================
# R/stockage.R — Parquet (arrow) et base DuckDB de vues
#
# Architecture « lac de données » minimaliste :
#   - les données harmonisées sont écrites en Parquet, compressé en zstd,
#     partitionné par version (`release=AAAA-MM-JJ/part-0.parquet`, convention
#     « hive ») ;
#   - DuckDB ne COPIE pas les données : la base `data/aei.duckdb` ne contient
#     que des VUES qui lisent les Parquet à la demande. La base pèse quelques
#     Ko, et les mêmes Parquet sont lus par le dashboard (DuckDB-WASM).
# =============================================================================

#' Écrire une table harmonisée en Parquet partitionné par version
#'
#' @param donnees Data frame (ou Table arrow) contenant une colonne `release`.
#' @param dossier Racine du jeu Parquet (ex. `data/parquet/usage`).
#' @return Les chemins des fichiers Parquet de la (des) partition(s) écrite(s),
#'   pour une cible `format = "file"`.
#' @export
ecrire_parquet <- function(donnees, dossier) {
  stopifnot("release" %in% names(donnees))
  dir.create(dossier, recursive = TRUE, showWarnings = FALSE)
  arrow::write_dataset(
    donnees,
    path = dossier,
    format = "parquet",
    partitioning = "release",
    # zstd : meilleur compromis taux de compression / vitesse de lecture que
    # snappy (défaut d'arrow) pour des colonnes texte très répétitives.
    compression = "zstd",
    # Ne remplace que les partitions présentes dans `donnees` : réécrire une
    # version ne touche pas aux autres.
    existing_data_behavior = "delete_matching",
    basename_template = "part-{i}.parquet"
  )
  releases <- unique(as.character(dplyr::pull(dplyr::distinct(
    dplyr::select(dplyr::as_tibble(donnees), "release")), "release")))
  sort(unlist(lapply(releases, \(r) {
    list.files(file.path(dossier, paste0("release=", r)), full.names = TRUE)
  })))
}

#' Lire une requête SQL nommée du dossier sql/
#'
#' @param nom Nom du fichier sans extension (ex. `"vue_usage_pays"`).
#' @param ... Paramètres `glue` à substituer (`{param}` dans le fichier).
#' @return La requête (chaîne de caractères).
#' @export
sql_nommee <- function(.nom, ..., dossier = chemins()$sql) {
  chemin <- file.path(dossier, paste0(.nom, ".sql"))
  if (!file.exists(chemin)) cli::cli_abort("Requête SQL introuvable : {.path {chemin}}")
  requete <- paste(readLines(chemin, encoding = "UTF-8"), collapse = "\n")
  params <- list(...)
  if (length(params)) requete <- glue::glue_data(params, requete, .open = "{{", .close = "}}")
  as.character(requete)
}

#' Ouvrir une connexion DuckDB sur la base du projet
#'
#' @param lecture_seule `TRUE` par défaut : plusieurs processus (rendus Quarto
#'   en parallèle) peuvent alors lire la même base sans verrou d'écriture.
#' @export
connexion_duckdb <- function(chemin = chemins()$duckdb, lecture_seule = TRUE) {
  # shared_home = FALSE : pas de répertoire personnel partagé pour les
  # extensions (parquet est intégré au moteur, aucune extension à télécharger).
  DBI::dbConnect(duckdb::duckdb(shared_home = FALSE), dbdir = chemin,
                 read_only = lecture_seule)
}

#' Construire la base DuckDB : des vues sur les Parquet + les vues SQL nommées
#'
#' La base est reconstruite de zéro à chaque exécution (quelques
#' millisecondes : aucune donnée n'est copiée).
#'
#' Les chemins dans les vues sont RELATIFS à la racine du projet : toutes les
#' lectures se font depuis cette racine (`execute-dir: project` dans Quarto).
#'
#' @param parquet Chemins des fichiers Parquet (dépendance {targets} : la
#'   base est reconstruite si un Parquet change).
#' @param fichiers_sql Fichiers `sql/vue_*.sql` exécutés dans l'ordre
#'   alphabétique (d'où la numérotation `vue_01_...`).
#' @return Le chemin de la base.
#' @export
construire_duckdb <- function(parquet, fichiers_sql, chemin = chemins()$duckdb) {
  force(parquet)
  dir.create(dirname(chemin), recursive = TRUE, showWarnings = FALSE)
  unlink(c(chemin, paste0(chemin, ".wal")))
  con <- connexion_duckdb(chemin, lecture_seule = FALSE)
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE), add = TRUE)

  racine <- chemins()$parquet
  # Vue « socle » : toutes les versions d'un coup. hive_partitioning = true
  # transforme le dossier `release=2025-09-15` en colonne `release`.
  # union_by_name = true : les partitions dont le schéma diffère légèrement
  # (colonne absente d'une version) sont alignées par nom de colonne.
  # hive_types_autocast = false : sinon DuckDB devine le type de la
  # partition et `release=2025-09-15` devient une DATE ; on garde du texte,
  # comme dans le reste du projet.
  DBI::dbExecute(con, glue::glue("
    CREATE VIEW usage AS
    SELECT * FROM read_parquet('{racine}/usage/*/*.parquet',
                               hive_partitioning = true,
                               hive_types_autocast = false,
                               union_by_name = true)"))
  for (t in c("job_exposure", "task_penetration")) {
    f <- file.path(racine, "marche_travail", paste0(t, ".parquet"))
    if (file.exists(f)) {
      DBI::dbExecute(con, glue::glue(
        "CREATE VIEW {t} AS SELECT * FROM read_parquet('{f}')"))
    }
  }
  # Vues d'analyse définies en SQL pur (sql/vue_*.sql).
  for (f in sort(fichiers_sql[grepl("^vue_", basename(fichiers_sql))])) {
    DBI::dbExecute(con, paste(readLines(f, encoding = "UTF-8"), collapse = "\n"))
  }
  chemin
}

#' Résumer la table harmonisée (contrôle et dictionnaire)
#'
#' @param base Chemin de la base DuckDB (dépendance {targets}).
#' @return Tibble : effectifs par version, schéma, source, niveau
#'   géographique, facette et variable.
#' @export
resumer_table_harmonisee <- function(base) {
  con <- connexion_duckdb(base)
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE), add = TRUE)
  DBI::dbGetQuery(con, sql_nommee("resume_harmonise")) |> tibble::as_tibble()
}

#' Publier les Parquet lus par le tableau de bord (DuckDB-WASM)
#'
#' @param base Chemin de la base DuckDB.
#' @param dossier Dossier publié avec le site (ressource Quarto).
#' @return Chemins des fichiers écrits.
#' @export
publier_donnees <- function(base, dossier = "donnees_publiees") {
  dir.create(dossier, showWarnings = FALSE)
  unlink(list.files(dossier, "\\.parquet$", full.names = TRUE))
  con <- connexion_duckdb(base)
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE), add = TRUE)
  DBI::dbExecute(con, sql_nommee("publication", sortie = dossier))
  list.files(dossier, "\\.parquet$", full.names = TRUE)
}
