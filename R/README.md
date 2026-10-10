# R/ — fonctions du projet

Chargées par `tar_source("R")` dans `_targets.R`, et par `source()` dans les
documents Quarto. Une famille de fonctions par fichier, documentées avec roxygen.

| Fichier | Rôle |
|---|---|
| `config.R` | Paramètres centraux : versions épinglées, pays, chemins, palette |
| `ingestion.R` | Inventaire et téléchargement des fichiers (phase 2) |
| `harmonisation.R` | Détection du schéma et passage au format long commun (phase 2) |
| `stockage.R` | Écriture Parquet et construction de la base DuckDB (phase 2) |
