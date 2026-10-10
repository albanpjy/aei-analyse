# Tests de la couche d'harmonisation (R/harmonisation.R), sur données FICTIVES.

test_that("detecter_schema reconnaît les trois époques et les fichiers wide", {
  expect_equal(detecter_schema(c("geo_id", "geography", "facet", "variable",
                                 "cluster_name", "value")), "long")
  expect_equal(detecter_schema(c("geo_id", "geo_level", "category_name",
                                 "metric_id", "node_name", "value")), "monthly")
  expect_equal(detecter_schema(c("task_name", "pct")), "wide_taches")
  expect_equal(detecter_schema(c("interaction_type", "pct")), "wide_collaboration")
  expect_equal(detecter_schema(c("task_name", "directive", "feedback_loop")),
               "wide_collaboration_tache")
  expect_equal(detecter_schema(c("x", "y")), "inconnu")
})

test_that("normaliser_geo convertit ISO-2 en ISO-3 sans piège", {
  g <- normaliser_geo(
    niveau = c("country", "country", "state_us", "country-state", "global"),
    code   = c("FR", "NA", "CA", "US-CA", "GLOBAL"),
    iso    = iso_fixture
  )
  # « NA » est la Namibie, pas une valeur manquante
  expect_equal(g$geo_id, c("FRA", "NAM", "US-CA", "US-CA", "GLOBAL"))
  expect_equal(g$geo_level, c("country", "country", "subregion", "subregion", "global"))
  # Un code déjà en ISO-3 est conservé
  expect_equal(normaliser_geo("country", "FRA", iso_fixture)$geo_id, "FRA")
})

test_that("lire_csv_aei garde « NA » comme texte", {
  f <- withr::local_tempfile(fileext = ".csv")
  writeLines(c("geo_id,value", "NA,1", ",2"), f)
  d <- lire_csv_aei(f)
  expect_identical(d$geo_id, c("NA", NA))
})

test_that("harmoniser_fichier produit le gabarit commun pour chaque époque", {
  cas <- c(
    "2025-02-10" = "release_2025_02_10/onet_task_mappings.csv",
    "2025-03-27" = "release_2025_03_27/automation_vs_augmentation_by_task.csv",
    "2025-09-15" = "release_2025_09_15/data/output/aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv",
    "2026-01-15" = "release_2026_01_15/data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv",
    "2026-06-26" = "release_2026_06_26/data/aei_1p_api_2026-06-26.csv"
  )
  for (r in names(cas)) {
    h <- harmoniser_fichier(file.path(fixtures, cas[[r]]), r, iso_fixture)
    expect_identical(names(h), names(colonnes_harmonisees()))
    expect_identical(vapply(h, class, ""), vapply(colonnes_harmonisees(), class, ""))
    expect_true(all(h$release == r))
    expect_false(anyNA(h$value))
  }
})

test_that("les fichiers RAW 2026 n'ont plus que des codes pays ISO-3", {
  h <- harmoniser_fichier(file.path(
    fixtures, "release_2026_01_15/data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv"),
    "2026-01-15", iso_fixture)
  pays <- unique(h$geo_id[h$geo_level == "country"])
  expect_true(all(nchar(pays) == 3))
  expect_true(all(c("FRA", "NAM") %in% pays))
})

test_that("la collaboration par tâche (wide) est exprimée en pourcentages", {
  h <- harmoniser_fichier(file.path(
    fixtures, "release_2025_03_27/automation_vs_augmentation_by_task.csv"),
    "2025-03-27", iso_fixture)
  expect_true(all(h$facet == "onet_task::collaboration"))
  expect_true(all(grepl("::(directive|feedback loop|task iteration|learning|validation|not_classified)$",
                        h$item)))
  # Les six fractions d'une tâche somment à 100 %
  sommes <- tapply(h$value, sub("::[^:]*$", "", h$item), sum)
  expect_equal(as.vector(sommes), rep(100, length(sommes)), tolerance = 1e-8)
})

test_that("source_depuis_nom distingue l'API de Claude.ai", {
  expect_equal(source_depuis_nom(c("x/aei_raw_1p_api_2025.csv", "aei_claude_ai_2026.csv")),
               c("1p_api", "claude_ai"))
})

test_that("correspondance_taches_soc répartit un énoncé partagé à parts égales", {
  onet <- tibble::tibble(cle_tache = c("a", "a", "b", "b"),
                         soc_majeur = c("13", "43", "13", "13"))
  m <- correspondance_taches_soc(onet)
  expect_equal(m$poids[m$cle_tache == "a"], c(0.5, 0.5))
  expect_equal(m$poids[m$cle_tache == "b"], 1)
  # Les poids d'un énoncé somment à 1 : pas de double compte
  expect_true(all(tapply(m$poids, m$cle_tache, sum) == 1))
})

test_that("cle_tache normalise casse et espaces", {
  expect_equal(cle_tache("  Prepare   Budgets. "), "prepare budgets.")
})
