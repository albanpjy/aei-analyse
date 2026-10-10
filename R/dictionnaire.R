# =============================================================================
# R/dictionnaire.R — Génération du dictionnaire de données
#
# Le dictionnaire est GÉNÉRÉ à partir de ce qui est réellement présent dans
# les données (inventaire des fichiers, facettes et variables observées) :
# aucun nom n'y est saisi à la main. Le texte explicatif (correspondances
# entre schémas) est dans docs/dictionnaire_entete.md, rédigé après
# inspection et repris en tête du document.
# =============================================================================

#' Écrire docs/dictionnaire_donnees.md
#'
#' En mode fixtures, le fichier est écrit dans data/ (ignoré par git) pour ne
#' jamais écraser le dictionnaire des données réelles.
#'
#' @param inventaire Inventaire de toutes les versions.
#' @param base Chemin de la base DuckDB.
#' @param chemin Fichier de sortie (mode réel).
#' @return Le chemin écrit.
#' @export
ecrire_dictionnaire <- function(inventaire, base, chemin, mode = mode_execution()) {
  if (mode != "reel") chemin <- "data/dictionnaire_donnees_FIXTURES.md"
  con <- connexion_duckdb(base)
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE), add = TRUE)
  resume <- DBI::dbGetQuery(con, sql_nommee("resume_harmonise"))
  colonnes <- DBI::dbGetQuery(con, "DESCRIBE usage")

  md_table <- function(df) {
    df[] <- lapply(df, \(x) gsub("\\|", "\\\\|", format(x, big.mark = " ")))
    c(paste0("| ", paste(names(df), collapse = " | "), " |"),
      paste0("|", strrep("---|", ncol(df))),
      apply(df, 1, \(r) paste0("| ", paste(r, collapse = " | "), " |")))
  }
  entete <- character()
  if (file.exists("docs/dictionnaire_entete.md")) {
    entete <- readLines("docs/dictionnaire_entete.md", encoding = "UTF-8")
  }

  inv <- inventaire |>
    dplyr::mutate(retenu = purrr::map2_lgl(.data$chemin, .data$release, \(c, r) {
      grepl(fichiers_par_version()[[r]], c)
    }),
      taille_mo = round(.data$taille_octets / 1024^2, 2)) |>
    dplyr::select("release", "chemin", "taille_mo", "retenu")

  lignes <- c(
    entete, "",
    sprintf("*Partie générée automatiquement par `ecrire_dictionnaire()` le %s (mode %s).*",
            format(Sys.Date()), mode), "",
    "## Colonnes de la table harmonisée (`data/parquet/usage`)", "",
    md_table(colonnes[c("column_name", "column_type")]), "",
    "## Combinaisons observées (version × source × niveau × facette × variable)", "",
    md_table(resume[c("release", "schema", "source", "geo_level", "facet", "variable",
                      "n_lignes", "n_geo", "n_items")]), "",
    "## Inventaire des fichiers publiés", "",
    "Colonne `retenu` : fichier utilisé par le pipeline (règles de",
    "`fichiers_par_version()`, R/config.R).", "",
    md_table(as.data.frame(inv))
  )
  dir.create(dirname(chemin), recursive = TRUE, showWarnings = FALSE)
  writeLines(lignes, chemin, useBytes = TRUE)
  chemin
}
