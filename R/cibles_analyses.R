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
    targets::tar_target(t1_top_taches, s1_top_taches(base_duckdb, release = derniere_version(), n = 15)),
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
    # Sujet 3 — Métiers budgétaires et financiers
    targets::tar_target(t3_exposition, s3_exposition(base_duckdb)),
    targets::tar_target(t3_taches, s3_taches(base_duckdb)),
    targets::tar_target(t3_usage, s3_usage(base_duckdb)),
    targets::tar_target(t3_militaire, s3_militaire(base_duckdb)),
    # Sujet 4 — Typologie des pays
    targets::tar_target(t4_matrice, s4_matrice(base_duckdb, release = derniere_version())),
    targets::tar_target(t4_typologie, s4_typologie(t4_matrice, banque_mondiale))
  )
}
