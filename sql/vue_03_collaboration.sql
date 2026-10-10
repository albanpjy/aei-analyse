-- =============================================================================
-- vue_03_collaboration.sql — Modes de collaboration humain–IA
--
--   wide / long : facet = 'collaboration' ; variables collaboration_pct et
--                 collaboration_count (effectif, schéma long seulement)
--   monthly     : facet = 'overall' ; une variable par mode
--                 collaboration_<mode>_pct (pas d'effectif publié)
-- Les libellés mensuels (feedback_loop) sont alignés sur ceux du schéma long
-- (feedback loop).
-- =============================================================================
CREATE OR REPLACE VIEW collaboration AS
WITH long_wide AS (
    -- Agrégation conditionnelle : une ligne par (géographie, mode) avec la
    -- part ET l'effectif côte à côte. GROUP BY ALL regroupe sur toutes les
    -- colonnes non agrégées.
    SELECT
        release, schema, source, date_start, geo_level, geo_id,
        item AS mode,
        max(CASE WHEN variable = 'collaboration_pct'   THEN value END) AS part_pct,
        max(CASE WHEN variable = 'collaboration_count' THEN value END) AS effectif
    FROM usage
    WHERE schema IN ('wide', 'long') AND facet = 'collaboration'
    GROUP BY ALL
),
mensuel AS (
    SELECT
        release, schema, source, date_start, geo_level, geo_id,
        replace(regexp_extract(variable, '^collaboration_(.*)_pct$', 1), '_', ' ') AS mode,
        value AS part_pct,
        CAST(NULL AS DOUBLE) AS effectif
    FROM usage
    WHERE schema = 'monthly' AND facet = 'overall'
      AND variable LIKE 'collaboration\_%\_pct' ESCAPE '\'
      AND variable NOT LIKE 'collaboration\_bucket%' ESCAPE '\'
)
SELECT * FROM long_wide
UNION ALL BY NAME
SELECT * FROM mensuel;

-- Parts d'automatisation et d'augmentation PARMI LES CONVERSATIONS CLASSABLES
-- (définition d'Anthropic : on exclut « none » et « not_classified »).
-- L'effectif classable (somme des effectifs) sert aux intervalles de confiance.
CREATE OR REPLACE VIEW automatisation AS
SELECT
    release, schema, source, date_start, geo_level, geo_id,
    sum(part_pct) FILTER (WHERE mode IN ('directive', 'feedback loop'))
        / sum(part_pct) FILTER (WHERE mode IN ('directive', 'feedback loop', 'task iteration', 'learning', 'validation'))
        * 100 AS automatisation_pct,
    sum(part_pct) FILTER (WHERE mode IN ('task iteration', 'learning', 'validation'))
        / sum(part_pct) FILTER (WHERE mode IN ('directive', 'feedback loop', 'task iteration', 'learning', 'validation'))
        * 100 AS augmentation_pct,
    sum(effectif) FILTER (WHERE mode IN ('directive', 'feedback loop', 'task iteration', 'learning', 'validation'))
        AS effectif_classable
FROM collaboration
GROUP BY ALL;
