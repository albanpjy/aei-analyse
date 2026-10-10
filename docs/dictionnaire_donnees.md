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

*Partie générée automatiquement par `ecrire_dictionnaire()` le 2026-10-10 (mode reel).*

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
| release       | VARCHAR |

## Combinaisons observées (version × source × niveau × facette × variable)

| release | schema | source | geo_level | facet | variable | n_lignes | n_geo | n_items |
|---|---|---|---|---|---|---|---|---|
| 2025-02-10 | wide    | claude_ai | global    | collaboration                         | collaboration_pct                               |       6 |     1 |      6 |
| 2025-02-10 | wide    | claude_ai | global    | onet_task                             | onet_task_pct                                   |   3 514 |     1 |  3 514 |
| 2025-03-27 | wide    | claude_ai | global    | collaboration                         | collaboration_pct                               |       6 |     1 |      6 |
| 2025-03-27 | wide    | claude_ai | global    | onet_task                             | onet_task_pct                                   |   3 365 |     1 |  3 365 |
| 2025-03-27 | wide    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |  20 184 |     1 | 20 184 |
| 2025-09-15 | long    | 1p_api    | global    | collaboration                         | collaboration_count                             |       7 |     1 |      7 |
| 2025-09-15 | long    | 1p_api    | global    | collaboration                         | collaboration_pct                               |       7 |     1 |      7 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task                             | onet_task_count                                 |   2 056 |     1 |  2 056 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task                             | onet_task_pct                                   |   2 056 |     1 |  2 056 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::collaboration              | onet_task_collaboration_count                   |   5 165 |     1 |  5 165 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |   5 165 |     1 |  5 165 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::completion_tokens          | completion_tokens_count                         |   2 055 |     1 |  2 055 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::completion_tokens          | completion_tokens_index                         |   2 055 |     1 |  2 055 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::cost                       | cost_count                                      |   2 055 |     1 |  2 055 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::cost                       | cost_index                                      |   2 055 |     1 |  2 055 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::prompt_tokens              | prompt_tokens_count                             |   2 055 |     1 |  2 055 |
| 2025-09-15 | long    | 1p_api    | global    | onet_task::prompt_tokens              | prompt_tokens_index                             |   2 055 |     1 |  2 055 |
| 2025-09-15 | long    | 1p_api    | global    | request                               | request_count                                   |     509 |     1 |    501 |
| 2025-09-15 | long    | 1p_api    | global    | request                               | request_pct                                     |     509 |     1 |    501 |
| 2025-09-15 | long    | 1p_api    | global    | request::collaboration                | request_collaboration_count                     |   2 995 |     1 |  2 959 |
| 2025-09-15 | long    | 1p_api    | global    | request::collaboration                | request_collaboration_pct                       |   2 995 |     1 |  2 959 |
| 2025-09-15 | long    | claude_ai | country   | collaboration                         | collaboration_count                             |     806 |   158 |      7 |
| 2025-09-15 | long    | claude_ai | country   | collaboration                         | collaboration_pct                               |     806 |   158 |      7 |
| 2025-09-15 | long    | claude_ai | country   | collaboration                         | collaboration_pct_index                         |     555 |   115 |      5 |
| 2025-09-15 | long    | claude_ai | country   | collaboration_automation_augmentation | augmentation_pct                                |     158 |   158 |      1 |
| 2025-09-15 | long    | claude_ai | country   | collaboration_automation_augmentation | automation_pct                                  |     158 |   158 |      1 |
| 2025-09-15 | long    | claude_ai | country   | country                               | gdp_per_working_age_capita                      |     174 |   174 |      0 |
| 2025-09-15 | long    | claude_ai | country   | country                               | usage_count                                     |     201 |   201 |      0 |
| 2025-09-15 | long    | claude_ai | country   | country                               | usage_pct                                       |     201 |   201 |      0 |
| 2025-09-15 | long    | claude_ai | country   | country                               | usage_per_capita                                |     194 |   194 |      0 |
| 2025-09-15 | long    | claude_ai | country   | country                               | usage_per_capita_index                          |     194 |   194 |      0 |
| 2025-09-15 | long    | claude_ai | country   | country                               | usage_tier                                      |     194 |   194 |      5 |
| 2025-09-15 | long    | claude_ai | country   | country                               | working_age_pop                                 |     194 |   194 |      0 |
| 2025-09-15 | long    | claude_ai | country   | onet_task                             | onet_task_count                                 |   7 251 |   114 |  1 279 |
| 2025-09-15 | long    | claude_ai | country   | onet_task                             | onet_task_pct                                   |   7 251 |   114 |  1 279 |
| 2025-09-15 | long    | claude_ai | country   | onet_task                             | onet_task_pct_index                             |   7 037 |   111 |  1 277 |
| 2025-09-15 | long    | claude_ai | country   | request                               | request_count                                   |  18 229 |   133 |    703 |
| 2025-09-15 | long    | claude_ai | country   | request                               | request_pct                                     |  18 229 |   133 |    703 |
| 2025-09-15 | long    | claude_ai | country   | request                               | request_pct_index                               |  17 879 |   115 |    702 |
| 2025-09-15 | long    | claude_ai | country   | soc_occupation                        | soc_pct                                         |     830 |   112 |     23 |
| 2025-09-15 | long    | claude_ai | global    | collaboration                         | collaboration_count                             |       7 |     1 |      7 |
| 2025-09-15 | long    | claude_ai | global    | collaboration                         | collaboration_pct                               |       7 |     1 |      7 |
| 2025-09-15 | long    | claude_ai | global    | collaboration_automation_augmentation | augmentation_pct                                |       1 |     1 |      1 |
| 2025-09-15 | long    | claude_ai | global    | collaboration_automation_augmentation | automation_pct                                  |       1 |     1 |      1 |
| 2025-09-15 | long    | claude_ai | global    | onet_task                             | onet_task_count                                 |   2 618 |     1 |  2 618 |
| 2025-09-15 | long    | claude_ai | global    | onet_task                             | onet_task_pct                                   |   2 618 |     1 |  2 618 |
| 2025-09-15 | long    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_count                   |   7 227 |     1 |  7 227 |
| 2025-09-15 | long    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |   7 227 |     1 |  7 227 |
| 2025-09-15 | long    | claude_ai | global    | request                               | request_count                                   |     722 |     1 |    704 |
| 2025-09-15 | long    | claude_ai | global    | request                               | request_pct                                     |     722 |     1 |    704 |
| 2025-09-15 | long    | claude_ai | global    | request::collaboration                | request_collaboration_count                     |   4 254 |     1 |  4 160 |
| 2025-09-15 | long    | claude_ai | global    | request::collaboration                | request_collaboration_pct                       |   4 254 |     1 |  4 160 |
| 2025-09-15 | long    | claude_ai | global    | soc_occupation                        | soc_pct                                         |      23 |     1 |     23 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration                         | collaboration_count                             |     299 |    51 |      7 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration                         | collaboration_pct                               |     299 |    51 |      7 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration                         | collaboration_pct_index                         |     247 |    51 |      5 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration_automation_augmentation | augmentation_pct                                |      51 |    51 |      1 |
| 2025-09-15 | long    | claude_ai | subregion | collaboration_automation_augmentation | automation_pct                                  |      51 |    51 |      1 |
| 2025-09-15 | long    | claude_ai | subregion | onet_task                             | onet_task_count                                 |   2 171 |    47 |    449 |
| 2025-09-15 | long    | claude_ai | subregion | onet_task                             | onet_task_pct                                   |   2 171 |    47 |    449 |
| 2025-09-15 | long    | claude_ai | subregion | onet_task                             | onet_task_pct_index                             |   2 078 |    44 |    447 |
| 2025-09-15 | long    | claude_ai | subregion | request                               | request_count                                   |   6 222 |    51 |    685 |
| 2025-09-15 | long    | claude_ai | subregion | request                               | request_pct                                     |   6 222 |    51 |    685 |
| 2025-09-15 | long    | claude_ai | subregion | request                               | request_pct_index                               |   6 098 |    51 |    684 |
| 2025-09-15 | long    | claude_ai | subregion | soc_occupation                        | soc_pct                                         |     355 |    47 |     22 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | gdp_per_working_age_capita                      |      51 |    51 |      0 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | usage_count                                     |      52 |    52 |      0 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | usage_pct                                       |      52 |    52 |      0 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | usage_per_capita                                |      51 |    51 |      0 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | usage_per_capita_index                          |      51 |    51 |      0 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | usage_tier                                      |      51 |    51 |      4 |
| 2025-09-15 | long    | claude_ai | subregion | state_us                              | working_age_pop                                 |      51 |    51 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_count                               |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_histogram_count                     |       5 |     1 |      5 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_histogram_pct                       |       5 |     1 |      5 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_mean                                |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_median                              |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_median_ci_lower                     |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_median_ci_upper                     |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_stdev                               |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_count                        |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_histogram_count              |      21 |     1 |     21 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_histogram_pct                |      21 |     1 |     21 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_mean                         |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_mean_ci_lower                |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_mean_ci_upper                |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_median                       |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_median_ci_lower              |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_median_ci_upper              |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_stdev                        |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | collaboration                         | collaboration_count                             |       7 |     1 |      7 |
| 2026-01-15 | long    | 1p_api    | global    | collaboration                         | collaboration_pct                               |       7 |     1 |      7 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_count                     |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_histogram_count           |      21 |     1 |     21 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_histogram_pct             |      21 |     1 |     21 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_mean                      |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_mean_ci_lower             |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_mean_ci_upper             |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_median                    |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_median_ci_lower           |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_median_ci_upper           |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_education_years                 | human_education_years_stdev                     |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_ability                    | human_only_ability_count                        |       2 |     1 |      2 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_ability                    | human_only_ability_pct                          |       2 |     1 |      2 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_count                           |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_histogram_count                 |      25 |     1 |     25 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_histogram_pct                   |      25 |     1 |     25 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_mean                            |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_mean_ci_lower                   |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_mean_ci_upper                   |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_median                          |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_median_ci_lower                 |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_median_ci_upper                 |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_only_time                       | human_only_time_stdev                           |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_count                        |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_histogram_count              |      25 |     1 |     25 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_histogram_pct                |      25 |     1 |     25 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_mean                         |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_mean_ci_lower                |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_mean_ci_upper                |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_median                       |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_median_ci_lower              |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_median_ci_upper              |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_stdev                        |       1 |     1 |      0 |
| 2026-01-15 | long    | 1p_api    | global    | multitasking                          | multitasking_count                              |       2 |     1 |      2 |
| 2026-01-15 | long    | 1p_api    | global    | multitasking                          | multitasking_pct                                |       2 |     1 |      2 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task                             | onet_task_count                                 |   2 253 |     1 |  2 253 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task                             | onet_task_pct                                   |   2 253 |     1 |  2 253 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_count                     |   2 303 |     1 |  2 303 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean                      |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_lower             |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_upper             |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median                    |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_lower           |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_upper           |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_pct                       |   2 303 |     1 |  2 303 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_stdev                     |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_count              |   2 255 |     1 |  2 255 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean               |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_lower      |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_upper      |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median             |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_lower    |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_upper    |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_pct                |   2 255 |     1 |  2 255 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_stdev              |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::collaboration              | onet_task_collaboration_count                   |   5 556 |     1 |  5 556 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |   5 556 |     1 |  5 556 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::completion_tokens          | completion_tokens_index                         |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::cost                       | cost_index                                      |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_count           |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_mean            |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_lower   |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_upper   |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_median          |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_lower |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_upper |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_pct             |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_stdev           |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_ability         | onet_task_human_only_ability_count              |   3 928 |     1 |  3 928 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_ability         | onet_task_human_only_ability_pct                |   3 928 |     1 |  3 928 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_count                 |   2 254 |     1 |  2 254 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_mean                  |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_lower         |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_upper         |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_median                |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_lower       |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_upper       |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_pct                   |   2 254 |     1 |  2 254 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_stdev                 |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_count              |   2 253 |     1 |  2 253 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean               |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_lower      |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_upper      |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median             |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_lower    |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_upper    |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_pct                |   2 253 |     1 |  2 253 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_stdev              |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::multitasking               | onet_task_multitasking_count                    |   3 706 |     1 |  3 706 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::multitasking               | onet_task_multitasking_pct                      |   3 706 |     1 |  3 706 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::prompt_tokens              | prompt_tokens_index                             |   2 252 |     1 |  2 252 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::task_success               | onet_task_task_success_count                    |   4 059 |     1 |  4 059 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::task_success               | onet_task_task_success_pct                      |   4 059 |     1 |  4 059 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::use_case                   | onet_task_use_case_count                        |   4 878 |     1 |  4 878 |
| 2026-01-15 | long    | 1p_api    | global    | onet_task::use_case                   | onet_task_use_case_pct                          |   4 878 |     1 |  4 878 |
| 2026-01-15 | long    | 1p_api    | global    | request                               | request_count                                   |     439 |     1 |    423 |
| 2026-01-15 | long    | 1p_api    | global    | request                               | request_pct                                     |     439 |     1 |    423 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_count                       |     453 |     1 |    439 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_mean                        |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_lower               |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_upper               |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_median                      |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_pct                         |     453 |     1 |    439 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_stdev                       |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_count                |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_mean                 |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_mean_ci_lower        |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_mean_ci_upper        |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_median               |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_pct                  |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_stdev                |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::collaboration                | request_collaboration_count                     |   2 567 |     1 |  2 483 |
| 2026-01-15 | long    | 1p_api    | global    | request::collaboration                | request_collaboration_pct                       |   2 567 |     1 |  2 483 |
| 2026-01-15 | long    | 1p_api    | global    | request::completion_tokens            | completion_tokens_index                         |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::cost                         | cost_index                                      |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_count             |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_mean              |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_mean_ci_lower     |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_mean_ci_upper     |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_median            |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_pct               |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_stdev             |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_ability           | request_human_only_ability_count                |     866 |     1 |    838 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_ability           | request_human_only_ability_pct                  |     866 |     1 |    838 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_count                   |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_mean                    |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_mean_ci_lower           |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_mean_ci_upper           |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_median                  |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_pct                     |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_stdev                   |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_count                |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_mean                 |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_lower        |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_upper        |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_median               |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_pct                  |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_stdev                |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::multitasking                 | request_multitasking_count                      |     871 |     1 |    844 |
| 2026-01-15 | long    | 1p_api    | global    | request::multitasking                 | request_multitasking_pct                        |     871 |     1 |    844 |
| 2026-01-15 | long    | 1p_api    | global    | request::prompt_tokens                | prompt_tokens_index                             |     436 |     1 |    422 |
| 2026-01-15 | long    | 1p_api    | global    | request::task_success                 | request_task_success_count                      |     872 |     1 |    844 |
| 2026-01-15 | long    | 1p_api    | global    | request::task_success                 | request_task_success_pct                        |     872 |     1 |    844 |
| 2026-01-15 | long    | 1p_api    | global    | request::use_case                     | request_use_case_count                          |   1 351 |     1 |  1 307 |
| 2026-01-15 | long    | 1p_api    | global    | request::use_case                     | request_use_case_pct                            |   1 351 |     1 |  1 307 |
| 2026-01-15 | long    | 1p_api    | global    | task_success                          | task_success_count                              |       2 |     1 |      2 |
| 2026-01-15 | long    | 1p_api    | global    | task_success                          | task_success_pct                                |       2 |     1 |      2 |
| 2026-01-15 | long    | 1p_api    | global    | use_case                              | use_case_count                                  |       4 |     1 |      4 |
| 2026-01-15 | long    | 1p_api    | global    | use_case                              | use_case_pct                                    |       4 |     1 |      4 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_count                               |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_mean                                |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_median                              |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_median_ci_lower                     |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_median_ci_upper                     |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_stdev                               |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_count                        |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_mean                         |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_mean_ci_lower                |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_mean_ci_upper                |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_median                       |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_median_ci_lower              |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_median_ci_upper              |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_stdev                        |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | collaboration                         | collaboration_count                             |     818 |   155 |      7 |
| 2026-01-15 | long    | claude_ai | country   | collaboration                         | collaboration_pct                               |     818 |   155 |      7 |
| 2026-01-15 | long    | claude_ai | country   | country                               | usage_count                                     |     174 |   174 |      0 |
| 2026-01-15 | long    | claude_ai | country   | country                               | usage_pct                                       |     174 |   174 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_count                     |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_mean                      |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_mean_ci_lower             |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_mean_ci_upper             |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_median                    |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_median_ci_lower           |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_median_ci_upper           |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_education_years                 | human_education_years_stdev                     |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_ability                    | human_only_ability_count                        |     339 |   171 |      3 |
| 2026-01-15 | long    | claude_ai | country   | human_only_ability                    | human_only_ability_pct                          |     339 |   171 |      3 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_count                           |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_mean                            |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_mean_ci_lower                   |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_mean_ci_upper                   |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_median                          |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_median_ci_lower                 |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_median_ci_upper                 |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_only_time                       | human_only_time_stdev                           |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_count                        |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_mean                         |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_mean_ci_lower                |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_mean_ci_upper                |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_median                       |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_median_ci_lower              |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_median_ci_upper              |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_stdev                        |     173 |   173 |      0 |
| 2026-01-15 | long    | claude_ai | country   | multitasking                          | multitasking_count                              |     341 |   171 |      3 |
| 2026-01-15 | long    | claude_ai | country   | multitasking                          | multitasking_pct                                |     341 |   171 |      3 |
| 2026-01-15 | long    | claude_ai | country   | onet_task                             | onet_task_count                                 |   7 290 |   117 |  1 470 |
| 2026-01-15 | long    | claude_ai | country   | onet_task                             | onet_task_pct                                   |   7 290 |   117 |  1 470 |
| 2026-01-15 | long    | claude_ai | country   | request                               | request_count                                   |  18 980 |   129 |    738 |
| 2026-01-15 | long    | claude_ai | country   | request                               | request_pct                                     |  18 980 |   129 |    738 |
| 2026-01-15 | long    | claude_ai | country   | task_success                          | task_success_count                              |     336 |   168 |      3 |
| 2026-01-15 | long    | claude_ai | country   | task_success                          | task_success_pct                                |     336 |   168 |      3 |
| 2026-01-15 | long    | claude_ai | country   | use_case                              | use_case_count                                  |     517 |   161 |      4 |
| 2026-01-15 | long    | claude_ai | country   | use_case                              | use_case_pct                                    |     517 |   161 |      4 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_count                               |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_histogram_count                     |       5 |     1 |      5 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_histogram_pct                       |       5 |     1 |      5 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_mean                                |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_median                              |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_median_ci_lower                     |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_median_ci_upper                     |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_stdev                               |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_count                        |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_histogram_count              |      21 |     1 |     21 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_histogram_pct                |      21 |     1 |     21 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_mean                         |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_mean_ci_lower                |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_mean_ci_upper                |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_median                       |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_median_ci_lower              |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_median_ci_upper              |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_stdev                        |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | collaboration                         | collaboration_count                             |       6 |     1 |      6 |
| 2026-01-15 | long    | claude_ai | global    | collaboration                         | collaboration_pct                               |       6 |     1 |      6 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_count                     |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_histogram_count           |      21 |     1 |     21 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_histogram_pct             |      21 |     1 |     21 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_mean                      |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_mean_ci_lower             |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_mean_ci_upper             |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_median                    |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_median_ci_lower           |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_median_ci_upper           |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_education_years                 | human_education_years_stdev                     |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_ability                    | human_only_ability_count                        |       2 |     1 |      2 |
| 2026-01-15 | long    | claude_ai | global    | human_only_ability                    | human_only_ability_pct                          |       2 |     1 |      2 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_count                           |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_histogram_count                 |      25 |     1 |     25 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_histogram_pct                   |      25 |     1 |     25 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_mean                            |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_mean_ci_lower                   |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_mean_ci_upper                   |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_median                          |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_median_ci_lower                 |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_median_ci_upper                 |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_only_time                       | human_only_time_stdev                           |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_count                        |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_histogram_count              |      25 |     1 |     25 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_histogram_pct                |      25 |     1 |     25 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_mean                         |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_mean_ci_lower                |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_mean_ci_upper                |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_median                       |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_median_ci_lower              |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_median_ci_upper              |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_stdev                        |       1 |     1 |      0 |
| 2026-01-15 | long    | claude_ai | global    | multitasking                          | multitasking_count                              |       2 |     1 |      2 |
| 2026-01-15 | long    | claude_ai | global    | multitasking                          | multitasking_pct                                |       2 |     1 |      2 |
| 2026-01-15 | long    | claude_ai | global    | onet_task                             | onet_task_count                                 |   3 170 |     1 |  3 170 |
| 2026-01-15 | long    | claude_ai | global    | onet_task                             | onet_task_pct                                   |   3 170 |     1 |  3 170 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_count                     |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean                      |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_lower             |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_upper             |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median                    |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_lower           |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_upper           |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_pct                       |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_stdev                     |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_count              |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean               |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_lower      |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_upper      |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median             |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_lower    |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_upper    |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_pct                |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_stdev              |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_count                   |   8 389 |     1 |  8 389 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |   8 389 |     1 |  8 389 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_count           |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_mean            |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_lower   |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_upper   |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_median          |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_lower |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_upper |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_pct             |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_stdev           |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_ability         | onet_task_human_only_ability_count              |   5 537 |     1 |  5 537 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_ability         | onet_task_human_only_ability_pct                |   5 537 |     1 |  5 537 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_count                 |   3 175 |     1 |  3 175 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_mean                  |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_lower         |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_upper         |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_median                |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_lower       |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_upper       |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_pct                   |   3 175 |     1 |  3 175 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_stdev                 |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_count              |   3 172 |     1 |  3 172 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean               |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_lower      |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_upper      |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median             |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_lower    |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_upper    |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_pct                |   3 172 |     1 |  3 172 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_stdev              |   3 169 |     1 |  3 169 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::multitasking               | onet_task_multitasking_count                    |   5 915 |     1 |  5 915 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::multitasking               | onet_task_multitasking_pct                      |   5 915 |     1 |  5 915 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::task_success               | onet_task_task_success_count                    |   5 770 |     1 |  5 770 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::task_success               | onet_task_task_success_pct                      |   5 770 |     1 |  5 770 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::use_case                   | onet_task_use_case_count                        |   6 954 |     1 |  6 954 |
| 2026-01-15 | long    | claude_ai | global    | onet_task::use_case                   | onet_task_use_case_pct                          |   6 954 |     1 |  6 954 |
| 2026-01-15 | long    | claude_ai | global    | request                               | request_count                                   |     754 |     1 |    738 |
| 2026-01-15 | long    | claude_ai | global    | request                               | request_pct                                     |     754 |     1 |    738 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_count                       |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_mean                        |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_lower               |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_upper               |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_median                      |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_pct                         |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_stdev                       |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_count                |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_mean                 |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_mean_ci_lower        |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_mean_ci_upper        |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_median               |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_pct                  |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_stdev                |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::collaboration                | request_collaboration_count                     |   4 416 |     1 |  4 333 |
| 2026-01-15 | long    | claude_ai | global    | request::collaboration                | request_collaboration_pct                       |   4 416 |     1 |  4 333 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_count             |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_mean              |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_mean_ci_lower     |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_mean_ci_upper     |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_median            |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_pct               |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_stdev             |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_ability           | request_human_only_ability_count                |   1 501 |     1 |  1 473 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_ability           | request_human_only_ability_pct                  |   1 501 |     1 |  1 473 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_count                   |     769 |     1 |    755 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_mean                    |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_mean_ci_lower           |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_mean_ci_upper           |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_median                  |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_pct                     |     769 |     1 |    755 |
| 2026-01-15 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_stdev                   |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_count                |     754 |     1 |    740 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_mean                 |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_lower        |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_upper        |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_median               |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_pct                  |     754 |     1 |    740 |
| 2026-01-15 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_stdev                |     751 |     1 |    737 |
| 2026-01-15 | long    | claude_ai | global    | request::multitasking                 | request_multitasking_count                      |   1 497 |     1 |  1 469 |
| 2026-01-15 | long    | claude_ai | global    | request::multitasking                 | request_multitasking_pct                        |   1 497 |     1 |  1 469 |
| 2026-01-15 | long    | claude_ai | global    | request::task_success                 | request_task_success_count                      |   1 502 |     1 |  1 474 |
| 2026-01-15 | long    | claude_ai | global    | request::task_success                 | request_task_success_pct                        |   1 502 |     1 |  1 474 |
| 2026-01-15 | long    | claude_ai | global    | request::use_case                     | request_use_case_count                          |   2 391 |     1 |  2 347 |
| 2026-01-15 | long    | claude_ai | global    | request::use_case                     | request_use_case_pct                            |   2 391 |     1 |  2 347 |
| 2026-01-15 | long    | claude_ai | global    | task_success                          | task_success_count                              |       2 |     1 |      2 |
| 2026-01-15 | long    | claude_ai | global    | task_success                          | task_success_pct                                |       2 |     1 |      2 |
| 2026-01-15 | long    | claude_ai | global    | use_case                              | use_case_count                                  |       4 |     1 |      4 |
| 2026-01-15 | long    | claude_ai | global    | use_case                              | use_case_pct                                    |       4 |     1 |      4 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_count                               |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_mean                                |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_median                              |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_median_ci_lower                     |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_median_ci_upper                     |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_stdev                               |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_count                        |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_mean                         |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_mean_ci_lower                |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_mean_ci_upper                |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_median                       |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_median_ci_lower              |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_median_ci_upper              |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_stdev                        |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | collaboration                         | collaboration_count                             |   3 601 |   754 |      7 |
| 2026-01-15 | long    | claude_ai | subregion | collaboration                         | collaboration_pct                               |   3 601 |   754 |      7 |
| 2026-01-15 | long    | claude_ai | subregion | country-state                         | usage_count                                     |   1 091 | 1 091 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | country-state                         | usage_pct                                       |   1 091 | 1 091 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_count                     |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_mean                      |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_mean_ci_lower             |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_mean_ci_upper             |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_median                    |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_median_ci_lower           |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_median_ci_upper           |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_education_years                 | human_education_years_stdev                     |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_ability                    | human_only_ability_count                        |   1 869 |   938 |      3 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_ability                    | human_only_ability_pct                          |   1 869 |   938 |      3 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_count                           |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_mean                            |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_mean_ci_lower                   |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_mean_ci_upper                   |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_median                          |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_median_ci_lower                 |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_median_ci_upper                 |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_only_time                       | human_only_time_stdev                           |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_count                        |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_mean                         |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_mean_ci_lower                |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_mean_ci_upper                |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_median                       |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_median_ci_lower              |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_median_ci_upper              |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_stdev                        |     981 |   981 |      0 |
| 2026-01-15 | long    | claude_ai | subregion | multitasking                          | multitasking_count                              |   1 882 |   955 |      3 |
| 2026-01-15 | long    | claude_ai | subregion | multitasking                          | multitasking_pct                                |   1 882 |   955 |      3 |
| 2026-01-15 | long    | claude_ai | subregion | onet_task                             | onet_task_count                                 |   7 295 |   392 |    439 |
| 2026-01-15 | long    | claude_ai | subregion | onet_task                             | onet_task_pct                                   |   7 295 |   392 |    439 |
| 2026-01-15 | long    | claude_ai | subregion | request                               | request_count                                   |  25 129 |   564 |    735 |
| 2026-01-15 | long    | claude_ai | subregion | request                               | request_pct                                     |  25 129 |   564 |    735 |
| 2026-01-15 | long    | claude_ai | subregion | task_success                          | task_success_count                              |   1 771 |   886 |      3 |
| 2026-01-15 | long    | claude_ai | subregion | task_success                          | task_success_pct                                |   1 771 |   886 |      3 |
| 2026-01-15 | long    | claude_ai | subregion | use_case                              | use_case_count                                  |   2 472 |   830 |      4 |
| 2026-01-15 | long    | claude_ai | subregion | use_case                              | use_case_pct                                    |   2 472 |   830 |      4 |
| 2026-03-24 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_count                               |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_histogram_count                     |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_histogram_pct                       |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_mean                                |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_median                              |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_autonomy                           | ai_autonomy_stdev                               |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_count                        |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_histogram_count              |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_histogram_pct                |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_mean                         |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_mean_ci_lower                |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_mean_ci_upper                |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_median                       |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_median_ci_lower              |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_median_ci_upper              |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | ai_education_years                    | ai_education_years_stdev                        |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | collaboration                         | collaboration_count                             |       6 |     1 |      6 |
| 2026-03-24 | long    | 1p_api    | global    | collaboration                         | collaboration_pct                               |       6 |     1 |      6 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_count                     |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_histogram_count           |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_histogram_pct             |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_mean                      |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_mean_ci_lower             |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_mean_ci_upper             |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_median                    |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_median_ci_lower           |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_median_ci_upper           |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_education_years                 | human_education_years_stdev                     |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_ability                    | human_only_ability_count                        |       3 |     1 |      3 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_ability                    | human_only_ability_pct                          |       3 |     1 |      3 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_time                       | human_only_time_count                           |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_time                       | human_only_time_histogram_count                 |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_time                       | human_only_time_histogram_pct                   |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_time                       | human_only_time_mean                            |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_time                       | human_only_time_median                          |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_only_time                       | human_only_time_stdev                           |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_count                        |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_histogram_count              |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_histogram_pct                |      25 |     1 |     25 |
| 2026-03-24 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_mean                         |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_median                       |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | human_with_ai_time                    | human_with_ai_time_stdev                        |       1 |     1 |      0 |
| 2026-03-24 | long    | 1p_api    | global    | multitasking                          | multitasking_count                              |       3 |     1 |      3 |
| 2026-03-24 | long    | 1p_api    | global    | multitasking                          | multitasking_pct                                |       3 |     1 |      3 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task                             | onet_task_count                                 |   2 299 |     1 |  2 299 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task                             | onet_task_pct                                   |   2 299 |     1 |  2 299 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_count                     |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean                      |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_lower             |   2 294 |     1 |  2 294 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_upper             |   2 294 |     1 |  2 294 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median                    |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_lower           |   2 294 |     1 |  2 294 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_upper           |   2 294 |     1 |  2 294 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_pct                       |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_stdev                     |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_count              |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean               |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_lower      |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_upper      |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median             |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_lower    |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_upper    |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_pct                |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::ai_education_years         | onet_task_ai_education_years_stdev              |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::collaboration              | onet_task_collaboration_count                   |   5 830 |     1 |  5 830 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |   5 830 |     1 |  5 830 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::completion_tokens          | completion_tokens_index                         |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::cost                       | cost_index                                      |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_count           |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_mean            |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_lower   |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_upper   |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_median          |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_lower |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_upper |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_pct             |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_education_years      | onet_task_human_education_years_stdev           |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_ability         | onet_task_human_only_ability_count              |   4 066 |     1 |  4 066 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_ability         | onet_task_human_only_ability_pct                |   4 066 |     1 |  4 066 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_count                 |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_mean                  |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_lower         |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_upper         |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_median                |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_lower       |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_upper       |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_pct                   |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_only_time            | onet_task_human_only_time_stdev                 |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_count              |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean               |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_lower      |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_upper      |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median             |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_lower    |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_upper    |   2 297 |     1 |  2 297 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_pct                |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_stdev              |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::multitasking               | onet_task_multitasking_count                    |   3 891 |     1 |  3 891 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::multitasking               | onet_task_multitasking_pct                      |   3 891 |     1 |  3 891 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::prompt_tokens              | prompt_tokens_index                             |   2 298 |     1 |  2 298 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::task_success               | onet_task_task_success_count                    |   4 128 |     1 |  4 128 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::task_success               | onet_task_task_success_pct                      |   4 128 |     1 |  4 128 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::use_case                   | onet_task_use_case_count                        |   4 937 |     1 |  4 937 |
| 2026-03-24 | long    | 1p_api    | global    | onet_task::use_case                   | onet_task_use_case_pct                          |   4 937 |     1 |  4 937 |
| 2026-03-24 | long    | 1p_api    | global    | request                               | request_count                                   |     493 |     1 |    477 |
| 2026-03-24 | long    | 1p_api    | global    | request                               | request_pct                                     |     493 |     1 |    477 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_count                       |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_mean                        |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_lower               |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_upper               |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_median                      |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_pct                         |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_autonomy                  | request_ai_autonomy_stdev                       |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_count                |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_mean                 |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_mean_ci_lower        |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_mean_ci_upper        |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_median               |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_pct                  |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::ai_education_years           | request_ai_education_years_stdev                |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::collaboration                | request_collaboration_count                     |   2 864 |     1 |  2 780 |
| 2026-03-24 | long    | 1p_api    | global    | request::collaboration                | request_collaboration_pct                       |   2 864 |     1 |  2 780 |
| 2026-03-24 | long    | 1p_api    | global    | request::completion_tokens            | completion_tokens_index                         |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::cost                         | cost_index                                      |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_count             |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_mean              |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_mean_ci_lower     |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_mean_ci_upper     |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_median            |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_pct               |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_education_years        | request_human_education_years_stdev             |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_ability           | request_human_only_ability_count                |     978 |     1 |    950 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_ability           | request_human_only_ability_pct                  |     978 |     1 |    950 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_count                   |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_mean                    |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_mean_ci_lower           |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_mean_ci_upper           |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_median                  |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_pct                     |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_only_time              | request_human_only_time_stdev                   |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_count                |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_mean                 |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_lower        |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_upper        |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_median               |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_pct                  |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::human_with_ai_time           | request_human_with_ai_time_stdev                |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::multitasking                 | request_multitasking_count                      |     980 |     1 |    952 |
| 2026-03-24 | long    | 1p_api    | global    | request::multitasking                 | request_multitasking_pct                        |     980 |     1 |    952 |
| 2026-03-24 | long    | 1p_api    | global    | request::prompt_tokens                | prompt_tokens_index                             |     490 |     1 |    476 |
| 2026-03-24 | long    | 1p_api    | global    | request::task_success                 | request_task_success_count                      |     983 |     1 |    955 |
| 2026-03-24 | long    | 1p_api    | global    | request::task_success                 | request_task_success_pct                        |     983 |     1 |    955 |
| 2026-03-24 | long    | 1p_api    | global    | request::use_case                     | request_use_case_count                          |   1 521 |     1 |  1 475 |
| 2026-03-24 | long    | 1p_api    | global    | request::use_case                     | request_use_case_pct                            |   1 521 |     1 |  1 475 |
| 2026-03-24 | long    | 1p_api    | global    | task_success                          | task_success_count                              |       3 |     1 |      3 |
| 2026-03-24 | long    | 1p_api    | global    | task_success                          | task_success_pct                                |       3 |     1 |      3 |
| 2026-03-24 | long    | 1p_api    | global    | use_case                              | use_case_count                                  |       4 |     1 |      4 |
| 2026-03-24 | long    | 1p_api    | global    | use_case                              | use_case_pct                                    |       4 |     1 |      4 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_count                               |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_mean                                |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_median                              |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_median_ci_lower                     |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_median_ci_upper                     |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_autonomy                           | ai_autonomy_stdev                               |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_count                        |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_mean                         |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_mean_ci_lower                |     176 |   176 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_mean_ci_upper                |     176 |   176 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_median                       |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_median_ci_lower              |     176 |   176 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_median_ci_upper              |     176 |   176 |      0 |
| 2026-03-24 | long    | claude_ai | country   | ai_education_years                    | ai_education_years_stdev                        |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | collaboration                         | collaboration_count                             |     831 |   157 |      7 |
| 2026-03-24 | long    | claude_ai | country   | collaboration                         | collaboration_pct                               |     831 |   157 |      7 |
| 2026-03-24 | long    | claude_ai | country   | country                               | usage_count                                     |     178 |   178 |      0 |
| 2026-03-24 | long    | claude_ai | country   | country                               | usage_pct                                       |     178 |   178 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_count                     |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_mean                      |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_mean_ci_lower             |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_mean_ci_upper             |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_median                    |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_median_ci_lower           |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_median_ci_upper           |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_education_years                 | human_education_years_stdev                     |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_ability                    | human_only_ability_count                        |     349 |   175 |      3 |
| 2026-03-24 | long    | claude_ai | country   | human_only_ability                    | human_only_ability_pct                          |     349 |   175 |      3 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_count                           |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_mean                            |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_mean_ci_lower                   |     171 |   171 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_mean_ci_upper                   |     171 |   171 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_median                          |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_median_ci_lower                 |     171 |   171 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_median_ci_upper                 |     171 |   171 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_only_time                       | human_only_time_stdev                           |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_count                        |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_mean                         |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_mean_ci_lower                |     173 |   173 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_mean_ci_upper                |     173 |   173 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_median                       |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_median_ci_lower              |     173 |   173 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_median_ci_upper              |     173 |   173 |      0 |
| 2026-03-24 | long    | claude_ai | country   | human_with_ai_time                    | human_with_ai_time_stdev                        |     177 |   177 |      0 |
| 2026-03-24 | long    | claude_ai | country   | multitasking                          | multitasking_count                              |     351 |   176 |      3 |
| 2026-03-24 | long    | claude_ai | country   | multitasking                          | multitasking_pct                                |     351 |   176 |      3 |
| 2026-03-24 | long    | claude_ai | country   | onet_task                             | onet_task_count                                 |   7 485 |   118 |  1 578 |
| 2026-03-24 | long    | claude_ai | country   | onet_task                             | onet_task_pct                                   |   7 485 |   118 |  1 578 |
| 2026-03-24 | long    | claude_ai | country   | request                               | request_count                                   |  17 657 |   134 |    714 |
| 2026-03-24 | long    | claude_ai | country   | request                               | request_pct                                     |  17 657 |   134 |    714 |
| 2026-03-24 | long    | claude_ai | country   | task_success                          | task_success_count                              |     340 |   170 |      3 |
| 2026-03-24 | long    | claude_ai | country   | task_success                          | task_success_pct                                |     340 |   170 |      3 |
| 2026-03-24 | long    | claude_ai | country   | use_case                              | use_case_count                                  |     534 |   163 |      5 |
| 2026-03-24 | long    | claude_ai | country   | use_case                              | use_case_pct                                    |     534 |   163 |      5 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_count                               |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_histogram_count                     |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_histogram_pct                       |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_mean                                |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_median                              |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_median_ci_lower                     |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_median_ci_upper                     |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_autonomy                           | ai_autonomy_stdev                               |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_count                        |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_histogram_count              |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_histogram_pct                |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_mean                         |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_median                       |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | ai_education_years                    | ai_education_years_stdev                        |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | collaboration                         | collaboration_count                             |       6 |     1 |      6 |
| 2026-03-24 | long    | claude_ai | global    | collaboration                         | collaboration_pct                               |       6 |     1 |      6 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_count                     |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_histogram_count           |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_histogram_pct             |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_mean                      |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_mean_ci_lower             |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_mean_ci_upper             |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_median                    |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_median_ci_lower           |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_median_ci_upper           |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_education_years                 | human_education_years_stdev                     |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_only_ability                    | human_only_ability_count                        |       2 |     1 |      2 |
| 2026-03-24 | long    | claude_ai | global    | human_only_ability                    | human_only_ability_pct                          |       2 |     1 |      2 |
| 2026-03-24 | long    | claude_ai | global    | human_only_time                       | human_only_time_count                           |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_only_time                       | human_only_time_histogram_count                 |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | human_only_time                       | human_only_time_histogram_pct                   |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | human_only_time                       | human_only_time_mean                            |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_only_time                       | human_only_time_median                          |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_only_time                       | human_only_time_stdev                           |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_count                        |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_histogram_count              |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_histogram_pct                |      25 |     1 |     25 |
| 2026-03-24 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_mean                         |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_median                       |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | human_with_ai_time                    | human_with_ai_time_stdev                        |       1 |     1 |      0 |
| 2026-03-24 | long    | claude_ai | global    | multitasking                          | multitasking_count                              |       2 |     1 |      2 |
| 2026-03-24 | long    | claude_ai | global    | multitasking                          | multitasking_pct                                |       2 |     1 |      2 |
| 2026-03-24 | long    | claude_ai | global    | onet_task                             | onet_task_count                                 |   3 260 |     1 |  3 260 |
| 2026-03-24 | long    | claude_ai | global    | onet_task                             | onet_task_pct                                   |   3 260 |     1 |  3 260 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_count                     |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean                      |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_lower             |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_mean_ci_upper             |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median                    |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_lower           |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_median_ci_upper           |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_pct                       |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_autonomy                | onet_task_ai_autonomy_stdev                     |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_count              |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean               |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_lower      |   3 258 |     1 |  3 258 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_mean_ci_upper      |   3 258 |     1 |  3 258 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median             |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_lower    |   3 258 |     1 |  3 258 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_median_ci_upper    |   3 258 |     1 |  3 258 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_pct                |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::ai_education_years         | onet_task_ai_education_years_stdev              |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_count                   |   8 765 |     1 |  8 765 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::collaboration              | onet_task_collaboration_pct                     |   8 765 |     1 |  8 765 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_count           |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_mean            |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_lower   |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_mean_ci_upper   |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_median          |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_lower |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_median_ci_upper |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_pct             |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_education_years      | onet_task_human_education_years_stdev           |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_ability         | onet_task_human_only_ability_count              |   5 796 |     1 |  5 796 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_ability         | onet_task_human_only_ability_pct                |   5 796 |     1 |  5 796 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_count                 |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_mean                  |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_lower         |   3 249 |     1 |  3 249 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_mean_ci_upper         |   3 249 |     1 |  3 249 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_median                |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_lower       |   3 249 |     1 |  3 249 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_median_ci_upper       |   3 249 |     1 |  3 249 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_pct                   |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_only_time            | onet_task_human_only_time_stdev                 |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_count              |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean               |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_lower      |   3 253 |     1 |  3 253 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_mean_ci_upper      |   3 253 |     1 |  3 253 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median             |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_lower    |   3 253 |     1 |  3 253 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_median_ci_upper    |   3 253 |     1 |  3 253 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_pct                |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::human_with_ai_time         | onet_task_human_with_ai_time_stdev              |   3 259 |     1 |  3 259 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::multitasking               | onet_task_multitasking_count                    |   6 150 |     1 |  6 150 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::multitasking               | onet_task_multitasking_pct                      |   6 150 |     1 |  6 150 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::task_success               | onet_task_task_success_count                    |   6 030 |     1 |  6 030 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::task_success               | onet_task_task_success_pct                      |   6 030 |     1 |  6 030 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::use_case                   | onet_task_use_case_count                        |   7 215 |     1 |  7 215 |
| 2026-03-24 | long    | claude_ai | global    | onet_task::use_case                   | onet_task_use_case_pct                          |   7 215 |     1 |  7 215 |
| 2026-03-24 | long    | claude_ai | global    | request                               | request_count                                   |     751 |     1 |    731 |
| 2026-03-24 | long    | claude_ai | global    | request                               | request_pct                                     |     751 |     1 |    731 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_count                       |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_mean                        |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_lower               |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_mean_ci_upper               |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_median                      |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_pct                         |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_autonomy                  | request_ai_autonomy_stdev                       |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_count                |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_mean                 |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_mean_ci_lower        |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_mean_ci_upper        |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_median               |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_pct                  |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::ai_education_years           | request_ai_education_years_stdev                |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::collaboration                | request_collaboration_count                     |   4 347 |     1 |  4 241 |
| 2026-03-24 | long    | claude_ai | global    | request::collaboration                | request_collaboration_pct                       |   4 347 |     1 |  4 241 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_count             |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_mean              |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_mean_ci_lower     |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_mean_ci_upper     |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_median            |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_pct               |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_education_years        | request_human_education_years_stdev             |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_ability           | request_human_only_ability_count                |   1 477 |     1 |  1 441 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_ability           | request_human_only_ability_pct                  |   1 477 |     1 |  1 441 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_count                   |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_mean                    |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_mean_ci_lower           |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_mean_ci_upper           |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_median                  |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_pct                     |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_only_time              | request_human_only_time_stdev                   |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_count                |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_mean                 |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_lower        |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_mean_ci_upper        |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_median               |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_pct                  |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::human_with_ai_time           | request_human_with_ai_time_stdev                |     748 |     1 |    730 |
| 2026-03-24 | long    | claude_ai | global    | request::multitasking                 | request_multitasking_count                      |   1 486 |     1 |  1 450 |
| 2026-03-24 | long    | claude_ai | global    | request::multitasking                 | request_multitasking_pct                        |   1 486 |     1 |  1 450 |
| 2026-03-24 | long    | claude_ai | global    | request::task_success                 | request_task_success_count                      |   1 496 |     1 |  1 460 |
| 2026-03-24 | long    | claude_ai | global    | request::task_success                 | request_task_success_pct                        |   1 496 |     1 |  1 460 |
| 2026-03-24 | long    | claude_ai | global    | request::use_case                     | request_use_case_count                          |   2 345 |     1 |  2 288 |
| 2026-03-24 | long    | claude_ai | global    | request::use_case                     | request_use_case_pct                            |   2 345 |     1 |  2 288 |
| 2026-03-24 | long    | claude_ai | global    | task_success                          | task_success_count                              |       2 |     1 |      2 |
| 2026-03-24 | long    | claude_ai | global    | task_success                          | task_success_pct                                |       2 |     1 |      2 |
| 2026-03-24 | long    | claude_ai | global    | use_case                              | use_case_count                                  |       4 |     1 |      4 |
| 2026-03-24 | long    | claude_ai | global    | use_case                              | use_case_pct                                    |       4 |     1 |      4 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_count                               |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_mean                                |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_mean_ci_lower                       |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_mean_ci_upper                       |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_median                              |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_median_ci_lower                     |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_median_ci_upper                     |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_autonomy                           | ai_autonomy_stdev                               |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_count                        |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_mean                         |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_mean_ci_lower                |   1 136 | 1 136 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_mean_ci_upper                |   1 136 | 1 136 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_median                       |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_median_ci_lower              |   1 136 | 1 136 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_median_ci_upper              |   1 136 | 1 136 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | ai_education_years                    | ai_education_years_stdev                        |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | collaboration                         | collaboration_count                             |   3 878 |   826 |      7 |
| 2026-03-24 | long    | claude_ai | subregion | collaboration                         | collaboration_pct                               |   3 878 |   826 |      7 |
| 2026-03-24 | long    | claude_ai | subregion | country-state                         | usage_count                                     |   1 256 | 1 256 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | country-state                         | usage_pct                                       |   1 256 | 1 256 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_count                     |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_mean                      |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_mean_ci_lower             |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_mean_ci_upper             |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_median                    |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_median_ci_lower           |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_median_ci_upper           |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_education_years                 | human_education_years_stdev                     |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_ability                    | human_only_ability_count                        |   2 154 | 1 082 |      3 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_ability                    | human_only_ability_pct                          |   2 154 | 1 082 |      3 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_count                           |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_mean                            |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_mean_ci_lower                   |   1 130 | 1 130 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_mean_ci_upper                   |   1 130 | 1 130 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_median                          |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_median_ci_lower                 |   1 130 | 1 130 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_median_ci_upper                 |   1 130 | 1 130 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_only_time                       | human_only_time_stdev                           |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_count                        |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_mean                         |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_mean_ci_lower                |   1 131 | 1 131 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_mean_ci_upper                |   1 131 | 1 131 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_median                       |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_median_ci_lower              |   1 131 | 1 131 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_median_ci_upper              |   1 131 | 1 131 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | human_with_ai_time                    | human_with_ai_time_stdev                        |   1 137 | 1 137 |      0 |
| 2026-03-24 | long    | claude_ai | subregion | multitasking                          | multitasking_count                              |   2 178 | 1 102 |      3 |
| 2026-03-24 | long    | claude_ai | subregion | multitasking                          | multitasking_pct                                |   2 178 | 1 102 |      3 |
| 2026-03-24 | long    | claude_ai | subregion | onet_task                             | onet_task_count                                 |   8 013 |   381 |    501 |
| 2026-03-24 | long    | claude_ai | subregion | onet_task                             | onet_task_pct                                   |   8 013 |   381 |    501 |
| 2026-03-24 | long    | claude_ai | subregion | request                               | request_count                                   |  26 870 |   642 |    705 |
| 2026-03-24 | long    | claude_ai | subregion | request                               | request_pct                                     |  26 870 |   642 |    705 |
| 2026-03-24 | long    | claude_ai | subregion | task_success                          | task_success_count                              |   2 078 | 1 039 |      3 |
| 2026-03-24 | long    | claude_ai | subregion | task_success                          | task_success_pct                                |   2 078 | 1 039 |      3 |
| 2026-03-24 | long    | claude_ai | subregion | use_case                              | use_case_count                                  |   2 820 |   942 |      4 |
| 2026-03-24 | long    | claude_ai | subregion | use_case                              | use_case_pct                                    |   2 820 |   942 |      4 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | ai_autonomy_mean                                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | ai_education_years_mean                         |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_academic_paper_or_thesis_pct           |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_advice_or_recommendation_pct           |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_analysis_or_summary_pct                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_app_or_website_pct                     |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_audio_or_music_pct                     |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_blog_or_article_pct                    |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_chart_or_visualization_pct             |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_code_fix_or_debug_pct                  |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_config_or_infra_pct                    |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_creative_writing_pct                   |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_data_or_spreadsheet_pct                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_document_or_report_pct                 |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_educational_material_pct               |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_email_or_message_pct                   |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_explanation_or_answer_pct              |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_game_or_interactive_pct                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_idea_or_brainstorm_pct                 |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_image_or_graphic_pct                   |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_marketing_or_social_content_pct        |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_math_or_calculation_pct                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_ml_or_ai_system_pct                    |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_none_pct                               |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_other_pct                              |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_plan_or_strategy_pct                   |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_presentation_or_slides_pct             |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_recipe_or_meal_plan_pct                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_resume_or_job_application_pct          |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_script_or_snippet_pct                  |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_sql_or_database_query_pct              |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_translation_pct                        |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_ui_or_design_mockup_pct                |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | artifact_video_or_animation_pct                 |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_bucket_augmentation_pct           |   6 094 |     1 |  3 370 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_bucket_automation_pct             |   6 094 |     1 |  3 370 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_directive_pct                     |   6 160 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_feedback_loop_pct                 |   6 160 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_learning_pct                      |   6 160 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_none_pct                          |   6 160 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_task_iteration_pct                |   6 160 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | collaboration_validation_pct                    |   6 160 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | human_education_years_mean                      |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | human_only_ability_pct                          |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | human_only_time_mean                            |   6 154 |     1 |  3 404 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | human_with_ai_time_mean                         |   6 156 |     1 |  3 404 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | multitasking_pct                                |   6 161 |     1 |  3 407 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | pct                                             |   6 162 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | use_case_coursework_pct                         |   6 161 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | use_case_personal_pct                           |   6 161 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | onet                                  | use_case_work_pct                               |   6 161 |     1 |  3 408 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | ai_autonomy_mean                                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | ai_education_years_mean                         |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_academic_paper_or_thesis_pct           |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_advice_or_recommendation_pct           |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_analysis_or_summary_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_app_or_website_pct                     |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_audio_or_music_pct                     |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_blog_or_article_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_chart_or_visualization_pct             |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_code_fix_or_debug_pct                  |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_config_or_infra_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_creative_writing_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_data_or_spreadsheet_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_document_or_report_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_educational_material_pct               |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_email_or_message_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_explanation_or_answer_pct              |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_game_or_interactive_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_idea_or_brainstorm_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_image_or_graphic_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_marketing_or_social_content_pct        |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_math_or_calculation_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_ml_or_ai_system_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_none_pct                               |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_other_pct                              |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_plan_or_strategy_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_presentation_or_slides_pct             |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_recipe_or_meal_plan_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_resume_or_job_application_pct          |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_script_or_snippet_pct                  |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_sql_or_database_query_pct              |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_translation_pct                        |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_ui_or_design_mockup_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | artifact_video_or_animation_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_bucket_augmentation_pct           |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_bucket_automation_pct             |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_directive_pct                     |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_feedback_loop_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_learning_pct                      |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_none_pct                          |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_task_iteration_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | collaboration_validation_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | human_education_years_mean                      |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | human_only_ability_pct                          |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | human_only_time_mean                            |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | human_with_ai_time_mean                         |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | multitasking_pct                                |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | usage_pct                                       |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | usage_per_capita_index                          |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | use_case_coursework_pct                         |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | use_case_personal_pct                           |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | overall                               | use_case_work_pct                               |       2 |     1 |      1 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | ai_autonomy_mean                                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | ai_education_years_mean                         |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_academic_paper_or_thesis_pct           |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_advice_or_recommendation_pct           |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_analysis_or_summary_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_app_or_website_pct                     |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_audio_or_music_pct                     |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_blog_or_article_pct                    |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_chart_or_visualization_pct             |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_code_fix_or_debug_pct                  |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_config_or_infra_pct                    |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_creative_writing_pct                   |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_data_or_spreadsheet_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_document_or_report_pct                 |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_educational_material_pct               |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_email_or_message_pct                   |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_explanation_or_answer_pct              |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_game_or_interactive_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_idea_or_brainstorm_pct                 |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_image_or_graphic_pct                   |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_marketing_or_social_content_pct        |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_math_or_calculation_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_ml_or_ai_system_pct                    |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_none_pct                               |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_other_pct                              |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_plan_or_strategy_pct                   |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_presentation_or_slides_pct             |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_recipe_or_meal_plan_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_resume_or_job_application_pct          |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_script_or_snippet_pct                  |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_sql_or_database_query_pct              |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_translation_pct                        |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_ui_or_design_mockup_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | artifact_video_or_animation_pct                 |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_bucket_augmentation_pct           |   2 088 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_bucket_automation_pct             |   2 088 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_directive_pct                     |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_feedback_loop_pct                 |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_learning_pct                      |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_none_pct                          |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_task_iteration_pct                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | collaboration_validation_pct                    |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | human_education_years_mean                      |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | human_only_ability_pct                          |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | human_only_time_mean                            |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | human_with_ai_time_mean                         |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | multitasking_pct                                |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | pct                                             |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | use_case_coursework_pct                         |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | use_case_personal_pct                           |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | request                               | use_case_work_pct                               |   2 095 |     1 |  1 083 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | ai_autonomy_mean                                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | ai_education_years_mean                         |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_academic_paper_or_thesis_pct           |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_advice_or_recommendation_pct           |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_analysis_or_summary_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_app_or_website_pct                     |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_audio_or_music_pct                     |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_blog_or_article_pct                    |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_chart_or_visualization_pct             |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_code_fix_or_debug_pct                  |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_config_or_infra_pct                    |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_creative_writing_pct                   |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_data_or_spreadsheet_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_document_or_report_pct                 |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_educational_material_pct               |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_email_or_message_pct                   |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_explanation_or_answer_pct              |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_game_or_interactive_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_idea_or_brainstorm_pct                 |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_image_or_graphic_pct                   |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_marketing_or_social_content_pct        |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_math_or_calculation_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_ml_or_ai_system_pct                    |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_none_pct                               |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_other_pct                              |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_plan_or_strategy_pct                   |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_presentation_or_slides_pct             |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_recipe_or_meal_plan_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_resume_or_job_application_pct          |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_script_or_snippet_pct                  |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_sql_or_database_query_pct              |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_translation_pct                        |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_ui_or_design_mockup_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | artifact_video_or_animation_pct                 |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_bucket_augmentation_pct           |   1 381 |     1 |    719 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_bucket_automation_pct             |   1 381 |     1 |    719 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_directive_pct                     |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_feedback_loop_pct                 |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_learning_pct                      |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_none_pct                          |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_task_iteration_pct                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | collaboration_validation_pct                    |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | human_education_years_mean                      |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | human_only_ability_pct                          |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | human_only_time_mean                            |   1 385 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | human_with_ai_time_mean                         |   1 385 |     1 |    722 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | multitasking_pct                                |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | pct                                             |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | use_case_coursework_pct                         |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | use_case_personal_pct                           |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | 1p_api    | global    | soc_occupation                        | use_case_work_pct                               |   1 386 |     1 |    723 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | ai_autonomy_mean                                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | ai_education_years_mean                         |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_academic_paper_or_thesis_pct           |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_advice_or_recommendation_pct           |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_analysis_or_summary_pct                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_app_or_website_pct                     |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_audio_or_music_pct                     |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_blog_or_article_pct                    |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_chart_or_visualization_pct             |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_code_fix_or_debug_pct                  |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_config_or_infra_pct                    |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_creative_writing_pct                   |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_data_or_spreadsheet_pct                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_document_or_report_pct                 |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_educational_material_pct               |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_email_or_message_pct                   |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_explanation_or_answer_pct              |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_game_or_interactive_pct                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_idea_or_brainstorm_pct                 |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_image_or_graphic_pct                   |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_marketing_or_social_content_pct        |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_math_or_calculation_pct                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_ml_or_ai_system_pct                    |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_none_pct                               |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_other_pct                              |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_plan_or_strategy_pct                   |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_presentation_or_slides_pct             |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_recipe_or_meal_plan_pct                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_resume_or_job_application_pct          |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_script_or_snippet_pct                  |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_sql_or_database_query_pct              |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_translation_pct                        |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_ui_or_design_mockup_pct                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | artifact_video_or_animation_pct                 |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_bucket_augmentation_pct           |   3 490 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_bucket_automation_pct             |   3 490 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_directive_pct                     |   3 555 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_feedback_loop_pct                 |   3 555 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_learning_pct                      |   3 555 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_none_pct                          |   3 555 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_task_iteration_pct                |   3 555 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | collaboration_validation_pct                    |   3 555 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | human_education_years_mean                      |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | human_only_ability_pct                          |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | human_only_time_mean                            |   3 552 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | human_with_ai_time_mean                         |   3 552 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | multitasking_pct                                |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | pct                                             |  73 328 |   121 |  2 503 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | use_case_coursework_pct                         |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | use_case_personal_pct                           |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | onet                                  | use_case_work_pct                               |   3 558 |    91 |     35 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | ai_autonomy_mean                                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | ai_education_years_mean                         |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_academic_paper_or_thesis_pct           |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_advice_or_recommendation_pct           |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_analysis_or_summary_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_app_or_website_pct                     |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_audio_or_music_pct                     |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_blog_or_article_pct                    |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_chart_or_visualization_pct             |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_code_fix_or_debug_pct                  |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_config_or_infra_pct                    |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_creative_writing_pct                   |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_data_or_spreadsheet_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_document_or_report_pct                 |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_educational_material_pct               |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_email_or_message_pct                   |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_explanation_or_answer_pct              |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_game_or_interactive_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_idea_or_brainstorm_pct                 |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_image_or_graphic_pct                   |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_marketing_or_social_content_pct        |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_math_or_calculation_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_ml_or_ai_system_pct                    |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_none_pct                               |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_other_pct                              |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_plan_or_strategy_pct                   |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_presentation_or_slides_pct             |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_recipe_or_meal_plan_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_resume_or_job_application_pct          |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_script_or_snippet_pct                  |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_sql_or_database_query_pct              |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_translation_pct                        |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_ui_or_design_mockup_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | artifact_video_or_animation_pct                 |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_bucket_augmentation_pct           |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_bucket_automation_pct             |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_directive_pct                     |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_feedback_loop_pct                 |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_learning_pct                      |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_none_pct                          |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_task_iteration_pct                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | collaboration_validation_pct                    |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | human_education_years_mean                      |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | human_only_ability_pct                          |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | human_only_time_mean                            |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | human_with_ai_time_mean                         |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | multitasking_pct                                |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | usage_pct                                       |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | usage_per_capita_index                          |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | use_case_coursework_pct                         |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | use_case_personal_pct                           |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | overall                               | use_case_work_pct                               |     235 |   121 |      1 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | ai_autonomy_mean                                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | ai_education_years_mean                         |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_academic_paper_or_thesis_pct           |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_advice_or_recommendation_pct           |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_analysis_or_summary_pct                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_app_or_website_pct                     |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_audio_or_music_pct                     |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_blog_or_article_pct                    |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_chart_or_visualization_pct             |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_code_fix_or_debug_pct                  |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_config_or_infra_pct                    |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_creative_writing_pct                   |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_data_or_spreadsheet_pct                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_document_or_report_pct                 |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_educational_material_pct               |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_email_or_message_pct                   |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_explanation_or_answer_pct              |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_game_or_interactive_pct                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_idea_or_brainstorm_pct                 |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_image_or_graphic_pct                   |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_marketing_or_social_content_pct        |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_math_or_calculation_pct                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_ml_or_ai_system_pct                    |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_none_pct                               |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_other_pct                              |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_plan_or_strategy_pct                   |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_presentation_or_slides_pct             |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_recipe_or_meal_plan_pct                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_resume_or_job_application_pct          |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_script_or_snippet_pct                  |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_sql_or_database_query_pct              |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_translation_pct                        |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_ui_or_design_mockup_pct                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | artifact_video_or_animation_pct                 |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_bucket_augmentation_pct           |   2 936 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_bucket_automation_pct             |   2 936 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_directive_pct                     |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_feedback_loop_pct                 |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_learning_pct                      |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_none_pct                          |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_task_iteration_pct                |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | collaboration_validation_pct                    |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | human_education_years_mean                      |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | human_only_ability_pct                          |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | human_only_time_mean                            |   3 029 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | human_with_ai_time_mean                         |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | multitasking_pct                                |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | pct                                             |  62 335 |   121 |  1 138 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | use_case_coursework_pct                         |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | use_case_personal_pct                           |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | request                               | use_case_work_pct                               |   3 030 |    91 |     20 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | ai_autonomy_mean                                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | ai_education_years_mean                         |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_academic_paper_or_thesis_pct           |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_advice_or_recommendation_pct           |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_analysis_or_summary_pct                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_app_or_website_pct                     |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_audio_or_music_pct                     |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_blog_or_article_pct                    |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_chart_or_visualization_pct             |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_code_fix_or_debug_pct                  |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_config_or_infra_pct                    |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_creative_writing_pct                   |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_data_or_spreadsheet_pct                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_document_or_report_pct                 |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_educational_material_pct               |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_email_or_message_pct                   |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_explanation_or_answer_pct              |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_game_or_interactive_pct                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_idea_or_brainstorm_pct                 |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_image_or_graphic_pct                   |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_marketing_or_social_content_pct        |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_math_or_calculation_pct                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_ml_or_ai_system_pct                    |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_none_pct                               |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_other_pct                              |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_plan_or_strategy_pct                   |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_presentation_or_slides_pct             |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_recipe_or_meal_plan_pct                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_resume_or_job_application_pct          |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_script_or_snippet_pct                  |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_sql_or_database_query_pct              |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_translation_pct                        |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_ui_or_design_mockup_pct                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | artifact_video_or_animation_pct                 |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_bucket_augmentation_pct           |   3 141 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_bucket_automation_pct             |   3 141 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_directive_pct                     |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_feedback_loop_pct                 |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_learning_pct                      |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_none_pct                          |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_task_iteration_pct                |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | collaboration_validation_pct                    |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | human_education_years_mean                      |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | human_only_ability_pct                          |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | human_only_time_mean                            |   3 159 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | human_with_ai_time_mean                         |   3 160 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | multitasking_pct                                |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | pct                                             |  38 269 |   121 |    655 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | use_case_coursework_pct                         |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | use_case_personal_pct                           |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | country   | soc_occupation                        | use_case_work_pct                               |   3 163 |    91 |     22 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | ai_autonomy_mean                                |   6 990 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | ai_education_years_mean                         |   6 990 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_academic_paper_or_thesis_pct           |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_advice_or_recommendation_pct           |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_analysis_or_summary_pct                |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_app_or_website_pct                     |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_audio_or_music_pct                     |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_blog_or_article_pct                    |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_chart_or_visualization_pct             |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_code_fix_or_debug_pct                  |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_config_or_infra_pct                    |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_creative_writing_pct                   |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_data_or_spreadsheet_pct                |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_document_or_report_pct                 |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_educational_material_pct               |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_email_or_message_pct                   |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_explanation_or_answer_pct              |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_game_or_interactive_pct                |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_idea_or_brainstorm_pct                 |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_image_or_graphic_pct                   |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_marketing_or_social_content_pct        |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_math_or_calculation_pct                |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_ml_or_ai_system_pct                    |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_none_pct                               |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_other_pct                              |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_plan_or_strategy_pct                   |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_presentation_or_slides_pct             |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_recipe_or_meal_plan_pct                |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_resume_or_job_application_pct          |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_script_or_snippet_pct                  |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_sql_or_database_query_pct              |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_translation_pct                        |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_ui_or_design_mockup_pct                |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | artifact_video_or_animation_pct                 |   6 989 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_bucket_augmentation_pct           |   6 927 |     1 |  3 756 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_bucket_automation_pct             |   6 927 |     1 |  3 756 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_directive_pct                     |   6 980 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_feedback_loop_pct                 |   6 980 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_learning_pct                      |   6 980 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_none_pct                          |   6 980 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_task_iteration_pct                |   6 980 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | collaboration_validation_pct                    |   6 980 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | human_education_years_mean                      |   6 991 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | human_only_ability_pct                          |   6 990 |     1 |  3 787 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | human_only_time_mean                            |   6 977 |     1 |  3 778 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | human_with_ai_time_mean                         |   6 977 |     1 |  3 781 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | multitasking_pct                                |   6 991 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | pct                                             |   6 991 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | use_case_coursework_pct                         |   6 991 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | use_case_personal_pct                           |   6 991 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | onet                                  | use_case_work_pct                               |   6 991 |     1 |  3 788 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | ai_autonomy_mean                                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | ai_education_years_mean                         |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_academic_paper_or_thesis_pct           |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_advice_or_recommendation_pct           |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_analysis_or_summary_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_app_or_website_pct                     |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_audio_or_music_pct                     |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_blog_or_article_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_chart_or_visualization_pct             |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_code_fix_or_debug_pct                  |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_config_or_infra_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_creative_writing_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_data_or_spreadsheet_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_document_or_report_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_educational_material_pct               |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_email_or_message_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_explanation_or_answer_pct              |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_game_or_interactive_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_idea_or_brainstorm_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_image_or_graphic_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_marketing_or_social_content_pct        |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_math_or_calculation_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_ml_or_ai_system_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_none_pct                               |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_other_pct                              |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_plan_or_strategy_pct                   |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_presentation_or_slides_pct             |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_recipe_or_meal_plan_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_resume_or_job_application_pct          |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_script_or_snippet_pct                  |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_sql_or_database_query_pct              |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_translation_pct                        |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_ui_or_design_mockup_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | artifact_video_or_animation_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_bucket_augmentation_pct           |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_bucket_automation_pct             |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_directive_pct                     |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_feedback_loop_pct                 |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_learning_pct                      |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_none_pct                          |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_task_iteration_pct                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | collaboration_validation_pct                    |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | human_education_years_mean                      |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | human_only_ability_pct                          |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | human_only_time_mean                            |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | human_with_ai_time_mean                         |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | multitasking_pct                                |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | usage_pct                                       |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | usage_per_capita_index                          |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | use_case_coursework_pct                         |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | use_case_personal_pct                           |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | overall                               | use_case_work_pct                               |       2 |     1 |      1 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | ai_autonomy_mean                                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | ai_education_years_mean                         |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_academic_paper_or_thesis_pct           |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_advice_or_recommendation_pct           |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_analysis_or_summary_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_app_or_website_pct                     |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_audio_or_music_pct                     |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_blog_or_article_pct                    |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_chart_or_visualization_pct             |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_code_fix_or_debug_pct                  |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_config_or_infra_pct                    |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_creative_writing_pct                   |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_data_or_spreadsheet_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_document_or_report_pct                 |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_educational_material_pct               |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_email_or_message_pct                   |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_explanation_or_answer_pct              |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_game_or_interactive_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_idea_or_brainstorm_pct                 |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_image_or_graphic_pct                   |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_marketing_or_social_content_pct        |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_math_or_calculation_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_ml_or_ai_system_pct                    |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_none_pct                               |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_other_pct                              |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_plan_or_strategy_pct                   |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_presentation_or_slides_pct             |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_recipe_or_meal_plan_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_resume_or_job_application_pct          |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_script_or_snippet_pct                  |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_sql_or_database_query_pct              |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_translation_pct                        |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_ui_or_design_mockup_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | artifact_video_or_animation_pct                 |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_bucket_augmentation_pct           |   2 435 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_bucket_automation_pct             |   2 435 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_directive_pct                     |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_feedback_loop_pct                 |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_learning_pct                      |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_none_pct                          |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_task_iteration_pct                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | collaboration_validation_pct                    |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | human_education_years_mean                      |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | human_only_ability_pct                          |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | human_only_time_mean                            |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | human_with_ai_time_mean                         |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | multitasking_pct                                |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | pct                                             |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | use_case_coursework_pct                         |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | use_case_personal_pct                           |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | request                               | use_case_work_pct                               |   2 436 |     1 |  1 192 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | ai_autonomy_mean                                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | ai_education_years_mean                         |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_academic_paper_or_thesis_pct           |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_advice_or_recommendation_pct           |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_analysis_or_summary_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_app_or_website_pct                     |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_audio_or_music_pct                     |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_blog_or_article_pct                    |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_chart_or_visualization_pct             |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_code_fix_or_debug_pct                  |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_config_or_infra_pct                    |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_creative_writing_pct                   |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_data_or_spreadsheet_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_document_or_report_pct                 |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_educational_material_pct               |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_email_or_message_pct                   |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_explanation_or_answer_pct              |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_game_or_interactive_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_idea_or_brainstorm_pct                 |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_image_or_graphic_pct                   |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_marketing_or_social_content_pct        |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_math_or_calculation_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_ml_or_ai_system_pct                    |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_none_pct                               |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_other_pct                              |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_plan_or_strategy_pct                   |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_presentation_or_slides_pct             |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_recipe_or_meal_plan_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_resume_or_job_application_pct          |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_script_or_snippet_pct                  |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_sql_or_database_query_pct              |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_translation_pct                        |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_ui_or_design_mockup_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | artifact_video_or_animation_pct                 |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_bucket_augmentation_pct           |   1 455 |     1 |    738 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_bucket_automation_pct             |   1 455 |     1 |    738 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_directive_pct                     |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_feedback_loop_pct                 |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_learning_pct                      |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_none_pct                          |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_task_iteration_pct                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | collaboration_validation_pct                    |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | human_education_years_mean                      |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | human_only_ability_pct                          |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | human_only_time_mean                            |   1 457 |     1 |    739 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | human_with_ai_time_mean                         |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | multitasking_pct                                |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | pct                                             |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | use_case_coursework_pct                         |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | use_case_personal_pct                           |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | global    | soc_occupation                        | use_case_work_pct                               |   1 458 |     1 |    740 |
| 2026-06-26 | monthly | claude_ai | subregion | onet                                  | pct                                             | 137 230 |   609 |  1 434 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | ai_autonomy_mean                                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | ai_education_years_mean                         |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_academic_paper_or_thesis_pct           |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_advice_or_recommendation_pct           |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_analysis_or_summary_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_app_or_website_pct                     |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_audio_or_music_pct                     |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_blog_or_article_pct                    |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_chart_or_visualization_pct             |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_code_fix_or_debug_pct                  |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_config_or_infra_pct                    |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_creative_writing_pct                   |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_data_or_spreadsheet_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_document_or_report_pct                 |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_educational_material_pct               |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_email_or_message_pct                   |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_explanation_or_answer_pct              |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_game_or_interactive_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_idea_or_brainstorm_pct                 |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_image_or_graphic_pct                   |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_marketing_or_social_content_pct        |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_math_or_calculation_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_ml_or_ai_system_pct                    |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_none_pct                               |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_other_pct                              |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_plan_or_strategy_pct                   |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_presentation_or_slides_pct             |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_recipe_or_meal_plan_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_resume_or_job_application_pct          |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_script_or_snippet_pct                  |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_sql_or_database_query_pct              |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_translation_pct                        |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_ui_or_design_mockup_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | artifact_video_or_animation_pct                 |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_bucket_augmentation_pct           |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_bucket_automation_pct             |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_directive_pct                     |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_feedback_loop_pct                 |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_learning_pct                      |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_none_pct                          |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_task_iteration_pct                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | collaboration_validation_pct                    |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | human_education_years_mean                      |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | human_only_ability_pct                          |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | human_only_time_mean                            |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | human_with_ai_time_mean                         |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | multitasking_pct                                |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | usage_pct                                       |   1 184 |   649 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | usage_per_capita_index                          |     102 |    51 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | use_case_coursework_pct                         |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | use_case_personal_pct                           |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | overall                               | use_case_work_pct                               |   1 188 |   652 |      1 |
| 2026-06-26 | monthly | claude_ai | subregion | request                               | pct                                             | 127 328 |   609 |    973 |
| 2026-06-26 | monthly | claude_ai | subregion | soc_occupation                        | pct                                             |  83 116 |   609 |    498 |

## Inventaire des fichiers publiés

Colonne `retenu` : fichier utilisé par le pipeline (règles de
`fichiers_par_version()`, R/config.R).

| release | chemin | taille_mo | retenu |
|---|---|---|---|
| 2025-02-10 | automation_vs_augmentation.csv                                   |   0.00 |  TRUE |
| 2025-02-10 | bls_employment_may_2023.csv                                      |   0.00 | FALSE |
| 2025-02-10 | onet_task_mappings.csv                                           |   0.44 |  TRUE |
| 2025-02-10 | onet_task_statements.csv                                         |   3.43 | FALSE |
| 2025-02-10 | plots.ipynb                                                      |   0.02 | FALSE |
| 2025-02-10 | plots/automation_vs_augmentation.png                             |   0.04 | FALSE |
| 2025-02-10 | plots/occupational_category_distribution_bls.png                 |   0.22 | FALSE |
| 2025-02-10 | plots/occupational_category_distribution.png                     |   0.14 | FALSE |
| 2025-02-10 | plots/occupations_distribution.png                               |   0.10 | FALSE |
| 2025-02-10 | plots/task_distribution.png                                      |   0.21 | FALSE |
| 2025-02-10 | plots/wage_distribution.png                                      |   0.20 | FALSE |
| 2025-02-10 | README.md                                                        |   0.00 | FALSE |
| 2025-02-10 | SOC_Structure.csv                                                |   0.07 | FALSE |
| 2025-02-10 | wage_data.csv                                                    |   0.12 | FALSE |
| 2025-03-27 | automation_augmentation_by_occupation.png                        |   0.64 | FALSE |
| 2025-03-27 | automation_augmentation_comparison.png                           |   0.14 | FALSE |
| 2025-03-27 | automation_vs_augmentation_by_task.csv                           |   0.54 |  TRUE |
| 2025-03-27 | automation_vs_augmentation_v1.csv                                |   0.00 | FALSE |
| 2025-03-27 | automation_vs_augmentation_v2.csv                                |   0.00 |  TRUE |
| 2025-03-27 | cluster_level_data/cluster_level_dataset.tsv                     |   0.90 | FALSE |
| 2025-03-27 | cluster_level_data/cluster_level_example_analysis.ipynb          |   0.27 | FALSE |
| 2025-03-27 | cluster_level_data/README.md                                     |   0.00 | FALSE |
| 2025-03-27 | normalized_automation_by_category.png                            |   0.81 | FALSE |
| 2025-03-27 | onet_task_statements.csv                                         |   3.43 | FALSE |
| 2025-03-27 | README.md                                                        |   0.00 | FALSE |
| 2025-03-27 | SOC_Structure.csv                                                |   0.07 | FALSE |
| 2025-03-27 | task_pct_v1.csv                                                  |   0.44 | FALSE |
| 2025-03-27 | task_pct_v2.csv                                                  |   0.42 |  TRUE |
| 2025-03-27 | task_thinking_fractions.csv                                      |   0.36 | FALSE |
| 2025-03-27 | v2_report_replication.ipynb                                      |   1.81 | FALSE |
| 2025-09-15 | code/aei_analysis_functions_1p_api.py                            |   0.07 | FALSE |
| 2025-09-15 | code/aei_analysis_functions_claude_ai.py                         |   0.09 | FALSE |
| 2025-09-15 | code/aei_report_v3_analysis_1p_api.ipynb                         |   0.01 | FALSE |
| 2025-09-15 | code/aei_report_v3_analysis_claude_ai.ipynb                      |   0.02 | FALSE |
| 2025-09-15 | code/aei_report_v3_change_over_time_claude_ai.py                 |   0.02 | FALSE |
| 2025-09-15 | code/aei_report_v3_preprocessing_claude_ai.ipynb                 |   0.08 | FALSE |
| 2025-09-15 | code/preprocess_gdp.py                                           |   0.01 | FALSE |
| 2025-09-15 | code/preprocess_iso_codes.py                                     |   0.00 | FALSE |
| 2025-09-15 | code/preprocess_onet.py                                          |   0.01 | FALSE |
| 2025-09-15 | code/preprocess_population.py                                    |   0.01 | FALSE |
| 2025-09-15 | data_documentation.md                                            |   0.02 |  TRUE |
| 2025-09-15 | data/input/automation_vs_augmentation_v1.csv                     |   0.00 | FALSE |
| 2025-09-15 | data/input/automation_vs_augmentation_v2.csv                     |   0.00 | FALSE |
| 2025-09-15 | data/input/bea_us_state_gdp_2024.csv                             |   0.00 | FALSE |
| 2025-09-15 | data/input/BTOS_National.xlsx                                    |   0.06 | FALSE |
| 2025-09-15 | data/input/census_state_codes.txt                                |   0.00 | FALSE |
| 2025-09-15 | data/input/geonames_countryInfo.txt                              |   0.03 | FALSE |
| 2025-09-15 | data/input/imf_gdp_raw_2024.json                                 |   0.25 | FALSE |
| 2025-09-15 | data/input/onet_task_statements_raw.xlsx                         |   1.15 | FALSE |
| 2025-09-15 | data/input/Population by single age _20250903072924.csv          |   0.00 | FALSE |
| 2025-09-15 | data/input/sc-est2024-agesex-civ.csv                             |   0.78 | FALSE |
| 2025-09-15 | data/input/soc_structure_raw.csv                                 |   0.07 | FALSE |
| 2025-09-15 | data/input/task_pct_v1.csv                                       |   0.44 | FALSE |
| 2025-09-15 | data/input/task_pct_v2.csv                                       |   0.42 | FALSE |
| 2025-09-15 | data/input/working_age_pop_2024_country_raw.csv                  |   0.02 | FALSE |
| 2025-09-15 | data/intermediate/aei_raw_1p_api_2025-08-04_to_2025-08-11.csv    |   6.70 |  TRUE |
| 2025-09-15 | data/intermediate/aei_raw_claude_ai_2025-08-04_to_2025-08-11.csv |  18.02 | FALSE |
| 2025-09-15 | data/intermediate/gdp_2024_country.csv                           |   0.00 | FALSE |
| 2025-09-15 | data/intermediate/gdp_2024_us_state.csv                          |   0.00 | FALSE |
| 2025-09-15 | data/intermediate/iso_country_codes.csv                          |   0.00 |  TRUE |
| 2025-09-15 | data/intermediate/onet_task_statements.csv                       |   3.48 |  TRUE |
| 2025-09-15 | data/intermediate/soc_structure.csv                              |   0.08 |  TRUE |
| 2025-09-15 | data/intermediate/working_age_pop_2024_country.csv               |   0.01 |  TRUE |
| 2025-09-15 | data/intermediate/working_age_pop_2024_us_state.csv              |   0.00 | FALSE |
| 2025-09-15 | data/output/aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv  |  25.60 |  TRUE |
| 2025-09-15 | data/output/request_hierarchy_tree_1p_api.json                   |   0.29 | FALSE |
| 2025-09-15 | data/output/request_hierarchy_tree_claude_ai.json                |   0.42 | FALSE |
| 2025-09-15 | README.md                                                        |   0.00 | FALSE |
| 2026-01-15 | aei_v4_appendix.pdf                                              |   5.76 | FALSE |
| 2026-01-15 | data_documentation.md                                            |   0.02 |  TRUE |
| 2026-01-15 | data/intermediate/aei_raw_1p_api_2025-11-13_to_2025-11-20.csv    |  39.59 |  TRUE |
| 2026-01-15 | data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv |  89.73 |  TRUE |
| 2026-03-24 | data_documentation.md                                            |   0.02 |  TRUE |
| 2026-03-24 | data/aei_raw_1p_api_2026-02-05_to_2026-02-12.csv                 |  41.92 |  TRUE |
| 2026-03-24 | data/aei_raw_claude_ai_2026-02-05_to_2026-02-12.csv              |  98.50 |  TRUE |
| 2026-06-26 | data_documentation.md                                            |   0.01 |  TRUE |
| 2026-06-26 | data/aei_1p_api_2026-06-26.csv                                   |  73.70 |  TRUE |
| 2026-06-26 | data/aei_claude_ai_2026-06-26.csv                                | 209.02 |  TRUE |
