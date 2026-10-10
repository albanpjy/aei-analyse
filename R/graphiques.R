# =============================================================================
# R/graphiques.R — Thème et échelles ggplot2 communs à toutes les sorties
#
# Principes (voir docs/SYNTHESE_TECHNIQUES.md, § visualisation) :
#   - la couleur suit l'ENTITÉ (un pays garde sa couleur partout) ;
#   - grille et axes discrets, encres de texte neutres (jamais la couleur
#     d'une série pour du texte) ;
#   - une seule échelle par graphique (pas de double axe) ;
#   - ≥ 2 séries : légende ou étiquettes directes ; tableau associé quand une
#     couleur a un contraste < 3:1.
# =============================================================================

#' Thème ggplot2 du projet
#'
#' @param base_size Taille de police de base.
#' @return Un thème ggplot2.
#' @export
theme_aei <- function(base_size = 11) {
  ink <- palette_interface()
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      text = ggplot2::element_text(colour = ink[["texte"]]),
      plot.title = ggplot2::element_text(face = "bold", size = base_size * 1.15),
      plot.title.position = "plot",
      plot.subtitle = ggplot2::element_text(colour = ink[["texte_2"]]),
      plot.caption = ggplot2::element_text(colour = ink[["discret"]], hjust = 0,
                                           size = base_size * 0.8),
      plot.caption.position = "plot",
      axis.text = ggplot2::element_text(colour = ink[["texte_2"]]),
      axis.title = ggplot2::element_text(colour = ink[["texte_2"]]),
      panel.grid.major = ggplot2::element_line(colour = ink[["grille"]], linewidth = 0.3),
      panel.grid.minor = ggplot2::element_blank(),
      legend.position = "top",
      legend.justification = "left",
      legend.title = ggplot2::element_text(colour = ink[["texte_2"]]),
      strip.text = ggplot2::element_text(face = "bold", hjust = 0),
      plot.background = ggplot2::element_rect(fill = ink[["surface"]], colour = NA),
      panel.background = ggplot2::element_rect(fill = ink[["surface"]], colour = NA)
    )
}

#' Échelle de couleur fixe par pays
#' @export
scale_colour_pays <- function(...) {
  ggplot2::scale_colour_manual(values = palette_pays(), labels = pays_comparaison(),
                               na.value = palette_interface()[["contexte"]], ...)
}

#' @rdname scale_colour_pays
#' @export
scale_fill_pays <- function(...) {
  ggplot2::scale_fill_manual(values = palette_pays(), labels = pays_comparaison(),
                             na.value = palette_interface()[["contexte"]], ...)
}

#' Légende de source commune à toutes les figures
#'
#' Rappelle systématiquement la nature des données (usage, pas emploi).
#' @param extra Précision supplémentaire (version, calcul...).
#' @export
source_aei <- function(extra = NULL) {
  paste0(
    "Source : Anthropic Economic Index (CC-BY 4.0), via le package R aieconindex. ",
    "Données d'USAGE de Claude, pas d'emploi.",
    if (!is.null(extra)) paste0("\n", extra) else ""
  )
}

#' Formater un nombre à la française (espace des milliers, virgule décimale)
#'
#' Utilisé pour TOUS les chiffres insérés dans les textes (inline R).
#' @export
nombre_fr <- function(x, decimales = 1) {
  formatC(x, format = "f", digits = decimales, big.mark = " ", decimal.mark = ",")
}

#' Formater un pourcentage à la française
#' @export
pct_fr <- function(x, decimales = 1) paste0(nombre_fr(x, decimales), " %")

#' Nom français d'un pays à partir de son code ISO-3
#'
#' Pays de comparaison : libellés de `pays_comparaison()` ; autres pays : nom
#' anglais du référentiel GeoNames (fourni via `noms`).
#' @export
nom_pays <- function(iso3, noms = NULL) {
  fr <- pays_comparaison()
  out <- unname(fr[iso3])
  if (!is.null(noms)) {
    out[is.na(out)] <- noms$country_name[match(iso3[is.na(out)], noms$iso_alpha_3)]
  }
  ifelse(is.na(out), iso3, out)
}

#' Textes français des tableaux reactable
#'
#' À activer une fois par document : options(reactable.language = langue_reactable())
#' @export
langue_reactable <- function() {
  reactable::reactableLang(
    searchPlaceholder = "Rechercher…", searchLabel = "Rechercher",
    noData = "Aucune ligne", pageNext = "Suivant", pagePrevious = "Précédent",
    pageNumbers = "{page} sur {pages}", pageInfo = "{rowStart}–{rowEnd} sur {rows} lignes",
    pageSizeOptions = "Afficher {rows}", filterPlaceholder = "Filtrer…",
    groupExpandLabel = "Déplier le groupe", selectAllRowsLabel = "Tout sélectionner",
    selectRowLabel = "Sélectionner la ligne"
  )
}
