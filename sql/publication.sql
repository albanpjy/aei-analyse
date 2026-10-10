-- =============================================================================
-- publication.sql — Fichiers Parquet publiés avec le site, lus dans le
-- navigateur par DuckDB-WASM (tableau de bord). Petits, agrégés, sans
-- donnée individuelle. Paramètre : {{sortie}}
-- =============================================================================

COPY (
    SELECT release, CAST(date_start AS VARCHAR) AS periode, geo_id,
           usage_pct, coalesce(aui_publie, aui_calcule) AS aui,
           CASE WHEN aui_publie IS NOT NULL THEN 'publié' ELSE 'recalculé' END AS origine_aui
    FROM usage_pays WHERE usage_pct IS NOT NULL
) TO '{{sortie}}/usage_pays.parquet' (FORMAT parquet, COMPRESSION zstd);

COPY (
    SELECT release, source, CAST(date_start AS VARCHAR) AS periode, geo_level, geo_id,
           automatisation_pct, augmentation_pct, effectif_classable
    FROM automatisation WHERE geo_level IN ('global', 'country')
) TO '{{sortie}}/automatisation.parquet' (FORMAT parquet, COMPRESSION zstd);

COPY (
    SELECT release, CAST(date_start AS VARCHAR) AS periode, geo_id, soc_majeur, part_pct
    FROM soc_derive WHERE source = 'claude_ai' AND geo_level IN ('global', 'country')
) TO '{{sortie}}/soc_pays.parquet' (FORMAT parquet, COMPRESSION zstd);

-- Tâches : pays de comparaison + mondial, dernière période de chaque version
COPY (
    SELECT release, geo_id, tache, part_pct
    FROM parts_taches
    WHERE source = 'claude_ai' AND est_classee
      AND geo_id IN ('GLOBAL', 'FRA', 'DEU', 'GBR', 'ESP', 'ITA', 'BEL', 'NLD', 'USA')
    QUALIFY date_start IS NOT DISTINCT FROM max(date_start) OVER (PARTITION BY release)
) TO '{{sortie}}/taches.parquet' (FORMAT parquet, COMPRESSION zstd);

COPY (
    SELECT occ_code, title, observed_exposure, left(occ_code, 2) AS soc_majeur
    FROM job_exposure
) TO '{{sortie}}/exposition.parquet' (FORMAT parquet, COMPRESSION zstd);

COPY (SELECT * FROM iso_pays) TO '{{sortie}}/pays.parquet' (FORMAT parquet, COMPRESSION zstd);
