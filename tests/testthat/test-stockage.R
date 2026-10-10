# Tests de la couche de stockage (Parquet + DuckDB), dans un dossier temporaire.

test_that("ecrire_parquet partitionne par version et remplace une partition", {
  dossier <- withr::local_tempdir()
  f1 <- ecrire_parquet(data.frame(release = c("2025-09-15", "2026-01-15"), v = 1:2), dossier)
  expect_length(f1, 2)
  expect_true(all(grepl("release=20", f1)))
  # Réécrire une version ne touche pas l'autre
  ecrire_parquet(data.frame(release = "2025-09-15", v = 10L), dossier)
  d <- dplyr::collect(arrow::open_dataset(dossier))
  expect_equal(sort(d$v), c(2L, 10L))
})

test_that("les vues SQL produisent une part d'automatisation cohérente", {
  dossier <- withr::local_tempdir()
  withr::local_dir(dossier)
  dir.create("sql")
  file.copy(file.path(racine, "sql", "vue_03_collaboration.sql"), "sql")
  d <- data.frame(
    release = "2025-09-15", schema = "long", source = "claude_ai",
    date_start = as.Date("2025-08-04"), geo_level = "global", geo_id = "GLOBAL",
    facet = "collaboration", variable = "collaboration_pct", level = 0L,
    item = c("directive", "feedback loop", "task iteration", "learning", "validation", "none"),
    value = c(30, 10, 20, 15, 5, 20)
  )
  ecrire_parquet(d, "data/parquet/usage")
  base <- construire_duckdb("x", "sql/vue_03_collaboration.sql", "data/aei.duckdb")
  con <- connexion_duckdb(base)
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))
  a <- DBI::dbGetQuery(con, "SELECT automatisation_pct, augmentation_pct FROM automatisation")
  # (30 + 10) / (30 + 10 + 20 + 15 + 5) = 50 % ; « none » exclu
  expect_equal(a$automatisation_pct, 50)
  expect_equal(a$automatisation_pct + a$augmentation_pct, 100)
})

test_that("sql_nommee substitue les paramètres", {
  dossier <- withr::local_tempdir()
  writeLines("SELECT * FROM t WHERE geo_id = '{{pays}}'", file.path(dossier, "q.sql"))
  expect_equal(sql_nommee("q", pays = "FRA", dossier = dossier),
               "SELECT * FROM t WHERE geo_id = 'FRA'")
})
