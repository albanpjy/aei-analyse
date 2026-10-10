# =============================================================================
# R/cibles_rendus.R — Cibles {targets} des rendus Quarto (phases 4 à 6)
#
# Une cible tar_quarto() PAR PAGE (et non un rendu global du projet) :
#   - {targets} détecte dans chaque document les tar_read()/tar_load() et ne
#     re-rend une page que si ses données ou sa source ont changé ;
#   - un rendu individuel force l'exécution du code, alors qu'un rendu global
#     réutiliserait les sorties gelées (_freeze/) : les chiffres suivent donc
#     toujours les données.
# =============================================================================

#' Documents Quarto du site (ordre de _quarto.yml), limités à ceux qui existent
#' @export
documents_quarto <- function() {
  docs <- yaml::read_yaml("_quarto.yml")$project$render
  docs[file.exists(docs)]
}

#' Liste des cibles de rendu
#' @export
cibles_rendus <- function() {
  if (!file.exists("_quarto.yml")) return(list())
  docs <- documents_quarto()
  noms <- paste0("rendu_", gsub("[^a-z0-9]+", "_", tolower(tools::file_path_sans_ext(docs))))
  purrr::map2(noms, docs, \(nom, doc) {
    # Profil « fixtures » en mode données fictives : sorties séparées, pas de gel
    # (_quarto-fixtures.yml).
    tarchetypes::tar_quarto_raw(
      nom, path = doc, quiet = TRUE,
      profile = if (mode_execution() == "fixtures") "fixtures" else NULL
    )
  })
}
