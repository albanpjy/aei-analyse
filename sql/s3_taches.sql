-- =============================================================================
-- s3_taches.sql — Pénétration de l'IA dans les tâches des métiers ciblés
-- (task_penetration, jointure texte normalisé avec les énoncés O*NET).
-- Paramètre : {{codes}} (liste SQL de codes SOC à 6 chiffres)
-- =============================================================================
SELECT
    o.soc6, o.metier, o.task_id, o.tache, o.type_tache,
    p.penetration
FROM onet_taches o
LEFT JOIN (
    SELECT regexp_replace(lower(trim(task)), '\s+', ' ', 'g') AS cle_tache,
           max(penetration) AS penetration          -- énoncés en double : max
    FROM task_penetration GROUP BY 1
) p USING (cle_tache)
WHERE o.soc6 IN ({{codes}})
ORDER BY o.soc6, p.penetration DESC NULLS LAST;
