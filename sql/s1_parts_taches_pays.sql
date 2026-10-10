-- =============================================================================
-- s1_parts_taches_pays.sql — Parts des tâches classées, dernière période de
-- chaque version, pays de comparaison + mondial (pour les indices de
-- concentration et la comparaison entre versions).
-- =============================================================================
SELECT release, date_start, geo_id, cle_tache, tache, part_pct
FROM parts_taches
WHERE source = 'claude_ai' AND est_classee
  AND geo_id IN ('GLOBAL', 'FRA', 'DEU', 'GBR', 'ESP', 'ITA', 'BEL', 'NLD', 'USA')
-- IS NOT DISTINCT FROM : les versions « wide » n'ont pas de date (NULL)
QUALIFY date_start IS NOT DISTINCT FROM max(date_start) OVER (PARTITION BY release);
