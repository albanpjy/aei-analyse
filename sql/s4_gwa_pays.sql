-- =============================================================================
-- s4_gwa_pays.sql — Matrice pays × familles de tâches (GWA), moyenne des
-- périodes de la version, avec l'usage et l'indice par habitant.
-- Paramètre : {{version}}
-- =============================================================================
WITH g AS (
    SELECT geo_id, gwa_code, any_value(gwa) AS gwa, avg(part_pct) AS part_pct
    FROM gwa_pays
    WHERE release = '{{version}}' AND geo_level = 'country'
    GROUP BY ALL
),
u AS (
    SELECT geo_id, avg(usage_pct) AS usage_pct, avg(coalesce(aui_calcule, aui_publie)) AS aui
    FROM usage_pays WHERE release = '{{version}}' GROUP BY ALL
)
SELECT g.*, u.usage_pct, u.aui
FROM g LEFT JOIN u USING (geo_id)
ORDER BY geo_id, gwa_code;
