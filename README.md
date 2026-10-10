# aei-analyse — L'usage de Claude vu par l'Anthropic Economic Index

> **Statut : projet en construction.** L'arborescence et les commandes ci-dessous
> décrivent l'architecture cible. Elles seront complétées au fil des phases de
> développement (voir [Feuille de route](#feuille-de-route)).

Projet d'analyse de données **reproductible**, rédigé en français, qui explore
l'[Anthropic Economic Index](https://www.anthropic.com/economic-index) (AEI) avec la
stack R moderne : tidyverse, {targets}, arrow/Parquet, DuckDB, Quarto, FactoMineR et
Mclust.

> ⚠️ **Avertissement méthodologique.** L'AEI mesure l'**usage de Claude**
> (conversations anonymisées et agrégées, classées par tâche O\*NET). Ce ne sont
> **pas** des données d'emploi : une part d'usage élevée sur une tâche ne signifie ni
> qu'un métier disparaît, ni qu'il est transformé. Toutes les analyses de ce dépôt
> doivent être lues avec cette réserve.

## Objectifs

Quatre questions d'analyse, chacune traitée dans un document Quarto dédié :

| # | Sujet | Questions principales | Méthodes |
|---|-------|-----------------------|----------|
| 1 | **La France face à Claude** | Profil d'usage français par tâche et par grand groupe de métiers ; comparaison avec DEU, GBR, ESP, ITA, BEL, NLD et USA ; évolution entre versions | Indice d'usage par habitant, `aei_compare()`, concentration (HHI, ratio top-N, entropie de Shannon) |
| 2 | **Automatisation vs augmentation** | Évolution de la part automatisation (directive, feedback loop) vs augmentation (task iteration, learning, validation) ; Claude.ai vs API first-party | Séries par version, ventilations par famille de métiers et par pays, incertitudes, discussion des ruptures méthodologiques |
| 3 | **Exposition des métiers budgétaires et financiers** | Exposition et pénétration des tâches pour les métiers proches du pilotage budgétaire et financier (codes SOC à vérifier dans les données) | `aei_labor_market()`, table de correspondance SOC → ISCO-08 → fonction publique française (**hypothèse de travail**, non officielle) |
| 4 | **Typologie des pays** | Familles de pays selon leur profil d'usage par famille de tâches | Transformation CLR (données compositionnelles), ACP et HCPC (FactoMineR), mélange gaussien (Mclust, BIC), indice de Rand ajusté |

## Livrables

- **Site web Quarto** : accueil, une page par sujet, méthodologie, techniques utilisées.
- **Dashboard Quarto** statique (GitHub Pages) : Observable JS + DuckDB-WASM sur les
  fichiers Parquet publiés, widgets R (plotly, reactable, echarts4r, leaflet, crosstalk).
- **Rapport académique PDF** (Quarto → LaTeX, KOMA-Script, biblatex/biber).
- **Synthèse des techniques** : [`docs/SYNTHESE_TECHNIQUES.md`](docs/SYNTHESE_TECHNIQUES.md).

## Source des données

Les données proviennent du package R [{aieconindex}](https://cran.r-project.org/package=aieconindex)
(licence MIT), qui donne accès aux fichiers publiés par Anthropic (licence
**CC-BY-4.0**).

Versions **épinglées** explicitement dans le pipeline (jamais de « latest ») :

| Version | Remarque |
|---------|----------|
| 2025-02-10 | Première publication |
| 2025-03-27 | |
| 2025-09-15 | Premières données géographiques |
| 2026-01-15 | |
| 2026-03-24 | |
| 2026-06-26 | Passage au schéma mensuel ; fichiers > 200 Mo |

Les écarts de schéma entre versions sont traités dans une **couche d'harmonisation**
dédiée. Les noms de colonnes, facettes et variables sont inspectés et non supposés ; ils
sont documentés dans [`docs/dictionnaire_donnees.md`](docs/dictionnaire_donnees.md).

## Architecture

```
aei-analyse/
├── _targets.R            # Pipeline {targets} : téléchargement → harmonisation → Parquet → DuckDB → analyses → rendus
├── DESCRIPTION           # Dépendances du projet (lues par renv et la CI)
├── renv.lock             # Versions figées des packages (renv)
├── .Rprofile, renv/      # Activation de renv à l'ouverture du projet
├── aei-analyse.Rproj     # Projet RStudio
├── .lintr                # Règles de style (lintr)
├── R/                    # Fonctions R (documentées roxygen) ; R/config.R = paramètres
├── sql/                  # Requêtes DuckDB nommées
├── data/
│   ├── raw/              # Fichiers téléchargés (ignorés par git)
│   ├── parquet/          # Parquet zstd, partitionnés par version (release=…)
│   └── aei.duckdb        # Base DuckDB de vues (ignorée par git)
├── analyses/             # Un .qmd par sujet
├── rapport/              # Rapport académique PDF
├── dashboard/            # Dashboard Quarto
├── tests/                # testthat + fixtures (jeu de données fictif)
├── docs/                 # Diagnostic, dictionnaire de données, synthèse des techniques
├── tools/                # Scripts d'installation de l'environnement de développement local
└── .github/workflows/    # CI/CD : pipeline, rendus, lintr, GitHub Pages
```

Flux de données :

```
aieconindex (CSV) ──► harmonisation ──► Parquet (hive : release=…) ──► DuckDB (vues)
                                                                         │
                     site Quarto · dashboard (DuckDB-WASM) · rapport PDF ◄┘
```

## Installation

Prérequis : **R ≥ 4.3**, [Quarto](https://quarto.org) ≥ 1.4 et une distribution LaTeX
(TinyTeX recommandé : `quarto install tinytex`) pour le PDF.

```r
# Depuis la racine du dépôt
install.packages("renv")
renv::restore()   # installe les versions exactes de renv.lock
```

## Exécution

```r
targets::tar_make()        # exécute tout le pipeline (téléchargement inclus)
targets::tar_visnetwork()  # visualise le graphe des dépendances
testthat::test_dir("tests/testthat")  # tests (sur fixtures)
```

```bash
quarto render              # site web + dashboard
quarto render rapport/ --to pdf   # rapport académique
```

> Le premier lancement télécharge plusieurs centaines de Mo depuis Hugging Face. Les
> fichiers sont mis en cache dans `data/raw/` (cache d'{aieconindex} redirigé).

Sans accès à Hugging Face, le pipeline peut tourner sur le **jeu fictif** de
`tests/fixtures/` (résultats sans valeur analytique, pour le développement) :

```r
Sys.setenv(AEI_MODE = "fixtures")
targets::tar_make()
```

Les paramètres du projet (versions épinglées, pays comparés, chemins, palette) sont
regroupés dans [`R/config.R`](R/config.R).

## Intégration continue

Le workflow GitHub Actions (`.github/workflows/build.yml`) restaure l'environnement
renv, exécute le pipeline, rend le site, le dashboard et le PDF, puis publie sur
GitHub Pages. Il se déclenche à chaque push sur `main`, manuellement
(`workflow_dispatch`) et une fois par mois pour intégrer les nouvelles versions de
l'index. Un job séparé exécute `lintr`.

**Action manuelle requise** : dans *Settings → Pages* du dépôt, choisir la source
**« GitHub Actions »**.

## Feuille de route

- [x] Phase 0 — Diagnostic de l'environnement (`docs/diagnostic_env.md`)
- [x] Phase 1 — Architecture (renv, {targets}, arborescence)
- [ ] Phase 2 — Ingestion, Parquet, DuckDB, harmonisation, tests
- [ ] Phase 3 — Les quatre analyses
- [ ] Phase 4 — Site web Quarto
- [ ] Phase 5 — Dashboard
- [ ] Phase 6 — Rapport académique PDF
- [ ] Phase 7 — CI/CD GitHub Actions et GitHub Pages
- [ ] Phase 8 — Synthèse des techniques

## Licences et citation

- **Code** de ce dépôt : licence à préciser par l'auteur.
- **Package {aieconindex}** : MIT.
- **Données Anthropic Economic Index** : CC-BY-4.0. Toute réutilisation doit créditer
  Anthropic.

Pour citer les données, utiliser la référence fournie par le package :

```r
aieconindex::aei_cite()
```

Références méthodologiques principales :

- Handa, K. et al. (2025). *Which Economic Tasks are Performed with AI? Evidence from
  Millions of Claude Conversations*. arXiv:2503.04761.
- Tamkin, A. et al. (2024). *Clio: Privacy-Preserving Insights into Real-World AI Use*.
  arXiv:2412.13678.
