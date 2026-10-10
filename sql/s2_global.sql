-- =============================================================================
-- s2_global.sql — Automatisation vs augmentation au niveau mondial, par
-- version, période et source (Claude.ai / API), avec l'effectif classable
-- (base des intervalles de confiance) et, pour le schéma mensuel, les parts
-- PUBLIÉES par Anthropic (collaboration_bucket_*) pour contrôle.
-- =============================================================================
WITH publie AS (
    -- UNPIVOT inverse : ici on part de lignes, on garde une colonne par mesure
    PIVOT (
        SELECT release, source, date_start, geo_id, variable, value
        FROM usage
        WHERE schema = 'monthly' AND facet = 'overall' AND geo_level = 'global'
          AND variable IN ('collaboration_bucket_automation_pct', 'collaboration_bucket_augmentation_pct')
    ) ON variable USING max(value)
)
SELECT
    a.*,
    p.collaboration_bucket_automation_pct   AS automatisation_publiee,
    p.collaboration_bucket_augmentation_pct AS augmentation_publiee
FROM automatisation a
LEFT JOIN publie p
  ON p.release = a.release AND p.source = a.source AND p.date_start = a.date_start
WHERE a.geo_level = 'global'
ORDER BY a.release, a.date_start, a.source;
