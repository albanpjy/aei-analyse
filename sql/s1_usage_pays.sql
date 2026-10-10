-- =============================================================================
-- s1_usage_pays.sql — Usage et indice d'usage par habitant, tous pays
-- Techniques : fonctions fenêtres rank() (classement par période) et lag()
-- (valeur de la version précédente, pour l'évolution).
-- =============================================================================
WITH base AS (
    SELECT
        release, date_start, geo_id, usage_pct, usage_count,
        aui_publie, aui_calcule,
        coalesce(aui_publie, aui_calcule) AS aui,
        CASE WHEN aui_publie IS NOT NULL THEN 'publié' ELSE 'recalculé' END AS origine_aui
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
