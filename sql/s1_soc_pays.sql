-- =============================================================================
-- s1_soc_pays.sql — Parts d'usage par grand groupe SOC (dérivées des tâches),
-- dernière période de chaque version, pays de comparaison + mondial.
-- Jointure avec les parts PUBLIÉES quand elles existent (contrôle croisé).
-- =============================================================================
WITH derive AS (
    SELECT release, date_start, geo_id, soc_majeur, part_pct AS part_derivee
    FROM soc_derive
    WHERE source = 'claude_ai'
      AND geo_id IN ('GLOBAL', 'FRA', 'DEU', 'GBR', 'ESP', 'ITA', 'BEL', 'NLD', 'USA')
    QUALIFY date_start IS NOT DISTINCT FROM max(date_start) OVER (PARTITION BY release)
),
publie AS (
    SELECT release, date_start, geo_id, soc_majeur, part_pct AS part_publiee
    FROM soc_publie
    WHERE geo_id IN ('GLOBAL', 'FRA', 'DEU', 'GBR', 'ESP', 'ITA', 'BEL', 'NLD', 'USA')
)
SELECT d.*, p.part_publiee
FROM derive d
LEFT JOIN publie p
  ON  p.release = d.release AND p.geo_id = d.geo_id AND p.soc_majeur = d.soc_majeur
  AND p.date_start IS NOT DISTINCT FROM d.date_start
ORDER BY ALL;
