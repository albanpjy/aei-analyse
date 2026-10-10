-- =============================================================================
-- vue_05_soc.sql — Usage par grand groupe de métiers (SOC à 2 chiffres)
--
-- Deux sources, volontairement gardées distinctes :
-- 1. parts PUBLIÉES par Anthropic :
--      2025-09-15 (enriched) : facet 'soc_occupation', variable 'soc_pct',
--                              item = intitulé anglais du grand groupe ;
--      2026-06-26 (monthly)  : facet 'soc_occupation', level 1, variable 'pct',
--                              item_id = code à 2 chiffres.
-- 2. parts DÉRIVÉES par le projet à partir des parts de tâches et de la
--    correspondance tâche -> grand groupe (vue taches_soc) : seule option pour
--    2026-01-15 et 2026-03-24, et contrôle croisé pour 2025-09-15.
-- =============================================================================
CREATE OR REPLACE VIEW soc_publie AS
SELECT
    u.release, u.schema, u.date_start, u.geo_level, u.geo_id,
    coalesce(s.code2, u.item_id) AS soc_majeur,
    u.item AS libelle_en,
    u.value AS part_pct
FROM usage u
LEFT JOIN (
    -- intitulé des grands groupes -> code à 2 chiffres
    SELECT left(code, 2) AS code2, intitule
    FROM soc_structure WHERE niveau = 'Major Group'
) s ON s.intitule = u.item || ' Occupations'
WHERE u.source = 'claude_ai'
  AND ((u.schema = 'long' AND u.facet = 'soc_occupation' AND u.variable = 'soc_pct')
    OR (u.schema = 'monthly' AND u.facet = 'soc_occupation' AND u.level = 1 AND u.variable = 'pct'))
  AND u.item NOT IN ('not_classified', 'none');

CREATE OR REPLACE VIEW soc_derive AS
WITH taches AS (
    -- tâches classées uniquement (ni « none » ni « not_classified »)
    SELECT * FROM parts_taches WHERE est_classee
),
totaux AS (
    -- usage total des tâches classées, par géographie
    SELECT release, source, date_start, geo_id, sum(part_pct) AS total
    FROM taches GROUP BY ALL
),
par_groupe AS (
    -- part pondérée de chaque grand groupe (poids = 1/k si l'énoncé est
    -- partagé par k grands groupes)
    SELECT t.release, t.schema, t.source, t.date_start, t.geo_level, t.geo_id,
           m.soc_majeur, sum(t.part_pct * m.poids) AS part_brute
    FROM taches t
    JOIN taches_soc m USING (cle_tache)
    GROUP BY ALL
)
SELECT
    g.release, g.schema, g.source, g.date_start, g.geo_level, g.geo_id, g.soc_majeur,
    -- renormalisation à 100 par géographie (fonction fenêtre)
    100 * g.part_brute / sum(g.part_brute) OVER w AS part_pct,
    -- taux de rattachement : part de l'usage des tâches classées retrouvée
    -- dans le référentiel O*NET (contrôle qualité de la jointure texte)
    sum(g.part_brute) OVER w / tot.total AS taux_rattachement
FROM par_groupe g
-- IS NOT DISTINCT FROM : les versions « wide » n'ont pas de date (NULL), et
-- NULL = NULL est faux en SQL ; une jointure USING perdrait ces lignes.
JOIN totaux tot
  ON  tot.release = g.release AND tot.source = g.source AND tot.geo_id = g.geo_id
  AND tot.date_start IS NOT DISTINCT FROM g.date_start
WINDOW w AS (PARTITION BY g.release, g.source, g.date_start, g.geo_id);
