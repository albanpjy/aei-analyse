-- =============================================================================
-- s2_soc.sql — Part d'automatisation par grand groupe de métiers (mondial)
--
-- Schémas wide/long : on combine, tâche par tâche,
--   * la répartition des modes de collaboration (facette
--     onet_task::collaboration, item « tâche::mode », % de la tâche),
--   * le poids de la tâche dans l'usage (parts_taches),
--   * le rattachement tâche -> grand groupe SOC (taches_soc, poids 1/k).
--   automatisation(groupe) = Σ part × poids × %auto / Σ part × poids × %classable
-- Schéma mensuel : parts publiées par Anthropic au niveau du grand groupe
-- (facette soc_occupation, niveau 1, collaboration_bucket_*).
-- =============================================================================
WITH inter AS (
    SELECT
        release, schema, source, date_start,
        regexp_replace(lower(trim(regexp_extract(item, '^(.*)::([^:]*)$', 1))), '\s+', ' ', 'g') AS cle_tache,
        regexp_extract(item, '^(.*)::([^:]*)$', 2) AS mode,
        value AS pct_mode
    FROM usage
    WHERE schema IN ('wide', 'long') AND geo_level = 'global'
      AND facet = 'onet_task::collaboration' AND variable = 'onet_task_collaboration_pct'
),
par_tache AS (
    SELECT
        release, schema, source, date_start, cle_tache,
        sum(pct_mode) FILTER (WHERE mode IN ('directive', 'feedback loop')) AS pct_auto,
        sum(pct_mode) FILTER (WHERE mode IN ('directive', 'feedback loop', 'task iteration',
                                             'learning', 'validation'))     AS pct_classable
    FROM inter
    GROUP BY ALL
),
pondere AS (
    SELECT
        t.release, t.schema, t.source, t.date_start, m.soc_majeur,
        sum(p.part_pct * m.poids * t.pct_auto)      AS num,
        sum(p.part_pct * m.poids * t.pct_classable) AS den,
        sum(p.part_pct * m.poids)                   AS poids_usage
    FROM par_tache t
    JOIN parts_taches p
      ON  p.release = t.release AND p.source = t.source AND p.geo_level = 'global'
      AND p.cle_tache = t.cle_tache
      AND p.date_start IS NOT DISTINCT FROM t.date_start
    JOIN taches_soc m ON m.cle_tache = t.cle_tache
    GROUP BY ALL
),
long_wide AS (
    SELECT release, schema, source, date_start, soc_majeur,
           100 * num / den AS automatisation_pct, poids_usage,
           'calculé (tâches)' AS methode
    FROM pondere WHERE den > 0
),
mensuel AS (
    SELECT
        u.release, u.schema, u.source, u.date_start,
        coalesce(s.code2, u.item_id) AS soc_majeur,
        max(u.value) FILTER (WHERE u.variable = 'collaboration_bucket_automation_pct')
          / (max(u.value) FILTER (WHERE u.variable = 'collaboration_bucket_automation_pct')
           + max(u.value) FILTER (WHERE u.variable = 'collaboration_bucket_augmentation_pct')) * 100
          AS automatisation_pct,
        CAST(NULL AS DOUBLE) AS poids_usage,
        'publié (groupe SOC)' AS methode
    FROM usage u
    LEFT JOIN (SELECT left(code, 2) AS code2, intitule FROM soc_structure
               WHERE niveau = 'Major Group') s
      ON s.intitule = u.item || ' Occupations'
    WHERE u.schema = 'monthly' AND u.geo_level = 'global'
      AND u.facet = 'soc_occupation' AND u.level = 1
      AND u.variable LIKE 'collaboration\_bucket\_%' ESCAPE '\'
      AND u.item NOT IN ('not_classified', 'none')
    GROUP BY ALL
)
SELECT * FROM long_wide
UNION ALL BY NAME
SELECT * FROM mensuel
ORDER BY ALL;
