-- =============================================================================
-- s3_usage_metiers.sql — Part de l'usage mondial de Claude.ai portant sur les
-- tâches de chaque métier ciblé, par version (dernière période).
-- Une tâche partagée par plusieurs métiers compte pour chacun d'eux : c'est
-- une mesure d'« empreinte » par métier, pas une partition.
-- Paramètre : {{codes}}
-- =============================================================================
WITH taches_metier AS (
    SELECT DISTINCT soc6, metier, cle_tache FROM onet_taches WHERE soc6 IN ({{codes}})
)
SELECT
    p.release, p.source, p.date_start, m.soc6, any_value(m.metier) AS metier,
    sum(p.part_pct)         AS part_usage_pct,
    count(*)                AS n_taches_observees
FROM parts_taches p
JOIN taches_metier m USING (cle_tache)
WHERE p.geo_level = 'global' AND p.est_classee
GROUP BY p.release, p.source, p.date_start, m.soc6
QUALIFY p.date_start IS NOT DISTINCT FROM max(p.date_start) OVER (PARTITION BY p.release, p.source)
ORDER BY ALL;
