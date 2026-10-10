-- =============================================================================
-- s1_top_taches.sql — Tâches les plus utilisées en France et indice de
-- spécialisation (part en France / part moyenne des 7 pays de comparaison)
-- Paramètres : {{version}}, {{nb}}
-- Techniques : CTE enchaînées, agrégation conditionnelle (FILTER), QUALIFY
-- (filtrer sur une fonction fenêtre sans sous-requête).
-- =============================================================================
WITH periode AS (
    -- dernière période publiée de la version (2 mois dans le schéma mensuel)
    SELECT * FROM parts_taches
    WHERE release = '{{version}}' AND source = 'claude_ai' AND est_classee
      AND geo_id IN ('FRA', 'DEU', 'GBR', 'ESP', 'ITA', 'BEL', 'NLD', 'USA')
    QUALIFY date_start = max(date_start) OVER ()
),
large AS (
    SELECT
        cle_tache,
        any_value(tache) AS tache,
        sum(part_pct) FILTER (WHERE geo_id = 'FRA')  AS part_fra,
        avg(part_pct) FILTER (WHERE geo_id <> 'FRA') AS part_autres,
        count(*) FILTER (WHERE geo_id <> 'FRA')      AS n_autres
    FROM periode
    GROUP BY ALL
)
SELECT *, part_fra / part_autres AS indice_specialisation
FROM large
WHERE part_fra IS NOT NULL
QUALIFY row_number() OVER (ORDER BY part_fra DESC) <= {{nb}}
ORDER BY part_fra DESC;
