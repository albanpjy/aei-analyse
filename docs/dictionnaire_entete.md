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
