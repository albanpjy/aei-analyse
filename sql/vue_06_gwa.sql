-- =============================================================================
-- vue_06_gwa.sql — Familles de tâches : activités de travail généralisées
-- (GWA, « Generalized Work Activities » d'O*NET), niveau 3 de la hiérarchie
-- `onet` du schéma mensuel. Base de la typologie des pays (sujet 4).
-- =============================================================================
CREATE OR REPLACE VIEW gwa_pays AS
SELECT
    release, date_start, geo_level, geo_id,
    item_id AS gwa_code,
    item    AS gwa,
    value   AS part_pct
FROM usage
WHERE schema = 'monthly' AND source = 'claude_ai'
  AND facet = 'onet' AND level = 3 AND variable = 'pct';
