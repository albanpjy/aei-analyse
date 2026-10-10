-- =============================================================================
-- vue_02_parts_taches.sql — Part de chaque tâche O*NET dans l'usage
--
-- Le même concept porte des noms différents selon l'époque de schéma :
--   wide / long : facet = 'onet_task', variable = 'onet_task_pct'
--   monthly     : facet = 'onet', level = 0 (tâche), variable = 'pct'
-- Unité : pourcentage du total de la géographie.
-- =============================================================================
CREATE OR REPLACE VIEW parts_taches AS
SELECT
    release, schema, source, date_start, geo_level, geo_id,
    item                                              AS tache,
    -- clé de jointure normalisée (minuscules, espaces réduits), identique à
    -- cle_tache() côté R
    regexp_replace(lower(trim(item)), '\s+', ' ', 'g') AS cle_tache,
    item_id                                           AS task_id,
    value                                             AS part_pct,
    item NOT IN ('none', 'not_classified')            AS est_classee
FROM usage
WHERE (schema IN ('wide', 'long') AND facet = 'onet_task' AND variable = 'onet_task_pct')
   OR (schema = 'monthly' AND facet = 'onet' AND level = 0 AND variable = 'pct');
