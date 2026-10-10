-- =============================================================================
-- vue_04_usage_pays.sql — Usage par pays et indice d'usage par habitant
--
-- Indice d'usage par habitant (« Anthropic AI Usage Index », AUI) :
--   AUI = part de l'usage mondial / part de la population mondiale 15–64 ans
-- Publié dans 2025-09-15 (enriched) et 2026-06-26 ; NON publié dans les
-- fichiers RAW de 2026-01-15 et 2026-03-24 : on le RECALCULE alors avec la
-- population 2024 publiée par Anthropic (working_age_pop_2024_country), sur
-- les pays présents. La version 2025-09-15, où les deux existent, sert de
-- contrôle (voir analyses/01_france.qmd).
-- =============================================================================
CREATE OR REPLACE VIEW usage_pays AS
WITH brut AS (
    -- PIVOT (syntaxe DuckDB) : une colonne par variable.
    PIVOT (
        SELECT release, schema, date_start, geo_id, variable, value
        FROM usage
        WHERE geo_level = 'country' AND source = 'claude_ai'
          AND ((schema = 'long' AND facet = 'country')
            OR (schema = 'monthly' AND facet = 'overall'))
          AND variable IN ('usage_pct', 'usage_count', 'usage_per_capita_index')
    )
    ON variable IN ('usage_pct', 'usage_count', 'usage_per_capita_index')
    USING max(value)
),
avec_pop AS (
    SELECT b.*, p.working_age_pop
    FROM brut b
    LEFT JOIN population_age_actif p ON p.iso_alpha_3 = b.geo_id
)
SELECT
    release, schema, date_start, geo_id,
    usage_pct, usage_count,
    usage_per_capita_index AS aui_publie,
    -- Recalcul : parts renormalisées sur les pays ayant une population connue.
    (usage_pct / sum(usage_pct) FILTER (WHERE working_age_pop IS NOT NULL)
                 OVER (PARTITION BY release, date_start))
    / (working_age_pop / sum(working_age_pop) FILTER (WHERE usage_pct IS NOT NULL)
                 OVER (PARTITION BY release, date_start)) AS aui_calcule,
    working_age_pop
FROM avec_pop;
