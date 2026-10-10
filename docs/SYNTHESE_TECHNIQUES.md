# Synthèse des techniques utilisées

Pour chaque technique : **à quoi elle sert**, **où** elle est utilisée dans le projet,
un **extrait commenté** et les **pièges** — dont ceux rencontrés réellement pendant la
construction du projet (signalés par ⚠ *vécu*).

---

## 1. R et le tidyverse

**À quoi ça sert.** Manipulation de données lisible (dplyr, tidyr), programmation
fonctionnelle (purrr), chaînes (stringr), graphiques (ggplot2).

**Où.** Partout : `R/analyses.R`, `R/harmonisation.R`, `R/graphiques.R`, les `.qmd`.

```r
# R/analyses.R — pivot vers une matrice pays × familles de tâches
large <- g |>
  dplyr::filter(.data$geo_id %in% pays_retenus) |>          # .data$ : pas d'ambiguïté
  tidyr::pivot_wider(id_cols = "geo_id", names_from = "gwa_code",
                     values_from = "part_pct", values_fill = 0)
```

**Pièges.**
- Préfixer `pkg::fonction()` dans le code de production : pas de conflit de noms
  (`dplyr::filter` contre `stats::filter`).
- ⚠ *vécu* : R **complète les noms d'arguments partiels**. Un appel
  `requete(base, "s1_top_taches", n = 15)` envoyait `15` dans l'argument `nom`.
  Remède : préfixer d'un point les arguments des fonctions qui acceptent `...`
  (`requete(.base, .nom, ...)`).
- ⚠ *vécu* : `dplyr::case_match()` est déprécié depuis dplyr 1.2 ; `case_when()` est stable.

## 2. renv — environnement reproductible

**À quoi ça sert.** Figer les versions exactes des packages (`renv.lock`) et les
restaurer à l'identique (`renv::restore()`).

**Où.** `renv.lock`, `renv/`, `.Rprofile`, `DESCRIPTION` (liste des dépendances),
`.github/workflows/renv-lock.yml`.

```yaml
# .github/workflows/renv-lock.yml — lockfile produit SUR la plateforme de CI,
# depuis un instantané DATÉ de Posit Package Manager (versions figées + binaires)
env:
  SNAPSHOT_BINAIRES: https://packagemanager.posit.co/cran/__linux__/noble/2026-10-01
```

**Pièges.**
- Un instantané **daté** du dépôt rend la restauration reproductible *et* rapide
  (binaires) ; `latest` change tous les jours.
- ⚠ *vécu* : avec une version de R très récente (4.6.1 en CI), le dépôt n'avait pas
  encore de binaires : **compilation de DuckDB pendant près d'une heure**. Épingler
  `r-version: "4.5"`.
- ⚠ *vécu* : le snapshot « explicit » n'enregistre pas les `Suggests` : `testthat`
  manquait en CI. Dans un *projet* (pas un package), tout mettre en `Imports`.
- ⚠ *vécu* : `renv::snapshot()` refuse d'écrire si des dépendances de compilation
  (`LinkingTo`) manquent, ce qui est normal avec des binaires : `force = TRUE`.
- Hors renv (conteneur sans CRAN), désactiver l'activation : `RENV_ACTIVATE_PROJECT=FALSE`.
- ⚠ *vécu* : un package **retiré de CRAN** (iscoCrosswalks) est absent des instantanés du
  dépôt : `renv.lock` devient impossible à produire. Pour une petite table de référence,
  l'**embarquer** (`references_externes/`, avec sa provenance et un script d'extraction)
  est plus robuste que d'en dépendre.

## 3. targets / tarchetypes — pipeline

**À quoi ça sert.** Un « make » pour R : chaque résultat est une cible en cache, recalculée
seulement si son code ou ses dépendances changent.

**Où.** `_targets.R`, `R/cibles_analyses.R`, `R/cibles_rendus.R`.

```r
# _targets.R — une branche par version de l'AEI, noms lisibles (parquet_usage_2025_09_15)
cibles_par_version <- tar_map(
  values = dplyr::transmute(versions, release, schema_attendu,
                            suffixe = gsub("-", "_", release)),
  names = "suffixe",
  tar_target(fichiers_bruts, telecharger_fichiers(inventaire, release),
             format = "file"),            # suivi du CONTENU des fichiers
  tar_target(parquet_usage, convertir_en_parquet(fichiers_bruts, ...),
             format = "file")
)
# R/cibles_rendus.R — une cible tar_quarto() par page : dépendances détectées
# automatiquement à partir des tar_read()/tar_load() du document
tarchetypes::tar_quarto_raw("rendu_analyses_01_france", path = "analyses/01_france.qmd")
```

**Pièges.**
- ⚠ *vécu* : `tar_map()` **renomme tout symbole** qui porte le nom d'une cible de la
  branche : une cible `parquet` transformait `chemins()$parquet` en
  `chemins()$parquet_2025_09_15`. Choisir des noms de cibles uniques.
- ⚠ *vécu* : `!!variable` dans une commande est évalué dans l'environnement global,
  pas dans la fonction qui construit la liste de cibles : passer par une fonction
  (`derniere_version()`).
- `format = "file"` pour tout ce qui est écrit sur disque, sinon {targets} ne voit pas
  les changements.
- ⚠ *vécu* : `Mclust()` appelle `mclustBIC()` sans préfixe : `mclust` doit être
  **attaché** (`tar_option_set(packages = ...)`).

## 4. arrow et Parquet partitionné

**À quoi ça sert.** Format colonnaire compressé, lu très vite et seulement sur les colonnes
utiles ; le partitionnement « hive » (`release=2025-09-15/`) permet de ne lire que les
versions nécessaires.

**Où.** `R/stockage.R` (`ecrire_parquet()`), `R/harmonisation.R` (`lire_csv_aei()`).

```r
arrow::write_dataset(donnees, path = dossier, format = "parquet",
                     partitioning = "release",          # un dossier par version
                     compression = "zstd",              # meilleur ratio que snappy
                     existing_data_behavior = "delete_matching")  # réécrire UNE version
```

**Pièges.**
- ⚠ *vécu* : le code ISO-2 de la **Namibie est « NA »** : à la lecture d'un CSV, ne
  traiter que la chaîne vide comme manquante (`na = ""`).
- ⚠ *vécu* (local) : sans accès au binaire libarrow, le package R arrow a été lié à la
  libarrow de **pyarrow de même version** (fichiers `pkg-config` et
  `ArrowOptions.cmake` écrits à la main ; voir `tools/installer_env_local.sh`). Après
  modification des options, recompiler **proprement** (`--preclean`), sinon les anciens
  objets sont réutilisés.

## 5. DuckDB et son SQL

**À quoi ça sert.** Base analytique embarquée : SQL rapide directement sur des fichiers
Parquet, sans serveur ni chargement.

**Où.** `R/stockage.R` (`construire_duckdb()`), `sql/*.sql`, `donnees.qmd` (démonstrations).

```sql
-- sql/vue_04_usage_pays.sql — PIVOT + fonctions fenêtres
WITH brut AS (
    PIVOT (SELECT release, date_start, geo_id, variable, value FROM usage WHERE ...)
    ON variable IN ('usage_pct', 'usage_count', 'usage_per_capita_index')
    USING max(value)
)
SELECT *,
  (usage_pct / sum(usage_pct) OVER (PARTITION BY release, date_start))
  / (working_age_pop / sum(working_age_pop) OVER (PARTITION BY release, date_start)) AS aui_calcule
FROM brut ...;

-- sql/s1_top_taches.sql — QUALIFY : filtrer sur une fonction fenêtre
SELECT ... FROM large QUALIFY row_number() OVER (ORDER BY part_fra DESC) <= {{nb}};
```

Techniques montrées : **vues** (la base ne contient que des vues sur les Parquet),
**CTE**, **`rank`/`lag`/`percent_rank`/`median` en fenêtre**, **`PIVOT`/`UNPIVOT`**,
**`QUALIFY`**, **`GROUP BY ALL`**/**`ORDER BY ALL`**, **`FILTER (WHERE ...)`**,
**`UNION ALL BY NAME`**, **`COPY ... TO ... (FORMAT parquet)`**, **`EXPLAIN ANALYZE`**.

**Pièges.**
- ⚠ *vécu* : DuckDB **devine le type** des partitions hive : `release=2025-09-15` devenait
  une DATE. `hive_types_autocast = false`.
- ⚠ *vécu* : `NULL = NULL` est faux : les versions sans date se perdaient dans une
  jointure `USING (date_start)`. Utiliser `IS NOT DISTINCT FROM`.
- ⚠ *vécu* : `QUALIFY` se place **après** `GROUP BY`, et ne se combine pas avec
  `GROUP BY ALL` (lister les colonnes).
- Ouvrir la base en **lecture seule** pour les rendus (plusieurs processus en parallèle).
- Les chemins des vues sont relatifs : exécuter depuis la racine (`execute-dir: project`).

## 6. dbplyr

**À quoi ça sert.** Écrire en dplyr une requête exécutée par la base (traduction en SQL).

**Où.** `donnees.qmd`, section « Le même calcul en SQL et en dplyr ».

```r
requete <- tbl(con, "automatisation") |>       # référence paresseuse, rien n'est lu
  filter(geo_level == "country") |>
  group_by(release) |>
  summarise(moyenne = mean(automatisation_pct, na.rm = TRUE))
show_query(requete)                              # SQL généré
collect(requete)                                 # exécution par DuckDB
```

**Pièges.** Toutes les fonctions R ne sont pas traduisibles ; `na.rm = TRUE` est
implicite en SQL ; `collect()` rapatrie tout : filtrer avant.

## 7. Quarto : site web, tableau de bord, PDF

**À quoi ça sert.** Un seul projet pour un site (`website`), un tableau de bord
(`format: dashboard`) et un rapport PDF (LaTeX).

**Où.** `_quarto.yml`, `index.qmd`, `analyses/*.qmd`, `dashboard/index.qmd`,
`rapport/rapport.qmd`, `theme/*.scss`.

Fonctions utilisées : thèmes clair/sombre (SCSS), table des matières, **code repliable**
(`code-fold`), **annotations de code** (`code-annotations`), callouts, onglets
(`panel-tabset`), références croisées (`@fig-`, `@tbl-`, `@eq-`), bibliographie,
grille (`.grid`), diagrammes Mermaid, **sorties figées** (`freeze: auto`), R en ligne.

```yaml
execute:
  freeze: auto   # un rendu GLOBAL réutilise _freeze/ si la source n'a pas changé
```

**Pièges.**
- ⚠ *vécu* : avec `freeze: auto`, un rendu **global** ne réexécute pas une page dont seules
  les **données** ont changé : les chiffres seraient périmés. Le pipeline rend donc chaque
  page **individuellement** (exécution forcée).
- ⚠ *vécu* : ne jamais commiter un `_freeze/` produit sur des données fictives : il est
  ignoré localement et versionné uniquement par la CI.
- ⚠ *vécu* (PDF) : babel/polyglossia réinitialisent les libellés au début du document
  (« Table » au lieu de « Tableau ») : redéfinir via `\captionsfrench`. La légende d'un
  tableau doit passer par `tbl-cap` (et non `kable(caption=)`) pour la liste des tableaux.
- ⚠ *vécu* : la locale du conteneur était « C » : accents mal comptés (lintr, analyse des
  documents par {tarchetypes}). Forcer `LANG=C.UTF-8`.

## 8. Observable JS et DuckDB-WASM

**À quoi ça sert.** Interactivité **sans serveur** : une base DuckDB complète s'exécute dans
le navigateur et lit les Parquet publiés avec le site.

**Où.** `dashboard/index.qmd` (page « Pays (interactif) »), `sql/publication.sql`
(fichiers publiés), cible `donnees_publiees`.

```js
db = DuckDBClient.of({ usage: FileAttachment("../donnees_publiees/usage_pays.parquet") })
viewof version = Inputs.select(versions, {label: "Version de l'index"})
aui = db.query(`SELECT geo_id, avg(aui) AS aui FROM usage
                WHERE release = ? GROUP BY ALL`, [version])   // réactif : se recalcule
```

**Pièges.** Les Parquet doivent être déclarés comme **ressources** du projet ; la version de
DuckDB-WASM embarquée par Quarto est plus ancienne que DuckDB natif (éviter le SQL le plus
récent et la liaison de tableaux en paramètres) ; publier des fichiers **petits et
agrégés**.

## 9. htmlwidgets : plotly, reactable, echarts4r

**Où.** Tableau de bord, pages d'analyse.

```r
reactable::reactable(df, searchable = TRUE,
  columns = list(Indice = reactable::colDef(cell = reactable::JS("...barre..."), html = TRUE)))
echarts4r::e_charts(carte, pays) |> echarts4r::e_map(aui, map = "world")
plotly::ggplotly(p, tooltip = "text")
```

**Pièges.** Les noms de pays attendus par la carte echarts ne sont pas des codes ISO :
convertir (`countrycode`, `e_country_names()`) ; textes français de reactable via
`reactableLang()` ; un widget pèse plusieurs centaines de Ko.

## 10. crosstalk

**À quoi ça sert.** Lier plusieurs widgets (sélection dans un tableau = mise en évidence dans
un graphique) dans une page **statique**.

```r
partage <- crosstalk::SharedData$new(dern, key = ~geo_id)
crosstalk::bscols(plotly::plot_ly(partage, ...) |> plotly::highlight(...),
                  reactable::reactable(partage, selection = "multiple"))
```

**Pièges.** Une clé (`key`) unique par ligne ; seuls certains widgets sont compatibles.

## 11. FactoMineR / factoextra — ACP et HCPC

**Où.** `R/analyses.R` (`s4_typologie()`), `analyses/04_typologie.qmd`.

```r
acp  <- FactoMineR::PCA(as.data.frame(z), scale.unit = FALSE, ncp = 10, graph = FALSE)
hcpc <- FactoMineR::HCPC(acp_k, nb.clust = -1, consol = TRUE, graph = FALSE)
factoextra::fviz_pca_var(acp, select.var = list(cos2 = 15), repel = TRUE)
```

**Pièges.** Sur des coordonnées CLR, ne pas réduire (même unité, log-ratio) ;
`nb.clust = -1` coupe l'arbre au plus grand gain d'inertie (choix automatique à
discuter) ; interpréter les classes avec `desc.var` (valeurs-tests).

## 12. mclust — mélanges gaussiens

```r
mc <- mclust::Mclust(coords, G = 2:8)          # modèle et G choisis par BIC
mclust::adjustedRandIndex(part_hcpc, mc$classification)
```

**Pièges.** Dans mclust, le BIC est **à maximiser** (convention de signe inverse de
l'usage courant) ; peu d'observations → modèles simples (EII, VII…) ; ⚠ *vécu* : package à
attacher.

## 13. Transformation CLR (données compositionnelles)

```r
remplacement_multiplicatif <- function(x, delta) { ... }   # zéros -> delta
clr <- function(x) { lx <- log(x); lx - rowMeans(lx) }    # ln(x_j / moyenne géométrique)
```

**Pièges.** Le log de zéro n'existe pas : remplacer les zéros **avant** ; la CLR produit des
coordonnées de somme nulle (matrice de covariance singulière, sans conséquence pour l'ACP).

## 14. LaTeX, KOMA-Script, biblatex/biber

**Où.** `rapport/rapport.qmd`, `rapport/preambule.tex`, `references.bib`.

```yaml
format:
  pdf:
    documentclass: scrartcl
    pdf-engine: xelatex
    cite-method: biblatex          # biber, style auteur-année
    include-in-header: preambule.tex
```

**Pièges.** Voir § 7 (libellés français, `tbl-cap`) ; `fig-format: pdf` pour des figures
vectorielles ; ne citer que des références **vérifiables**.

## 15. testthat

**Où.** `tests/testthat/` (46 tests), `tests/fixtures/` (données **fictives** au format réel).

```r
test_that("normaliser_geo convertit ISO-2 en ISO-3 sans piège", {
  g <- normaliser_geo(c("country", "state_us"), c("NA", "CA"), iso)
  expect_equal(g$geo_id, c("NAM", "US-CA"))   # Namibie ; Californie (pas le Canada)
})
```

**Pièges.** Les fixtures doivent reproduire les **pièges réels** constatés (codes ISO-2,
« CA »…) ; tester les vues SQL dans un dossier temporaire (`withr::local_dir()`).

## 16. lintr

**Où.** `.lintr`, job `lint` de `.github/workflows/build.yml`.

**Pièges.** ⚠ *vécu* : le fichier `.lintr` est au format DCF (pas de commentaire en tête) ;
locale UTF-8 indispensable.

## 17. GitHub Actions

**Où.** `.github/workflows/` : `build.yml` (lint, pipeline réel, rendus, Pages),
`renv-lock.yml` (lockfile), `explorer.yml` (inspection des données).

```yaml
on:
  push: { branches: [main, developpement] }
  workflow_dispatch:
  schedule: [{ cron: "17 5 3 * *" }]     # mensuel
- uses: r-lib/actions/setup-renv@v2       # restaure renv.lock, avec cache
- uses: quarto-dev/quarto-actions/setup@v2
  with: { tinytex: true }
```

**Pièges.** ⚠ *vécu* : le poste de développement n'avait pas accès à Hugging Face :
l'**inspection des vraies données** a été confiée à un workflow qui versionne ses constats
(`docs/exploration/`), avant d'écrire l'harmonisation ; ⚠ *vécu* : un bot qui pousse doit
faire `git pull --rebase --autostash` ; `[skip ci]` évite les boucles ; `workflow_dispatch`
ne fonctionne que si le workflow est sur la branche par défaut.

## 18. GitHub Pages

**Où.** Job `deploy` de `build.yml` (`actions/upload-pages-artifact`, `actions/deploy-pages`).

**Pièges.** Activer Pages avec la source **« GitHub Actions »** (*Settings → Pages*) ;
l'environnement `github-pages` n'autorise par défaut que la branche par défaut (`main`).

## 19. Visualisation accessible

**Où.** `R/config.R` (palettes), `R/graphiques.R` (thème).

Palette catégorielle **validée par calcul** (séparation pour les daltonismes, plancher en
vision normale, bande de luminosité) ; une couleur suit une **entité** (la France est
toujours bleue) ; texte en encre neutre ; une seule échelle par graphique ; textes
alternatifs (`fig-alt`) sur toutes les figures ; tableau associé quand une couleur a un
contraste faible.

⚠ *vécu* : la palette Okabe-Ito initiale échouait au contrôle (jaune trop clair, gris sans
chroma) : remplacée par une palette validée.
