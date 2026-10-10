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
#' (docs/exploration/exploration.md), centralisées dans
#' `fichiers_par_version()` (R/config.R).
#'
#' @param inventaire Sortie de `inventorier_fichiers()`.
#' @return L'inventaire filtré.
#' @export
selectionner_fichiers <- function(inventaire, release) {
  motif <- fichiers_par_version()[[release]]
  if (is.null(motif)) cli::cli_abort("Version non épinglée : {.val {release}}.")
  dplyr::filter(inventaire, grepl(motif, .data$chemin))
}

#' Télécharger (ou copier) les fichiers retenus
#'
#' @return Chemins locaux des fichiers (cible `format = "file"`).
#' @export
telecharger_fichiers <- function(inventaire, release, mode = mode_execution()) {
  retenus <- selectionner_fichiers(inventaire, release)
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
    purrr::map_chr(retenus$chemin, \(p) {
      aieconindex:::.aei_fetch_file(release_id, p, quiet = TRUE)
    })
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

#' Importer le PIB par habitant (Banque mondiale)
#'
#' Indicateur NY.GDP.PCAP.PP.KD : PIB par habitant en parité de pouvoir
#' d'achat, dollars internationaux constants de 2021. Source : Banque
#' mondiale, World Development Indicators (licence CC-BY 4.0), via l'API
#' publique https://api.worldbank.org/v2/. On retient, pour chaque pays, la
#' dernière année disponible entre 2022 et 2025.
#'
#' @return Chemin du Parquet `pib_habitant.parquet`.
#' @export
importer_banque_mondiale <- function(dossier, mode = mode_execution()) {
  dir.create(dossier, recursive = TRUE, showWarnings = FALSE)
  brut <- if (mode == "reel") {
    url <- paste0("https://api.worldbank.org/v2/country/all/indicator/",
                  "NY.GDP.PCAP.PP.KD?format=json&per_page=20000&date=2022:2025")
    rep <- jsonlite::fromJSON(url)
    # La réponse est une liste : [[1]] métadonnées, [[2]] observations.
    tibble::tibble(iso3 = rep[[2]]$countryiso3code, annee = as.integer(rep[[2]]$date),
                   pib_hab_ppa = rep[[2]]$value)
  } else {
    f <- lire_csv_aei(file.path(chemins()$fixtures, "banque_mondiale", "NY.GDP.PCAP.PP.KD.csv"))
    tibble::tibble(iso3 = f$countryiso3code, annee = as.integer(f$date), pib_hab_ppa = f$value)
  }
  pib <- brut |>
    dplyr::filter(!is.na(.data$pib_hab_ppa), nchar(.data$iso3) == 3) |>
    dplyr::slice_max(.data$annee, n = 1, by = "iso3") |>
    dplyr::mutate(date_import = Sys.Date())
  dest <- file.path(dossier, "pib_habitant.parquet")
  arrow::write_parquet(pib, dest, compression = "zstd")
  dest
}
