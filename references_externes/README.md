# references_externes/ — tables de référence embarquées

| Fichier | Contenu | Source | Licence |
|---|---|---|---|
| `soc2010_isco08.csv` | Table de passage SOC 2010 → ISCO-08 (un vers plusieurs) | Package R iscoCrosswalks 1.0.0 (Kouretsis & Bampouris, objet `soc10_isco08`), table de l'Institute for Structural Research (IBS) d'après la correspondance du Bureau of Labor Statistics | MIT (package) ; correspondance BLS : domaine public (États-Unis) |

Pourquoi embarquer ? Le package iscoCrosswalks a été retiré de CRAN : en dépendre
rendrait l'environnement renv impossible à restaurer. L'extraction est rejouable avec
`tools/extraire_crosswalk.R`.
