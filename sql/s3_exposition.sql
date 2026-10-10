-- =============================================================================
-- s3_exposition.sql — Exposition observée des métiers (job_exposure) :
-- rang centile parmi tous les métiers et médiane du grand groupe.
-- Technique : percent_rank() et median() en fenêtre.
-- =============================================================================
SELECT
    occ_code, title, observed_exposure,
    left(occ_code, 2)                                                   AS soc_majeur,
    percent_rank() OVER (ORDER BY observed_exposure)                    AS centile,
    median(observed_exposure) OVER (PARTITION BY left(occ_code, 2))     AS mediane_groupe,
    median(observed_exposure) OVER ()                                   AS mediane_ensemble,
    count(*) OVER ()                                                    AS n_metiers
FROM job_exposure
ORDER BY observed_exposure DESC;
