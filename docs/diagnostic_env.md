# Diagnostic de l'environnement (phase 0)

*Date du diagnostic : 2026-10-10. Environnement : conteneur Claude Code (cloud),
éphémère.*

Ce document répond à une question simple : **qu'est-ce qui peut réellement
s'exécuter ici, et qu'est-ce qui sera confié à GitHub Actions ?**

## 1. Système

| Élément | Valeur |
|---|---|
| OS | Ubuntu 24.04.5 LTS (x86_64) |
| CPU / RAM | 4 cœurs / 15 Gio |
| Python | 3.13 |
| Node.js | 22 |

## 2. Accès réseau

Les sorties passent par un proxy dont la politique est fixée par l'environnement.

| Destination | Accès | Conséquence |
|---|---|---|
| `huggingface.co` (données AEI) | ❌ bloqué (HTTP 403 sur CONNECT) | **Aucune donnée réelle téléchargeable ici** |
| `cloud.r-project.org` (CRAN) | ❌ bloqué | Pas d'`install.packages()` classique |
| `packagemanager.posit.co` (P3M) | ❌ bloqué | Pas de binaires R précompilés |
| `r-universe.dev`, `conda.anaconda.org` | ❌ bloqués | — |
| `quarto.org`, `ctan.org` | ❌ bloqués | Pas d'installeur Quarto officiel, pas de `tlmgr` |
| `archive.ubuntu.com` (apt) | ✅ | R 4.3.3, packages `r-cran-*`, TeX Live 2023 |
| `pypi.org` | ✅ | Quarto (via `quarto-cli`), `pyarrow` |
| `github.com` (git) | ✅ | Miroir CRAN en lecture : `github.com/cran/<package>` |

Vérification avec le package lui-même :

```r
aieconindex::aei_releases()        # OK : renvoie la liste embarquée des 6 versions
aieconindex::aei_files("2026-06-26")
#> Failed to reach the Hugging Face dataset listing ...
#> CONNECT tunnel failed, response 403
```

**Décision, conforme à la consigne : on ne contourne pas le blocage.** Aucune
recherche de miroir non officiel des données. Le code est écrit en entier, testé sur
un **jeu de données fictif** (`tests/fixtures/`), et l'exécution sur les vraies
données est confiée à **GitHub Actions** (phase 7), qui a un accès réseau normal.

## 3. Outils installés

| Outil | Version | Méthode d'installation |
|---|---|---|
| R | 4.3.3 | apt (`r-base-core`, `r-base-dev`) |
| Quarto | 1.10.19 | PyPI (`pip install quarto-cli`) |
| XeLaTeX / LuaLaTeX / pdfLaTeX | TeX Live 2023 | apt |
| biber | 2.19 | apt |
| KOMA-Script, biblatex, polyglossia, babel-french, fontspec, booktabs, unicode-math | TeX Live 2023 | apt (`texlive-latex-extra`, `texlive-lang-french`…) |

## 4. Packages R

| Package | Version | Source |
|---|---|---|
| tidyverse, dbplyr, DBI, testthat, roxygen2, lintr, renv, knitr, rmarkdown | Ubuntu 24.04 | apt (`r-cran-*`) |
| FactoMineR, factoextra, Mclust | Ubuntu 24.04 | apt |
| plotly, crosstalk, htmlwidgets, kableExtra | Ubuntu 24.04 | apt |
| aieconindex | 0.2.0 | sources, miroir `github.com/cran` |
| arrow | 25.0.1 | sources, liée à la bibliothèque C++ de `pyarrow` 25.0.1 (voir § 5) |
| duckdb | 1.5.6 (moteur DuckDB v1.5.6) | sources, miroir `github.com/cran` (compilation ≈ 40 min) |
| targets / tarchetypes | 1.12.0 / 0.14.1 | sources, miroir `github.com/cran` |
| gt, reactable, echarts4r, leaflet, quarto (R), visNetwork | 1.3.0, 0.4.5, 0.5.0, 2.2.3, 1.5.1, 2.1.4 | sources, miroir `github.com/cran` |
| rlang, yaml, data.table, cpp11, igraph, fs, cli, xfun, knitr, rmarkdown… | versions CRAN récentes | sources : mises à jour imposées par les versions minimales des packages ci-dessus |

Tous ces packages se chargent (`library()`), et un document Quarto de test (inline R,
équation LaTeX, requête DuckDB) se rend en **HTML et en PDF** (XeLaTeX + `scrartcl`).

## 5. Points notables

- **arrow sans binaire officiel.** Le package R arrow télécharge normalement sa
  bibliothèque C++ (libarrow) précompilée, ce qui est impossible ici. On a réutilisé la
  libarrow fournie avec la roue Python `pyarrow` de **même version** (25.0.1), via un
  `ARROW_HOME` local avec des fichiers `pkg-config` et `ArrowOptions.cmake` écrits à la
  main. Fonctionnalités vérifiées : `dataset`, `parquet`, `zstd`, `acero` ; écriture et
  relecture d'un jeu Parquet partitionné `release=…`. **Bricolage local uniquement** :
  en CI, arrow s'installe normalement depuis les binaires.
- **Mélange apt + sources.** Les packages apt d'Ubuntu 24.04 datent de début 2024 :
  plusieurs ont dû être recompilés depuis les sources (contraintes `>=`), et la mise à
  jour de `xfun` a cassé l'ancien `knitr` d'apt (export `xfun::attr` disparu). C'est
  l'illustration concrète de l'intérêt de **renv** : figer un ensemble cohérent.
- **Versions R : local ≠ CI.** Les packages venant d'apt sont parfois plus anciens que
  CRAN. Le `renv.lock` de référence sera donc produit dans un environnement à accès
  CRAN normal (GitHub Actions) ; localement, seul le code est validé.
- **Schémas de l'AEI.** Le code d'`aieconindex` (`R/utilities.R`) distingue trois
  époques de schéma, selon la date de version :
  `wide` (≤ 2025-03-27), `long` (2025-09-15 → 2026-03-24) et `monthly`
  (≥ 2026-06-26). C'est **la lecture du code du package, pas une vérification sur les
  données** : les colonnes réelles seront inspectées en CI et consignées dans
  `docs/dictionnaire_donnees.md`.

## 6. Ce qui sera testé où

| Élément | Ici (fixtures) | GitHub Actions (données réelles) |
|---|---|---|
| Fonctions d'harmonisation (testthat) | ✅ | ✅ |
| Conversion Parquet / vues DuckDB | ✅ | ✅ |
| Pipeline `{targets}` complet | partiel (fixtures) | ✅ |
| Rendu du site, du dashboard et du PDF | ✅ (sur fixtures) | ✅ |
| Téléchargement Hugging Face | ❌ | ✅ |
| Chiffres et interprétations | ❌ | ✅ |

## 7. Reconstruire cet environnement

Le conteneur est éphémère. Pour tout réinstaller lors d'une nouvelle session :

```bash
sudo bash tools/installer_env_local.sh   # ~1 h, surtout la compilation de DuckDB
```

- [`tools/installer_env_local.sh`](../tools/installer_env_local.sh) : apt, Quarto via
  PyPI, arrow lié à pyarrow, puis le reste.
- [`tools/installer_depuis_miroir_cran.R`](../tools/installer_depuis_miroir_cran.R) :
  installe depuis `github.com/cran` en résolvant dépendances et versions minimales.

Ces scripts servent **uniquement** au développement local dans ce conteneur. Ils ne
remplacent pas renv.
