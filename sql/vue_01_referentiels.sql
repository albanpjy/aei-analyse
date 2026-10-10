-- =============================================================================
-- vue_01_referentiels.sql — Vues sur les référentiels (Parquet)
-- Exécuté par construire_duckdb() ; chemins relatifs à la racine du projet.
-- =============================================================================

-- Énoncés de tâches O*NET avec leur grand groupe SOC (2 premiers chiffres).
CREATE OR REPLACE VIEW onet_taches AS
SELECT * FROM read_parquet('data/parquet/referentiels/onet_taches.parquet');

CREATE OR REPLACE VIEW soc_structure AS
SELECT * FROM read_parquet('data/parquet/referentiels/soc_structure.parquet');

CREATE OR REPLACE VIEW iso_pays AS
SELECT * FROM read_parquet('data/parquet/referentiels/iso_pays.parquet');

CREATE OR REPLACE VIEW population_age_actif AS
SELECT * FROM read_parquet('data/parquet/referentiels/population_age_actif.parquet');

-- Correspondance tâche -> grand groupe SOC, avec un POIDS : un énoncé présent
-- dans k grands groupes compte pour 1/k dans chacun (convention du projet,
-- voir correspondance_taches_soc() dans R/harmonisation.R).
-- Technique : fonction fenêtre COUNT() OVER (PARTITION BY ...) — pas besoin
-- de sous-requête d'agrégation puis de jointure.
CREATE OR REPLACE VIEW taches_soc AS
SELECT
    cle_tache,
    soc_majeur,
    1.0 / COUNT(*) OVER (PARTITION BY cle_tache) AS poids
FROM (SELECT DISTINCT cle_tache, soc_majeur FROM onet_taches);

-- Source externe : PIB par habitant en PPA (Banque mondiale, CC-BY 4.0).
CREATE OR REPLACE VIEW pib_habitant AS
SELECT * FROM read_parquet('data/parquet/referentiels/pib_habitant.parquet');
