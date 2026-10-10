# =============================================================================
# R/cibles_analyses.R — Cibles {targets} des tables d'analyse (phase 3)
#
# Appelée par _targets.R (via `cibles_analyses()`). Chaque table est une cible :
# les documents Quarto la lisent avec tar_read(), ce qui garantit que le texte
# et les chiffres viennent du même calcul (aucun chiffre écrit en dur).
# =============================================================================

#' Liste des cibles d'analyse
#' @export
cibles_analyses <- function() {
  list(
    # Sujet 1 — La France face à Claude
    targets::tar_target(t1_usage_pays, s1_usage_pays(base_duckdb)),
    targets::tar_target(
      t1_top_taches,
      s1_top_taches(base_duckdb, release = derniere_version(), n = 15)
    ),
    targets::tar_target(t1_soc_pays, s1_soc_pays(base_duckdb)),
    targets::tar_target(t1_concentration, s1_concentration(base_duckdb)),
    targets::tar_target(
      t1_comparaison,
      s1_comparer(base_duckdb, a = "2026-01-15", b = "2026-03-24", pays_iso3 = "FRA")
    ),
    # Sujet 2 — Automatisation vs augmentation
    targets::tar_target(t2_global, s2_global(base_duckdb)),
    targets::tar_target(t2_modes, s2_modes(base_duckdb)),
    targets::tar_target(t2_pays, s2_pays(base_duckdb)),
    targets::tar_target(t2_soc, s2_soc(base_duckdb)),
    # Sujet 3 — Métiers du chiffre (finance, budget, comptabilité)
    targets::tar_target(t3_exposition, s3_exposition(base_duckdb)),
    targets::tar_target(t3_taches, s3_taches(base_duckdb)),
    targets::tar_target(t3_usage, s3_usage(base_duckdb)),
    targets::tar_target(t3_automatisation, s3_automatisation(base_duckdb)),
    # Sujet 4 — Typologie des pays
    targets::tar_target(t4_matrice, s4_matrice(base_duckdb, release = derniere_version())),
    targets::tar_target(t4_typologie, s4_typologie(t4_matrice, banque_mondiale)),
    # Parquet publiés avec le site pour le tableau de bord (DuckDB-WASM)
    targets::tar_target(donnees_publiees, publier_donnees(base_duckdb), format = "file"),
    # Export CSV des tables (sans les objets statistiques volumineux)
    targets::tar_target(
      resultats_csv,
      exporter_resultats(list(
        s1_usage_pays = t1_usage_pays, s1_top_taches_france = t1_top_taches,
        s1_soc_pays = t1_soc_pays, s1_concentration = t1_concentration,
        s1_comparaison_france = t1_comparaison, s2_global = t2_global,
        s2_modes = t2_modes, s2_pays = t2_pays, s2_soc = t2_soc,
        s3_exposition_cibles = t3_exposition$cibles, s3_taches = t3_taches,
        s3_usage = t3_usage, s3_automatisation = t3_automatisation,
        s4_typologie_pays = t4_typologie$croise,
        s4_valeurs_propres = tibble::as_tibble(t4_typologie$acp$eig, rownames = "axe"),
        s4_couverture = t4_matrice$couverture,
        s4_couverture_gwa = requete(base_duckdb, "s4_gwa_pays", version = derniere_version()) |>
          dplyr::count(.data$gwa_code, .data$gwa, name = "n_pays")
      )),
      format = "file"
    )
  )
}

#' Exporter les tables d'analyse en CSV (versionnées dans docs/resultats/)
#'
#' Rend les résultats lisibles sans R (et consultables depuis le dépôt). En
#' mode fixtures, l'export va dans data/ (ignoré par git).
#' @export
exporter_resultats <- function(tables, mode = mode_execution()) {
  dossier <- if (mode == "reel") "docs/resultats" else "data/resultats_FIXTURES"
  dir.create(dossier, recursive = TRUE, showWarnings = FALSE)
  purrr::imap_chr(tables, \(t, nom) {
    f <- file.path(dossier, paste0(nom, ".csv"))
    readr::write_csv(t, f, na = "")
    f
  }) |> unname()
}
