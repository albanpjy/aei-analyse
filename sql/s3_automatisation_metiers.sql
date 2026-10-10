-- =============================================================================
-- s3_automatisation_metiers.sql — Part d'automatisation des tâches de chaque
-- métier du chiffre (Claude.ai, mondial), par version.
--
-- Pour chaque tâche, Anthropic publie la répartition des modes de
-- collaboration (facette onet_task::collaboration, schémas wide et long) ; on
-- l'agrège sur les tâches du métier, pondérées par leur poids dans l'usage :
--   automatisation(métier) = Σ part × %auto / Σ part × %classable
-- Paramètre : {{codes}} (liste SQL de codes SOC à 6 chiffres)
-- =============================================================================
WITH inter AS (
    SELECT
        release, source, date_start,
        regexp_replace(lower(trim(regexp_extract(item, '^(.*)::([^:]*)$', 1))), '\s+', ' ', 'g') AS cle_tache,
        regexp_extract(item, '^(.*)::([^:]*)$', 2) AS mode,
        value AS pct_mode
    FROM usage
    WHERE schema IN ('wide', 'long') AND geo_level = 'global' AND source = 'claude_ai'
      AND facet = 'onet_task::collaboration' AND variable = 'onet_task_collaboration_pct'
),
par_tache AS (
    SELECT release, source, date_start, cle_tache,
           sum(pct_mode) FILTER (WHERE mode IN ('directive', 'feedback loop')) AS pct_auto,
           sum(pct_mode) FILTER (WHERE mode IN ('directive', 'feedback loop', 'task iteration',
                                                'learning', 'validation'))     AS pct_classable
    FROM inter GROUP BY ALL
),
taches_metier AS (
    SELECT DISTINCT soc6, cle_tache FROM onet_taches WHERE soc6 IN ({{codes}})
)
SELECT
    t.release, m.soc6,
    100 * sum(p.part_pct * t.pct_auto) / sum(p.part_pct * t.pct_classable) AS automatisation_pct,
    count(*)                                                               AS n_taches,
    sum(p.part_pct)                                                        AS part_usage_pct
FROM par_tache t
JOIN taches_metier m USING (cle_tache)
JOIN parts_taches p
  ON  p.release = t.release AND p.source = t.source AND p.geo_level = 'global'
  AND p.cle_tache = t.cle_tache AND p.date_start IS NOT DISTINCT FROM t.date_start
WHERE t.pct_classable > 0
GROUP BY t.release, m.soc6
ORDER BY t.release, m.soc6;
