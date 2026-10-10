-- =============================================================================
-- s2_pays.sql — Part d'automatisation par pays (Claude.ai), dernière période
-- de chaque version.
-- =============================================================================
SELECT release, date_start, geo_id, automatisation_pct, augmentation_pct, effectif_classable
FROM automatisation
WHERE geo_level = 'country' AND source = 'claude_ai'
QUALIFY date_start = max(date_start) OVER (PARTITION BY release)
ORDER BY release, automatisation_pct DESC;
