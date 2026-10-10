# =============================================================================
# R/ingestion.R — Inventaire et téléchargement des fichiers de l'AEI
#
# Deux modes (voir mode_execution() dans R/config.R) :
#   - "reel"     : Hugging Face via {aieconindex} (cache redirigé vers data/raw) ;
#   - "fixtures" : copie des fichiers FICTIFS de tests/fixtures/<release_id>/,
#                  organisés exactement comme sur Hugging Face.
# Le reste du pipeline ne voit aucune différence entre les deux modes.
# =============================================================================

#' Inventorier les fichiers publiés pour une version
#'
#' @param release Version au format ISO (`"2025-09-15"`), jamais `"latest"`.
#' @param mode `"reel"` ou `"fixtures"`.
#' @return Tibble : `release`, `chemin` (relatif au dossier de la version),
#'   `taille_octets`.
#' @export
inventorier_fichiers <- function(release, mode = mode_execution()) {
  release_id <- paste0("release_", gsub("-", "_", release))
  if (mode == "reel") {
    f <- tibble::as_tibble(as.data.frame(aieconindex::aei_files(release, recursive = TRUE)))
    f <- dplyr::filter(f, .data$type == "file")
    chemin <- sub(paste0("^", release_id, "/"), "", f$path)
    taille <- f$size_bytes
  } else {
    racine <- file.path(chemins()$fixtures, release_id)
    chemin <- list.files(racine, recursive = TRUE)
    chemin <- chemin[!grepl("README", chemin)]
    taille <- file.size(file.path(racine, chemin))
  }
  tibble::tibble(release = release, chemin = chemin, taille_octets = taille)
}

#' Choisir les fichiers utiles d'une version
#'
#' Règles écrites APRÈS inspection des données réelles
#' (docs/exploration/exploration.md) :
#' - la documentation officielle (`*.md`) est toujours récupérée ;
#' - le reste dépend de l'époque de schéma (voir `fichiers_utiles_regex()`).
#'
#' @param inventaire Sortie de `inventorier_fichiers()`.
#' @return L'inventaire filtré.
#' @export
selectionner_fichiers <- function(inventaire, schema_attendu) {
  motif <- fichiers_utiles_regex(schema_attendu)
  dplyr::filter(inventaire, grepl(motif, .data$chemin))
}

#' Télécharger (ou copier) les fichiers retenus
#'
#' @return Chemins locaux des fichiers (cible `format = "file"`).
#' @export
telecharger_fichiers <- function(inventaire, release, schema_attendu,
                                 mode = mode_execution()) {
  retenus <- selectionner_fichiers(inventaire, schema_attendu)
  if (nrow(retenus) == 0) {
    cli::cli_abort("Aucun fichier utile trouvé pour la version {.val {release}}.")
  }
  release_id <- paste0("release_", gsub("-", "_", release))
  if (mode == "reel") {
    # .aei_fetch_file() télécharge dans le cache (data/raw/<release_id>/...)
    # SANS lire le CSV en mémoire, contrairement à aei_download() qui le
    # parse avec read.csv() : inutile et lent sur des fichiers de > 200 Mo.
    # Fonction interne du package : on l'isole ici pour pouvoir l'adapter si
    # {aieconindex} évolue.
    purrr::map_chr(retenus$chemin, \(p) aieconindex:::.aei_fetch_file(
      release_id, p, quiet = TRUE))
  } else {
    dest <- file.path(chemins()$brut, release_id, retenus$chemin)
    purrr::walk(unique(dirname(dest)), dir.create, recursive = TRUE,
                showWarnings = FALSE)
    file.copy(file.path(chemins()$fixtures, release_id, retenus$chemin), dest,
              overwrite = TRUE)
    dest
  }
}

#' Importer les tables « labor market impacts » en Parquet
#'
#' Dossier non daté sur Hugging Face : on horodate l'import (colonne
#' `date_import`) pour garder une trace de la version utilisée.
#'
#' @return Chemins des deux fichiers Parquet.
#' @export
importer_marche_travail <- function(dossier, mode = mode_execution()) {
  dir.create(dossier, recursive = TRUE, showWarnings = FALSE)
  purrr::map_chr(c("job_exposure", "task_penetration"), \(t) {
    src <- if (mode == "reel") {
      aieconindex:::.aei_fetch_file("labor_market_impacts", paste0(t, ".csv"), quiet = TRUE)
    } else {
      file.path(chemins()$fixtures, "labor_market_impacts", paste0(t, ".csv"))
    }
    # Lecture avec arrow : types inférés sur tout le fichier, colonnes texte
    # conservées (les codes SOC du type "13-2031" ne doivent pas devenir des
    # nombres).
    tab <- arrow::read_csv_arrow(src, as_data_frame = TRUE)
    tab$date_import <- Sys.Date()
    dest <- file.path(dossier, paste0(t, ".parquet"))
    arrow::write_parquet(tab, dest, compression = "zstd")
    dest
  })
}
