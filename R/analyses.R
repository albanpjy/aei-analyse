# =============================================================================
# R/analyses.R — Fonctions des quatre sujets d'analyse
#
# Chaque fonction prend le chemin de la base DuckDB (dépendance {targets}) et
# renvoie un tibble ou une liste. Le SQL vit dans sql/ ; R ajoute ce que SQL
# fait mal : statistique (intervalles, ACP, mélanges gaussiens), appels au
# package aieconindex, mise en forme.
#
# RAPPEL : données d'USAGE de Claude, pas d'emploi.
# =============================================================================

#' Exécuter une requête SQL nommée sur la base du projet
#'
#' @param base Chemin de la base DuckDB.
#' @param nom Nom du fichier de sql/ (sans extension).
#' @param ... Paramètres substitués dans la requête (`{{param}}`).
#' @return Un tibble.
#' @export
requete <- function(.base, .nom, ...) {
  # Arguments préfixés d'un point : R complète les noms d'arguments partiels
  # (`n = 15` serait capté par un argument `nom`, `b =` par `base`).
  con <- connexion_duckdb(.base)
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE), add = TRUE)
  tibble::as_tibble(DBI::dbGetQuery(con, sql_nommee(.nom, ...)))
}

#' Liste SQL de chaînes : c("a", "b") -> "'a', 'b'"
#' @keywords internal
liste_sql <- function(x) paste0("'", x, "'", collapse = ", ")

#' Intervalle de confiance de Wilson pour une proportion
#'
#' Préféré à l'intervalle de Wald (p ± 1,96·√(p(1-p)/n)), qui se dégrade près de
#' 0 et 1 et pour de petits effectifs. Hypothèse : les conversations sont un
#' échantillon aléatoire simple (approximation : l'échantillonnage réel de Clio
#' n'est pas documenté au niveau de détail nécessaire). Les bornes reflètent
#' donc l'aléa d'échantillonnage SEULEMENT, pas l'incertitude de classification.
#'
#' @param p Proportion (0–1).
#' @param n Effectif.
#' @param niveau Niveau de confiance.
#' @return Tibble `bas`, `haut` (0–1).
#' @export
ic_wilson <- function(p, n, niveau = 0.95) {
  z <- stats::qnorm(1 - (1 - niveau) / 2)
  centre <- (p + z^2 / (2 * n)) / (1 + z^2 / n)
  demi <- z * sqrt(p * (1 - p) / n + z^2 / (4 * n^2)) / (1 + z^2 / n)
  tibble::tibble(bas = pmax(0, centre - demi), haut = pmin(1, centre + demi))
}

# -----------------------------------------------------------------------------
# Sujet 1 — La France face à Claude
# -----------------------------------------------------------------------------

#' Usage et indice d'usage par habitant (tous pays, toutes versions)
#' @export
s1_usage_pays <- function(base) requete(base, "s1_usage_pays")

#' Tâches les plus fréquentes en France et spécialisation
#' @export
s1_top_taches <- function(base, release, n = 15) {
  requete(base, "s1_top_taches", version = release, nb = n)
}

#' Parts d'usage par grand groupe de métiers (dérivées et publiées)
#' @export
s1_soc_pays <- function(base) {
  requete(base, "s1_soc_pays") |>
    dplyr::left_join(groupes_soc(), by = "soc_majeur")
}

#' Concentration de l'usage sur les tâches (HHI, CR10, entropie de Shannon)
#'
#' Utilise aieconindex::aei_concentration() sur les parts des tâches classées,
#' renormalisées à 100 % dans chaque (version, pays) : `rescale = TRUE`.
#' L'entropie normalisée (H / log2 n) neutralise le nombre de tâches, qui varie
#' d'une version à l'autre (seuils de confidentialité).
#' @export
s1_concentration <- function(base) {
  parts <- requete(base, "s1_parts_taches_pays")
  aieconindex::aei_concentration(
    as.data.frame(parts), share_col = "part_pct",
    group_cols = c("release", "geo_id"), top_n = 10L, rescale = TRUE
  ) |>
    tibble::as_tibble()
}

#' Comparer deux versions pour un pays (parts des tâches)
#'
#' Mode réel : aieconindex::aei_compare(), sur les fichiers RAW (mêmes codes
#' ISO-2 dans les deux versions comparées). Les clés de jointure sont passées
#' explicitement : les clés par défaut du schéma long (cluster_name, facet,
#' variable) ignorent la géographie et démultiplieraient les lignes.
#' Mode fixtures (sans réseau) : requête SQL équivalente
#' (sql/s1_comparer_versions.sql).
#'
#' @param a,b Versions (ISO).
#' @param pays_iso3 Pays (ISO-3).
#' @return Tibble : tâche, `value_a`, `value_b`, `delta`, `pct_change`, et
#'   `methode`.
#' @export
s1_comparer <- function(base, a, b, pays_iso3 = "FRA", mode = mode_execution()) {
  sql <- requete(base, "s1_comparer_versions", version_a = a, version_b = b,
                 pays = pays_iso3) |>
    dplyr::mutate(methode = "SQL (projet)")
  if (mode != "reel") return(sql)
  iso <- requete(base, "iso_pays")
  iso2 <- iso$iso_alpha_2[iso$iso_alpha_3 == pays_iso3]
  cmp <- aieconindex::aei_compare(
    a, b, source = "claude_ai", variant = "raw",
    by = c("geo_id", "geography", "facet", "level", "variable", "cluster_name")
  )
  cmp <- tibble::as_tibble(as.data.frame(cmp)) |>
    dplyr::filter(.data$geo_id == iso2, .data$facet == "onet_task",
                  .data$variable == "onet_task_pct",
                  !.data$cluster_name %in% c("none", "not_classified")) |>
    dplyr::transmute(cle_tache = cle_tache(.data$cluster_name), tache = .data$cluster_name,
                     .data$value_a, .data$value_b, .data$delta, .data$pct_change,
                     methode = "aei_compare()")
  cmp
}

# -----------------------------------------------------------------------------
# Sujet 2 — Automatisation vs augmentation
# -----------------------------------------------------------------------------

#' Automatisation mondiale par version et source, avec IC de Wilson
#' @export
s2_global <- function(base) {
  g <- requete(base, "s2_global")
  ic <- ic_wilson(g$automatisation_pct / 100, g$effectif_classable)
  g |>
    dplyr::mutate(ic_bas = 100 * ic$bas, ic_haut = 100 * ic$haut,
                  periode = dplyr::coalesce(format(.data$date_start), .data$release))
}

#' Parts des six modes de collaboration (mondial)
#' @export
s2_modes <- function(base) {
  requete(base, "s2_modes") |>
    dplyr::left_join(modes_collaboration(), by = "mode")
}

#' Automatisation par pays, avec IC de Wilson quand l'effectif est publié
#' @export
s2_pays <- function(base) {
  p <- requete(base, "s2_pays")
  ic <- ic_wilson(p$automatisation_pct / 100, p$effectif_classable)
  dplyr::mutate(p, ic_bas = 100 * ic$bas, ic_haut = 100 * ic$haut)
}

#' Automatisation par grand groupe de métiers
#' @export
s2_soc <- function(base) {
  requete(base, "s2_soc") |>
    dplyr::left_join(groupes_soc(), by = "soc_majeur")
}

# -----------------------------------------------------------------------------
# Sujet 3 — Métiers budgétaires et financiers
# -----------------------------------------------------------------------------

#' Métiers ciblés et correspondance SOC -> ISCO-08 -> fonction publique
#'
#' ⚠ HYPOTHÈSE DE TRAVAIL du projet, pas une correspondance officielle : les
#' codes ISCO-08 proposés suivent la logique de la table de passage
#' SOC 2010 -> ISCO-08 du Bureau of Labor Statistics, à VÉRIFIER sur cette
#' table avant tout usage ; les emplois de la fonction publique française sont
#' des rapprochements fonctionnels argumentés.
#' @export
metiers_cibles <- function() {
  tibble::tribble(
    ~soc6, ~intitule_soc, ~isco08, ~intitule_isco, ~fonction_publique, ~argument,
    "13-2031", "Budget Analysts", "2411", "Comptables (hypothèse ; 2422 possible)",
    "Analyste budgétaire, contrôleur budgétaire (BOP/UO, DAF, CBCM)",
    "Préparation, exécution et suivi du budget ; justification des crédits",
    "13-2011", "Accountants and Auditors", "2411", "Comptables",
    "Comptable public, auditeur et contrôleur interne comptable",
    "Tenue et contrôle des comptes, audit, certification",
    "11-3031", "Financial Managers", "1211", "Directeurs des services financiers",
    "Directeur ou chef de bureau des affaires financières",
    "Pilotage de la fonction financière, arbitrages, dialogue de gestion",
    "13-2051", "Financial and Investment Analysts", "2413", "Analystes financiers",
    "Analyste financier, chargé d'études financières et de soutenabilité",
    "Analyse de soutenabilité, modélisation financière, études de coûts",
    "13-1111", "Management Analysts", "2421", "Analystes de gestion et d'organisation",
    "Contrôleur de gestion, conseiller en organisation",
    "Indicateurs de performance, analyse des coûts, organisation",
    "43-3031", "Bookkeeping, Accounting, and Auditing Clerks", "4311",
    "Employés des services comptables",
    "Gestionnaire budgétaire et comptable (catégories B et C)",
    "Saisie et contrôle des engagements, liquidations et pièces comptables",
    "13-1023", "Purchasing Agents, Except Wholesale, Retail, and Farm Products", "3323",
    "Acheteurs", "Acheteur public",
    "Passation et suivi des marchés, analyse des offres",
    "11-3061", "Purchasing Managers", "1324",
    "Directeurs des services d'approvisionnement", "Responsable de la fonction achats",
    "Stratégie d'achat, pilotage des marchés"
  )
}

#' Exposition des métiers ciblés et position dans la distribution
#' @export
s3_exposition <- function(base) {
  e <- requete(base, "s3_exposition")
  cibles <- metiers_cibles()
  list(
    toutes = e,
    cibles = dplyr::left_join(
      cibles, e, by = c("soc6" = "occ_code")
    ),
    codes_absents = setdiff(cibles$soc6, e$occ_code)
  )
}

#' Tâches des métiers ciblés et pénétration de l'IA
#' @export
s3_taches <- function(base) {
  requete(base, "s3_taches", codes = liste_sql(metiers_cibles()$soc6))
}

#' Empreinte des métiers ciblés dans l'usage mondial, par version
#' @export
s3_usage <- function(base) {
  requete(base, "s3_usage_metiers", codes = liste_sql(metiers_cibles()$soc6))
}

#' Couverture des métiers militaires (SOC 55-xxxx)
#' @export
s3_militaire <- function(base) requete(base, "s3_militaire")

# -----------------------------------------------------------------------------
# Sujet 4 — Typologie des pays (données compositionnelles)
# -----------------------------------------------------------------------------

#' Remplacement multiplicatif des zéros (Martín-Fernández et al., 2003)
#'
#' Le log d'un zéro n'existe pas : avant la transformation CLR, chaque zéro
#' d'une composition est remplacé par `delta`, et les parts non nulles sont
#' réduites proportionnellement pour que le total reste inchangé. C'est la
#' méthode qui préserve le mieux les rapports entre parts non nulles.
#'
#' @param x Matrice de compositions (lignes = pays), total quelconque.
#' @param delta Valeur de remplacement (même unité que `x`). Par défaut, 65 %
#'   de la plus petite part non nulle observée (règle usuelle : 65 % du seuil
#'   de détection).
#' @export
remplacement_multiplicatif <- function(x, delta = 0.65 * min(x[x > 0])) {
  t(apply(x, 1, \(r) {
    total <- sum(r)
    z <- r == 0
    r[!z] <- r[!z] * (1 - sum(z) * delta / total)
    r[z] <- delta
    r
  }))
}

#' Transformation log-ratio centrée (CLR, Aitchison 1986)
#'
#' clr(x)_j = ln(x_j / g(x)), où g(x) est la moyenne géométrique de la
#' composition. Les parts d'usage sont des données COMPOSITIONNELLES (elles
#' somment à 100) : leurs corrélations brutes sont biaisées (une part qui monte
#' en fait mécaniquement baisser d'autres). La CLR les envoie dans un espace
#' euclidien où ACP et distances ont un sens.
#' @export
clr <- function(x) {
  lx <- log(x)
  lx - rowMeans(lx)
}

#' Construire la matrice pays × familles de tâches
#'
#' Pays retenus : ceux où au moins `couverture_min` des familles sont publiées
#' (les cellules non publiées sont sous le seuil de confidentialité : on les
#' traite comme des zéros « arrondis », remplacés avant la CLR).
#' @export
s4_matrice <- function(base, release, couverture_min = 0.9) {
  g <- requete(base, "s4_gwa_pays", version = release)
  n_gwa <- dplyr::n_distinct(g$gwa_code)
  retenus <- g |>
    dplyr::summarise(couverture = dplyr::n() / n_gwa, .by = "geo_id") |>
    dplyr::filter(.data$couverture >= couverture_min)
  large <- g |>
    dplyr::filter(.data$geo_id %in% retenus$geo_id) |>
    tidyr::pivot_wider(id_cols = "geo_id", names_from = "gwa_code",
                       values_from = "part_pct", values_fill = 0)
  m <- as.matrix(large[, -1])
  rownames(m) <- large$geo_id
  list(
    parts = m,
    libelles = dplyr::distinct(g, .data$gwa_code, .data$gwa),
    pays = dplyr::distinct(g, .data$geo_id, .data$usage_pct, .data$aui) |>
      dplyr::filter(.data$geo_id %in% rownames(m)),
    n_zeros = sum(m == 0)
  )
}

#' Typologie : CLR, ACP (FactoMineR), HCPC et mélange gaussien (Mclust)
#'
#' @param mat Sortie de `s4_matrice()`.
#' @param pib Chemin du Parquet PIB par habitant (Banque mondiale).
#' @return Liste : objets ACP/HCPC/Mclust, coordonnées, partitions, indice de
#'   Rand ajusté, croisement avec le PIB.
#' @export
s4_typologie <- function(mat, pib) {
  set.seed(2026)
  x <- remplacement_multiplicatif(mat$parts)
  z <- clr(x)
  # ACP NON normée sur la CLR : les coordonnées CLR partagent la même unité
  # (log-ratio) ; réduire les variables donnerait trop de poids aux familles
  # rares, dont la variance des log-ratios est gonflée par les petits effectifs.
  acp <- FactoMineR::PCA(as.data.frame(z), scale.unit = FALSE, ncp = 10, graph = FALSE)
  # Nombre d'axes retenus : 80 % d'inertie cumulée (au moins 2)
  k <- max(2L, which(acp$eig[, 3] >= 80)[1])
  # HCPC : classification ascendante hiérarchique (Ward) sur les k premiers
  # axes, coupure choisie automatiquement (gain d'inertie), consolidation par
  # k-means.
  acp_k <- FactoMineR::PCA(as.data.frame(z), scale.unit = FALSE, ncp = k, graph = FALSE)
  hcpc <- FactoMineR::HCPC(acp_k, nb.clust = -1, consol = TRUE, graph = FALSE)
  # Mclust : mélanges gaussiens sur les MÊMES k axes ; le modèle (forme des
  # covariances) et le nombre de groupes sont choisis par le BIC.
  coords <- acp$ind$coord[, seq_len(k), drop = FALSE]
  mc <- mclust::Mclust(coords, G = 2:min(8, nrow(coords) - 1), verbose = FALSE)
  part_hcpc <- hcpc$data.clust$clust[match(rownames(z), rownames(hcpc$data.clust))]
  part_mc <- mc$classification
  ari <- mclust::adjustedRandIndex(part_hcpc, part_mc)

  pib_tab <- arrow::read_parquet(pib)
  # aei_link() : jointure d'une table AEI avec des données externes, en
  # conservant la provenance (attributs) du côté AEI.
  pays_aei <- aieconindex:::new_aei_tbl(as.data.frame(mat$pays),
                                        list(endpoint = "typologie (projet)"))
  croise <- aieconindex::aei_link(pays_aei, as.data.frame(pib_tab),
                                  by = c(geo_id = "iso3"), type = "left") |>
    tibble::as_tibble() |>
    dplyr::mutate(classe_hcpc = factor(part_hcpc[match(.data$geo_id, rownames(z))]),
                  classe_mclust = factor(part_mc[match(.data$geo_id, rownames(z))]))
  # Test de Kruskal-Wallis : le PIB par habitant diffère-t-il entre classes ?
  # (non paramétrique : peu de pays par classe, distribution asymétrique)
  test_pib <- NULL
  if (sum(!is.na(croise$pib_hab_ppa)) > 5 && nlevels(croise$classe_hcpc) > 1) {
    test_pib <- stats::kruskal.test(pib_hab_ppa ~ classe_hcpc, data = croise)
  }

  list(
    acp = acp, k = k, hcpc = hcpc, mclust = mc,
    clr = z, ari = ari, croise = croise, test_pib = test_pib,
    bic = mc$BIC, n_zeros = mat$n_zeros, libelles = mat$libelles
  )
}
