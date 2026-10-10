# =============================================================================
# tests/fixtures/generer_fixtures.R — Génère le jeu de données FICTIF
#
# POURQUOI : développer et tester sans accès à Hugging Face. Les fichiers
# reproduisent la STRUCTURE réelle de l'AEI (chemins, noms de colonnes,
# vocabulaire des facettes et variables), telle que constatée par inspection
# (docs/exploration/exploration.md). Les VALEURS sont aléatoires et n'ont aucun
# sens : ne jamais interpréter un résultat tiré de ces fichiers.
#
# Pièges réels volontairement reproduits pour tester l'harmonisation :
#   - la Namibie a le code ISO-2 « NA » (ne doit pas devenir une valeur
#     manquante) ;
#   - en 2025-09-15, l'État de Californie a le code « CA » (≠ Canada) ;
#   - les fichiers RAW de 2026 utilisent des codes pays ISO-2 ;
#   - un même énoncé de tâche appartient à deux grands groupes SOC.
#
# Usage : Rscript tests/fixtures/generer_fixtures.R (depuis la racine)
# =============================================================================

set.seed(20261010)
racine <- "tests/fixtures"

ecrire <- function(df, chemin) {
  dir.create(dirname(file.path(racine, chemin)), recursive = TRUE, showWarnings = FALSE)
  # na = "" : comme les fichiers d'Anthropic (cellules vides)
  utils::write.csv(df, file.path(racine, chemin), row.names = FALSE, na = "")
}
parts <- function(n, alpha = 1) { x <- stats::rgamma(n, alpha); 100 * x / sum(x) }

# --- Univers fictif -----------------------------------------------------------
pays <- data.frame(
  iso3 = c("FRA", "DEU", "GBR", "ESP", "ITA", "BEL", "NLD", "USA", "CAN", "JPN",
           "KOR", "IND", "BRA", "MEX", "POL", "SWE", "NOR", "DNK", "FIN", "CHE",
           "AUT", "PRT", "IRL", "AUS", "NZL", "ISR", "SGP", "ZAF", "NAM", "ARG"),
  iso2 = c("FR", "DE", "GB", "ES", "IT", "BE", "NL", "US", "CA", "JP", "KR", "IN",
           "BR", "MX", "PL", "SE", "NO", "DK", "FI", "CH", "AT", "PT", "IE", "AU",
           "NZ", "IL", "SG", "ZA", "NA", "AR"),
  nom = c("France", "Germany", "United Kingdom", "Spain", "Italy", "Belgium",
          "Netherlands", "United States", "Canada", "Japan", "South Korea", "India",
          "Brazil", "Mexico", "Poland", "Sweden", "Norway", "Denmark", "Finland",
          "Switzerland", "Austria", "Portugal", "Ireland", "Australia", "New Zealand",
          "Israel", "Singapore", "South Africa", "Namibia", "Argentina")
)
pays$pop <- round(stats::runif(nrow(pays), 2e6, 2e8))

majeurs <- data.frame(
  code = c("11", "13", "15", "17", "19", "21", "23", "25", "27", "29", "31", "33",
           "35", "37", "39", "41", "43", "45", "47", "49", "51", "53"),
  titre = c("Management", "Business and Financial Operations", "Computer and Mathematical",
            "Architecture and Engineering", "Life, Physical, and Social Science",
            "Community and Social Service", "Legal", "Educational Instruction and Library",
            "Arts, Design, Entertainment, Sports, and Media",
            "Healthcare Practitioners and Technical", "Healthcare Support",
            "Protective Service", "Food Preparation and Serving Related",
            "Building and Grounds Cleaning and Maintenance", "Personal Care and Service",
            "Sales and Related", "Office and Administrative Support",
            "Farming, Fishing, and Forestry", "Construction and Extraction",
            "Installation, Maintenance, and Repair", "Production",
            "Transportation and Material Moving")
)
# Métiers : 1 métier « générique » par grand groupe + les métiers budgétaires
# du chiffre étudiés au sujet 3 (codes SOC réels, tâches fictives).
metiers <- rbind(
  data.frame(soc6 = paste0(majeurs$code, "-9999"), titre = paste("Generic occupation", majeurs$code)),
  data.frame(
    soc6 = c("13-2031", "13-2011", "11-3031", "13-2051", "13-1111", "43-3031", "43-3051",
             "13-2061", "13-2081"),
    titre = c("Budget Analysts", "Accountants and Auditors", "Financial Managers",
              "Financial and Investment Analysts", "Management Analysts",
              "Bookkeeping, Accounting, and Auditing Clerks", "Payroll and Timekeeping Clerks",
              "Financial Examiners", "Tax Examiners and Collectors, and Revenue Agents")
  )
)
taches <- do.call(rbind, lapply(seq_len(nrow(metiers)), \(i) data.frame(
  onet_soc = paste0(metiers$soc6[i], ".00"), metier = metiers$titre[i],
  tache = sprintf("Fictitious task %d of occupation %s.", 1:3, metiers$soc6[i])
)))
# Un énoncé partagé par deux grands groupes (13 et 43) : teste la pondération.
taches$tache[taches$onet_soc == "43-3031.00"][1] <-
  taches$tache[taches$onet_soc == "13-2011.00"][1]
taches$task_id <- 10000 + seq_len(nrow(taches))
taches$cle <- tolower(taches$tache)
cles <- unique(taches$cle)
gwa <- data.frame(code = sprintf("4.A.%d.a.%d", rep(1:4, each = 3), rep(1:3, 4)),
                  nom = sprintf("Fictitious work activity %02d", 1:12))
modes <- c("directive", "feedback loop", "task iteration", "learning", "validation",
           "none", "not_classified")

# --- Référentiels (publiés dans release_2025_09_15/data/intermediate) ---------
r0915 <- "release_2025_09_15/data/intermediate/"
ecrire(data.frame(
  `O*NET-SOC Code` = taches$onet_soc, Title = taches$metier, `Task ID` = taches$task_id,
  Task = taches$tache, `Task Type` = "Core", `Incumbents Responding` = 20,
  Date = "07/2014", `Domain Source` = "Incumbent",
  soc_major_group = as.integer(substr(taches$onet_soc, 1, 2)), check.names = FALSE
), paste0(r0915, "onet_task_statements.csv"))
soc_struct <- rbind(
  data.frame(mg = paste0(c(majeurs$code, "55"), "-0000"), det = NA,
             titre = paste(c(majeurs$titre, "Military Specific"), "Occupations")),
  data.frame(mg = NA, det = metiers$soc6, titre = metiers$titre)
)
ecrire(data.frame(
  `Major Group` = soc_struct$mg, `Minor Group` = NA, `Broad Occupation` = NA,
  `Detailed Occupation` = soc_struct$det, `Detailed O*NET-SOC` = NA,
  `SOC or O*NET-SOC 2019 Title` = soc_struct$titre,
  soc_major_group = as.integer(substr(soc_struct$mg, 1, 2)), check.names = FALSE
), paste0(r0915, "soc_structure.csv"))
ecrire(data.frame(iso_alpha_2 = pays$iso2, iso_alpha_3 = pays$iso3, country_name = pays$nom),
       paste0(r0915, "iso_country_codes.csv"))
ecrire(data.frame(iso_alpha_3 = pays$iso3, year = 2024L, working_age_pop = pays$pop,
                  country_code = pays$iso2, country_name = pays$nom),
       paste0(r0915, "working_age_pop_2024_country.csv"))

# --- Schéma « wide » ------------------------------------------------------------
taches_pct <- function() data.frame(task_name = cles, pct = parts(length(cles)) / 100)
collab_wide <- function() data.frame(interaction_type = modes[1:6], pct = parts(6) * 0.85)
ecrire(taches_pct(), "release_2025_02_10/onet_task_mappings.csv")
ecrire(collab_wide(), "release_2025_02_10/automation_vs_augmentation.csv")
ecrire(taches_pct(), "release_2025_03_27/task_pct_v2.csv")
ecrire(collab_wide(), "release_2025_03_27/automation_vs_augmentation_v2.csv")
fr <- t(replicate(length(cles), parts(6) / 100))
colnames(fr) <- c("feedback_loop", "directive", "task_iteration", "validation", "learning", "filtered")
ecrire(data.frame(task_name = cles, fr), "release_2025_03_27/automation_vs_augmentation_by_task.csv")

# --- Schéma « long » ------------------------------------------------------------
# Une géographie : lignes country/usage, onet_task, collaboration (+ SOC en
# version enriched).
lignes_geo <- function(geo_id, geography, enriched, n_conv) {
  tp <- parts(length(cles), 0.6)
  cp <- parts(7)
  out <- rbind(
    data.frame(facet = "onet_task", level = 0L, variable = "onet_task_pct",
               cluster_name = cles, value = tp),
    data.frame(facet = "onet_task", level = 0L, variable = "onet_task_count",
               cluster_name = cles, value = round(tp * n_conv / 100)),
    data.frame(facet = "collaboration", level = 0L, variable = "collaboration_pct",
               cluster_name = modes, value = cp),
    data.frame(facet = "collaboration", level = 0L, variable = "collaboration_count",
               cluster_name = modes, value = round(cp * n_conv / 100))
  )
  if (enriched && geography != "state_us") {
    out <- rbind(out, data.frame(facet = "soc_occupation", level = 0L, variable = "soc_pct",
                                 cluster_name = majeurs$titre, value = parts(nrow(majeurs))))
  }
  cbind(geo_id = geo_id, geography = geography, out)
}
fichier_long <- function(debut, fin, produit, iso2, enriched, chemin, etats = "US-CA") {
  geo_pays <- if (iso2) pays$iso2 else pays$iso3
  n <- round(stats::runif(nrow(pays), 5e3, 5e5))
  usage <- data.frame(
    geo_id = geo_pays, geography = "country", facet = "country", level = 0L,
    variable = rep(c("usage_count", "usage_pct"), each = nrow(pays)),
    cluster_name = NA, value = c(n, 100 * n / sum(n))
  )
  if (enriched) {
    aui <- (n / sum(n)) / (pays$pop / sum(pays$pop))
    usage <- rbind(usage, data.frame(
      geo_id = geo_pays, geography = "country", facet = "country", level = 0L,
      variable = "usage_per_capita_index", cluster_name = NA, value = aui))
  }
  geo <- do.call(rbind, c(
    list(lignes_geo("GLOBAL", "global", enriched, sum(n))),
    lapply(seq_along(geo_pays), \(i) lignes_geo(geo_pays[i], "country", enriched, n[i])),
    lapply(etats, \(e) lignes_geo(e, if (enriched) "state_us" else "country-state", FALSE, 1e4))
  ))
  inter <- data.frame(geo_id = "GLOBAL", geography = "global", facet = "onet_task::collaboration",
                      level = 0L, variable = "onet_task_collaboration_pct",
                      cluster_name = paste0(rep(cles, each = 7), "::", modes),
                      value = as.vector(replicate(length(cles), parts(7))))
  df <- rbind(usage, geo, inter)
  df <- cbind(date_start = debut, date_end = fin, platform_and_product = produit, df)
  df <- df[c("geo_id", "geography", "date_start", "date_end", "platform_and_product",
             "facet", "level", "variable", "cluster_name", "value")]
  if (enriched) df$geo_name <- df$geo_id
  ecrire(df, chemin)
}
fichier_api_long <- function(debut, fin, chemin) {
  df <- rbind(
    data.frame(facet = "onet_task", level = 0L, variable = "onet_task_pct", cluster_name = cles,
               value = parts(length(cles))),
    data.frame(facet = "collaboration", level = 0L, variable = "collaboration_pct",
               cluster_name = modes, value = parts(7)),
    data.frame(facet = "collaboration", level = 0L, variable = "collaboration_count",
               cluster_name = modes, value = round(parts(7) * 1e4))
  )
  ecrire(cbind(geo_id = "GLOBAL", geography = "global", date_start = debut, date_end = fin,
               platform_and_product = "1P API", df), chemin)
}
fichier_long("2025-08-04", "2025-08-11", "Claude AI (Free and Pro)", FALSE, TRUE,
             "release_2025_09_15/data/output/aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv",
             etats = "CA")  # piège : « CA » = Californie dans ce fichier
fichier_api_long("2025-08-04", "2025-08-11",
                 "release_2025_09_15/data/intermediate/aei_raw_1p_api_2025-08-04_to_2025-08-11.csv")
fichier_long("2025-11-13", "2025-11-20", "Claude AI (Free and Pro)", TRUE, FALSE,
             "release_2026_01_15/data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv")
fichier_api_long("2025-11-13", "2025-11-20",
                 "release_2026_01_15/data/intermediate/aei_raw_1p_api_2025-11-13_to_2025-11-20.csv")
fichier_long("2026-02-05", "2026-02-12", "Claude AI (Free, Pro, and Max)", TRUE, FALSE,
             "release_2026_03_24/data/aei_raw_claude_ai_2026-02-05_to_2026-02-12.csv")
fichier_api_long("2026-02-05", "2026-02-12",
                 "release_2026_03_24/data/aei_raw_1p_api_2026-02-05_to_2026-02-12.csv")

# --- Schéma « monthly » -----------------------------------------------------------
lignes_mois <- function(debut, fin, geo_id, geo_level, avec_soc_collab) {
  cp <- parts(6)
  auto <- sum(cp[1:2]) / sum(cp[1:5]) * 100
  overall <- data.frame(
    category_name = "overall", hierarchy_level = 0L,
    metric_id = c(sprintf("collaboration_%s_pct", gsub(" ", "_", modes[1:6])),
                  "collaboration_bucket_automation_pct", "collaboration_bucket_augmentation_pct"),
    value = round(c(cp, auto, 100 - auto), 2), node_name = "Overall", node_external_id = "-"
  )
  onet0 <- data.frame(category_name = "onet", hierarchy_level = 0L, metric_id = "pct",
                      value = round(parts(nrow(taches), 0.6), 2), node_name = taches$tache,
                      node_external_id = as.character(taches$task_id))
  onet3 <- data.frame(category_name = "onet", hierarchy_level = 3L, metric_id = "pct",
                      value = round(parts(nrow(gwa), 0.8), 2), node_name = gwa$nom,
                      node_external_id = gwa$code)
  soc <- data.frame(category_name = "soc_occupation", hierarchy_level = 1L, metric_id = "pct",
                    value = round(parts(nrow(majeurs)), 2), node_name = majeurs$titre,
                    node_external_id = majeurs$code)
  if (avec_soc_collab) {
    a <- stats::runif(nrow(majeurs), 20, 70)
    soc <- rbind(soc, data.frame(
      category_name = "soc_occupation", hierarchy_level = 1L,
      metric_id = rep(c("collaboration_bucket_automation_pct", "collaboration_bucket_augmentation_pct"),
                      each = nrow(majeurs)),
      value = round(c(a, 100 - a), 2), node_name = majeurs$titre, node_external_id = majeurs$code))
  }
  cbind(date_start = debut, date_end = fin, geo_id = geo_id, geo_level = geo_level,
        rbind(overall, onet0, onet3, soc))
}
mois <- list(c("2026-04-01", "2026-05-01"), c("2026-05-01", "2026-06-01"))
mensuel <- do.call(rbind, lapply(mois, \(m) {
  n <- stats::runif(nrow(pays), 1, 100)
  aui <- (n / sum(n)) / (pays$pop / sum(pays$pop))
  usage <- data.frame(date_start = m[1], date_end = m[2], geo_id = pays$iso3, geo_level = "country",
                      category_name = "overall", hierarchy_level = 0L,
                      metric_id = rep(c("usage_pct", "usage_per_capita_index"), each = nrow(pays)),
                      value = round(c(100 * n / sum(n), aui), 2), node_name = "Overall",
                      node_external_id = "-")
  rbind(usage, lignes_mois(m[1], m[2], "GLOBAL", "global", TRUE),
        do.call(rbind, lapply(pays$iso3, \(p) lignes_mois(m[1], m[2], p, "country", FALSE))),
        lignes_mois(m[1], m[2], "US-CA", "subregion", FALSE))
}))
mensuel <- mensuel[c("date_start", "date_end", "geo_id", "geo_level", "category_name",
                     "hierarchy_level", "metric_id", "value", "node_name", "node_external_id")]
ecrire(mensuel, "release_2026_06_26/data/aei_claude_ai_2026-06-26.csv")
api_m <- do.call(rbind, lapply(mois, \(m) lignes_mois(m[1], m[2], "GLOBAL", "global", TRUE)))
ecrire(api_m[names(mensuel)], "release_2026_06_26/data/aei_1p_api_2026-06-26.csv")

# --- Documentation (copie minimale) ---------------------------------------------
for (r in c("release_2025_09_15", "release_2026_01_15", "release_2026_03_24", "release_2026_06_26")) {
  writeLines(c("# Données FICTIVES", "", "Voir docs/exploration/ pour la vraie documentation."),
             file.path(racine, r, "data_documentation.md"))
}

# --- Tables « labor market impacts » -----------------------------------------------
ecrire(data.frame(occ_code = metiers$soc6, title = metiers$titre,
                  observed_exposure = round(stats::runif(nrow(metiers), 0, 0.8), 4)),
       "labor_market_impacts/job_exposure.csv")
ecrire(data.frame(task = taches$tache,
                  penetration = round(ifelse(stats::runif(nrow(taches)) < 0.5, 0,
                                             stats::runif(nrow(taches))), 4)),
       "labor_market_impacts/task_penetration.csv")

# --- Banque mondiale (PIB par habitant en PPA) : format de l'API, simplifié -------
ecrire(data.frame(countryiso3code = pays$iso3, date = 2024L,
                  value = round(stats::runif(nrow(pays), 5000, 90000))),
       "banque_mondiale/NY.GDP.PCAP.PP.KD.csv")

message("Fixtures générées dans ", racine)
