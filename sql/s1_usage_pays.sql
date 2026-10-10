-- =============================================================================
-- s1_usage_pays.sql — Usage et indice d'usage par habitant, tous pays
-- Techniques : fonctions fenêtres rank() (classement par période) et lag()
-- (valeur de la version précédente, pour l'évolution).
-- =============================================================================
WITH base AS (
    SELECT
        release, date_start, geo_id, usage_pct, usage_count,
        aui_publie, aui_calcule,
        -- Indice RECALCULÉ pour toutes les versions : même méthode partout
        -- (il coïncide avec l'indice publié en 2026-06-26 ; en 2025-09-15
        -- l'indice publié diffère d'un facteur d'échelle constant).
        coalesce(aui_calcule, aui_publie) AS aui,
        CASE WHEN aui_calcule IS NOT NULL THEN 'recalculé' ELSE 'publié' END AS origine_aui
    FROM usage_pays
    WHERE usage_pct IS NOT NULL
)
SELECT
    *,
    rank() OVER (PARTITION BY release, date_start ORDER BY aui DESC NULLS LAST) AS rang_aui,
    count(aui) OVER (PARTITION BY release, date_start)                         AS n_pays_aui,
    lag(aui) OVER (PARTITION BY geo_id ORDER BY release, date_start)           AS aui_precedent
FROM base
ORDER BY release, date_start, rang_aui;
