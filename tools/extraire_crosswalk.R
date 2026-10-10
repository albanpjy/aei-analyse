# =============================================================================
# tools/extraire_crosswalk.R — Extrait la table de passage SOC 2010 -> ISCO-08
#
# Source : objet `soc10_isco08` du package R iscoCrosswalks 1.0.0 (licence MIT,
# Kouretsis & Bampouris), table de l'Institute for Structural Research (IBS)
# d'après la correspondance du Bureau of Labor Statistics. Le package a été
# retiré de CRAN : la table est donc EMBARQUÉE dans le dépôt
# (references_externes/soc2010_isco08.csv) pour que le pipeline ne dépende pas
# d'un package archivé. Ce script documente et rejoue l'extraction.
#
# Usage : Rscript tools/extraire_crosswalk.R  (iscoCrosswalks installé,
# par exemple depuis https://github.com/cran/iscoCrosswalks)
# =============================================================================
x <- as.data.frame(iscoCrosswalks::soc10_isco08)
x$isco_label <- as.character(x$isco_label)
x <- x[order(x$soc10, x$isco08), c("soc10", "isco08", "soc_label", "isco_label")]
utils::write.csv(x, "references_externes/soc2010_isco08.csv", row.names = FALSE)
message(nrow(x), " lignes écrites.")
