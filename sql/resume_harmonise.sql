-- Synthèse de la table harmonisée : une ligne par combinaison structurante.
-- Sert au dictionnaire de données et aux contrôles de non-régression.
SELECT
    release, schema, source, geo_level, facet, variable,
    count(*)                    AS n_lignes,
    count(DISTINCT geo_id)      AS n_geo,
    count(DISTINCT item)        AS n_items,
    min(date_start)             AS debut,
    max(date_end)               AS fin
FROM usage
GROUP BY ALL
ORDER BY ALL;
