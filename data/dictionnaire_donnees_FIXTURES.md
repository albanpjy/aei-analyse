# Dictionnaire de données

> **Rappel.** L'Anthropic Economic Index décrit l'**usage de Claude** (conversations
> échantillonnées, anonymisées par Clio, classées par tâche O\*NET), pas l'emploi. Un
> code SOC ou une tâche O\*NET sert ici d'**étiquette de classement d'une
> conversation**, pas de mesure d'un marché du travail.

Ce document combine :

1. une partie **rédigée** (ci-dessous) : les correspondances entre les trois schémas
   successifs de l'AEI, établies en inspectant les vraies données
   ([`docs/exploration/exploration.md`](exploration/exploration.md), généré par
   GitHub Actions) et la documentation officielle de chaque version
   (`docs/exploration/<version>/data_documentation.md`) ;
2. une partie **générée** par le pipeline (`ecrire_dictionnaire()`) : colonnes,
   combinaisons facette × variable réellement observées, inventaire des fichiers.

## 1. Trois schémas successifs

| Époque | Versions | Structure | Géographie | Particularités constatées |
|---|---|---|---|---|
| `wide` | 2025-02-10, 2025-03-27 | un fichier par mesure | aucune (mondial) | pas de dates de collecte dans les fichiers ; en 2025-03-27, fichiers `_v1` (= copie de 2025-02-10) et `_v2` (Claude 3.7 Sonnet) |
| `long` | 2025-09-15, 2026-01-15, 2026-03-24 | `geo_id, geography, date_start, date_end, platform_and_product, facet, level, variable, cluster_name, value` | `global`, `country`, `state_us` (2025-09-15) puis `country-state` (2026) | fichiers **RAW** en codes pays **ISO-2** ; fichier **ENRICHED** (2025-09-15 seulement) en **ISO-3**, avec `geo_name`, parts SOC, indice par habitant |
| `monthly` | 2026-06-26 | `date_start, date_end, geo_id, geo_level, category_name, hierarchy_level, metric_id, value, node_name, node_external_id` | `global`, `country`, `subregion` | **deux mois** (avril et mai 2026) ; valeurs arrondies à 2 décimales ; pas d'effectifs |

## 2. Fichiers retenus par version

| Version | Fichiers | Motif |
|---|---|---|
| 2025-02-10 | `onet_task_mappings.csv`, `automation_vs_augmentation.csv` | parts des tâches et des modes de collaboration (rapport 1) |
| 2025-03-27 | `task_pct_v2.csv`, `automation_vs_augmentation_v2.csv`, `automation_vs_augmentation_by_task.csv` | données du rapport 2 ; les `_v1` sont des doublons de 2025-02-10 |
| 2025-09-15 | `data/output/aei_enriched_claude_ai_*.csv`, `data/intermediate/aei_raw_1p_api_*.csv` + référentiels | l'enriched est le seul fichier Claude.ai en ISO-3 avec parts SOC et indice par habitant |
| 2026-01-15 | `data/intermediate/aei_raw_{claude_ai,1p_api}_*.csv` | seuls fichiers publiés |
| 2026-03-24 | `data/aei_raw_{claude_ai,1p_api}_*.csv` | seuls fichiers publiés |
| 2026-06-26 | `data/aei_{claude_ai,1p_api}_2026-06-26.csv` | un fichier par source |
| non daté | `labor_market_impacts/job_exposure.csv`, `task_penetration.csv` | exposition des métiers (SOC) et pénétration des tâches |

Référentiels (publiés par Anthropic dans `release_2025_09_15/data/intermediate/`) :
`onet_task_statements.csv` (19 530 tâches, colonnes `O*NET-SOC Code`, `Title`,
`Task ID`, `Task`…), `soc_structure.csv`, `iso_country_codes.csv` (GeoNames),
`working_age_pop_2024_country.csv` (Banque mondiale, 15–64 ans).

## 3. Table harmonisée : règles de passage

Chaque fichier est ramené au même schéma long (`R/harmonisation.R`) :

| Colonne harmonisée | `wide` | `long` | `monthly` |
|---|---|---|---|
| `geo_level` | `global` | `geography` : country → `country` ; state_us, country-state → `subregion` | `geo_level` |
| `geo_id` | `GLOBAL` | ISO-2 → **ISO-3** (référentiel GeoNames) ; `state_us` « CA » → « US-CA » | `geo_id` |
| `facet` | `onet_task`, `collaboration`, `onet_task::collaboration` | `facet` | `category_name` |
| `variable` | `onet_task_pct`, `collaboration_pct`, `onet_task_collaboration_pct` | `variable` | `metric_id` |
| `item` | `task_name` / `interaction_type` / « tâche::mode » | `cluster_name` | `node_name` |
| `item_id` | — | — | `node_external_id` (ID de tâche O\*NET, code SOC, code GWA…) |
| `level` | 0 | `level` | `hierarchy_level` |

Pièges traités : le code ISO-2 de la **Namibie est « NA »** (lu comme texte, pas comme
valeur manquante) ; « **CA** » désigne la **Californie** dans les lignes `state_us`
de 2025-09-15 et le **Canada** dans les lignes `country`.

## 4. Concepts communs (vues DuckDB, dossier `sql/`)

| Concept | Vue | `wide` / `long` | `monthly` |
|---|---|---|---|
| Part d'une tâche O\*NET | `parts_taches` | facet `onet_task`, variable `onet_task_pct` | facet `onet`, `level` 0, variable `pct` |
| Mode de collaboration | `collaboration` | facet `collaboration`, variables `collaboration_pct` / `_count` | facet `overall`, variables `collaboration_<mode>_pct` |
| Automatisation / augmentation | `automatisation` | calculées sur les modes classables | idem (et `collaboration_bucket_*` publiés, pour contrôle) |
| Usage d'un pays, indice par habitant | `usage_pays` | facet `country` : `usage_pct`, `usage_count`, `usage_per_capita_index` (enriched) | facet `overall` : `usage_pct`, `usage_per_capita_index` |
| Grand groupe SOC (publié) | `soc_publie` | enriched : facet `soc_occupation`, variable `soc_pct` | facet `soc_occupation`, `level` 1, variable `pct` |
| Grand groupe SOC (dérivé) | `soc_derive` | parts de tâches × correspondance tâche → SOC | idem |
| Famille de tâches (GWA) | `gwa_pays` | — | facet `onet`, `level` 3, variable `pct` |

Définitions (documentation officielle 2025-09-15) : **automatisation** = modes
*directive* + *feedback loop* ; **augmentation** = *task iteration* + *learning* +
*validation* ; parts calculées sur les conversations **classables** (hors *none* et
*not_classified*).

**Ruptures de méthode** à garder en tête : fenêtres d'une semaine (2025-09-15 → 2026-03-24)
puis mois civils (2026-06-26) ; périmètre produit élargi (Free/Pro → Free/Pro/Max → +
Cowork) ; seuils de publication et arrondis différents ; classifieurs mis à jour entre
rapports.

*Partie générée automatiquement par `ecrire_dictionnaire()` le 2026-10-10 (mode fixtures).*

## Colonnes de la table harmonisée (`data/parquet/usage`)

| column_name | column_type |
|---|---|
| schema        | VARCHAR |
| source        | VARCHAR |
| fichier       | VARCHAR |
| date_start    | DATE    |
| date_end      | DATE    |
| geo_level     | VARCHAR |
| geo_id        | VARCHAR |
| geo_id_source | VARCHAR |
| facet         | VARCHAR |
| variable      | VARCHAR |
| item          | VARCHAR |
| item_id       | VARCHAR |
| level         | INTEGER |
| value         | DOUBLE  |
| release       | DATE    |

## Combinaisons observées (version × source × niveau × facette × variable)

| release | schema | source | geo_level | facet | variable | n_lignes | n_geo | n_items |
|---|---|---|---|---|---|---|---|---|
| 2025-02-10 | wide    | claude_ai | global    | collaboration            | collaboration_pct                     |     6 |  1 |   6 |
| 2025-02-10 | wide    | claude_ai | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2025-03-27 | wide    | claude_ai | global    | collaboration            | collaboration_pct                     |     6 |  1 |   6 |
| 2025-03-27 | wide    | claude_ai | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2025-03-27 | wide    | claude_ai | global    | onet_task::collaboration | onet_task_collaboration_pct           |   534 |  1 | 534 |
| 2025-09-15 | long    | 1p_api    | global    | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2025-09-15 | long    | 1p_api    | global    | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2025-09-15 | long    | claude_ai | country   | collaboration            | collaboration_count                   |   210 | 30 |   7 |
| 2025-09-15 | long    | claude_ai | country   | collaboration            | collaboration_pct                     |   210 | 30 |   7 |
| 2025-09-15 | long    | claude_ai | country   | country                  | usage_count                           |    30 | 30 |   0 |
| 2025-09-15 | long    | claude_ai | country   | country                  | usage_pct                             |    30 | 30 |   0 |
| 2025-09-15 | long    | claude_ai | country   | country                  | usage_per_capita_index                |    30 | 30 |   0 |
| 2025-09-15 | long    | claude_ai | country   | onet_task                | onet_task_count                       | 2 670 | 30 |  89 |
| 2025-09-15 | long    | claude_ai | country   | onet_task                | onet_task_pct                         | 2 670 | 30 |  89 |
| 2025-09-15 | long    | claude_ai | country   | soc_occupation           | soc_pct                               |   660 | 30 |  22 |
| 2025-09-15 | long    | claude_ai | global    | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2025-09-15 | long    | claude_ai | global    | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2025-09-15 | long    | claude_ai | global    | onet_task                | onet_task_count                       |    89 |  1 |  89 |
| 2025-09-15 | long    | claude_ai | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2025-09-15 | long    | claude_ai | global    | onet_task::collaboration | onet_task_collaboration_pct           |   623 |  1 | 623 |
| 2025-09-15 | long    | claude_ai | global    | soc_occupation           | soc_pct                               |    22 |  1 |  22 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2025-09-15 | long    | claude_ai | subregion | onet_task                | onet_task_count                       |    89 |  1 |  89 |
| 2025-09-15 | long    | claude_ai | subregion | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-01-15 | long    | 1p_api    | global    | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2026-01-15 | long    | 1p_api    | global    | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-01-15 | long    | claude_ai | country   | collaboration            | collaboration_count                   |   210 | 30 |   7 |
| 2026-01-15 | long    | claude_ai | country   | collaboration            | collaboration_pct                     |   210 | 30 |   7 |
| 2026-01-15 | long    | claude_ai | country   | country                  | usage_count                           |    30 | 30 |   0 |
| 2026-01-15 | long    | claude_ai | country   | country                  | usage_pct                             |    30 | 30 |   0 |
| 2026-01-15 | long    | claude_ai | country   | onet_task                | onet_task_count                       | 2 670 | 30 |  89 |
| 2026-01-15 | long    | claude_ai | country   | onet_task                | onet_task_pct                         | 2 670 | 30 |  89 |
| 2026-01-15 | long    | claude_ai | global    | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2026-01-15 | long    | claude_ai | global    | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2026-01-15 | long    | claude_ai | global    | onet_task                | onet_task_count                       |    89 |  1 |  89 |
| 2026-01-15 | long    | claude_ai | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::collaboration | onet_task_collaboration_pct           |   623 |  1 | 623 |
| 2026-01-15 | long    | claude_ai | subregion | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2026-01-15 | long    | claude_ai | subregion | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2026-01-15 | long    | claude_ai | subregion | onet_task                | onet_task_count                       |    89 |  1 |  89 |
| 2026-01-15 | long    | claude_ai | subregion | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-03-24 | long    | 1p_api    | global    | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2026-03-24 | long    | 1p_api    | global    | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-03-24 | long    | claude_ai | country   | collaboration            | collaboration_count                   |   210 | 30 |   7 |
| 2026-03-24 | long    | claude_ai | country   | collaboration            | collaboration_pct                     |   210 | 30 |   7 |
| 2026-03-24 | long    | claude_ai | country   | country                  | usage_count                           |    30 | 30 |   0 |
| 2026-03-24 | long    | claude_ai | country   | country                  | usage_pct                             |    30 | 30 |   0 |
| 2026-03-24 | long    | claude_ai | country   | onet_task                | onet_task_count                       | 2 670 | 30 |  89 |
| 2026-03-24 | long    | claude_ai | country   | onet_task                | onet_task_pct                         | 2 670 | 30 |  89 |
| 2026-03-24 | long    | claude_ai | global    | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2026-03-24 | long    | claude_ai | global    | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2026-03-24 | long    | claude_ai | global    | onet_task                | onet_task_count                       |    89 |  1 |  89 |
| 2026-03-24 | long    | claude_ai | global    | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::collaboration | onet_task_collaboration_pct           |   623 |  1 | 623 |
| 2026-03-24 | long    | claude_ai | subregion | collaboration            | collaboration_count                   |     7 |  1 |   7 |
| 2026-03-24 | long    | claude_ai | subregion | collaboration            | collaboration_pct                     |     7 |  1 |   7 |
| 2026-03-24 | long    | claude_ai | subregion | onet_task                | onet_task_count                       |    89 |  1 |  89 |
| 2026-03-24 | long    | claude_ai | subregion | onet_task                | onet_task_pct                         |    89 |  1 |  89 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                     | pct                                   |   204 |  1 | 101 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_bucket_augmentation_pct |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_bucket_automation_pct   |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_directive_pct           |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_feedback_loop_pct       |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_learning_pct            |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_none_pct                |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_task_iteration_pct      |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                  | collaboration_validation_pct          |     2 |  1 |   1 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation           | collaboration_bucket_augmentation_pct |    44 |  1 |  22 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation           | collaboration_bucket_automation_pct   |    44 |  1 |  22 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation           | pct                                   |    44 |  1 |  22 |
| 2026-06-26 | monthly | claude_ai | country   | onet                     | pct                                   | 6 120 | 30 | 101 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_bucket_augmentation_pct |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_bucket_automation_pct   |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_directive_pct           |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_feedback_loop_pct       |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_learning_pct            |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_none_pct                |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_task_iteration_pct      |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | collaboration_validation_pct          |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | usage_pct                             |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                  | usage_per_capita_index                |    60 | 30 |   1 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation           | pct                                   | 1 320 | 30 |  22 |
| 2026-06-26 | monthly | claude_ai | global    | onet                     | pct                                   |   204 |  1 | 101 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_bucket_augmentation_pct |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_bucket_automation_pct   |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_directive_pct           |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_feedback_loop_pct       |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_learning_pct            |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_none_pct                |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_task_iteration_pct      |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                  | collaboration_validation_pct          |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation           | collaboration_bucket_augmentation_pct |    44 |  1 |  22 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation           | collaboration_bucket_automation_pct   |    44 |  1 |  22 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation           | pct                                   |    44 |  1 |  22 |
| 2026-06-26 | monthly | claude_ai | subregion | onet                     | pct                                   |   204 |  1 | 101 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_bucket_augmentation_pct |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_bucket_automation_pct   |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_directive_pct           |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_feedback_loop_pct       |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_learning_pct            |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_none_pct                |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_task_iteration_pct      |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                  | collaboration_validation_pct          |     2 |  1 |   1 |
| 2026-06-26 | monthly | claude_ai | subregion | soc_occupation           | pct                                   |    44 |  1 |  22 |

## Inventaire des fichiers publiés

Colonne `retenu` : fichier utilisé par le pipeline (règles de
`fichiers_par_version()`, R/config.R).

| release | chemin | taille_mo | retenu |
|---|---|---|---|
| 2025-02-10 | automation_vs_augmentation.csv                                   | 0.00 | TRUE |
| 2025-02-10 | onet_task_mappings.csv                                           | 0.01 | TRUE |
| 2025-03-27 | automation_vs_augmentation_by_task.csv                           | 0.01 | TRUE |
| 2025-03-27 | automation_vs_augmentation_v2.csv                                | 0.00 | TRUE |
| 2025-03-27 | task_pct_v2.csv                                                  | 0.01 | TRUE |
| 2025-09-15 | data_documentation.md                                            | 0.00 | TRUE |
| 2025-09-15 | data/intermediate/aei_raw_1p_api_2025-08-04_to_2025-08-11.csv    | 0.01 | TRUE |
| 2025-09-15 | data/intermediate/iso_country_codes.csv                          | 0.00 | TRUE |
| 2025-09-15 | data/intermediate/onet_task_statements.csv                       | 0.01 | TRUE |
| 2025-09-15 | data/intermediate/soc_structure.csv                              | 0.00 | TRUE |
| 2025-09-15 | data/intermediate/working_age_pop_2024_country.csv               | 0.00 | TRUE |
| 2025-09-15 | data/output/aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv  | 1.16 | TRUE |
| 2026-01-15 | data_documentation.md                                            | 0.00 | TRUE |
| 2026-01-15 | data/intermediate/aei_raw_1p_api_2025-11-13_to_2025-11-20.csv    | 0.01 | TRUE |
| 2026-01-15 | data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv | 1.02 | TRUE |
| 2026-03-24 | data_documentation.md                                            | 0.00 | TRUE |
| 2026-03-24 | data/aei_raw_1p_api_2026-02-05_to_2026-02-12.csv                 | 0.01 | TRUE |
| 2026-03-24 | data/aei_raw_claude_ai_2026-02-05_to_2026-02-12.csv              | 1.06 | TRUE |
| 2026-06-26 | data_documentation.md                                            | 0.00 | TRUE |
| 2026-06-26 | data/aei_1p_api_2026-06-26.csv                                   | 0.04 | TRUE |
| 2026-06-26 | data/aei_claude_ai_2026-06-26.csv                                | 0.92 | TRUE |
