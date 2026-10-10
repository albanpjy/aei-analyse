# =============================================================================
# tools/explorer_schema.R — Inspection des VRAIES données de l'AEI
#
# POURQUOI : la règle du projet est de ne jamais supposer un nom de colonne, de
# facette ou de variable. Ce script, exécuté par GitHub Actions (qui a accès à
# Hugging Face), inventorie chaque version épinglée et décrit chaque fichier
# CSV : colonnes, types, nombre de lignes, valeurs distinctes des colonnes
# catégorielles. Le résultat est versionné dans docs/exploration/ et sert de
# base au code d'harmonisation et au dictionnaire de données.
#
# Usage : Rscript tools/explorer_schema.R   (réseau vers huggingface.co requis)
# =============================================================================

suppressPackageStartupMessages({
  library(aieconindex)
  library(DBI)
  library(duckdb)
})

source("R/config.R")

sortie <- "docs/exploration"
dir.create(sortie, recursive = TRUE, showWarnings = FALSE)
options(aieconindex.cache_dir = normalizePath("data/raw", mustWork = FALSE))

con <- dbConnect(duckdb())
on.exit(dbDisconnect(con, shutdown = TRUE), add = TRUE)

# Décrit un CSV avec DuckDB (bien plus rapide que read.csv sur > 200 Mo).
# Renvoie un vecteur de lignes Markdown.
decrire_csv <- function(chemin, titre) {
  # Chargement unique en table temporaire : chaque requête suivante évite de
  # relire le CSV.
  dbExecute(con, sprintf(
    "CREATE OR REPLACE TEMP TABLE t AS SELECT * FROM read_csv('%s', sample_size = -1)", chemin))
  rel <- "t"
  n <- dbGetQuery(con, sprintf("SELECT count(*) AS n FROM %s", rel))$n
  schema <- dbGetQuery(con, sprintf("DESCRIBE SELECT * FROM %s", rel))
  out <- c(sprintf("### `%s`", titre), "",
           sprintf("- Lignes : %s", format(n, big.mark = " ")),
           sprintf("- Taille : %.1f Mo", file.size(chemin) / 1024^2), "",
           "| Colonne | Type | Distinctes | Exemples / modalités |",
           "|---|---|---|---|")
  for (i in seq_len(nrow(schema))) {
    col <- schema$column_name[i]
    q <- sprintf('"%s"', gsub('"', '""', col))
    nd <- dbGetQuery(con, sprintf("SELECT count(DISTINCT %s) AS n FROM %s", q, rel))$n
    # Colonnes catégorielles peu nombreuses : liste COMPLÈTE avec effectifs.
    # Sinon : quelques exemples seulement.
    lim <- if (nd <= 60) nd else 8
    ex <- dbGetQuery(con, sprintf(
      "SELECT CAST(%s AS VARCHAR) AS v, count(*) AS n FROM %s GROUP BY 1 ORDER BY n DESC LIMIT %d",
      q, rel, lim))
    ex_txt <- paste(sprintf("`%s` (%s)", substr(ex$v, 1, 60), ex$n), collapse = ", ")
    if (nd > lim) ex_txt <- paste0(ex_txt, ", …")
    out <- c(out, sprintf("| `%s` | %s | %s | %s |", col, schema$column_type[i], nd,
                          gsub("\\|", "\\\\|", ex_txt)))
  }
  # Croisements utiles pour les schémas « long » et « monthly ».
  cles <- intersect(c("geography", "geo_level", "facet", "category_name",
                      "variable", "metric_id", "hierarchy_level"), schema$column_name)
  if (length(cles) >= 2) {
    paires <- list(c("facet", "variable"), c("category_name", "metric_id"),
                   c("geography", "facet"), c("geo_level", "category_name"),
                   c("category_name", "hierarchy_level"))
    for (p in paires) {
      if (all(p %in% cles)) {
        x <- dbGetQuery(con, sprintf(
          'SELECT "%s" AS a, "%s" AS b, count(*) AS n FROM %s GROUP BY ALL ORDER BY 1, 2',
          p[1], p[2], rel))
        out <- c(out, "", sprintf("Croisement `%s` × `%s` :", p[1], p[2]), "",
                 sprintf("| %s | %s | lignes |", p[1], p[2]), "|---|---|---|",
                 sprintf("| `%s` | `%s` | %s |", x$a, x$b, x$n))
      }
    }
  }
  head5 <- dbGetQuery(con, sprintf("SELECT * FROM %s LIMIT 5", rel))
  c(out, "", "Premières lignes :", "", "```",
    utils::capture.output(print(head5, width = 200)), "```", "")
}

versions <- aei_versions_epinglees()
journal <- c("# Exploration des données réelles de l'AEI", "",
             sprintf("*Généré par `tools/explorer_schema.R` le %s (GitHub Actions).*",
                     format(Sys.time(), "%Y-%m-%d %H:%M UTC", tz = "UTC")), "")

for (i in seq_len(nrow(versions))) {
  rel <- versions$release[i]
  rid <- versions$release_id[i]
  message("== ", rel)
  fichiers <- as.data.frame(aei_files(rel, recursive = TRUE))
  write.csv(fichiers, file.path(sortie, sprintf("fichiers_%s.csv", rel)), row.names = FALSE)
  journal <- c(journal, sprintf("## Version %s", rel), "",
               "| Fichier | Type | Taille (Mo) |", "|---|---|---|",
               sprintf("| `%s` | %s | %.2f |", fichiers$path, fichiers$type,
                       fichiers$size_bytes / 1024^2), "")
  fic <- fichiers[fichiers$type == "file", ]
  rel_paths <- sub(paste0("^", rid, "/"), "", fic$path)
  # Documentation officielle : copiée telle quelle.
  for (p in rel_paths[grepl("\\.md$", rel_paths)]) {
    loc <- aieconindex:::.aei_fetch_file(rid, p)
    dest <- file.path(sortie, rel, p)
    dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
    file.copy(loc, dest, overwrite = TRUE)
  }
  # Tous les CSV : description complète.
  for (j in which(grepl("\\.csv$", rel_paths))) {
    p <- rel_paths[j]
    message("   ", p)
    loc <- tryCatch(aieconindex:::.aei_fetch_file(rid, p), error = function(e) NULL)
    if (is.null(loc)) {
      journal <- c(journal, sprintf("### `%s` : téléchargement impossible", p), "")
      next
    }
    journal <- c(journal, tryCatch(decrire_csv(loc, p),
                                   error = function(e) c(sprintf("### `%s` : %s", p, conditionMessage(e)), "")))
  }
}

# Tables « labor market impacts » (dossier non daté).
journal <- c(journal, "## Tables labor_market_impacts", "")
for (t in c("job_exposure", "task_penetration")) {
  loc <- aieconindex:::.aei_fetch_file("labor_market_impacts", paste0(t, ".csv"))
  journal <- c(journal, decrire_csv(loc, paste0("labor_market_impacts/", t, ".csv")))
}
lm_files <- tryCatch(as.data.frame(aieconindex:::.aei_hf_list("labor_market_impacts")),
                     error = function(e) NULL)
if (!is.null(lm_files)) write.csv(lm_files, file.path(sortie, "fichiers_labor_market_impacts.csv"),
                                  row.names = FALSE)

writeLines(journal, file.path(sortie, "exploration.md"))

# Test d'accès à l'API de la Banque mondiale (PIB/hab. en PPA et population),
# envisagée comme source externe pour les sujets 1 et 4.
bm <- tryCatch({
  u <- paste0("https://api.worldbank.org/v2/country/all/indicator/",
              c("NY.GDP.PCAP.PP.KD", "SP.POP.TOTL"),
              "?format=json&per_page=20000&date=2023:2025")
  lapply(u, function(x) jsonlite::fromJSON(x)[[2]])
}, error = function(e) conditionMessage(e))
writeLines(utils::capture.output(str(bm, max.level = 2, list.len = 12)),
           file.path(sortie, "test_banque_mondiale.txt"))

# Citation officielle, pour la bibliographie.
writeLines(aei_cite(format = "bibtex"), file.path(sortie, "aei_cite.bib"))
message("Terminé.")
