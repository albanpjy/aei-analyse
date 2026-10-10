# =============================================================================
# R/harmonisation.R — Couche d'harmonisation multi-versions
#
# Problème : l'AEI a changé TROIS fois de format (constats dans
# docs/exploration/exploration.md et docs/dictionnaire_donnees.md) :
#
#   wide    (2025-02-10, 2025-03-27) : un fichier par mesure
#             onet_task_mappings / task_pct_v2      : task_name, pct
#             automation_vs_augmentation(_v2)       : interaction_type, pct
#             automation_vs_augmentation_by_task    : task_name + 1 colonne
#                                                     par mode (fractions)
#   long    (2025-09-15 → 2026-03-24) : geo_id, geography, date_start,
#             date_end, platform_and_product, facet, level, variable,
#             cluster_name, value (+ geo_name dans le fichier « enriched »)
#             ⚠ codes pays ISO-2 dans les fichiers RAW, ISO-3 dans ENRICHED ;
#             ⚠ `state_us` (2025-09-15) devient `country-state` (2026).
#   monthly (2026-06-26) : date_start, date_end, geo_id, geo_level,
#             category_name, hierarchy_level, metric_id, value, node_name,
#             node_external_id
#
# Solution : chaque fichier est ramené au MÊME schéma long (voir
# `colonnes_harmonisees()`), sans perte d'information : le vocabulaire
# d'origine (facettes, variables) est conservé, seules la structure, la
# géographie (ISO-3 partout) et les types sont unifiés. Les correspondances
# de CONCEPTS (ex. « part d'une tâche » = `onet_task_pct` en long,
# `onet`/`pct`/niveau 0 en mensuel) sont faites ensuite, en SQL, dans les vues
# DuckDB (sql/vue_*.sql), où elles sont lisibles et testables.
# =============================================================================

#' Colonnes (et types) de la table harmonisée
#'
#' @return Un tibble à 0 ligne servant de gabarit (prototype vctrs).
#' @export
colonnes_harmonisees <- function() {
  tibble::tibble(
    release = character(),      # version de l'AEI (partition Parquet)
    schema = character(),       # wide / long / monthly
    source = character(),       # claude_ai / 1p_api
    fichier = character(),      # fichier d'origine (traçabilité)
    date_start = as.Date(character()),
    date_end = as.Date(character()),
    geo_level = character(),    # global / country / subregion
    geo_id = character(),       # GLOBAL, ISO-3 (pays), ISO 3166-2 (régions)
    geo_id_source = character(), # code tel que publié (ISO-2 dans les RAW)
    facet = character(),        # facet (long) ou category_name (monthly)
    variable = character(),     # variable (long) ou metric_id (monthly)
    item = character(),         # cluster_name / node_name / task_name...
    item_id = character(),      # node_external_id (monthly) : ID O*NET, SOC...
    level = integer(),          # level (long) ou hierarchy_level (monthly)
    value = double()
  )
}

#' Lire un CSV de l'AEI sans altérer les codes
#'
#' Pièges évités :
#' - le code ISO-2 de la Namibie est « NA » : il ne doit PAS devenir une valeur
#'   manquante (seule la chaîne vide est traitée comme manquante) ;
#' - les codes SOC (« 13-2031 ») et identifiants doivent rester du texte.
#'
#' @param chemin Fichier CSV (ou TSV).
#' @return Un tibble.
#' @export
lire_csv_aei <- function(chemin) {
  tab <- arrow::read_csv_arrow(
    chemin,
    na = "",                         # « NA » reste un code pays valide
    as_data_frame = TRUE,
    read_options = arrow::CsvReadOptions$create(block_size = 64L * 1024L^2)
  )
  tibble::as_tibble(tab)
}

#' Identifier le type d'un fichier d'après ses colonnes
#'
#' On se fonde sur les colonnes RÉELLEMENT présentes, pas sur la date de la
#' version : si Anthropic modifie un format, l'erreur est explicite.
#'
#' @param noms Noms de colonnes.
#' @return Une chaîne : `long`, `monthly`, `wide_taches`, `wide_collaboration`,
#'   `wide_collaboration_tache` ou `inconnu`.
#' @export
detecter_schema <- function(noms) {
  dplyr::case_when(
    all(c("category_name", "metric_id", "node_name", "geo_level") %in% noms) ~ "monthly",
    all(c("facet", "variable", "cluster_name", "geography") %in% noms) ~ "long",
    all(c("task_name", "directive", "feedback_loop") %in% noms) ~ "wide_collaboration_tache",
    all(c("interaction_type", "pct") %in% noms) ~ "wide_collaboration",
    all(c("task_name", "pct") %in% noms) ~ "wide_taches",
    .default = "inconnu"
  )
}

#' Déduire la source (Claude.ai ou API) du nom de fichier
#' @export
source_depuis_nom <- function(chemin) {
  ifelse(grepl("1p_api", basename(chemin)), "1p_api", "claude_ai")
}

#' Normaliser la géographie : niveaux et codes
#'
#' - `geography` (long) : country → country ; state_us / country-state →
#'   subregion ; global → global (vocabulaire du schéma mensuel).
#' - Pays : ISO-2 → ISO-3 grâce au référentiel GeoNames publié par Anthropic
#'   (iso_country_codes.csv, version 2025-09-15).
#' - `state_us` (2025-09-15) : « CA » désigne la Californie, pas le Canada.
#'   On préfixe « US- » (norme ISO 3166-2) pour lever l'ambiguïté.
#'
#' @param niveau Vecteur `geography` ou `geo_level`.
#' @param code Vecteur `geo_id` tel que publié.
#' @param iso Référentiel avec `iso_alpha_2` et `iso_alpha_3`.
#' @return Un tibble à deux colonnes : `geo_level`, `geo_id`.
#' @export
normaliser_geo <- function(niveau, code, iso) {
  geo_level <- dplyr::case_match(
    niveau,
    "country" ~ "country",
    c("state_us", "country-state", "subregion") ~ "subregion",
    "global" ~ "global",
    .default = NA_character_
  )
  iso3 <- iso$iso_alpha_3[match(code, iso$iso_alpha_2)]
  geo_id <- dplyr::case_when(
    geo_level == "global" ~ "GLOBAL",
    geo_level == "country" & nchar(code) == 2 ~ iso3,
    niveau == "state_us" ~ paste0("US-", code),
    .default = code
  )
  tibble::tibble(geo_level = geo_level, geo_id = geo_id)
}

#' Harmoniser un fichier de schéma « long »
#' @keywords internal
harmoniser_long <- function(df, iso) {
  geo <- normaliser_geo(df$geography, df$geo_id, iso)
  tibble::tibble(
    source = NA_character_, # complété par l'appelant
    date_start = as.Date(df$date_start),
    date_end = as.Date(df$date_end),
    geo_level = geo$geo_level,
    geo_id = geo$geo_id,
    geo_id_source = as.character(df$geo_id),
    facet = df$facet,
    variable = df$variable,
    item = df$cluster_name,
    item_id = NA_character_,
    level = as.integer(df$level),
    value = as.double(df$value)
  )
}

#' Harmoniser un fichier de schéma « monthly »
#' @keywords internal
harmoniser_monthly <- function(df, iso) {
  geo <- normaliser_geo(df$geo_level, df$geo_id, iso)
  tibble::tibble(
    source = NA_character_,
    date_start = as.Date(df$date_start),
    date_end = as.Date(df$date_end),
    geo_level = geo$geo_level,
    geo_id = geo$geo_id,
    geo_id_source = as.character(df$geo_id),
    facet = df$category_name,
    variable = df$metric_id,
    item = df$node_name,
    item_id = as.character(df$node_external_id),
    level = as.integer(df$hierarchy_level),
    value = as.double(df$value)
  )
}

#' Harmoniser les fichiers « wide » (2025-02-10, 2025-03-27)
#'
#' On les exprime avec le vocabulaire du schéma long, pour que les mêmes vues
#' SQL s'appliquent :
#' - parts de tâches → facet `onet_task`, variable `onet_task_pct` ;
#' - modes de collaboration → facet `collaboration`, variable
#'   `collaboration_pct` ;
#' - collaboration par tâche (fractions 0–1 par colonne) → facet
#'   `onet_task::collaboration`, variable `onet_task_collaboration_pct`
#'   (× 100), item « tâche::mode » comme dans le schéma long. La colonne
#'   `filtered` devient le mode `not_classified`.
#' Ces versions n'ont ni géographie (tout est GLOBAL) ni dates de collecte
#' dans les fichiers : `date_start`/`date_end` restent manquantes.
#' @keywords internal
harmoniser_wide <- function(df, type) {
  base <- function(facet, variable, item, value) {
    tibble::tibble(
      source = "claude_ai", date_start = as.Date(NA), date_end = as.Date(NA),
      geo_level = "global", geo_id = "GLOBAL", geo_id_source = NA_character_,
      facet = facet, variable = variable, item = item, item_id = NA_character_,
      level = 0L, value = as.double(value)
    )
  }
  switch(
    type,
    wide_taches = base("onet_task", "onet_task_pct", df$task_name, df$pct),
    wide_collaboration = base("collaboration", "collaboration_pct",
                              df$interaction_type, df$pct),
    wide_collaboration_tache = {
      modes <- c(directive = "directive", feedback_loop = "feedback loop",
                 task_iteration = "task iteration", learning = "learning",
                 validation = "validation", filtered = "not_classified")
      long <- tidyr::pivot_longer(
        df, cols = tidyselect::any_of(names(modes)),
        names_to = "mode", values_to = "fraction"
      )
      base("onet_task::collaboration", "onet_task_collaboration_pct",
           paste0(long$task_name, "::", modes[long$mode]), long$fraction * 100)
    }
  )
}

#' Harmoniser un fichier de l'AEI (toutes époques)
#'
#' @param chemin Fichier CSV local.
#' @param release Version (ISO).
#' @param iso Référentiel ISO-2 → ISO-3.
#' @return Un tibble au gabarit `colonnes_harmonisees()`.
#' @export
harmoniser_fichier <- function(chemin, release, iso) {
  df <- lire_csv_aei(chemin)
  type <- detecter_schema(names(df))
  out <- switch(
    type,
    long = harmoniser_long(df, iso),
    monthly = harmoniser_monthly(df, iso),
    wide_taches = , wide_collaboration = , wide_collaboration_tache =
      harmoniser_wide(df, type),
    cli::cli_abort(c(
      "Schéma non reconnu pour {.path {basename(chemin)}}.",
      "i" = "Colonnes : {.val {names(df)}}",
      "i" = "Mettre à jour detecter_schema() après inspection."
    ))
  )
  out$source <- source_depuis_nom(chemin)
  out$release <- release
  out$schema <- if (startsWith(type, "wide")) "wide" else type
  out$fichier <- basename(chemin)
  # vec_cast + relocate : garantit noms, ordre ET types du gabarit commun.
  out <- dplyr::relocate(out, tidyselect::all_of(names(colonnes_harmonisees())))
  vctrs::vec_cast(out, colonnes_harmonisees())
}

#' Harmoniser une version et l'écrire en Parquet
#'
#' @param fichiers Chemins locaux de la version (sortie de
#'   `telecharger_fichiers()`), dont on ne garde que les données d'usage.
#' @param referentiels Chemins des Parquet de référentiels (pour le passage
#'   ISO-2 → ISO-3).
#' @return Chemins des fichiers Parquet de la partition `release=...`.
#' @export
convertir_en_parquet <- function(fichiers, release, schema_attendu, dossier,
                                 referentiels) {
  usage <- fichiers[grepl("\\.csv$", fichiers) &
                      !grepl(motif_referentiels(), fichiers)]
  iso <- arrow::read_parquet(referentiels[grepl("iso_pays", referentiels)])
  tab <- purrr::map(usage, \(f) harmoniser_fichier(f, release, iso)) |>
    purrr::list_rbind()
  # Contrôle de cohérence : l'époque observée doit être celle attendue.
  observes <- setdiff(unique(tab$schema), schema_attendu)
  if (length(observes)) {
    cli::cli_warn(c(
      paste("Version {.val {release}} : schéma observé {.val {observes}},",
            "attendu {.val {schema_attendu}}."),
      "i" = "Vérifier aei_versions_epinglees() et docs/dictionnaire_donnees.md."
    ))
  }
  ecrire_parquet(tab, dossier)
}

# -----------------------------------------------------------------------------
# Référentiels (publiés par Anthropic dans la version 2025-09-15)
# -----------------------------------------------------------------------------

#' Préparer les référentiels en Parquet
#'
#' - `onet_taches` : énoncés de tâches O*NET (ID, code O*NET-SOC, grand groupe
#'   SOC) + clé de jointure texte normalisée ;
#' - `soc_structure` : codes et intitulés de la nomenclature SOC ;
#' - `iso_pays` : correspondance ISO-2 / ISO-3 / nom (GeoNames) ;
#' - `population_age_actif` : population 15–64 ans en 2024 (Banque mondiale,
#'   extraction d'Anthropic) — dénominateur de l'indice d'usage par habitant.
#'
#' @param fichiers Fichiers locaux de la version 2025-09-15.
#' @return Chemins des Parquet écrits.
#' @export
preparer_referentiels <- function(fichiers, dossier) {
  dir.create(dossier, recursive = TRUE, showWarnings = FALSE)
  trouver <- function(motif) {
    f <- fichiers[grepl(motif, basename(fichiers))]
    if (length(f) != 1) cli::cli_abort("Référentiel introuvable : {.val {motif}}")
    lire_csv_aei(f)
  }
  taches <- trouver("^onet_task_statements\\.csv$")
  onet <- tibble::tibble(
    task_id = as.character(taches[["Task ID"]]),
    onet_soc = taches[["O*NET-SOC Code"]],
    soc6 = substr(taches[["O*NET-SOC Code"]], 1, 7),
    soc_majeur = substr(taches[["O*NET-SOC Code"]], 1, 2),
    metier = taches[["Title"]],
    tache = taches[["Task"]],
    type_tache = taches[["Task Type"]],
    cle_tache = cle_tache(taches[["Task"]])
  )
  soc <- trouver("^soc_structure\\.csv$")
  cols <- c("Major Group", "Minor Group", "Broad Occupation",
            "Detailed Occupation", "Detailed O*NET-SOC")
  niv <- apply(!is.na(soc[cols]), 1, \(x) if (any(x)) cols[which(x)[1]] else NA)
  soc_tab <- tibble::tibble(
    code = dplyr::coalesce(!!!unname(as.list(soc[cols]))),
    niveau = niv,
    intitule = soc[["SOC or O*NET-SOC 2019 Title"]]
  )
  iso <- trouver("^iso_country_codes\\.csv$")
  pop <- trouver("^working_age_pop_2024_country\\.csv$")
  sorties <- list(
    onet_taches = onet, soc_structure = soc_tab,
    iso_pays = iso[c("iso_alpha_2", "iso_alpha_3", "country_name")],
    population_age_actif = pop[c("iso_alpha_3", "year", "working_age_pop")]
  )
  purrr::imap_chr(sorties, \(d, nom) {
    f <- file.path(dossier, paste0(nom, ".parquet"))
    arrow::write_parquet(d, f, compression = "zstd")
    f
  }) |> unname()
}

#' Clé de jointure d'un énoncé de tâche
#'
#' Les énoncés apparaissent en minuscules dans les fichiers d'usage
#' (`cluster_name`), en casse normale dans O*NET et dans le schéma mensuel :
#' on compare donc des textes normalisés (minuscules, espaces réduits).
#' @export
cle_tache <- function(x) {
  stringr::str_squish(stringr::str_to_lower(x))
}

#' Rattacher les tâches O*NET aux grands groupes SOC
#'
#' Un même énoncé peut appartenir à plusieurs métiers (18 429 énoncés
#' distincts pour 19 530 tâches dans O*NET). CHOIX DU PROJET : la part d'usage
#' d'un énoncé est répartie à parts égales entre les grands groupes SOC où il
#' apparaît (poids = 1 / nombre de groupes distincts). C'est une convention
#' simple et transparente ; elle est rappelée dans la méthodologie.
#'
#' @param onet Référentiel `onet_taches`.
#' @return Tibble `cle_tache`, `soc_majeur`, `poids`.
#' @export
correspondance_taches_soc <- function(onet) {
  onet |>
    dplyr::distinct(.data$cle_tache, .data$soc_majeur) |>
    dplyr::mutate(poids = 1 / dplyr::n(), .by = "cle_tache")
}
