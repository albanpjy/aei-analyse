-- =============================================================================
-- s3_militaire.sql — Couverture des métiers militaires (SOC 55-xxxx) dans les
-- différentes sources : nomenclature SOC, tâches O*NET, exposition.
-- =============================================================================
SELECT 'Nomenclature SOC (codes 55-)' AS source, count(*) AS n
FROM soc_structure WHERE code LIKE '55-%'
UNION ALL
SELECT 'Tâches O*NET des métiers 55-', count(*) FROM onet_taches WHERE soc_majeur = '55'
UNION ALL
SELECT 'Métiers 55- dans job_exposure', count(*) FROM job_exposure WHERE occ_code LIKE '55-%';
