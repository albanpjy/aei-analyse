-- =============================================================================
-- s2_modes.sql — Parts des six modes de collaboration (mondial), par version,
-- période et source. Format long, prêt pour un graphique en barres empilées.
-- =============================================================================
SELECT release, schema, source, date_start, mode, part_pct, effectif
FROM collaboration
WHERE geo_level = 'global'
ORDER BY ALL;
