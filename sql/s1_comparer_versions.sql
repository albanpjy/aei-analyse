-- =============================================================================
-- s1_comparer_versions.sql — Équivalent SQL de aieconindex::aei_compare()
-- pour un pays : parts des tâches dans deux versions, écart et variation.
-- Utilisé en mode fixtures (sans réseau) et comme contrôle en mode réel.
-- Paramètres : {{version_a}}, {{version_b}}, {{pays}}
-- =============================================================================
WITH periodes AS (
    -- dernière période de chacune des deux versions
    SELECT * FROM parts_taches
    WHERE release IN ('{{version_a}}', '{{version_b}}') AND geo_id = '{{pays}}' AND source = 'claude_ai'
    QUALIFY date_start = max(date_start) OVER (PARTITION BY release)
),
large AS (
    -- passage en colonnes : une colonne par version (agrégation conditionnelle)
    SELECT
        cle_tache,
        any_value(tache)                                  AS tache,
        sum(part_pct) FILTER (WHERE release = '{{version_a}}')    AS value_a,
        sum(part_pct) FILTER (WHERE release = '{{version_b}}')    AS value_b
    FROM periodes
    GROUP BY cle_tache
)
SELECT
    cle_tache, tache, value_a, value_b,
    value_b - value_a AS delta,
    CASE WHEN value_a = 0 THEN NULL ELSE (value_b - value_a) / value_a * 100 END AS pct_change
FROM large
WHERE value_a IS NOT NULL AND value_b IS NOT NULL   -- jointure interne, comme aei_compare()
ORDER BY abs(delta) DESC;
