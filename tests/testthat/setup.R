# Chargé automatiquement par testthat avant les tests : on source les
# fonctions du projet (ce n'est pas un package, pas de library()).
racine <- normalizePath(file.path(testthat::test_path(), "..", ".."))
for (f in list.files(file.path(racine, "R"), "\\.R$", full.names = TRUE)) source(f)
fixtures <- file.path(racine, "tests", "fixtures")
iso_fixture <- lire_csv_aei(file.path(
  fixtures, "release_2025_09_15/data/intermediate/iso_country_codes.csv"))
