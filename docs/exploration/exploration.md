# Exploration des données réelles de l'AEI

*Généré par `tools/explorer_schema.py` le 2026-10-10 15:10 UTC (GitHub Actions).*

## Version 2025-02-10

| Fichier | Taille (Mo) |
|---|---|
| `release_2025_02_10/plots/automation_vs_augmentation.png` | 0.04 |
| `release_2025_02_10/plots/occupational_category_distribution.png` | 0.14 |
| `release_2025_02_10/plots/occupational_category_distribution_bls.png` | 0.22 |
| `release_2025_02_10/plots/occupations_distribution.png` | 0.10 |
| `release_2025_02_10/plots/task_distribution.png` | 0.21 |
| `release_2025_02_10/plots/wage_distribution.png` | 0.20 |
| `release_2025_02_10/README.md` | 0.00 |
| `release_2025_02_10/SOC_Structure.csv` | 0.07 |
| `release_2025_02_10/automation_vs_augmentation.csv` | 0.00 |
| `release_2025_02_10/bls_employment_may_2023.csv` | 0.00 |
| `release_2025_02_10/onet_task_mappings.csv` | 0.44 |
| `release_2025_02_10/onet_task_statements.csv` | 3.43 |
| `release_2025_02_10/plots.ipynb` | 0.02 |
| `release_2025_02_10/wage_data.csv` | 0.12 |

### `release_2025_02_10/SOC_Structure.csv`

- Lignes : 1 596
- Taille : 0.1 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `Major Group` | VARCHAR | 23 | 1573 | `None` (1573), `47-0000` (1), `39-0000` (1), `37-0000` (1), `35-0000` (1), `29-0000` (1), `27-0000` (1), `17-0000` (1), `11-0000` (1), `43-0000` (1), `23-0000` (1), `53-0000` (1), `15-0000` (1), `41-0000` (1), `33-0000` (1), `31-0000` (1), `51-0000` (1), `19-0000` (1), `21-0000` (1), `13-0000` (1), `45-0000` (1), `49-0000` (1), `25-0000` (1) |
| `Minor Group` | VARCHAR | 98 | 1498 | `None` (1498), `19-3000` (1), `19-2000` (1), `25-4000` (1), `19-4000` (1), `25-2000` (1), `25-3000` (1), `33-2000` (1), … |
| `Broad Occupation` | VARCHAR | 459 | 1137 | `None` (1137), `11-2010` (1), `11-2020` (1), `11-2030` (1), `11-9010` (1), `11-9030` (1), `11-3020` (1), `11-3120` (1), … |
| `Detailed Occupation` | VARCHAR | 867 | 729 | `None` (729), `11-9013` (1), `11-3051` (1), `11-9111` (1), `11-9031` (1), `11-9071` (1), `11-9081` (1), `11-9131` (1), … |
| `Detailed O*NET-SOC` | VARCHAR | 149 | 1447 | `None` (1447), `11-3051.03` (1), `11-3031.01` (1), `11-9199.01` (1), `11-3071.04` (1), `11-9041.01` (1), `11-9179.02` (1), `11-9199.09` (1), … |
| `SOC or O*NET-SOC 2019 Title` | VARCHAR | 1333 | 0 | `Fishing and Hunting Workers` (3), `Human Resources Managers` (2), `Market Research Analysts and Marketing Specialists` (2), `Industrial Production Managers` (2), `Chemical Engineers` (2), `Farmers, Ranchers, and Other Agricultural Managers` (2), `Postmasters and Mail Superintendents` (2), `Transportation, Storage, and Distribution Managers` (2), … |

Premières lignes :

```
  Major Group Minor Group Broad Occupation Detailed Occupation Detailed O*NET-SOC    SOC or O*NET-SOC 2019 Title
0     11-0000         NaN              NaN                 NaN                NaN         Management Occupations
1         NaN     11-1000              NaN                 NaN                NaN                 Top Executives
2         NaN         NaN          11-1010                 NaN                NaN               Chief Executives
3         NaN         NaN              NaN             11-1011                NaN               Chief Executives
4         NaN         NaN              NaN                 NaN         11-1011.03  Chief Sustainability Officers
```

### `release_2025_02_10/automation_vs_augmentation.csv`

- Lignes : 6
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `interaction_type` | VARCHAR | 6 | 0 | `feedback loop` (1), `learning` (1), `task iteration` (1), `directive` (1), `none` (1), `validation` (1) |
| `pct` | DOUBLE | 6 | 0 | `2.9013020624347967` (1), `22.563272409918948` (1), `12.036303266190515` (1), `18.917648061953294` (1), `25.47648663831153` (1), `2.314220367546746` (1) |

Premières lignes :

```
  interaction_type        pct
0        directive  22.563272
1    feedback loop  12.036303
2         learning  18.917648
3             none   2.901302
4   task iteration  25.476487
```

### `release_2025_02_10/bls_employment_may_2023.csv`

- Lignes : 22
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `SOC or O*NET-SOC 2019 Title` | VARCHAR | 22 | 0 | `Protective Service Occupations` (1), `Transportation and Material Moving Occupations` (1), `Food Preparation and Serving Related Occupations` (1), `Arts, Design, Entertainment, Sports, and Media Occupations` (1), `Educational Instruction and Library Occupations` (1), `Personal Care and Service Occupations` (1), `Healthcare Support Occupations` (1), `Computer and Mathematical Occupations` (1), `Construction and Extraction Occupations` (1), `Farming, Fishing, and Forestry Occupations` (1), `Sales and Related Occupations` (1), `Management Occupations` (1), `Life, Physical, and Social Science Occupations` (1), `Business and Financial Operations Occupations` (1), `Production Occupations` (1), `Installation, Maintenance, and Repair Occupations` (1), `Office and Administrative Support Occupations` (1), `Building and Grounds Cleaning and Maintenance Occupations` (1), `Healthcare Practitioners and Technical Occupations` (1), `Legal Occupations` (1), `Community and Social Service Occupations` (1), `Architecture and Engineering Occupations` (1) |
| `bls_distribution` | BIGINT | 22 | 0 | `432200` (1), `18533450` (1), `1389430` (1), `10495770` (1), `13752760` (1), `8770170` (1), `13247870` (1), `3504330` (1), `2106490` (1), `8744560` (1), `6225630` (1), `10087830` (1), `2418130` (1), `2539660` (1), `5989460` (1), `13380660` (1), `3040630` (1), `4429070` (1), `7063530` (1), `9284210` (1), `1240630` (1), `5177400` (1) |

Premières lignes :

```
               SOC or O*NET-SOC 2019 Title  bls_distribution
0                   Management Occupations          10495770
1  Business and Financial Operations Oc...          10087830
2    Computer and Mathematical Occupations           5177400
3  Architecture and Engineering Occupat...           2539660
4  Life, Physical, and Social Science O...           1389430
```

### `release_2025_02_10/onet_task_mappings.csv`

- Lignes : 3 514
- Taille : 0.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3514 | 0 | `act as an intermediary in negotiations between buyers and se` (1), `act as liaisons between on-site managers or tenants and owne` (1), `adapt teaching methods and instructional materials to meet s` (1), `adapt translations to students' cognitive and grade levels, ` (1), `advise animal owners regarding sanitary measures, feeding, g` (1), `advise clients on financial and legal matters such as invest` (1), `advise clients or respond to inquiries about financial matte` (1), `advise corporations on issues involving corporate image proj` (1), … |
| `pct` | DOUBLE | 609 | 0 | `0.002084663392007922` (116), `0.0019543719300074264` (103), `0.002475537778009407` (97), `0.0023452463160089122` (96), `0.002214954854008417` (93), `0.002736120702010397` (87), `0.002605829240009902` (79), `0.0029967036260113876` (74), … |

Premières lignes :

```
                                 task_name       pct
0  act as advisers to student organizat...  0.006775
1  act as an advocate for farmers or fa...  0.002997
2  act as an intermediary in negotiatio...  0.012638
3  act as an intermediary in negotiatio...  0.011466
4  act as liaisons between clients and ...  0.001954
```

### `release_2025_02_10/onet_task_statements.csv`

- Lignes : 19 530
- Taille : 3.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `O*NET-SOC Code` | VARCHAR | 974 | 0 | `25-2053.00` (40), `25-2052.00` (40), `25-2054.00` (40), `51-4121.06` (40), `51-9071.01` (40), `49-2022.00` (40), `25-3011.00` (39), `49-2092.00` (39), … |
| `Title` | VARCHAR | 974 | 0 | `Special Education Teachers, Middle School` (40), `Telecommunications Equipment Installers and Repairers, Excep` (40), `Jewelers` (40), `Special Education Teachers, Kindergarten and Elementary Scho` (40), `Special Education Teachers, Secondary School` (40), `Welders, Cutters, and Welder Fitters` (40), `Electric Motor, Power Tool, and Related Repairers` (39), `Plating and Coating Machine Setters, Operators, and Tenders,` (39), … |
| `Task ID` | BIGINT | 19530 | 0 | `8836` (1), `8832` (1), `8835` (1), `8833` (1), `8837` (1), `8843` (1), `8846` (1), `8848` (1), … |
| `Task` | VARCHAR | 18429 | 0 | `Act as advisers to student organizations.` (34), `Maintain student attendance records, grades, and other requi` (34), `Participate in student recruitment, registration, and placem` (34), `Serve on academic or administrative committees that deal wit` (34), `Compile bibliographies of specialized materials for outside ` (34), `Maintain regularly scheduled office hours to advise and assi` (34), `Collaborate with colleagues to address teaching and research` (33), `Prepare course materials such as syllabi, homework assignmen` (33), … |
| `Task Type` | VARCHAR | 2 | 658 | `Core` (13487), `Supplemental` (5385) |
| `Incumbents Responding` | DOUBLE | 191 | 658 | `None` (658), `23.0` (457), `24.0` (423), `28.0` (396), `26.0` (384), `25.0` (360), `22.0` (339), `21.0` (313), … |
| `Date` | VARCHAR | 17 | 0 | `07/2014` (2659), `07/2011` (2346), `07/2013` (2243), `07/2012` (2142), `07/2015` (2037), `06/2010` (1872), `06/2009` (1471), `06/2007` (1356), `06/2008` (1112), `12/2006` (926), `06/2006` (537), `12/2005` (390), `02/2011` (129), `07/2005` (110), `12/2004` (109), `03/2003` (54), `07/2004` (37) |
| `Domain Source` | VARCHAR | 3 | 0 | `Incumbent` (14511), `Occupational Expert` (4361), `Analyst` (658) |

Premières lignes :

```
  O*NET-SOC Code             Title  Task ID                                     Task Task Type  Incumbents Responding     Date Domain Source
0     11-1011.00  Chief Executives     8823  Direct or coordinate an organization...      Core                   87.0  07/2014     Incumbent
1     11-1011.00  Chief Executives     8831  Appoint department heads or managers...      Core                   87.0  07/2014     Incumbent
2     11-1011.00  Chief Executives     8825  Analyze operations to evaluate perfo...      Core                   87.0  07/2014     Incumbent
3     11-1011.00  Chief Executives     8826  Direct, plan, or implement policies,...      Core                   87.0  07/2014     Incumbent
4     11-1011.00  Chief Executives     8827  Prepare budgets for approval, includ...      Core                   87.0  07/2014     Incumbent
```

### `release_2025_02_10/wage_data.csv`

- Lignes : 1 090
- Taille : 0.1 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `SOCcode` | VARCHAR | 1090 | 0 | `29-1141.01` (1), `25-3011.00` (1), `45-2099.00` (1), `29-1061.00` (1), `19-1011.00` (1), `13-2021.00` (1), `19-3091.02` (1), `27-1011.00` (1), … |
| `JobName` | VARCHAR | 1090 | 0 | `Acute Care Nurses` (1), `Adhesive Bonding Machine Operators and Tenders` (1), `Advanced Practice Psychiatric Nurses` (1), `Aerospace Engineers` (1), `Agents and Business Managers of Artists, Performers, and Ath` (1), `Agricultural and Food Science Technicians` (1), `Agricultural Engineers` (1), `Agricultural Workers, All Other` (1), … |
| `JobFamily` | VARCHAR | 22 | 0 | `Production` (122), `Healthcare Practitioners and Technical` (92), `Architecture and Engineering` (80), `Life, Physical, and Social Science` (72), `Office and Administrative Support` (72), `Construction and Extraction` (67), `Education, Training, and Library` (66), `Management` (64), `Transportation and Material Moving` (59), `Installation, Maintenance, and Repair` (58), `Business and Financial Operations` (57), `Arts, Design, Entertainment, Sports, and Media` (52), `Protective Service` (36), `Personal Care and Service` (35), `Computer and Mathematical` (35), `Sales and Related` (27), `Farming, Fishing, and Forestry` (21), `Healthcare Support` (19), `Food Preparation and Serving Related` (19), `Community and Social Service` (18), `Building and Grounds Cleaning and Maintenance` (10), `Legal` (9) |
| `isBright` | BOOLEAN | 2 | 0 | `false` (655), `true` (435) |
| `isGreen` | BOOLEAN | 2 | 0 | `false` (886), `true` (204) |
| `JobZone` | BIGINT | 6 | 0 | `2` (294), `3` (245), `4` (232), `5` (162), `-1` (121), `1` (36) |
| `MedianSalary` | DOUBLE | 759 | 0 | `63200.0` (13), `200890.0` (13), `90270.0` (13), `96980.0` (12), `107480.0` (10), `70530.0` (7), `103380.0` (7), `68860.0` (7), … |
| `JobForecast` | BIGINT | 318 | 0 | `800` (20), `11700` (20), `200` (17), `5300` (16), `1400` (16), `8800` (16), `700` (15), `1800` (14), … |
| `ChanceAuto` | DOUBLE | 114 | 0 | `-1.0` (424), `97.0` (24), `98.0` (21), `94.0` (19), `4.0` (18), `3.0` (17), `96.0` (16), `83.0` (16), … |
| `WageGroup` | VARCHAR | 117 | 795 | `None` (795), `Physicians and Surgeons, All Other` (12), `Engineering Technicians, Except Drafters, All Other` (12), `Computer Occupations, All Other` (12), `Engineers, All Other` (11), `Managers, All Other` (9), `Compliance Officers` (6), `Industrial Production Managers` (6), … |

Premières lignes :

```
      SOCcode                   JobName                                JobFamily  isBright  isGreen  JobZone  MedianSalary  JobForecast  ChanceAuto                                WageGroup
0  13-2011.01               Accountants        Business and Financial Operations      True    False        4      70500.00       146000        -1.0                 Accountants and Auditors
1  13-2011.00  Accountants and Auditors        Business and Financial Operations      True    False       -1      70500.00       146000        94.0                                      NaN
2  27-2011.00                    Actors  Arts, Design, Entertainment, Sports,...     False    False        2         17.54         7700        37.0                                      NaN
3  15-2011.00                 Actuaries                Computer and Mathematical      True    False        4     102880.00         2200        21.0                                      NaN
4  29-1199.01            Acupuncturists   Healthcare Practitioners and Technical      True    False        5      73960.00         3400        -1.0  Health Diagnosing and Treating Pract...
```

## Version 2025-03-27

| Fichier | Taille (Mo) |
|---|---|
| `release_2025_03_27/cluster_level_data/README.md` | 0.00 |
| `release_2025_03_27/cluster_level_data/cluster_level_dataset.tsv` | 0.90 |
| `release_2025_03_27/cluster_level_data/cluster_level_example_analysis.ipynb` | 0.27 |
| `release_2025_03_27/README.md` | 0.00 |
| `release_2025_03_27/SOC_Structure.csv` | 0.07 |
| `release_2025_03_27/automation_augmentation_by_occupation.png` | 0.64 |
| `release_2025_03_27/automation_augmentation_comparison.png` | 0.14 |
| `release_2025_03_27/automation_vs_augmentation_by_task.csv` | 0.54 |
| `release_2025_03_27/automation_vs_augmentation_v1.csv` | 0.00 |
| `release_2025_03_27/automation_vs_augmentation_v2.csv` | 0.00 |
| `release_2025_03_27/normalized_automation_by_category.png` | 0.81 |
| `release_2025_03_27/onet_task_statements.csv` | 3.43 |
| `release_2025_03_27/task_pct_v1.csv` | 0.44 |
| `release_2025_03_27/task_pct_v2.csv` | 0.42 |
| `release_2025_03_27/task_thinking_fractions.csv` | 0.36 |
| `release_2025_03_27/v2_report_replication.ipynb` | 1.81 |

### `release_2025_03_27/SOC_Structure.csv`

- Lignes : 1 596
- Taille : 0.1 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `Major Group` | VARCHAR | 23 | 1573 | `None` (1573), `19-0000` (1), `43-0000` (1), `23-0000` (1), `49-0000` (1), `25-0000` (1), `15-0000` (1), `47-0000` (1), `41-0000` (1), `33-0000` (1), `31-0000` (1), `45-0000` (1), `11-0000` (1), `21-0000` (1), `13-0000` (1), `53-0000` (1), `55-0000` (1), `39-0000` (1), `37-0000` (1), `35-0000` (1), `29-0000` (1), `27-0000` (1), `17-0000` (1) |
| `Minor Group` | VARCHAR | 98 | 1498 | `None` (1498), `19-3000` (1), `19-2000` (1), `25-4000` (1), `19-4000` (1), `25-2000` (1), `25-3000` (1), `33-2000` (1), … |
| `Broad Occupation` | VARCHAR | 459 | 1137 | `None` (1137), `11-2010` (1), `11-2020` (1), `11-2030` (1), `11-9010` (1), `11-9030` (1), `11-3020` (1), `11-3120` (1), … |
| `Detailed Occupation` | VARCHAR | 867 | 729 | `None` (729), `11-9013` (1), `11-3051` (1), `11-9111` (1), `11-9031` (1), `11-9071` (1), `11-9081` (1), `11-9131` (1), … |
| `Detailed O*NET-SOC` | VARCHAR | 149 | 1447 | `None` (1447), `11-3013.01` (1), `11-3031.03` (1), `11-3051.01` (1), `13-1199.05` (1), `13-1199.07` (1), `11-9121.01` (1), `13-1041.03` (1), … |
| `SOC or O*NET-SOC 2019 Title` | VARCHAR | 1333 | 0 | `Fishing and Hunting Workers` (3), `Human Resources Managers` (2), `Market Research Analysts and Marketing Specialists` (2), `Industrial Production Managers` (2), `Chemical Engineers` (2), `Farmers, Ranchers, and Other Agricultural Managers` (2), `Postmasters and Mail Superintendents` (2), `Transportation, Storage, and Distribution Managers` (2), … |

Premières lignes :

```
  Major Group Minor Group Broad Occupation Detailed Occupation Detailed O*NET-SOC    SOC or O*NET-SOC 2019 Title
0     11-0000         NaN              NaN                 NaN                NaN         Management Occupations
1         NaN     11-1000              NaN                 NaN                NaN                 Top Executives
2         NaN         NaN          11-1010                 NaN                NaN               Chief Executives
3         NaN         NaN              NaN             11-1011                NaN               Chief Executives
4         NaN         NaN              NaN                 NaN         11-1011.03  Chief Sustainability Officers
```

### `release_2025_03_27/automation_vs_augmentation_by_task.csv`

- Lignes : 3 364
- Taille : 0.5 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3364 | 0 | `accept commissions to create music for special occasions.` (1), `act as an advocate for farmers or farmers' groups.` (1), `act as an intermediary in negotiations between buyers and se` (1), `adapt or design computer hardware or software for medical sc` (1), `adapt software and accompanying technical documents to anoth` (1), `address legal issues, such as child abuse and discipline, as` (1), `address the relationships of quantities, magnitudes, and for` (1), `adjust, repair, or replace malfunctioning components or asse` (1), … |
| `feedback_loop` | DOUBLE | 469 | 0 | `0.0` (2887), `0.2` (3), `0.08196721311475409` (2), `0.24489795918367346` (2), `0.25` (2), `0.2112676056338028` (2), `0.07575757575757576` (2), `0.1743119266055046` (2), … |
| `directive` | DOUBLE | 1376 | 0 | `0.0` (1615), `0.5` (16), `0.4` (16), `0.375` (10), `0.42857142857142855` (8), `0.3333333333333333` (7), `0.3` (7), `0.6` (7), … |
| `task_iteration` | DOUBLE | 1295 | 0 | `0.0` (1822), `0.3333333333333333` (15), `0.5` (14), `0.4` (12), `0.45454545454545453` (6), `0.4722222222222222` (6), `0.46153846153846156` (5), `0.4444444444444444` (5), … |
| `validation` | DOUBLE | 358 | 0 | `0.0` (3005), `0.033707865168539325` (2), `0.03937007874015748` (2), `0.03834355828220859` (1), `0.017897091722595078` (1), `0.10778443113772455` (1), `0.0703205791106515` (1), `0.09798270893371758` (1), … |
| `learning` | DOUBLE | 1292 | 0 | `0.0` (1804), `0.5` (14), `0.4` (9), `0.45454545454545453` (9), `0.6666666666666666` (8), `0.48484848484848486` (6), `0.6428571428571429` (6), `0.3333333333333333` (6), … |
| `filtered` | DOUBLE | 1543 | 0 | `1.0` (1066), `0.5` (25), `0.3333333333333333` (23), `0.2` (13), `0.4` (13), `0.125` (12), `0.2857142857142857` (11), `0.5454545454545454` (10), … |

Premières lignes :

```
                                 task_name  feedback_loop  directive  task_iteration  validation  learning  filtered
0  accept commissions to create music f...            0.0   0.000000        0.000000         0.0       0.0  1.000000
1  act as advisers to student organizat...            0.0   0.382979        0.361702         0.0       0.0  0.255319
2  act as an advocate for farmers or fa...            0.0   0.000000        0.000000         0.0       0.0  1.000000
3  act as an intermediary in negotiatio...            0.0   0.391304        0.434783         0.0       0.0  0.173913
4  act as an intermediary in negotiatio...            0.0   0.391304        0.376812         0.0       0.0  0.231884
```

### `release_2025_03_27/automation_vs_augmentation_v1.csv`

- Lignes : 6
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `interaction_type` | VARCHAR | 6 | 0 | `directive` (1), `feedback loop` (1), `learning` (1), `task iteration` (1), `none` (1), `validation` (1) |
| `pct` | DOUBLE | 6 | 0 | `22.563272409918948` (1), `12.036303266190515` (1), `18.917648061953294` (1), `25.47648663831153` (1), `2.314220367546746` (1), `2.9013020624347967` (1) |

Premières lignes :

```
  interaction_type        pct
0        directive  22.563272
1    feedback loop  12.036303
2         learning  18.917648
3             none   2.901302
4   task iteration  25.476487
```

### `release_2025_03_27/automation_vs_augmentation_v2.csv`

- Lignes : 6
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `interaction_type` | VARCHAR | 6 | 0 | `feedback loop` (1), `directive` (1), `learning` (1), `task iteration` (1), `none` (1), `validation` (1) |
| `pct` | DOUBLE | 6 | 0 | `24.038560578408678` (1), `3.972959594393916` (1), `29.420541308119624` (1), `27.080406206093095` (1), `12.245083676255144` (1), `3.2389485842287633` (1) |

Premières lignes :

```
  interaction_type        pct
0        directive  29.420541
1    feedback loop  12.245084
2         learning  27.080406
3             none   3.238949
4   task iteration  24.038561
```

### `release_2025_03_27/onet_task_statements.csv`

- Lignes : 19 530
- Taille : 3.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `O*NET-SOC Code` | VARCHAR | 974 | 0 | `25-2053.00` (40), `25-2052.00` (40), `25-2054.00` (40), `51-4121.06` (40), `51-9071.01` (40), `49-2022.00` (40), `25-3011.00` (39), `49-2092.00` (39), … |
| `Title` | VARCHAR | 974 | 0 | `Jewelers` (40), `Telecommunications Equipment Installers and Repairers, Excep` (40), `Special Education Teachers, Secondary School` (40), `Special Education Teachers, Kindergarten and Elementary Scho` (40), `Special Education Teachers, Middle School` (40), `Welders, Cutters, and Welder Fitters` (40), `Plating and Coating Machine Setters, Operators, and Tenders,` (39), `Musical Instrument Repairers and Tuners` (39), … |
| `Task ID` | BIGINT | 19530 | 0 | `8836` (1), `8832` (1), `8835` (1), `8833` (1), `8837` (1), `8843` (1), `8846` (1), `8848` (1), … |
| `Task` | VARCHAR | 18429 | 0 | `Compile bibliographies of specialized materials for outside ` (34), `Serve on academic or administrative committees that deal wit` (34), `Maintain student attendance records, grades, and other requi` (34), `Maintain regularly scheduled office hours to advise and assi` (34), `Participate in student recruitment, registration, and placem` (34), `Act as advisers to student organizations.` (34), `Write grant proposals to procure external research funding.` (33), `Initiate, facilitate, and moderate classroom discussions.` (33), … |
| `Task Type` | VARCHAR | 2 | 658 | `Core` (13487), `Supplemental` (5385) |
| `Incumbents Responding` | DOUBLE | 191 | 658 | `None` (658), `23.0` (457), `24.0` (423), `28.0` (396), `26.0` (384), `25.0` (360), `22.0` (339), `21.0` (313), … |
| `Date` | VARCHAR | 17 | 0 | `07/2014` (2659), `07/2011` (2346), `07/2013` (2243), `07/2012` (2142), `07/2015` (2037), `06/2010` (1872), `06/2009` (1471), `06/2007` (1356), `06/2008` (1112), `12/2006` (926), `06/2006` (537), `12/2005` (390), `02/2011` (129), `07/2005` (110), `12/2004` (109), `03/2003` (54), `07/2004` (37) |
| `Domain Source` | VARCHAR | 3 | 0 | `Incumbent` (14511), `Occupational Expert` (4361), `Analyst` (658) |

Premières lignes :

```
  O*NET-SOC Code             Title  Task ID                                     Task Task Type  Incumbents Responding     Date Domain Source
0     11-1011.00  Chief Executives     8823  Direct or coordinate an organization...      Core                   87.0  07/2014     Incumbent
1     11-1011.00  Chief Executives     8831  Appoint department heads or managers...      Core                   87.0  07/2014     Incumbent
2     11-1011.00  Chief Executives     8825  Analyze operations to evaluate perfo...      Core                   87.0  07/2014     Incumbent
3     11-1011.00  Chief Executives     8826  Direct, plan, or implement policies,...      Core                   87.0  07/2014     Incumbent
4     11-1011.00  Chief Executives     8827  Prepare budgets for approval, includ...      Core                   87.0  07/2014     Incumbent
```

### `release_2025_03_27/task_pct_v1.csv`

- Lignes : 3 514
- Taille : 0.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3514 | 0 | `act as liaisons between ships' captains and shore personnel ` (1), `adapt instructional content or delivery methods for differen` (1), `adapt the quantity of ingredients to match the amount of ite` (1), `address employee relations issues, such as harassment allega` (1), `address public audiences to explain program objectives and t` (1), `adjust controls of equipment to control particle beam moveme` (1), `adjust controls to regulate temperature, pressure, feed, or ` (1), `adjust sales scripts to better target the needs and interest` (1), … |
| `pct` | DOUBLE | 609 | 0 | `0.002084663392007922` (116), `0.0019543719300074264` (103), `0.002475537778009407` (97), `0.0023452463160089122` (96), `0.002214954854008417` (93), `0.002736120702010397` (87), `0.002605829240009902` (79), `0.0029967036260113876` (74), … |

Premières lignes :

```
                                 task_name       pct
0  act as advisers to student organizat...  0.006775
1  act as an advocate for farmers or fa...  0.002997
2  act as an intermediary in negotiatio...  0.012638
3  act as an intermediary in negotiatio...  0.011466
4  act as liaisons between clients and ...  0.001954
```

### `release_2025_03_27/task_pct_v2.csv`

- Lignes : 3 365
- Taille : 0.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3365 | 0 | `adapt instructional content or delivery methods for differen` (1), `adapt the quantity of ingredients to match the amount of ite` (1), `address employee relations issues, such as harassment allega` (1), `adjust controls to regulate temperature, pressure, feed, or ` (1), `adjust sales scripts to better target the needs and interest` (1), `adjust, maintain, or repair laboratory equipment such as mic` (1), `administer document and system access rights and revision co` (1), `administer, proctor, or score academic or diagnostic assessm` (1), … |
| `pct` | DOUBLE | 661 | 0 | `0.0016433246100185286` (112), `0.0015406168218923706` (103), `0.0017460323981446867` (92), `0.0019514479743970028` (79), `0.002156863550649319` (76), `0.002567694703153951` (73), `0.0018487401862708444` (68), `0.002464986915027793` (65), … |

Premières lignes :

```
                                 task_name       pct
0  accept commissions to create music f...  0.002054
1  act as advisers to student organizat...  0.004827
2  act as an advocate for farmers or fa...  0.001643
3  act as an intermediary in negotiatio...  0.004725
4  act as an intermediary in negotiatio...  0.007087
```

### `release_2025_03_27/task_thinking_fractions.csv`

- Lignes : 3 365
- Taille : 0.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3365 | 0 | `accept commissions to create music for special occasions.` (1), `act as an advocate for farmers or farmers' groups.` (1), `act as an intermediary in negotiations between buyers and se` (1), `adapt or design computer hardware or software for medical sc` (1), `adapt software and accompanying technical documents to anoth` (1), `address legal issues, such as child abuse and discipline, as` (1), `address the relationships of quantities, magnitudes, and for` (1), `adjust, repair, or replace malfunctioning components or asse` (1), … |
| `thinking_fraction` | DOUBLE | 409 | 2950 | `None` (2950), `0.052478135` (2), `0.057142857` (2), `0.06993007` (2), `0.058192957` (2), `0.04` (2), `0.098445594` (2), `0.044487428` (1), … |

Premières lignes :

```
                                 task_name  thinking_fraction
0  accept commissions to create music f...                NaN
1  act as advisers to student organizat...                NaN
2  act as an advocate for farmers or fa...                NaN
3  act as an intermediary in negotiatio...                NaN
4  act as an intermediary in negotiatio...                NaN
```

## Version 2025-09-15

| Fichier | Taille (Mo) |
|---|---|
| `release_2025_09_15/code/aei_analysis_functions_1p_api.py` | 0.07 |
| `release_2025_09_15/code/aei_analysis_functions_claude_ai.py` | 0.09 |
| `release_2025_09_15/code/aei_report_v3_analysis_1p_api.ipynb` | 0.01 |
| `release_2025_09_15/code/aei_report_v3_analysis_claude_ai.ipynb` | 0.02 |
| `release_2025_09_15/code/aei_report_v3_change_over_time_claude_ai.py` | 0.02 |
| `release_2025_09_15/code/aei_report_v3_preprocessing_claude_ai.ipynb` | 0.08 |
| `release_2025_09_15/code/preprocess_gdp.py` | 0.01 |
| `release_2025_09_15/code/preprocess_iso_codes.py` | 0.00 |
| `release_2025_09_15/code/preprocess_onet.py` | 0.01 |
| `release_2025_09_15/code/preprocess_population.py` | 0.01 |
| `release_2025_09_15/data/input/BTOS_National.xlsx` | 0.06 |
| `release_2025_09_15/data/input/Population by single age _20250903072924.csv` | 0.00 |
| `release_2025_09_15/data/input/automation_vs_augmentation_v1.csv` | 0.00 |
| `release_2025_09_15/data/input/automation_vs_augmentation_v2.csv` | 0.00 |
| `release_2025_09_15/data/input/bea_us_state_gdp_2024.csv` | 0.00 |
| `release_2025_09_15/data/input/census_state_codes.txt` | 0.00 |
| `release_2025_09_15/data/input/geonames_countryInfo.txt` | 0.03 |
| `release_2025_09_15/data/input/imf_gdp_raw_2024.json` | 0.25 |
| `release_2025_09_15/data/input/onet_task_statements_raw.xlsx` | 1.15 |
| `release_2025_09_15/data/input/sc-est2024-agesex-civ.csv` | 0.78 |
| `release_2025_09_15/data/input/soc_structure_raw.csv` | 0.07 |
| `release_2025_09_15/data/input/task_pct_v1.csv` | 0.44 |
| `release_2025_09_15/data/input/task_pct_v2.csv` | 0.42 |
| `release_2025_09_15/data/input/working_age_pop_2024_country_raw.csv` | 0.02 |
| `release_2025_09_15/data/intermediate/aei_raw_1p_api_2025-08-04_to_2025-08-11.csv` | 6.70 |
| `release_2025_09_15/data/intermediate/aei_raw_claude_ai_2025-08-04_to_2025-08-11.csv` | 18.02 |
| `release_2025_09_15/data/intermediate/gdp_2024_country.csv` | 0.00 |
| `release_2025_09_15/data/intermediate/gdp_2024_us_state.csv` | 0.00 |
| `release_2025_09_15/data/intermediate/iso_country_codes.csv` | 0.00 |
| `release_2025_09_15/data/intermediate/onet_task_statements.csv` | 3.48 |
| `release_2025_09_15/data/intermediate/soc_structure.csv` | 0.08 |
| `release_2025_09_15/data/intermediate/working_age_pop_2024_country.csv` | 0.01 |
| `release_2025_09_15/data/intermediate/working_age_pop_2024_us_state.csv` | 0.00 |
| `release_2025_09_15/data/output/aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv` | 25.60 |
| `release_2025_09_15/data/output/request_hierarchy_tree_1p_api.json` | 0.29 |
| `release_2025_09_15/data/output/request_hierarchy_tree_claude_ai.json` | 0.42 |
| `release_2025_09_15/README.md` | 0.00 |
| `release_2025_09_15/data_documentation.md` | 0.02 |

### `release_2025_09_15/data/input/Population by single age _20250903072924.csv` : ERREUR URL can't contain control characters. '/datasets/Anthropic/EconomicIndex/resolve/main/release_2025_09_15/data/input/Population by single age _20250903072924.csv' (found at least ' ')

### `release_2025_09_15/data/input/automation_vs_augmentation_v1.csv`

- Lignes : 6
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `interaction_type` | VARCHAR | 6 | 0 | `feedback loop` (1), `directive` (1), `none` (1), `validation` (1), `learning` (1), `task iteration` (1) |
| `pct` | DOUBLE | 6 | 0 | `22.563272409918948` (1), `12.036303266190515` (1), `18.917648061953294` (1), `25.47648663831153` (1), `2.314220367546746` (1), `2.9013020624347967` (1) |

Premières lignes :

```
  interaction_type        pct
0        directive  22.563272
1    feedback loop  12.036303
2         learning  18.917648
3             none   2.901302
4   task iteration  25.476487
```

### `release_2025_09_15/data/input/automation_vs_augmentation_v2.csv`

- Lignes : 6
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `interaction_type` | VARCHAR | 6 | 0 | `directive` (1), `feedback loop` (1), `none` (1), `validation` (1), `learning` (1), `task iteration` (1) |
| `pct` | DOUBLE | 6 | 0 | `24.038560578408678` (1), `3.972959594393916` (1), `12.245083676255144` (1), `3.2389485842287633` (1), `29.420541308119624` (1), `27.080406206093095` (1) |

Premières lignes :

```
  interaction_type        pct
0        directive  29.420541
1    feedback loop  12.245084
2         learning  27.080406
3             none   3.238949
4   task iteration  24.038561
```

### `release_2025_09_15/data/input/bea_us_state_gdp_2024.csv`

- Lignes : 58
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `SASUMMARY State annual summary statistics: personal income, GDP, consumer spending, price indexes, and employment` | VARCHAR | 57 | 1 | `46000,South Dakota,75179.5` (1), `47000,Tennessee,549708.5` (1), `48000,Texas,2709392.9` (1), `55000,Wisconsin,451285.3` (1), `SASUMMARY State annual summary statistics: personal income, ` (1), `State or DC` (1), `00000,United States,29184890.0` (1), `12000,Florida,1705564.9` (1), `15000,Hawaii,115627.2` (1), `18000,Indiana,527381.1` (1), `21000,Kentucky,293021.0` (1), `22000,Louisiana,327782.1` (1), `23000,Maine,98606.0` (1), `33000,New Hampshire,121189.4` (1), `42000,Pennsylvania,1024206.3` (1), `44000,Rhode Island,82492.5` (1), `Legend/Footnotes` (1), `  Last updated: March 28, 2025.` (1), `02000,Alaska,69969.0` (1), `04000,Arizona,552167.0` (1), `05000,Arkansas,188723.1` (1), `06000,California,4103123.6` (1), `17000,Illinois,1137243.6` (1), `29000,Missouri,451201.4` (1), `34000,New Jersey,846587.5` (1), `37000,North Carolina,839122.2` (1), `41000,Oregon,331028.6` (1), `49000,Utah,300903.8` (1), `54000,West Virginia,107660.1` (1), `27000,Minnesota,500851.4` (1), `56000,Wyoming,52946.1` (1), `53000,Washington,854683.3` (1), `51000,Virginia,764474.8` (1), `50000,Vermont,45707.2` (1), `45000,South Carolina,349965.4` (1), `39000,Ohio,927740.1` (1), `38000,North Dakota,75399.4` (1), `36000,New York,2297028.0` (1), `35000,New Mexico,140542.0` (1), `32000,Nevada,260728.4` (1), `31000,Nebraska,185411.0` (1), `GeoFips,GeoName,2024` (1), `28000,Mississippi,157491.0` (1), `30000,Montana,75999.2` (1), `26000,Michigan,706615.8` (1), `25000,Massachusetts,780666.2` (1), `20000,Kansas,234673.2` (1), `16000,Idaho,128132.1` (1), `13000,Georgia,882534.5` (1), `10000,Delaware,103253.3` (1), `09000,Connecticut,365723.1` (1), `08000,Colorado,553322.5` (1), `01000,Alabama,321237.6` (1), `11000,District of Columbia,186165.0` (1), `19000,Iowa,257020.8` (1), `24000,Maryland,542765.8` (1), `40000,Oklahoma,265779.1` (1) |

Premières lignes :

```
  SASUMMARY State annual summary statistics: personal income, GDP, consumer spending, price indexes, and employment
0  SASUMMARY State annual summary stati...                                                                         
1                              State or DC                                                                         
2                     GeoFips,GeoName,2024                                                                         
3           00000,United States,29184890.0                                                                         
4                   01000,Alabama,321237.6                                                                         
```

### `release_2025_09_15/data/input/sc-est2024-agesex-civ.csv`

- Lignes : 13 572
- Taille : 0.8 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `SUMLEV` | BIGINT | 2 | 0 | `40` (13311), `10` (261) |
| `REGION` | BIGINT | 5 | 0 | `3` (4437), `4` (3393), `2` (3132), `1` (2349), `0` (261) |
| `DIVISION` | BIGINT | 10 | 0 | `5` (2349), `8` (2088), `4` (1827), `1` (1566), `3` (1305), `9` (1305), `6` (1044), `7` (1044), `2` (783), `0` (261) |
| `STATE` | BIGINT | 52 | 0 | `42` (261), `50` (261), `54` (261), `1` (261), `5` (261), `6` (261), `9` (261), `15` (261), `18` (261), `20` (261), `22` (261), `36` (261), `39` (261), `49` (261), `53` (261), `2` (261), `11` (261), `12` (261), `24` (261), `27` (261), `30` (261), `31` (261), `35` (261), `37` (261), `45` (261), `51` (261), `23` (261), `56` (261), `55` (261), `48` (261), `47` (261), `46` (261), `44` (261), `41` (261), `40` (261), `38` (261), `0` (261), `32` (261), `26` (261), `34` (261), `21` (261), `19` (261), `17` (261), `16` (261), `13` (261), `8` (261), `4` (261), `10` (261), `25` (261), `28` (261), `29` (261), `33` (261) |
| `NAME` | VARCHAR | 52 | 0 | `Washington` (261), `New Mexico` (261), `New York` (261), `Wisconsin` (261), `Connecticut` (261), `District of Columbia` (261), `Louisiana` (261), `Minnesota` (261), `Mississippi` (261), `Montana` (261), `Nevada` (261), `New Hampshire` (261), `South Dakota` (261), `Michigan` (261), `Wyoming` (261), `Alaska` (261), `Arkansas` (261), `Delaware` (261), `Georgia` (261), `Idaho` (261), `Indiana` (261), `Maine` (261), `Massachusetts` (261), `Missouri` (261), `Pennsylvania` (261), `Utah` (261), `New Jersey` (261), `West Virginia` (261), `Virginia` (261), `Vermont` (261), `Texas` (261), `Tennessee` (261), `South Carolina` (261), `Rhode Island` (261), `Oregon` (261), `Alabama` (261), `Ohio` (261), `North Dakota` (261), `North Carolina` (261), `Oklahoma` (261), `Nebraska` (261), `Hawaii` (261), `Florida` (261), `California` (261), `United States` (261), `Arizona` (261), `Colorado` (261), `Illinois` (261), `Iowa` (261), `Kansas` (261), `Kentucky` (261), `Maryland` (261) |
| `SEX` | BIGINT | 3 | 0 | `0` (4524), `1` (4524), `2` (4524) |
| `AGE` | BIGINT | 87 | 0 | `1` (156), `5` (156), `6` (156), `7` (156), `9` (156), `15` (156), `18` (156), `20` (156), … |
| `ESTBASE2020_CIV` | BIGINT | 12495 | 0 | `4929` (5), `11968` (4), `3640` (4), `6252` (4), `9031` (4), `12008` (4), `3851` (4), `3815` (4), … |
| `POPEST2020_CIV` | BIGINT | 12497 | 0 | `3873` (5), `11384` (4), `3604` (4), `19122` (4), `6828` (4), `4012` (3), `3265` (3), `5260` (3), … |
| `POPEST2021_CIV` | BIGINT | 12549 | 0 | `11269` (5), `4858` (4), `12617` (4), `12012` (4), `3488` (4), `19156` (3), `18118` (3), `8012` (3), … |
| `POPEST2022_CIV` | BIGINT | 12558 | 0 | `8021` (5), `4014` (4), `11450` (4), `7558` (3), `3944` (3), `5530` (3), `3616` (3), `4894` (3), … |
| `POPEST2023_CIV` | BIGINT | 12558 | 0 | `4083` (5), `6073` (4), `6679` (4), `3544` (4), `6407` (4), `41966` (4), `8295` (4), `11728` (3), … |
| `POPEST2024_CIV` | BIGINT | 12599 | 0 | `21986` (4), `5988` (4), `14549` (3), `17757` (3), `8074` (3), `14036` (3), `11184` (3), `4568` (3), … |

Premières lignes :

```
   SUMLEV  REGION  DIVISION  STATE           NAME  SEX  AGE  ESTBASE2020_CIV  POPEST2020_CIV  POPEST2021_CIV  POPEST2022_CIV  POPEST2023_CIV  POPEST2024_CIV
0      10       0         0      0  United States    0    0          3735085         3703341         3572166         3680587         3653650         3615598
1      10       0         0      0  United States    0    1          3777552         3764698         3708865         3602662         3720079         3701824
2      10       0         0      0  United States    0    2          3873736         3854287         3771032         3738864         3642354         3768012
3      10       0         0      0  United States    0    3          3966696         3933667         3860489         3800263         3778530         3690129
4      10       0         0      0  United States    0    4          4049711         4038296         3939654         3888578         3837784         3823751
```

### `release_2025_09_15/data/input/soc_structure_raw.csv`

- Lignes : 1 596
- Taille : 0.1 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `Major Group` | VARCHAR | 23 | 1573 | `None` (1573), `25-0000` (1), `43-0000` (1), `23-0000` (1), `55-0000` (1), `39-0000` (1), `37-0000` (1), `35-0000` (1), `29-0000` (1), `17-0000` (1), `11-0000` (1), `49-0000` (1), `13-0000` (1), `15-0000` (1), `53-0000` (1), `47-0000` (1), `27-0000` (1), `33-0000` (1), `31-0000` (1), `45-0000` (1), `41-0000` (1), `21-0000` (1), `19-0000` (1) |
| `Minor Group` | VARCHAR | 98 | 1498 | `None` (1498), `13-2000` (1), `19-3000` (1), `19-2000` (1), `25-4000` (1), `19-4000` (1), `25-2000` (1), `25-3000` (1), … |
| `Broad Occupation` | VARCHAR | 459 | 1137 | `None` (1137), `11-2010` (1), `11-2020` (1), `11-2030` (1), `11-9010` (1), `11-9030` (1), `11-3020` (1), `11-3120` (1), … |
| `Detailed Occupation` | VARCHAR | 867 | 729 | `None` (729), `11-9013` (1), `11-3051` (1), `11-9111` (1), `11-9031` (1), `11-9071` (1), `11-9081` (1), `11-9131` (1), … |
| `Detailed O*NET-SOC` | VARCHAR | 149 | 1447 | `None` (1447), `11-3051.03` (1), `11-3031.01` (1), `11-9199.01` (1), `11-3071.04` (1), `11-9041.01` (1), `11-9179.02` (1), `11-9199.09` (1), … |
| `SOC or O*NET-SOC 2019 Title` | VARCHAR | 1333 | 0 | `Fishing and Hunting Workers` (3), `Human Resources Managers` (2), `Market Research Analysts and Marketing Specialists` (2), `Industrial Production Managers` (2), `Chemical Engineers` (2), `Farmers, Ranchers, and Other Agricultural Managers` (2), `Postmasters and Mail Superintendents` (2), `Transportation, Storage, and Distribution Managers` (2), … |

Premières lignes :

```
  Major Group Minor Group Broad Occupation Detailed Occupation Detailed O*NET-SOC    SOC or O*NET-SOC 2019 Title
0     11-0000         NaN              NaN                 NaN                NaN         Management Occupations
1         NaN     11-1000              NaN                 NaN                NaN                 Top Executives
2         NaN         NaN          11-1010                 NaN                NaN               Chief Executives
3         NaN         NaN              NaN             11-1011                NaN               Chief Executives
4         NaN         NaN              NaN                 NaN         11-1011.03  Chief Sustainability Officers
```

### `release_2025_09_15/data/input/task_pct_v1.csv`

- Lignes : 3 514
- Taille : 0.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3514 | 0 | `act as an intermediary in negotiations between buyers and se` (1), `act as liaisons between on-site managers or tenants and owne` (1), `adapt teaching methods and instructional materials to meet s` (1), `adapt translations to students' cognitive and grade levels, ` (1), `advise animal owners regarding sanitary measures, feeding, g` (1), `advise clients on financial and legal matters such as invest` (1), `advise clients or respond to inquiries about financial matte` (1), `advise corporations on issues involving corporate image proj` (1), … |
| `pct` | DOUBLE | 609 | 0 | `0.002084663392007922` (116), `0.0019543719300074264` (103), `0.002475537778009407` (97), `0.0023452463160089122` (96), `0.002214954854008417` (93), `0.002736120702010397` (87), `0.002605829240009902` (79), `0.0029967036260113876` (74), … |

Premières lignes :

```
                                 task_name       pct
0  act as advisers to student organizat...  0.006775
1  act as an advocate for farmers or fa...  0.002997
2  act as an intermediary in negotiatio...  0.012638
3  act as an intermediary in negotiatio...  0.011466
4  act as liaisons between clients and ...  0.001954
```

### `release_2025_09_15/data/input/task_pct_v2.csv`

- Lignes : 3 365
- Taille : 0.4 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task_name` | VARCHAR | 3365 | 0 | `adapt instructional content or delivery methods for differen` (1), `adapt the quantity of ingredients to match the amount of ite` (1), `address employee relations issues, such as harassment allega` (1), `adjust controls to regulate temperature, pressure, feed, or ` (1), `adjust sales scripts to better target the needs and interest` (1), `adjust, maintain, or repair laboratory equipment such as mic` (1), `administer document and system access rights and revision co` (1), `administer, proctor, or score academic or diagnostic assessm` (1), … |
| `pct` | DOUBLE | 661 | 0 | `0.0016433246100185286` (112), `0.0015406168218923706` (103), `0.0017460323981446867` (92), `0.0019514479743970028` (79), `0.002156863550649319` (76), `0.002567694703153951` (73), `0.0018487401862708444` (68), `0.002464986915027793` (65), … |

Premières lignes :

```
                                 task_name       pct
0  accept commissions to create music f...  0.002054
1  act as advisers to student organizat...  0.004827
2  act as an advocate for farmers or fa...  0.001643
3  act as an intermediary in negotiatio...  0.004725
4  act as an intermediary in negotiatio...  0.007087
```

### `release_2025_09_15/data/input/working_age_pop_2024_country_raw.csv`

- Lignes : 266
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `countryiso3code` | VARCHAR | 261 | 5 | `None` (5), `CEB` (1), `ECA` (1), `EMU` (1), `LMY` (1), `SSF` (1), `IBD` (1), `TLA` (1), … |
| `date` | BIGINT | 1 | 0 | `2024` (266) |
| `value` | DOUBLE | 263 | 1 | `1138375451.0` (2), `724342128.0` (2), `739686529.0` (1), `64510212.0` (1), `437777504.0` (1), `222581140.0` (1), `617981055.0` (1), `917750384.0` (1), … |
| `unit` | VARCHAR | 0 | 266 |  |
| `obs_status` | VARCHAR | 0 | 266 |  |
| `decimal` | BIGINT | 1 | 0 | `0` (266) |
| `indicator.id` | VARCHAR | 1 | 0 | `SP.POP.1564.TO` (266) |
| `indicator.value` | VARCHAR | 1 | 0 | `Population ages 15-64, total` (266) |
| `country.id` | VARCHAR | 266 | 0 | `1A` (1), `V2` (1), `Z4` (1), `F1` (1), `XG` (1), `V3` (1), `XL` (1), `XO` (1), … |
| `country.value` | VARCHAR | 266 | 0 | `Caribbean small states` (1), `Europe & Central Asia` (1), `Europe & Central Asia (excluding high income)` (1), `Europe & Central Asia (IDA & IBRD countries)` (1), `IBRD only` (1), `IDA only` (1), `Low & middle income` (1), `Not classified` (1), … |

Premières lignes :

```
  countryiso3code  date        value  unit obs_status  decimal    indicator.id               indicator.value country.id                   country.value
0             AFE  2024  433631182.0  None       None        0  SP.POP.1564.TO  Population ages 15-64, total         ZH     Africa Eastern and Southern
1             AFW  2024  290710946.0  None       None        0  SP.POP.1564.TO  Population ages 15-64, total         ZI      Africa Western and Central
2             ARB  2024  310488106.0  None       None        0  SP.POP.1564.TO  Population ages 15-64, total         1A                      Arab World
3             CSS  2024    3087915.0  None       None        0  SP.POP.1564.TO  Population ages 15-64, total         S3          Caribbean small states
4             CEB  2024   64510212.0  None       None        0  SP.POP.1564.TO  Population ages 15-64, total         B8  Central Europe and the Baltics
```

### `release_2025_09_15/data/intermediate/aei_raw_1p_api_2025-08-04_to_2025-08-11.csv`

- Lignes : 33 794
- Taille : 6.7 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 1 | 0 | `GLOBAL` (33794) |
| `geography` | VARCHAR | 1 | 0 | `global` (33794) |
| `date_start` | DATE | 1 | 0 | `2025-08-04` (33794) |
| `date_end` | DATE | 1 | 0 | `2025-08-11` (33794) |
| `platform_and_product` | VARCHAR | 1 | 0 | `1P API` (33794) |
| `facet` | VARCHAR | 8 | 0 | `onet_task::collaboration` (10330), `request::collaboration` (5990), `onet_task` (4112), `onet_task::prompt_tokens` (4110), `onet_task::cost` (4110), `onet_task::completion_tokens` (4110), `request` (1018), `collaboration` (14) |
| `level` | BIGINT | 3 | 0 | `0` (32040), `1` (1304), `2` (450) |
| `variable` | VARCHAR | 16 | 0 | `onet_task_collaboration_count` (5165), `onet_task_collaboration_pct` (5165), `request_collaboration_count` (2995), `request_collaboration_pct` (2995), `onet_task_count` (2056), `onet_task_pct` (2056), `cost_index` (2055), `cost_count` (2055), `completion_tokens_index` (2055), `prompt_tokens_count` (2055), `prompt_tokens_index` (2055), `completion_tokens_count` (2055), `request_pct` (509), `request_count` (509), `collaboration_pct` (7), `collaboration_count` (7) |
| `cluster_name` | VARCHAR | 14795 | 0 | `not_classified` (10), `Implement and troubleshoot software analytics tracking syste` (4), `Provide automotive information and vehicle management assist` (4), `Develop and troubleshoot audio-visual software systems::task` (4), `Provide automotive information and vehicle management assist` (4), `Provide automotive information and vehicle management assist` (4), `Implement and troubleshoot software analytics tracking syste` (4), `Develop and troubleshoot geospatial mapping software::direct` (4), … |
| `value` | DOUBLE | 14930 | 0 | `15.0` (535), `16.0` (465), `17.0` (414), `18.0` (392), `100.0` (385), `19.0` (336), `21.0` (333), `22.0` (329), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| global | collaboration | 14 |
| global | onet_task | 4112 |
| global | onet_task::collaboration | 10330 |
| global | onet_task::completion_tokens | 4110 |
| global | onet_task::cost | 4110 |
| global | onet_task::prompt_tokens | 4110 |
| global | request | 1018 |
| global | request::collaboration | 5990 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| collaboration | collaboration_count | 7 |
| collaboration | collaboration_pct | 7 |
| onet_task | onet_task_count | 2056 |
| onet_task | onet_task_pct | 2056 |
| onet_task::collaboration | onet_task_collaboration_count | 5165 |
| onet_task::collaboration | onet_task_collaboration_pct | 5165 |
| onet_task::completion_tokens | completion_tokens_count | 2055 |
| onet_task::completion_tokens | completion_tokens_index | 2055 |
| onet_task::cost | cost_count | 2055 |
| onet_task::cost | cost_index | 2055 |
| onet_task::prompt_tokens | prompt_tokens_count | 2055 |
| onet_task::prompt_tokens | prompt_tokens_index | 2055 |
| request | request_count | 509 |
| request | request_pct | 509 |
| request::collaboration | request_collaboration_count | 2995 |
| request::collaboration | request_collaboration_pct | 2995 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| collaboration | 0 | 14 |
| onet_task | 0 | 4112 |
| onet_task::collaboration | 0 | 10330 |
| onet_task::completion_tokens | 0 | 4110 |
| onet_task::cost | 0 | 4110 |
| onet_task::prompt_tokens | 0 | 4110 |
| request | 0 | 768 |
| request | 1 | 186 |
| request | 2 | 64 |
| request::collaboration | 0 | 4486 |
| request::collaboration | 1 | 1118 |
| request::collaboration | 2 | 386 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| 1P API | collaboration | 14 |
| 1P API | onet_task | 4112 |
| 1P API | onet_task::collaboration | 10330 |
| 1P API | onet_task::completion_tokens | 4110 |
| 1P API | onet_task::cost | 4110 |
| 1P API | onet_task::prompt_tokens | 4110 |
| 1P API | request | 1018 |
| 1P API | request::collaboration | 5990 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **collaboration** (7 distincts) : `directive`, `validation`, `learning`, `task iteration`, `feedback loop`, `not_classified`, `none`
- **onet_task** (2056 distincts) : `access computerized financial information to answe`, `adapt instructional content or delivery methods fo`, `administer and score applicant and employee aptitu`, `administer document and system access rights and r`, `administer, proctor, or score academic or diagnost`, `advise and teach students.`, `advise clients on how they could be helped by coun`, `advise customers of necessary actions and strategi`, `advise management concerning personnel, managerial`, `advise or instruct patients regarding preventive d`, `advise students on academic and vocational curricu`, `analyze and evaluate robotic systems or prototypes`, `analyze characteristics of animals to identify and`, `analyze competitive market strategies through anal`, `analyze complex systems to determine potential for`, `analyze computer and information technologies to d`, `analyze corporate intelligence data to identify tr`, `analyze data to assess distance learning program s`, `analyze data to determine validity, quality, and s`, `analyze expenditures and other financial informati`, `analyze geographic information systems (gis) data `, `analyze information obtained from management to co`, `analyze information to determine, recommend, and p`, `analyze market conditions to determine optimum tim`, `analyze organic or inorganic compounds to determin`, `analyze organizational, occupational, and industri`, `analyze physical findings and medical histories to`, `analyze product complaints and make recommendation`, `analyze research data to determine its significanc`, `analyze statistical data and reports to identify a`, `analyze system performance or operational requirem`, `analyze the financial details of past, present, an`, `analyze training needs to design employee developm`, `analyze user needs and recommend appropriate hardw`, `analyze, interpret, or disseminate system performa`, `answer applicants' questions about benefits and cl`, `answer clients' questions regarding construction w`, `answer customers' questions, and explain available`, `answer questions from the public and media.`, `answer telephone calls from potential customers wh`
- **onet_task::collaboration** (5165 distincts) : `act as an intermediary in negotiations between buy`, `adapt instructional content or delivery methods fo`, `adapt translations to students' cognitive and grad`, `administer and score applicant and employee aptitu`, `administer document and system access rights and r`, `administer standardized ability and achievement te`, `administer standardized ability and achievement te`, `administer, proctor, or score academic or diagnost`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::not_classified`, `advise clients concerning business transactions, c`, `advise clients on how they could be helped by coun`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise food service managers and organizations on `, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `align, adjust, or calibrate equipment according to`, `analyze and classify risks and investments to dete`, `analyze and classify risks and investments to dete`, `analyze and interpret patient, nursing, or informa`, `analyze and interpret patients' histories, symptom`, `analyze and interpret patients' histories, symptom`, `analyze and interpret patients' histories, symptom`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and record test data to issue reports that`, `analyze available data and consult with other scie`, `analyze business operations, trends, costs, revenu`, `analyze characteristics of animals to identify and`, `analyze characteristics of animals to identify and`, `analyze clinical data using appropriate statistica`, `analyze complex systems to determine potential for`, `analyze corporate intelligence data to identify tr`
- **onet_task::completion_tokens** (4110 distincts) : `act as an intermediary in negotiations between buy`, `act as an intermediary in negotiations between buy`, `adapt teaching methods and instructional materials`, `administer and score applicant and employee aptitu`, `administer highway planning, construction, or main`, `administer online purchasing systems.::index`, `administer standardized ability and achievement te`, `administer, dispense, or prescribe natural medicin`, `advise clients concerning business transactions, c`, `advise clients concerning business transactions, c`, `advise corporations on issues involving corporate `, `advise customers of necessary actions and strategi`, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise students on academic and vocational curricu`, `align, adjust, or calibrate equipment according to`, `analyze all aspects of corporate logistics to dete`, `analyze and classify risks and investments to dete`, `analyze and evaluate patient data or test findings`, `analyze and evaluate security operations to identi`, `analyze and interpret patient, nursing, or informa`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and report computer network security breac`, `analyze business operations, trends, costs, revenu`, `analyze characteristics of animals to identify and`, `analyze characteristics of animals to identify and`, `analyze complex systems to determine potential for`, `analyze corporate intelligence data to identify tr`, `analyze credit data and financial statements to de`, `analyze data from surveys, old records, or case st`, `analyze data such as interview notes, test results`, `analyze data to assess distance learning program s`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`, `analyze equipment performance records to assess eq`, `analyze financial data to detect irregularities in`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial information obtained from client`
- **onet_task::cost** (4110 distincts) : `access computerized financial information to answe`, `address the relationships of quantities, magnitude`, `administer document and system access rights and r`, `administer highway planning, construction, or main`, `administer online purchasing systems.::count`, `advise business or other groups on local, national`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers of necessary actions and strategi`, `advise management concerning personnel, managerial`, `advise management regarding customer satisfaction,`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and evaluate patient data or test findings`, `analyze and evaluate robotic systems or prototypes`, `analyze and record personnel or operational data a`, `analyze and record test data to issue reports that`, `analyze and report computer network security breac`, `analyze applicants' financial status, credit, and `, `analyze applicants' financial status, credit, and `, `analyze archival data such as birth, death, and di`, `analyze available data and consult with other scie`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze clinical or survey data using statistical `, `analyze competitive market strategies through anal`, `analyze complex systems to determine potential for`, `analyze computer and information technologies to d`, `analyze credit data and financial statements to de`, `analyze data from surveys, old records, or case st`, `analyze data to determine answers to questions fro`, `analyze data to determine answers to questions fro`, `analyze data to determine feasibility of product p`, `analyze data to determine the effectiveness of tre`, `analyze data to determine validity, quality, and s`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`
- **onet_task::prompt_tokens** (4110 distincts) : `access computerized financial information to answe`, `address the relationships of quantities, magnitude`, `administer document and system access rights and r`, `administer highway planning, construction, or main`, `administer online purchasing systems.::count`, `advise business or other groups on local, national`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers of necessary actions and strategi`, `advise management concerning personnel, managerial`, `advise management regarding customer satisfaction,`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and evaluate patient data or test findings`, `analyze and evaluate robotic systems or prototypes`, `analyze and record personnel or operational data a`, `analyze and record test data to issue reports that`, `analyze and report computer network security breac`, `analyze applicants' financial status, credit, and `, `analyze applicants' financial status, credit, and `, `analyze archival data such as birth, death, and di`, `analyze available data and consult with other scie`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze clinical or survey data using statistical `, `analyze competitive market strategies through anal`, `analyze complex systems to determine potential for`, `analyze computer and information technologies to d`, `analyze credit data and financial statements to de`, `analyze data from surveys, old records, or case st`, `analyze data to determine answers to questions fro`, `analyze data to determine answers to questions fro`, `analyze data to determine feasibility of product p`, `analyze data to determine the effectiveness of tre`, `analyze data to determine validity, quality, and s`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`
- **request** (501 distincts) : `not_classified`, `Develop and troubleshoot audio-visual software sys`, `Provide automotive information and vehicle managem`, `Develop and troubleshoot software authentication a`, `Develop and troubleshoot data visualization softwa`, `Implement and troubleshoot software analytics trac`, `Develop and troubleshoot geospatial mapping softwa`, `Configure and set up local software development en`, `Configure and implement AI assistant web search fu`, `Design and implement access control and permission`, `Create and analyze vocabulary learning activities `, `Create and improve educational teaching materials `, `Create and manage database schemas and models for `, `Create marketing content and copy for products and`, `Conduct job candidate screening and recruitment pr`, `Configure and troubleshoot software deployment and`, `Assist with creative writing, narrative editing, a`, `Assist with banking and financial account manageme`, `Analyze, complete, and improve programming code sn`, `Assist with cybersecurity professional tasks and a`, `Analyze and document software architecture and cod`, `Design and develop user interface components for s`, `Debug and fix JavaScript and HTML syntax errors in`, `Develop AI tools for social media content creation`, `Debug and modify software configuration files and `, `Debug and fix database query and schema errors in `, `Debug and implement mouse/touch interface interact`, `Categorize and translate product data using standa`, `Develop and debug blockchain software systems and `, `Debug and modify video game software code and syst`, `Debug and optimize graphics rendering and image pr`, `Classify document types using predefined rules and`, `Develop and manage project management tools and me`, `Design and modify mobile app user interface compon`, `Assist with job search, recruitment, and professio`, `Configure AI assistant security and task managemen`, `Develop and debug statistical analysis code and co`, `Develop and implement frontend web application arc`, `Develop and implement software UI component archit`, `Develop and improve educational technology and e-l`
- **request::collaboration** (2959 distincts) : `Implement and troubleshoot software analytics trac`, `Provide automotive information and vehicle managem`, `Develop and troubleshoot data visualization softwa`, `Develop and troubleshoot software authentication a`, `Develop and troubleshoot software authentication a`, `Develop and troubleshoot geospatial mapping softwa`, `Develop and troubleshoot geospatial mapping softwa`, `Develop and troubleshoot software authentication a`, `Provide automotive information and vehicle managem`, `Implement and troubleshoot software analytics trac`, `Develop and troubleshoot data visualization softwa`, `Develop and troubleshoot audio-visual software sys`, `Implement and troubleshoot software analytics trac`, `Develop and troubleshoot data visualization softwa`, `Implement and troubleshoot software analytics trac`, `Provide automotive information and vehicle managem`, `Develop and troubleshoot software authentication a`, `Develop and troubleshoot audio-visual software sys`, `Develop and troubleshoot audio-visual software sys`, `Develop and troubleshoot software authentication a`, `Develop and troubleshoot geospatial mapping softwa`, `Develop and troubleshoot geospatial mapping softwa`, `Develop and troubleshoot data visualization softwa`, `Develop and troubleshoot audio-visual software sys`, `Implement and troubleshoot software analytics trac`, `Develop and troubleshoot geospatial mapping softwa`, `Develop and troubleshoot data visualization softwa`, `Develop and troubleshoot audio-visual software sys`, `Develop and troubleshoot software authentication a`, `Develop and troubleshoot geospatial mapping softwa`, `Provide automotive information and vehicle managem`, `Provide automotive information and vehicle managem`, `Develop and troubleshoot data visualization softwa`, `Provide automotive information and vehicle managem`, `Implement and troubleshoot software analytics trac`, `Develop and troubleshoot audio-visual software sys`, `Analyze and evaluate job requirements and candidat`, `Configure AI system's tools and operational enviro`, `Assist with job search, recruitment, and professio`, `Analyze and evaluate job requirements and candidat`

Lignes pour les pays étudiés : 

Premières lignes :

```
   geo_id geography date_start   date_end platform_and_product          facet  level             variable   cluster_name          value
0  GLOBAL    global 2025-08-04 2025-08-11               1P API  collaboration      0  collaboration_count      directive  626255.000000
1  GLOBAL    global 2025-08-04 2025-08-11               1P API  collaboration      0    collaboration_pct      directive      66.295766
2  GLOBAL    global 2025-08-04 2025-08-11               1P API  collaboration      0  collaboration_count  feedback loop  104633.000000
3  GLOBAL    global 2025-08-04 2025-08-11               1P API  collaboration      0    collaboration_pct  feedback loop      11.076518
4  GLOBAL    global 2025-08-04 2025-08-11               1P API  collaboration      0  collaboration_count       learning   35696.000000
```

### `release_2025_09_15/data/intermediate/aei_raw_claude_ai_2025-08-04_to_2025-08-11.csv`

- Lignes : 100 062
- Taille : 18.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 203 | 0 | `GLOBAL` (29656), `CA` (4086), `US` (3964), `IN` (2564), `JP` (2098), `KR` (2052), `GB` (2032), `DE` (1918), … |
| `geography` | VARCHAR | 3 | 0 | `country` (52918), `global` (29656), `state_us` (17488) |
| `date_start` | DATE | 1 | 0 | `2025-08-04` (100062) |
| `date_end` | DATE | 1 | 0 | `2025-08-11` (100062) |
| `platform_and_product` | VARCHAR | 1 | 0 | `Claude AI (Free and Pro)` (100062) |
| `facet` | VARCHAR | 7 | 0 | `request` (50346), `onet_task` (24080), `onet_task::collaboration` (14454), `request::collaboration` (8508), `collaboration` (2224), `country` (346), `state_us` (104) |
| `level` | BIGINT | 3 | 0 | `0` (76370), `1` (16602), `2` (7090) |
| `variable` | VARCHAR | 12 | 0 | `request_count` (25173), `request_pct` (25173), `onet_task_count` (12040), `onet_task_pct` (12040), `onet_task_collaboration_pct` (7227), `onet_task_collaboration_count` (7227), `request_collaboration_count` (4254), `request_collaboration_pct` (4254), `collaboration_count` (1112), `collaboration_pct` (1112), `usage_count` (225), `usage_pct` (225) |
| `cluster_name` | VARCHAR | 14713 | 450 | `not_classified` (1402), `none` (526), `None` (450), `Create comprehensive K-12 educational materials and teaching` (424), `directive` (418), `task iteration` (378), `Provide comprehensive software development assistance across` (370), `learning` (364), … |
| `value` | DOUBLE | 23798 | 0 | `15.0` (2162), `16.0` (2038), `17.0` (1899), `18.0` (1690), `19.0` (1460), `20.0` (1383), `21.0` (1251), `22.0` (1209), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| country | collaboration | 1612 |
| country | country | 346 |
| country | onet_task | 14502 |
| country | request | 36458 |
| global | collaboration | 14 |
| global | onet_task | 5236 |
| global | onet_task::collaboration | 14454 |
| global | request | 1444 |
| global | request::collaboration | 8508 |
| state_us | collaboration | 598 |
| state_us | onet_task | 4342 |
| state_us | request | 12444 |
| state_us | state_us | 104 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| collaboration | collaboration_count | 1112 |
| collaboration | collaboration_pct | 1112 |
| country | usage_count | 173 |
| country | usage_pct | 173 |
| onet_task | onet_task_count | 12040 |
| onet_task | onet_task_pct | 12040 |
| onet_task::collaboration | onet_task_collaboration_count | 7227 |
| onet_task::collaboration | onet_task_collaboration_pct | 7227 |
| request | request_count | 25173 |
| request | request_pct | 25173 |
| request::collaboration | request_collaboration_count | 4254 |
| request::collaboration | request_collaboration_pct | 4254 |
| state_us | usage_count | 52 |
| state_us | usage_pct | 52 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| collaboration | 0 | 2224 |
| country | 0 | 346 |
| onet_task | 0 | 24080 |
| onet_task::collaboration | 0 | 14454 |
| request | 0 | 28240 |
| request | 1 | 15318 |
| request | 2 | 6788 |
| request::collaboration | 0 | 6922 |
| request::collaboration | 1 | 1284 |
| request::collaboration | 2 | 302 |
| state_us | 0 | 104 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| Claude AI (Free and Pro) | collaboration | 2224 |
| Claude AI (Free and Pro) | country | 346 |
| Claude AI (Free and Pro) | onet_task | 24080 |
| Claude AI (Free and Pro) | onet_task::collaboration | 14454 |
| Claude AI (Free and Pro) | request | 50346 |
| Claude AI (Free and Pro) | request::collaboration | 8508 |
| Claude AI (Free and Pro) | state_us | 104 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **collaboration** (7 distincts) : `directive`, `task iteration`, `learning`, `feedback loop`, `validation`, `none`, `not_classified`
- **country** (0 distincts) : `None`
- **onet_task** (2618 distincts) : `not_classified`, `write new programs or modify existing programs to `, `none`, `modify existing software to correct errors, allow `, `modify existing software to correct errors, to ada`, `diagnose, troubleshoot, and resolve hardware, soft`, `design, build, or maintain web sites, using author`, `correct errors by making appropriate changes and r`, `perform routine system administrative functions su`, `assist students who need extra help with their cou`, `provide private instruction to individual or small`, `edit, standardize, or make changes to material pre`, `troubleshoot problems involving office equipment, `, `write, update, and maintain computer programs or s`, `prepare, rewrite and edit copy to improve readabil`, `analyze user needs and software requirements to de`, `perform initial debugging procedures by reviewing `, `review and analyze computer printouts and performa`, `confer with clients regarding the nature of the in`, `instruct through lectures, discussions, and demons`, `develop instructional materials to be used by educ`, `edit or rewrite existing copy as necessary, and su`, `instruct individuals in career development techniq`, `develop new software applications or customize exi`, `compile and write documentation of program develop`, `prepare and deliver lectures to undergraduate or g`, `develop briefings, brochures, multimedia presentat`, `develop instructional materials, such as lesson pl`, `search electronic sources, such as databases or re`, `answer customers' questions, and provide informati`, `develop or apply data mining and machine learning `, `modify existing programs to enhance efficiency.`, `review class material with students by discussing `, `write, analyze, review, and rewrite programs, usin`, `write supporting code for web applications or web `, `conduct searches to find needed information, using`, `determine sources of web page or server problems, `, `read manuals, periodicals, and technical reports t`, `research, compile, analyze and organize informatio`, `conduct classes, workshops, and demonstrations, an`
- **onet_task::collaboration** (7227 distincts) : `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `address the relationships of quantities, magnitude`, `address the relationships of quantities, magnitude`, `address the relationships of quantities, magnitude`, `administer online purchasing systems.::directive`, `administer online purchasing systems.::not_classif`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `advise and teach students.::task iteration`, `advise animal owners regarding sanitary measures, `, `advise business or other groups on local, national`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise clients on transportation and payment metho`, `advise corporations on issues involving corporate `, `advise customer about or perform maintenance of so`, `advise customer about or perform maintenance of so`, `advise customers of necessary actions and strategi`, `advise customers of necessary actions and strategi`, `advise customers on use and care of merchandise.::`, `advise customers on use and care of merchandise.::`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise management concerning personnel, managerial`, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise other physicians on the treatment of neurol`, `advise patients and community members concerning d`, `advise patients and their families on nutritional `, `advise retail managers on compliance with applicab`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`
- **request** (704 distincts) : `not_classified`, `Create comprehensive K-12 educational materials an`, `Provide comprehensive software development assista`, `Help develop and debug complete web applications a`, `Provide educational tutoring and academic assistan`, `Help edit, improve, and create professional writte`, `Provide technical and academic assistance across s`, `Provide technical IT support and troubleshooting a`, `Provide comprehensive financial guidance and inves`, `Debug and fix software code errors across multiple`, `Provide comprehensive multi-technology programming`, `Analyze and process data from documents, visual me`, `Help with academic research, writing, and educatio`, `Create comprehensive digital marketing strategies `, `Provide medical and sports training guidance`, `Edit and improve existing written content and docu`, `Provide educational assistance and tutoring across`, `Help with automation scripts, robotics programming`, `Provide personalized lifestyle advice and recommen`, `Help create visual content, graphics, and multimed`, `Provide comprehensive medical and healthcare guida`, `Provide multilingual translation services and lang`, `Fix and improve web and mobile application UI layo`, `Provide business operations support and strategic `, `Provide comprehensive database development and man`, `Provide translation services and comprehensive lan`, `Help develop and debug cross-platform mobile appli`, `Provide comprehensive domestic life and household `, `Provide comprehensive business consulting and stra`, `Provide technical troubleshooting and support for `, `Provide comprehensive legal assistance including i`, `Help with job applications, resumes, and career ad`, `Provide comprehensive financial advice and assista`, `Develop automated trading systems and technical an`, `Help develop, debug, and modify web applications a`, `Help create and optimize comprehensive digital mar`, `Provide comprehensive legal assistance and documen`, `Help plan and organize events, schedules, and trav`, `Help build complete web applications and websites `, `Assist with game development programming and mobil`
- **request::collaboration** (4160 distincts) : `Provide parenting advice and child development gui`, `Provide real estate investment analysis and busine`, `Process meeting transcripts into summaries and str`, `Provide parenting advice and child development gui`, `Help implement multilingual features and communica`, `Create comprehensive K-12 educational materials an`, `Help with medical education applications and exam `, `Help implement multilingual features and communica`, `Help with time calculations, duration tracking, an`, `Help implement and create icons for websites and a`, `Debug and optimize computational physics simulatio`, `Help with medical education applications and exam `, `Help with medical education applications and exam `, `Help with random number generation and lottery pre`, `Provide parenting advice and child development gui`, `Provide comprehensive blockchain and cryptocurrenc`, `Help with time calculations, duration tracking, an`, `Extract and transcribe text from images using OCR `, `Provide parenting advice and child development gui`, `Create comprehensive K-12 educational materials an`, `Help with medical education applications and exam `, `Create comprehensive K-12 educational materials an`, `Develop automated trading systems and technical an`, `Help implement and create icons for websites and a`, `Help implement multilingual features and communica`, `Help with timezone conversions and timestamp forma`, `Help with random number generation and lottery pre`, `Create comprehensive K-12 educational materials an`, `Help implement and create icons for websites and a`, `Provide real estate investment analysis and busine`, `Help with medical education applications and exam `, `Process meeting transcripts into summaries and str`, `Help with emoji implementation, formatting, and mo`, `Help with timezone conversions and timestamp forma`, `Help with date calculations, formatting, and datet`, `Develop automated trading systems and technical an`, `Create comprehensive K-12 educational materials an`, `Help with timezone conversions and timestamp forma`, `Help with random number generation and lottery pre`, `Help with time calculations, duration tracking, an`
- **state_us** (0 distincts) : `None`

Lignes pour les pays étudiés : 

Premières lignes :

```
  geo_id geography date_start   date_end      platform_and_product          facet  level             variable    cluster_name  value
0     AD   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  collaboration      0  collaboration_count  not_classified   25.0
1     AD   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  collaboration      0    collaboration_pct  not_classified   62.5
2     AD   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  collaboration      0  collaboration_count  task iteration   15.0
3     AD   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  collaboration      0    collaboration_pct  task iteration   37.5
4     AD   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)        country      0          usage_count             NaN   40.0
```

### `release_2025_09_15/data/intermediate/gdp_2024_country.csv`

- Lignes : 174
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `iso_alpha_3` | VARCHAR | 174 | 0 | `AGO` (1), `ARM` (1), `AUS` (1), `AZE` (1), `BHS` (1), `BRN` (1), `CIV` (1), `COG` (1), … |
| `gdp_total` | DOUBLE | 174 | 0 | `3952000000.0` (1), `27259000000.0` (1), `1796805000000.0` (1), `74316000000.0` (1), `4743000000.0` (1), `451096000000.0` (1), `46943000000.0` (1), `7167000000.0` (1), … |
| `year` | BIGINT | 1 | 0 | `2024` (174) |

Premières lignes :

```
  iso_alpha_3     gdp_total  year
0         ABW  3.952000e+09  2024
1         AGO  1.159460e+11  2024
2         ALB  2.725900e+10  2024
3         AND  4.038000e+09  2024
4         ARE  5.370790e+11  2024
```

### `release_2025_09_15/data/intermediate/gdp_2024_us_state.csv`

- Lignes : 51
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `state_code` | VARCHAR | 51 | 0 | `DE` (1), `DC` (1), `HI` (1), `IN` (1), `LA` (1), `MO` (1), `NE` (1), `NM` (1), `OH` (1), `OR` (1), `VA` (1), `WI` (1), `AL` (1), `WA` (1), `IL` (1), `IA` (1), `MI` (1), `MS` (1), `MT` (1), `NJ` (1), `NY` (1), `ND` (1), `PA` (1), `SC` (1), `TN` (1), `WY` (1), `CO` (1), `AR` (1), `FL` (1), `ID` (1), `KS` (1), `MN` (1), `NC` (1), `OK` (1), `TX` (1), `VT` (1), `WV` (1), `AZ` (1), `CA` (1), `AK` (1), `CT` (1), `GA` (1), `KY` (1), `ME` (1), `MD` (1), `MA` (1), `NV` (1), `NH` (1), `RI` (1), `SD` (1), `UT` (1) |
| `state_name` | VARCHAR | 51 | 0 | `Pennsylvania` (1), `Hawaii` (1), `Florida` (1), `California` (1), `Alaska` (1), `Arkansas` (1), `Delaware` (1), `Georgia` (1), `Idaho` (1), `Indiana` (1), `Maine` (1), `Massachusetts` (1), `Missouri` (1), `Nebraska` (1), `Utah` (1), `Arizona` (1), `Colorado` (1), `Illinois` (1), `Iowa` (1), `Kansas` (1), `Kentucky` (1), `Maryland` (1), `Michigan` (1), `New Mexico` (1), `New York` (1), `Wisconsin` (1), `Virginia` (1), `District of Columbia` (1), `Louisiana` (1), `Minnesota` (1), `Mississippi` (1), `Montana` (1), `Nevada` (1), `New Hampshire` (1), `South Dakota` (1), `Washington` (1), `Wyoming` (1), `Oklahoma` (1), `West Virginia` (1), `Connecticut` (1), `Vermont` (1), `Texas` (1), `Tennessee` (1), `South Carolina` (1), `Rhode Island` (1), `Oregon` (1), `Alabama` (1), `Ohio` (1), `North Dakota` (1), `North Carolina` (1), `New Jersey` (1) |
| `gdp_total` | DOUBLE | 51 | 0 | `321237600000.0` (1), `52946100000.0` (1), `69969000000.0` (1), `552167000000.0` (1), `365723100000.0` (1), `527381100000.0` (1), `257020800000.0` (1), `121189400000.0` (1), `839122200000.0` (1), `75399400000.0` (1), `265779099999.99997` (1), `331028600000.0` (1), `45707200000.0` (1), `451285300000.0` (1), `115627200000.0` (1), `1137243600000.0` (1), `293021000000.0` (1), `780666200000.0` (1), `706615800000.0` (1), `500851400000.0` (1), `140542000000.0` (1), `2297028000000.0` (1), `1024206300000.0` (1), `75179500000.0` (1), `2709392900000.0` (1), `300903800000.0` (1), `1705564900000.0` (1), `103253300000.0` (1), `186165000000.0` (1), `98606000000.0` (1), `542765800000.00006` (1), `260728400000.0` (1), `846587500000.0` (1), `349965400000.0` (1), `549708500000.0` (1), `764474800000.0` (1), `854683300000.0` (1), `4103123600000.0` (1), `553322500000.0` (1), `188723100000.0` (1), `882534500000.0` (1), `128132100000.0` (1), `234673200000.0` (1), `327782100000.0` (1), `157491000000.0` (1), `451201400000.0` (1), `75999200000.0` (1), `185411000000.0` (1), `927740100000.0` (1), `82492500000.0` (1), `107660100000.0` (1) |
| `gdp_millions` | DOUBLE | 51 | 0 | `331028.6` (1), `107660.1` (1), `52946.1` (1), `552167.0` (1), `4103123.6` (1), `115627.2` (1), `527381.1` (1), `542765.8` (1), `706615.8` (1), `500851.4` (1), `157491.0` (1), `140542.0` (1), `2297028.0` (1), `549708.5` (1), `2709392.9` (1), `300903.8` (1), `451285.3` (1), `553322.5` (1), `365723.1` (1), `103253.3` (1), `186165.0` (1), `1705564.9` (1), `293021.0` (1), `121189.4` (1), `349965.4` (1), `45707.2` (1), `854683.3` (1), `188723.1` (1), `882534.5` (1), `1137243.6` (1), `257020.8` (1), `780666.2` (1), `451201.4` (1), `75999.2` (1), `839122.2` (1), `75399.4` (1), `265779.1` (1), `75179.5` (1), `764474.8` (1), `69969.0` (1), `321237.6` (1), `128132.1` (1), `234673.2` (1), `327782.1` (1), `98606.0` (1), `185411.0` (1), `260728.4` (1), `846587.5` (1), `927740.1` (1), `1024206.3` (1), `82492.5` (1) |
| `year` | BIGINT | 1 | 0 | `2024` (51) |

Premières lignes :

```
  state_code  state_name     gdp_total  gdp_millions  year
0         AL     Alabama  3.212376e+11      321237.6  2024
1         AK      Alaska  6.996900e+10       69969.0  2024
2         AZ     Arizona  5.521670e+11      552167.0  2024
3         AR    Arkansas  1.887231e+11      188723.1  2024
4         CA  California  4.103124e+12     4103123.6  2024
```

### `release_2025_09_15/data/intermediate/iso_country_codes.csv`

- Lignes : 252
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `iso_alpha_2` | VARCHAR | 252 | 0 | `AU` (1), `AZ` (1), `BY` (1), `BM` (1), `BV` (1), `BF` (1), `CV` (1), `KH` (1), … |
| `iso_alpha_3` | VARCHAR | 252 | 0 | `AFG` (1), `ALB` (1), `DZA` (1), `ATG` (1), `BGD` (1), `BRB` (1), `BMU` (1), `IOT` (1), … |
| `country_name` | VARCHAR | 252 | 0 | `Afghanistan` (1), `Aland Islands` (1), `Algeria` (1), `Argentina` (1), `Armenia` (1), `Azerbaijan` (1), `Brazil` (1), `Brunei` (1), … |

Premières lignes :

```
  iso_alpha_2 iso_alpha_3    country_name
0          AF         AFG     Afghanistan
1          AX         ALA   Aland Islands
2          AL         ALB         Albania
3          DZ         DZA         Algeria
4          AS         ASM  American Samoa
```

### `release_2025_09_15/data/intermediate/onet_task_statements.csv`

- Lignes : 19 530
- Taille : 3.5 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `O*NET-SOC Code` | VARCHAR | 974 | 0 | `49-2022.00` (40), `51-4121.06` (40), `25-2053.00` (40), `25-2054.00` (40), `25-2052.00` (40), `51-9071.01` (40), `25-3011.00` (39), `51-4193.00` (39), … |
| `Title` | VARCHAR | 974 | 0 | `Special Education Teachers, Kindergarten and Elementary Scho` (40), `Special Education Teachers, Middle School` (40), `Welders, Cutters, and Welder Fitters` (40), `Telecommunications Equipment Installers and Repairers, Excep` (40), `Jewelers` (40), `Special Education Teachers, Secondary School` (40), `Control and Valve Installers and Repairers, Except Mechanica` (39), `Electric Motor, Power Tool, and Related Repairers` (39), … |
| `Task ID` | BIGINT | 19530 | 0 | `8824` (1), `8830` (1), `8839` (1), `20461` (1), `8852` (1), `15372` (1), `15381` (1), `15382` (1), … |
| `Task` | VARCHAR | 18429 | 0 | `Serve on academic or administrative committees that deal wit` (34), `Maintain student attendance records, grades, and other requi` (34), `Participate in student recruitment, registration, and placem` (34), `Compile bibliographies of specialized materials for outside ` (34), `Maintain regularly scheduled office hours to advise and assi` (34), `Act as advisers to student organizations.` (34), `Write grant proposals to procure external research funding.` (33), `Initiate, facilitate, and moderate classroom discussions.` (33), … |
| `Task Type` | VARCHAR | 2 | 658 | `Core` (13487), `Supplemental` (5385) |
| `Incumbents Responding` | DOUBLE | 191 | 658 | `None` (658), `23.0` (457), `24.0` (423), `28.0` (396), `26.0` (384), `25.0` (360), `22.0` (339), `21.0` (313), … |
| `Date` | VARCHAR | 17 | 0 | `07/2014` (2659), `07/2011` (2346), `07/2013` (2243), `07/2012` (2142), `07/2015` (2037), `06/2010` (1872), `06/2009` (1471), `06/2007` (1356), `06/2008` (1112), `12/2006` (926), `06/2006` (537), `12/2005` (390), `02/2011` (129), `07/2005` (110), `12/2004` (109), `03/2003` (54), `07/2004` (37) |
| `Domain Source` | VARCHAR | 3 | 0 | `Incumbent` (14511), `Occupational Expert` (4361), `Analyst` (658) |
| `soc_major_group` | BIGINT | 22 | 0 | `51` (2350), `29` (1695), `25` (1591), `17` (1438), `11` (1293), `19` (1166), `47` (1136), `43` (1129), `49` (1101), `13` (987), `53` (928), `27` (807), `15` (690), `39` (632), `33` (548), `41` (459), `31` (334), `35` (327), `45` (311), `21` (291), `37` (183), `23` (134) |

Premières lignes :

```
  O*NET-SOC Code             Title  Task ID                                     Task Task Type  Incumbents Responding     Date Domain Source  soc_major_group
0     11-1011.00  Chief Executives     8823  Direct or coordinate an organization...      Core                   87.0  07/2014     Incumbent               11
1     11-1011.00  Chief Executives     8831  Appoint department heads or managers...      Core                   87.0  07/2014     Incumbent               11
2     11-1011.00  Chief Executives     8825  Analyze operations to evaluate perfo...      Core                   87.0  07/2014     Incumbent               11
3     11-1011.00  Chief Executives     8826  Direct, plan, or implement policies,...      Core                   87.0  07/2014     Incumbent               11
4     11-1011.00  Chief Executives     8827  Prepare budgets for approval, includ...      Core                   87.0  07/2014     Incumbent               11
```

### `release_2025_09_15/data/intermediate/soc_structure.csv`

- Lignes : 1 596
- Taille : 0.1 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `Major Group` | VARCHAR | 23 | 1573 | `None` (1573), `19-0000` (1), `25-0000` (1), `15-0000` (1), `51-0000` (1), `43-0000` (1), `23-0000` (1), `47-0000` (1), `41-0000` (1), `33-0000` (1), `31-0000` (1), `45-0000` (1), `11-0000` (1), `21-0000` (1), `13-0000` (1), `53-0000` (1), `55-0000` (1), `39-0000` (1), `37-0000` (1), `35-0000` (1), `29-0000` (1), `27-0000` (1), `17-0000` (1) |
| `Minor Group` | VARCHAR | 98 | 1498 | `None` (1498), `19-3000` (1), `19-2000` (1), `25-4000` (1), `19-4000` (1), `25-2000` (1), `25-3000` (1), `33-2000` (1), … |
| `Broad Occupation` | VARCHAR | 459 | 1137 | `None` (1137), `11-2010` (1), `11-2020` (1), `11-2030` (1), `11-9010` (1), `11-9030` (1), `11-3020` (1), `11-3120` (1), … |
| `Detailed Occupation` | VARCHAR | 867 | 729 | `None` (729), `11-9013` (1), `11-3051` (1), `11-9111` (1), `11-9031` (1), `11-9071` (1), `11-9081` (1), `11-9131` (1), … |
| `Detailed O*NET-SOC` | VARCHAR | 149 | 1447 | `None` (1447), `11-3051.03` (1), `11-3031.01` (1), `11-9199.01` (1), `11-3071.04` (1), `11-9041.01` (1), `11-9179.02` (1), `11-9199.09` (1), … |
| `SOC or O*NET-SOC 2019 Title` | VARCHAR | 1333 | 0 | `Fishing and Hunting Workers` (3), `Human Resources Managers` (2), `Market Research Analysts and Marketing Specialists` (2), `Industrial Production Managers` (2), `Chemical Engineers` (2), `Farmers, Ranchers, and Other Agricultural Managers` (2), `Postmasters and Mail Superintendents` (2), `Transportation, Storage, and Distribution Managers` (2), … |
| `soc_major_group` | BIGINT | 23 | 1573 | `None` (1573), `47` (1), `45` (1), `37` (1), `35` (1), `31` (1), `27` (1), `11` (1), `49` (1), `29` (1), `25` (1), `55` (1), `15` (1), `43` (1), `41` (1), `23` (1), `33` (1), `19` (1), `17` (1), `13` (1), `21` (1), `53` (1), `39` (1) |

Premières lignes :

```
  Major Group Minor Group Broad Occupation Detailed Occupation Detailed O*NET-SOC    SOC or O*NET-SOC 2019 Title  soc_major_group
0     11-0000         NaN              NaN                 NaN                NaN         Management Occupations               11
1         NaN     11-1000              NaN                 NaN                NaN                 Top Executives             <NA>
2         NaN         NaN          11-1010                 NaN                NaN               Chief Executives             <NA>
3         NaN         NaN              NaN             11-1011                NaN               Chief Executives             <NA>
4         NaN         NaN              NaN                 NaN         11-1011.03  Chief Sustainability Officers             <NA>
```

### `release_2025_09_15/data/intermediate/working_age_pop_2024_country.csv`

- Lignes : 194
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `iso_alpha_3` | VARCHAR | 194 | 0 | `ALB` (1), `DZA` (1), `ATG` (1), `BGD` (1), `BRB` (1), `BMU` (1), `BFA` (1), `BDI` (1), … |
| `year` | BIGINT | 1 | 0 | `2024` (194) |
| `working_age_pop` | DOUBLE | 194 | 0 | `1798066.0` (1), `29534577.0` (1), `2034270.0` (1), `17527551.0` (1), `5981212.0` (1), `7104510.0` (1), `41787.0` (1), `1609356.0` (1), … |
| `country_code` | VARCHAR | 194 | 0 | `AD` (1), `AO` (1), `AG` (1), `AM` (1), `AT` (1), `BS` (1), `BB` (1), `BT` (1), … |
| `country_name` | VARCHAR | 194 | 0 | `Algeria` (1), `Argentina` (1), `Armenia` (1), `Azerbaijan` (1), `Bahamas, The` (1), `Brazil` (1), `Burundi` (1), `Cambodia` (1), … |

Premières lignes :

```
  iso_alpha_3  year  working_age_pop country_code    country_name
0         ALB  2024        1798066.0           AL         Albania
1         DZA  2024       29534577.0           DZ         Algeria
2         ASM  2024          30373.0           AS  American Samoa
3         AND  2024          59134.0           AD         Andorra
4         AGO  2024       20002446.0           AO          Angola
```

### `release_2025_09_15/data/intermediate/working_age_pop_2024_us_state.csv`

- Lignes : 51
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `state` | VARCHAR | 51 | 0 | `Florida` (1), `Texas` (1), `Tennessee` (1), `South Carolina` (1), `Rhode Island` (1), `Oregon` (1), `Alabama` (1), `Ohio` (1), `North Dakota` (1), `North Carolina` (1), `New Jersey` (1), `Nebraska` (1), `Hawaii` (1), `Vermont` (1), `California` (1), `Arizona` (1), `Colorado` (1), `Illinois` (1), `Iowa` (1), `Kansas` (1), `Kentucky` (1), `Maryland` (1), `Michigan` (1), `New Mexico` (1), `New York` (1), `Wisconsin` (1), `Delaware` (1), `District of Columbia` (1), `Louisiana` (1), `Minnesota` (1), `Mississippi` (1), `Montana` (1), `Nevada` (1), `New Hampshire` (1), `South Dakota` (1), `Washington` (1), `Wyoming` (1), `Alaska` (1), `Arkansas` (1), `Connecticut` (1), `Georgia` (1), `Idaho` (1), `Indiana` (1), `Maine` (1), `Massachusetts` (1), `Missouri` (1), `Pennsylvania` (1), `Utah` (1), `Oklahoma` (1), `West Virginia` (1), `Virginia` (1) |
| `working_age_pop` | BIGINT | 51 | 0 | `4787742` (1), `4634205` (1), `2594338` (1), `1326681` (1), `903744` (1), `3262439` (1), `3939611` (1), `1858512` (1), `4691965` (1), `4009368` (1), `1857837` (1), `2033214` (1), `496883` (1), `409700` (1), `1948947` (1), `644810` (1), `14540563` (1), `1264612` (1), `8234916` (1), `2905378` (1), `12815913` (1), `2751203` (1), `8265190` (1), `722897` (1), `20531428` (1), `2310503` (1), `4412999` (1), `25927814` (1), `3958343` (1), `7302240` (1), `850928` (1), `3674398` (1), `1252815` (1), `2119118` (1), `6112451` (1), `3427308` (1), `566060` (1), `5172793` (1), `2366950` (1), `464424` (1), `2894382` (1), `874202` (1), `6433974` (1), `7047991` (1), `497728` (1), `7502858` (1), `5620883` (1), `705291` (1), `366535` (1), `3785250` (1), `1099978` (1) |
| `state_code` | VARCHAR | 51 | 0 | `DE` (1), `GA` (1), `KY` (1), `ME` (1), `MD` (1), `MA` (1), `NV` (1), `NH` (1), `RI` (1), `SD` (1), `UT` (1), `WA` (1), `AL` (1), `CT` (1), `IL` (1), `IA` (1), `MI` (1), `MS` (1), `MT` (1), `NJ` (1), `NY` (1), `ND` (1), `PA` (1), `SC` (1), `TN` (1), `WY` (1), `FL` (1), `HI` (1), `IN` (1), `LA` (1), `MO` (1), `NE` (1), `NM` (1), `OH` (1), `OR` (1), `VA` (1), `WI` (1), `AK` (1), `AR` (1), `DC` (1), `ID` (1), `KS` (1), `MN` (1), `NC` (1), `OK` (1), `TX` (1), `VT` (1), `WV` (1), `AZ` (1), `CA` (1), `CO` (1) |

Premières lignes :

```
        state  working_age_pop state_code
0     Alabama          3262439         AL
1      Alaska           464424         AK
2     Arizona          4787742         AZ
3    Arkansas          1948947         AR
4  California         25927814         CA
```

### `release_2025_09_15/data/output/aei_enriched_claude_ai_2025-08-04_to_2025-08-11.csv`

- Lignes : 136 845
- Taille : 25.6 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 253 | 0 | `GLOBAL` (29681), `USA` (5969), `IND` (3585), `CA` (3484), `JPN` (3168), `KOR` (3098), `GBR` (3068), `DEU` (2815), … |
| `geography` | VARCHAR | 3 | 0 | `country` (80541), `global` (29681), `state_us` (26623) |
| `date_start` | DATE | 1 | 0 | `2025-08-04` (136845) |
| `date_end` | DATE | 1 | 0 | `2025-08-11` (136845) |
| `platform_and_product` | VARCHAR | 1 | 0 | `Claude AI (Free and Pro)` (136845) |
| `facet` | VARCHAR | 9 | 0 | `request` (74323), `onet_task` (33195), `onet_task::collaboration` (14454), `request::collaboration` (8508), `collaboration` (3026), `country` (1352), `soc_occupation` (1208), `collaboration_automation_augmentation` (420), `state_us` (359) |
| `level` | BIGINT | 3 | 0 | `0` (102610), `1` (23995), `2` (10240) |
| `variable` | VARCHAR | 23 | 0 | `request_count` (25173), `request_pct` (25173), `request_pct_index` (23977), `onet_task_pct` (12040), `onet_task_count` (12040), `onet_task_pct_index` (9115), `onet_task_collaboration_pct` (7227), `onet_task_collaboration_count` (7227), `request_collaboration_count` (4254), `request_collaboration_pct` (4254), `soc_pct` (1208), `collaboration_pct` (1112), `collaboration_count` (1112), `collaboration_pct_index` (802), `usage_count` (253), `usage_pct` (253), `working_age_pop` (245), `usage_per_capita_index` (245), `usage_per_capita` (245), `usage_tier` (245), `gdp_per_working_age_capita` (225), `automation_pct` (210), `augmentation_pct` (210) |
| `cluster_name` | VARCHAR | 14742 | 1466 | `not_classified` (1562), `None` (1466), `Create comprehensive K-12 educational materials and teaching` (634), `directive` (584), `task iteration` (544), `Provide comprehensive software development assistance across` (536), `learning` (530), `none` (526), … |
| `value` | DOUBLE | 59018 | 0 | `15.0` (2162), `16.0` (2038), `17.0` (1899), `18.0` (1690), `19.0` (1460), `20.0` (1383), `21.0` (1251), `22.0` (1209), … |
| `geo_name` | VARCHAR | 252 | 0 | `global` (29681), `United States` (5969), `India` (3585), `California` (3484), `Japan` (3168), `South Korea` (3098), `United Kingdom` (3068), `Germany` (2815), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| country | collaboration | 2167 |
| country | collaboration_automation_augmentation | 316 |
| country | country | 1352 |
| country | onet_task | 21539 |
| country | request | 54337 |
| country | soc_occupation | 830 |
| global | collaboration | 14 |
| global | collaboration_automation_augmentation | 2 |
| global | onet_task | 5236 |
| global | onet_task::collaboration | 14454 |
| global | request | 1444 |
| global | request::collaboration | 8508 |
| global | soc_occupation | 23 |
| state_us | collaboration | 845 |
| state_us | collaboration_automation_augmentation | 102 |
| state_us | onet_task | 6420 |
| state_us | request | 18542 |
| state_us | soc_occupation | 355 |
| state_us | state_us | 359 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| collaboration | collaboration_count | 1112 |
| collaboration | collaboration_pct | 1112 |
| collaboration | collaboration_pct_index | 802 |
| collaboration_automation_augmentation | augmentation_pct | 210 |
| collaboration_automation_augmentation | automation_pct | 210 |
| country | gdp_per_working_age_capita | 174 |
| country | usage_count | 201 |
| country | usage_pct | 201 |
| country | usage_per_capita | 194 |
| country | usage_per_capita_index | 194 |
| country | usage_tier | 194 |
| country | working_age_pop | 194 |
| onet_task | onet_task_count | 12040 |
| onet_task | onet_task_pct | 12040 |
| onet_task | onet_task_pct_index | 9115 |
| onet_task::collaboration | onet_task_collaboration_count | 7227 |
| onet_task::collaboration | onet_task_collaboration_pct | 7227 |
| request | request_count | 25173 |
| request | request_pct | 25173 |
| request | request_pct_index | 23977 |
| request::collaboration | request_collaboration_count | 4254 |
| request::collaboration | request_collaboration_pct | 4254 |
| soc_occupation | soc_pct | 1208 |
| state_us | gdp_per_working_age_capita | 51 |
| state_us | usage_count | 52 |
| state_us | usage_pct | 52 |
| state_us | usage_per_capita | 51 |
| state_us | usage_per_capita_index | 51 |
| state_us | usage_tier | 51 |
| state_us | working_age_pop | 51 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| collaboration | 0 | 3026 |
| collaboration_automation_augmentation | 0 | 420 |
| country | 0 | 1352 |
| onet_task | 0 | 33195 |
| onet_task::collaboration | 0 | 14454 |
| request | 0 | 41674 |
| request | 1 | 22711 |
| request | 2 | 9938 |
| request::collaboration | 0 | 6922 |
| request::collaboration | 1 | 1284 |
| request::collaboration | 2 | 302 |
| soc_occupation | 0 | 1208 |
| state_us | 0 | 359 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| Claude AI (Free and Pro) | collaboration | 3026 |
| Claude AI (Free and Pro) | collaboration_automation_augmentation | 420 |
| Claude AI (Free and Pro) | country | 1352 |
| Claude AI (Free and Pro) | onet_task | 33195 |
| Claude AI (Free and Pro) | onet_task::collaboration | 14454 |
| Claude AI (Free and Pro) | request | 74323 |
| Claude AI (Free and Pro) | request::collaboration | 8508 |
| Claude AI (Free and Pro) | soc_occupation | 1208 |
| Claude AI (Free and Pro) | state_us | 359 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **collaboration** (7 distincts) : `directive`, `task iteration`, `learning`, `feedback loop`, `validation`, `none`, `not_classified`
- **collaboration_automation_augmentation** (2 distincts) : `augmentation`, `automation`
- **country** (5 distincts) : `None`, `Emerging (bottom 25%)`, `Lower middle (25-50%)`, `Leading (top 25%)`, `Upper middle (50-75%)`, `Minimal`
- **onet_task** (2618 distincts) : `write new programs or modify existing programs to `, `modify existing software to correct errors, allow `, `modify existing software to correct errors, to ada`, `diagnose, troubleshoot, and resolve hardware, soft`, `design, build, or maintain web sites, using author`, `correct errors by making appropriate changes and r`, `not_classified`, `perform routine system administrative functions su`, `none`, `assist students who need extra help with their cou`, `provide private instruction to individual or small`, `troubleshoot problems involving office equipment, `, `edit, standardize, or make changes to material pre`, `prepare, rewrite and edit copy to improve readabil`, `write, update, and maintain computer programs or s`, `analyze user needs and software requirements to de`, `perform initial debugging procedures by reviewing `, `review and analyze computer printouts and performa`, `confer with clients regarding the nature of the in`, `instruct through lectures, discussions, and demons`, `develop instructional materials to be used by educ`, `edit or rewrite existing copy as necessary, and su`, `instruct individuals in career development techniq`, `develop new software applications or customize exi`, `compile and write documentation of program develop`, `prepare and deliver lectures to undergraduate or g`, `develop briefings, brochures, multimedia presentat`, `develop instructional materials, such as lesson pl`, `search electronic sources, such as databases or re`, `answer customers' questions, and provide informati`, `develop or apply data mining and machine learning `, `write, analyze, review, and rewrite programs, usin`, `review class material with students by discussing `, `modify existing programs to enhance efficiency.`, `write supporting code for web applications or web `, `conduct searches to find needed information, using`, `determine sources of web page or server problems, `, `read manuals, periodicals, and technical reports t`, `research, compile, analyze and organize informatio`, `conduct classes, workshops, and demonstrations, an`
- **onet_task::collaboration** (7227 distincts) : `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `address the relationships of quantities, magnitude`, `address the relationships of quantities, magnitude`, `address the relationships of quantities, magnitude`, `administer online purchasing systems.::directive`, `administer online purchasing systems.::not_classif`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `advise and teach students.::task iteration`, `advise animal owners regarding sanitary measures, `, `advise business or other groups on local, national`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise clients on transportation and payment metho`, `advise corporations on issues involving corporate `, `advise customer about or perform maintenance of so`, `advise customer about or perform maintenance of so`, `advise customers of necessary actions and strategi`, `advise customers of necessary actions and strategi`, `advise customers on use and care of merchandise.::`, `advise customers on use and care of merchandise.::`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise management concerning personnel, managerial`, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise other physicians on the treatment of neurol`, `advise patients and community members concerning d`, `advise patients and their families on nutritional `, `advise retail managers on compliance with applicab`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`
- **request** (704 distincts) : `not_classified`, `Create comprehensive K-12 educational materials an`, `Provide comprehensive software development assista`, `Help develop and debug complete web applications a`, `Provide educational tutoring and academic assistan`, `Help edit, improve, and create professional writte`, `Provide technical and academic assistance across s`, `Provide technical IT support and troubleshooting a`, `Provide comprehensive financial guidance and inves`, `Debug and fix software code errors across multiple`, `Analyze and process data from documents, visual me`, `Provide comprehensive multi-technology programming`, `Help with academic research, writing, and educatio`, `Create comprehensive digital marketing strategies `, `Provide medical and sports training guidance`, `Edit and improve existing written content and docu`, `Provide educational assistance and tutoring across`, `Provide personalized lifestyle advice and recommen`, `Help with automation scripts, robotics programming`, `Help create visual content, graphics, and multimed`, `Provide comprehensive medical and healthcare guida`, `Provide multilingual translation services and lang`, `Fix and improve web and mobile application UI layo`, `Provide business operations support and strategic `, `Provide comprehensive database development and man`, `Help develop and debug cross-platform mobile appli`, `Provide translation services and comprehensive lan`, `Provide comprehensive domestic life and household `, `Provide comprehensive business consulting and stra`, `Provide technical troubleshooting and support for `, `Provide comprehensive legal assistance including i`, `Help with job applications, resumes, and career ad`, `Provide comprehensive financial advice and assista`, `Develop automated trading systems and technical an`, `Help develop, debug, and modify web applications a`, `Help create and optimize comprehensive digital mar`, `Provide comprehensive legal assistance and documen`, `Help plan and organize events, schedules, and trav`, `Help build complete web applications and websites `, `Assist with game development programming and mobil`
- **request::collaboration** (4160 distincts) : `Help with random number generation and lottery pre`, `Develop automated trading systems and technical an`, `Help with medical education applications and exam `, `Process meeting transcripts into summaries and str`, `Extract and transcribe text from images using OCR `, `Provide comprehensive blockchain and cryptocurrenc`, `Help implement multilingual features and communica`, `Help implement and create icons for websites and a`, `Create comprehensive K-12 educational materials an`, `Process meeting transcripts into summaries and str`, `Help with date calculations, formatting, and datet`, `Debug and optimize computational physics simulatio`, `Help implement multilingual features and communica`, `Help implement multilingual features and communica`, `Help implement multilingual features and communica`, `Debug and optimize computational physics simulatio`, `Provide real estate investment analysis and busine`, `Provide comprehensive blockchain and cryptocurrenc`, `Help implement and create icons for websites and a`, `Provide comprehensive blockchain and cryptocurrenc`, `Help with medical education applications and exam `, `Extract and transcribe text from images using OCR `, `Provide real estate investment analysis and busine`, `Help with timezone conversions and timestamp forma`, `Provide comprehensive blockchain and cryptocurrenc`, `Develop automated trading systems and technical an`, `Process meeting transcripts into summaries and str`, `Provide parenting advice and child development gui`, `Help with time calculations, duration tracking, an`, `Provide real estate investment analysis and busine`, `Help with date calculations, formatting, and datet`, `Help with time calculations, duration tracking, an`, `Help implement multilingual features and communica`, `Help with emoji implementation, formatting, and mo`, `Help with timezone conversions and timestamp forma`, `Debug and optimize computational physics simulatio`, `Create comprehensive K-12 educational materials an`, `Help with emoji implementation, formatting, and mo`, `Provide parenting advice and child development gui`, `Help with emoji implementation, formatting, and mo`
- **soc_occupation** (23 distincts) : `not_classified`, `Computer and Mathematical`, `Office and Administrative Support`, `Educational Instruction and Library`, `Arts, Design, Entertainment, Sports, and Media`, `Life, Physical, and Social Science`, `Community and Social Service`, `Sales and Related`, `Production`, `Farming, Fishing, and Forestry`, `Architecture and Engineering`, `Management`, `Installation, Maintenance, and Repair`, `Business and Financial Operations`, `Healthcare Practitioners and Technical`, `Legal`, `Personal Care and Service`, `Food Preparation and Serving Related`, `Protective Service`, `Building and Grounds Cleaning and Maintenance`, `Healthcare Support`, `Construction and Extraction`, `Transportation and Material Moving`
- **state_us** (4 distincts) : `None`, `Leading (top 25%)`, `Lower middle (25-50%)`, `Emerging (bottom 25%)`, `Upper middle (50-75%)`

Lignes pour les pays étudiés : `BEL` (513), `DEU` (2815), `ESP` (1719), `FRA` (2636), `GBR` (3068), `ITA` (2137), `NLD` (1270), `USA` (5969)

Premières lignes :

```
  geo_id geography date_start   date_end      platform_and_product    facet  level                    variable cluster_name         value geo_name
0    ABW   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  country      0  gdp_per_working_age_capita         None  55553.993646    Aruba
1    ABW   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  country      0                 usage_count         None      0.000000    Aruba
2    ABW   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  country      0                   usage_pct         None      0.000000    Aruba
3    ABW   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  country      0            usage_per_capita         None      0.000000    Aruba
4    ABW   country 2025-08-04 2025-08-11  Claude AI (Free and Pro)  country      0      usage_per_capita_index         None      0.000000    Aruba
```

## Version 2026-01-15

| Fichier | Taille (Mo) |
|---|---|
| `release_2026_01_15/data/intermediate/aei_raw_1p_api_2025-11-13_to_2025-11-20.csv` | 39.59 |
| `release_2026_01_15/data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv` | 89.73 |
| `release_2026_01_15/aei_v4_appendix.pdf` | 5.76 |
| `release_2026_01_15/data_documentation.md` | 0.02 |

### `release_2026_01_15/data/intermediate/aei_raw_1p_api_2025-11-13_to_2025-11-20.csv`

- Lignes : 187 772
- Taille : 39.6 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 1 | 0 | `GLOBAL` (187772) |
| `geography` | VARCHAR | 1 | 0 | `global` (187772) |
| `date_start` | DATE | 1 | 0 | `2025-11-13` (187772) |
| `date_end` | DATE | 1 | 0 | `2025-11-20` (187772) |
| `platform_and_product` | VARCHAR | 1 | 0 | `1P API` (187772) |
| `facet` | VARCHAR | 38 | 0 | `onet_task::ai_autonomy` (20370), `onet_task::ai_education_years` (20274), `onet_task::human_only_time` (20272), `onet_task::human_with_ai_time` (20270), `onet_task::human_education_years` (20268), `onet_task::collaboration` (11112), `onet_task::use_case` (9756), `onet_task::task_success` (8118), `onet_task::human_only_ability` (7856), `onet_task::multitasking` (7412), `request::collaboration` (5134), `onet_task` (4506), `request::ai_autonomy` (3086), `request::human_with_ai_time` (3052), `request::human_education_years` (3052), `request::ai_education_years` (3052), `request::human_only_time` (3052), `request::use_case` (2702), `onet_task::completion_tokens` (2252), `onet_task::prompt_tokens` (2252), `onet_task::cost` (2252), `request::task_success` (1744), `request::multitasking` (1742), `request::human_only_ability` (1732), `request` (878), `request::completion_tokens` (436), `request::cost` (436), `request::prompt_tokens` (436), `human_with_ai_time` (58), `human_only_time` (58), `ai_education_years` (50), `human_education_years` (50), `ai_autonomy` (18), `collaboration` (14), `use_case` (8), `human_only_ability` (4), `multitasking` (4), `task_success` (4) |
| `level` | BIGINT | 3 | 0 | `0` (180340), `1` (5922), `2` (1510) |
| `variable` | VARCHAR | 167 | 0 | `onet_task_collaboration_pct` (5556), `onet_task_collaboration_count` (5556), `onet_task_use_case_pct` (4878), `onet_task_use_case_count` (4878), `onet_task_task_success_count` (4059), `onet_task_task_success_pct` (4059), `onet_task_human_only_ability_pct` (3928), `onet_task_human_only_ability_count` (3928), … |
| `cluster_name` | VARCHAR | 23114 | 40 | `Debug and configure containerized applications and orchestra` (74), `Remove unused and deprecated code from software codebases` (74), `Execute file operations and shell commands through terminal ` (74), `Extract and structure financial data from documents into sta` (74), `Extract and structure data from insurance policy documents` (74), `Develop and use AI systems for tax document processing and c` (74), `Develop and debug blockchain applications, smart contracts, ` (74), `Process and extract information from business and legal docu` (74), … |
| `value` | DOUBLE | 93178 | 0 | `100.0` (16035), `3.0` (2709), `12.0` (2574), `16.0` (2265), `2.0` (2219), `1.0` (1991), `14.0` (1503), `15.0` (1441), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| global | ai_autonomy | 18 |
| global | ai_education_years | 50 |
| global | collaboration | 14 |
| global | human_education_years | 50 |
| global | human_only_ability | 4 |
| global | human_only_time | 58 |
| global | human_with_ai_time | 58 |
| global | multitasking | 4 |
| global | onet_task | 4506 |
| global | onet_task::ai_autonomy | 20370 |
| global | onet_task::ai_education_years | 20274 |
| global | onet_task::collaboration | 11112 |
| global | onet_task::completion_tokens | 2252 |
| global | onet_task::cost | 2252 |
| global | onet_task::human_education_years | 20268 |
| global | onet_task::human_only_ability | 7856 |
| global | onet_task::human_only_time | 20272 |
| global | onet_task::human_with_ai_time | 20270 |
| global | onet_task::multitasking | 7412 |
| global | onet_task::prompt_tokens | 2252 |
| global | onet_task::task_success | 8118 |
| global | onet_task::use_case | 9756 |
| global | request | 878 |
| global | request::ai_autonomy | 3086 |
| global | request::ai_education_years | 3052 |
| global | request::collaboration | 5134 |
| global | request::completion_tokens | 436 |
| global | request::cost | 436 |
| global | request::human_education_years | 3052 |
| global | request::human_only_ability | 1732 |
| global | request::human_only_time | 3052 |
| global | request::human_with_ai_time | 3052 |
| global | request::multitasking | 1742 |
| global | request::prompt_tokens | 436 |
| global | request::task_success | 1744 |
| global | request::use_case | 2702 |
| global | task_success | 4 |
| global | use_case | 8 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| ai_autonomy | ai_autonomy_count | 1 |
| ai_autonomy | ai_autonomy_histogram_count | 5 |
| ai_autonomy | ai_autonomy_histogram_pct | 5 |
| ai_autonomy | ai_autonomy_mean | 1 |
| ai_autonomy | ai_autonomy_mean_ci_lower | 1 |
| ai_autonomy | ai_autonomy_mean_ci_upper | 1 |
| ai_autonomy | ai_autonomy_median | 1 |
| ai_autonomy | ai_autonomy_median_ci_lower | 1 |
| ai_autonomy | ai_autonomy_median_ci_upper | 1 |
| ai_autonomy | ai_autonomy_stdev | 1 |
| ai_education_years | ai_education_years_count | 1 |
| ai_education_years | ai_education_years_histogram_count | 21 |
| ai_education_years | ai_education_years_histogram_pct | 21 |
| ai_education_years | ai_education_years_mean | 1 |
| ai_education_years | ai_education_years_mean_ci_lower | 1 |
| ai_education_years | ai_education_years_mean_ci_upper | 1 |
| ai_education_years | ai_education_years_median | 1 |
| ai_education_years | ai_education_years_median_ci_lower | 1 |
| ai_education_years | ai_education_years_median_ci_upper | 1 |
| ai_education_years | ai_education_years_stdev | 1 |
| collaboration | collaboration_count | 7 |
| collaboration | collaboration_pct | 7 |
| human_education_years | human_education_years_count | 1 |
| human_education_years | human_education_years_histogram_count | 21 |
| human_education_years | human_education_years_histogram_pct | 21 |
| human_education_years | human_education_years_mean | 1 |
| human_education_years | human_education_years_mean_ci_lower | 1 |
| human_education_years | human_education_years_mean_ci_upper | 1 |
| human_education_years | human_education_years_median | 1 |
| human_education_years | human_education_years_median_ci_lower | 1 |
| human_education_years | human_education_years_median_ci_upper | 1 |
| human_education_years | human_education_years_stdev | 1 |
| human_only_ability | human_only_ability_count | 2 |
| human_only_ability | human_only_ability_pct | 2 |
| human_only_time | human_only_time_count | 1 |
| human_only_time | human_only_time_histogram_count | 25 |
| human_only_time | human_only_time_histogram_pct | 25 |
| human_only_time | human_only_time_mean | 1 |
| human_only_time | human_only_time_mean_ci_lower | 1 |
| human_only_time | human_only_time_mean_ci_upper | 1 |
| human_only_time | human_only_time_median | 1 |
| human_only_time | human_only_time_median_ci_lower | 1 |
| human_only_time | human_only_time_median_ci_upper | 1 |
| human_only_time | human_only_time_stdev | 1 |
| human_with_ai_time | human_with_ai_time_count | 1 |
| human_with_ai_time | human_with_ai_time_histogram_count | 25 |
| human_with_ai_time | human_with_ai_time_histogram_pct | 25 |
| human_with_ai_time | human_with_ai_time_mean | 1 |
| human_with_ai_time | human_with_ai_time_mean_ci_lower | 1 |
| human_with_ai_time | human_with_ai_time_mean_ci_upper | 1 |
| human_with_ai_time | human_with_ai_time_median | 1 |
| human_with_ai_time | human_with_ai_time_median_ci_lower | 1 |
| human_with_ai_time | human_with_ai_time_median_ci_upper | 1 |
| human_with_ai_time | human_with_ai_time_stdev | 1 |
| multitasking | multitasking_count | 2 |
| multitasking | multitasking_pct | 2 |
| onet_task | onet_task_count | 2253 |
| onet_task | onet_task_pct | 2253 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_count | 2303 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean | 2252 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_lower | 2252 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_upper | 2252 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median | 2252 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_lower | 2252 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_upper | 2252 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_pct | 2303 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_stdev | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_count | 2255 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_lower | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_upper | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_median | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_lower | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_upper | 2252 |
| onet_task::ai_education_years | onet_task_ai_education_years_pct | 2255 |
| onet_task::ai_education_years | onet_task_ai_education_years_stdev | 2252 |
| onet_task::collaboration | onet_task_collaboration_count | 5556 |
| onet_task::collaboration | onet_task_collaboration_pct | 5556 |
| onet_task::completion_tokens | completion_tokens_index | 2252 |
| onet_task::cost | cost_index | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_count | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_mean | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_lower | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_upper | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_median | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_lower | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_upper | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_pct | 2252 |
| onet_task::human_education_years | onet_task_human_education_years_stdev | 2252 |
| onet_task::human_only_ability | onet_task_human_only_ability_count | 3928 |
| onet_task::human_only_ability | onet_task_human_only_ability_pct | 3928 |
| onet_task::human_only_time | onet_task_human_only_time_count | 2254 |
| onet_task::human_only_time | onet_task_human_only_time_mean | 2252 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_lower | 2252 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_upper | 2252 |
| onet_task::human_only_time | onet_task_human_only_time_median | 2252 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_lower | 2252 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_upper | 2252 |
| onet_task::human_only_time | onet_task_human_only_time_pct | 2254 |
| onet_task::human_only_time | onet_task_human_only_time_stdev | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_count | 2253 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_lower | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_upper | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_lower | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_upper | 2252 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_pct | 2253 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_stdev | 2252 |
| onet_task::multitasking | onet_task_multitasking_count | 3706 |
| onet_task::multitasking | onet_task_multitasking_pct | 3706 |
| onet_task::prompt_tokens | prompt_tokens_index | 2252 |
| onet_task::task_success | onet_task_task_success_count | 4059 |
| onet_task::task_success | onet_task_task_success_pct | 4059 |
| onet_task::use_case | onet_task_use_case_count | 4878 |
| onet_task::use_case | onet_task_use_case_pct | 4878 |
| request | request_count | 439 |
| request | request_pct | 439 |
| request::ai_autonomy | request_ai_autonomy_count | 453 |
| request::ai_autonomy | request_ai_autonomy_mean | 436 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_lower | 436 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_upper | 436 |
| request::ai_autonomy | request_ai_autonomy_median | 436 |
| request::ai_autonomy | request_ai_autonomy_pct | 453 |
| request::ai_autonomy | request_ai_autonomy_stdev | 436 |
| request::ai_education_years | request_ai_education_years_count | 436 |
| request::ai_education_years | request_ai_education_years_mean | 436 |
| request::ai_education_years | request_ai_education_years_mean_ci_lower | 436 |
| request::ai_education_years | request_ai_education_years_mean_ci_upper | 436 |
| request::ai_education_years | request_ai_education_years_median | 436 |
| request::ai_education_years | request_ai_education_years_pct | 436 |
| request::ai_education_years | request_ai_education_years_stdev | 436 |
| request::collaboration | request_collaboration_count | 2567 |
| request::collaboration | request_collaboration_pct | 2567 |
| request::completion_tokens | completion_tokens_index | 436 |
| request::cost | cost_index | 436 |
| request::human_education_years | request_human_education_years_count | 436 |
| request::human_education_years | request_human_education_years_mean | 436 |
| request::human_education_years | request_human_education_years_mean_ci_lower | 436 |
| request::human_education_years | request_human_education_years_mean_ci_upper | 436 |
| request::human_education_years | request_human_education_years_median | 436 |
| request::human_education_years | request_human_education_years_pct | 436 |
| request::human_education_years | request_human_education_years_stdev | 436 |
| request::human_only_ability | request_human_only_ability_count | 866 |
| request::human_only_ability | request_human_only_ability_pct | 866 |
| request::human_only_time | request_human_only_time_count | 436 |
| request::human_only_time | request_human_only_time_mean | 436 |
| request::human_only_time | request_human_only_time_mean_ci_lower | 436 |
| request::human_only_time | request_human_only_time_mean_ci_upper | 436 |
| request::human_only_time | request_human_only_time_median | 436 |
| request::human_only_time | request_human_only_time_pct | 436 |
| request::human_only_time | request_human_only_time_stdev | 436 |
| request::human_with_ai_time | request_human_with_ai_time_count | 436 |
| request::human_with_ai_time | request_human_with_ai_time_mean | 436 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_lower | 436 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_upper | 436 |
| request::human_with_ai_time | request_human_with_ai_time_median | 436 |
| request::human_with_ai_time | request_human_with_ai_time_pct | 436 |
| request::human_with_ai_time | request_human_with_ai_time_stdev | 436 |
| request::multitasking | request_multitasking_count | 871 |
| request::multitasking | request_multitasking_pct | 871 |
| request::prompt_tokens | prompt_tokens_index | 436 |
| request::task_success | request_task_success_count | 872 |
| request::task_success | request_task_success_pct | 872 |
| request::use_case | request_use_case_count | 1351 |
| request::use_case | request_use_case_pct | 1351 |
| task_success | task_success_count | 2 |
| task_success | task_success_pct | 2 |
| use_case | use_case_count | 4 |
| use_case | use_case_pct | 4 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| ai_autonomy | 0 | 18 |
| ai_education_years | 0 | 50 |
| collaboration | 0 | 14 |
| human_education_years | 0 | 50 |
| human_only_ability | 0 | 4 |
| human_only_time | 0 | 58 |
| human_with_ai_time | 0 | 58 |
| multitasking | 0 | 4 |
| onet_task | 0 | 4506 |
| onet_task::ai_autonomy | 0 | 20370 |
| onet_task::ai_education_years | 0 | 20274 |
| onet_task::collaboration | 0 | 11112 |
| onet_task::completion_tokens | 0 | 2252 |
| onet_task::cost | 0 | 2252 |
| onet_task::human_education_years | 0 | 20268 |
| onet_task::human_only_ability | 0 | 7856 |
| onet_task::human_only_time | 0 | 20272 |
| onet_task::human_with_ai_time | 0 | 20270 |
| onet_task::multitasking | 0 | 7412 |
| onet_task::prompt_tokens | 0 | 2252 |
| onet_task::task_success | 0 | 8118 |
| onet_task::use_case | 0 | 9756 |
| request | 0 | 664 |
| request | 1 | 170 |
| request | 2 | 44 |
| request::ai_autonomy | 0 | 2329 |
| request::ai_autonomy | 1 | 600 |
| request::ai_autonomy | 2 | 157 |
| request::ai_education_years | 0 | 2317 |
| request::ai_education_years | 1 | 588 |
| request::ai_education_years | 2 | 147 |
| request::collaboration | 0 | 3880 |
| request::collaboration | 1 | 1000 |
| request::collaboration | 2 | 254 |
| request::completion_tokens | 0 | 331 |
| request::completion_tokens | 1 | 84 |
| request::completion_tokens | 2 | 21 |
| request::cost | 0 | 331 |
| request::cost | 1 | 84 |
| request::cost | 2 | 21 |
| request::human_education_years | 0 | 2317 |
| request::human_education_years | 1 | 588 |
| request::human_education_years | 2 | 147 |
| request::human_only_ability | 0 | 1314 |
| request::human_only_ability | 1 | 334 |
| request::human_only_ability | 2 | 84 |
| request::human_only_time | 0 | 2317 |
| request::human_only_time | 1 | 588 |
| request::human_only_time | 2 | 147 |
| request::human_with_ai_time | 0 | 2317 |
| request::human_with_ai_time | 1 | 588 |
| request::human_with_ai_time | 2 | 147 |
| request::multitasking | 0 | 1322 |
| request::multitasking | 1 | 336 |
| request::multitasking | 2 | 84 |
| request::prompt_tokens | 0 | 331 |
| request::prompt_tokens | 1 | 84 |
| request::prompt_tokens | 2 | 21 |
| request::task_success | 0 | 1324 |
| request::task_success | 1 | 336 |
| request::task_success | 2 | 84 |
| request::use_case | 0 | 2008 |
| request::use_case | 1 | 542 |
| request::use_case | 2 | 152 |
| task_success | 0 | 4 |
| use_case | 0 | 8 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| 1P API | ai_autonomy | 18 |
| 1P API | ai_education_years | 50 |
| 1P API | collaboration | 14 |
| 1P API | human_education_years | 50 |
| 1P API | human_only_ability | 4 |
| 1P API | human_only_time | 58 |
| 1P API | human_with_ai_time | 58 |
| 1P API | multitasking | 4 |
| 1P API | onet_task | 4506 |
| 1P API | onet_task::ai_autonomy | 20370 |
| 1P API | onet_task::ai_education_years | 20274 |
| 1P API | onet_task::collaboration | 11112 |
| 1P API | onet_task::completion_tokens | 2252 |
| 1P API | onet_task::cost | 2252 |
| 1P API | onet_task::human_education_years | 20268 |
| 1P API | onet_task::human_only_ability | 7856 |
| 1P API | onet_task::human_only_time | 20272 |
| 1P API | onet_task::human_with_ai_time | 20270 |
| 1P API | onet_task::multitasking | 7412 |
| 1P API | onet_task::prompt_tokens | 2252 |
| 1P API | onet_task::task_success | 8118 |
| 1P API | onet_task::use_case | 9756 |
| 1P API | request | 878 |
| 1P API | request::ai_autonomy | 3086 |
| 1P API | request::ai_education_years | 3052 |
| 1P API | request::collaboration | 5134 |
| 1P API | request::completion_tokens | 436 |
| 1P API | request::cost | 436 |
| 1P API | request::human_education_years | 3052 |
| 1P API | request::human_only_ability | 1732 |
| 1P API | request::human_only_time | 3052 |
| 1P API | request::human_with_ai_time | 3052 |
| 1P API | request::multitasking | 1742 |
| 1P API | request::prompt_tokens | 436 |
| 1P API | request::task_success | 1744 |
| 1P API | request::use_case | 2702 |
| 1P API | task_success | 4 |
| 1P API | use_case | 8 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **ai_autonomy** (5 distincts) : `None`, `[2.0, 2.0)`, `[3.0, 3.0)`, `[4.0, 4.0)`, `[1.0, 1.0)`, `[5.0, 5.0)`
- **ai_education_years** (21 distincts) : `None`, `[16.0, 16.0)`, `[9.0, 9.0)`, `[4.0, 4.0)`, `[2.0, 2.0)`, `[14.0, 14.0)`, `[8.0, 8.0)`, `[5.0, 5.0)`, `[20.0, 20.0)`, `[19.0, 19.0)`, `[18.0, 18.0)`, `[10.0, 10.0)`, `[15.0, 15.0)`, `[3.0, 3.0)`, `[12.0, 12.0)`, `[1.0, 1.0)`, `[11.0, 11.0)`, `[0.0, 0.0)`, `[17.0, 17.0)`, `[7.0, 7.0)`, `[6.0, 6.0)`, `[13.0, 13.0)`
- **collaboration** (7 distincts) : `directive`, `validation`, `learning`, `task iteration`, `none`, `feedback loop`, `not_classified`
- **human_education_years** (21 distincts) : `None`, `[16.0, 16.0)`, `[9.0, 9.0)`, `[4.0, 4.0)`, `[2.0, 2.0)`, `[14.0, 14.0)`, `[8.0, 8.0)`, `[5.0, 5.0)`, `[20.0, 20.0)`, `[19.0, 19.0)`, `[18.0, 18.0)`, `[10.0, 10.0)`, `[15.0, 15.0)`, `[3.0, 3.0)`, `[12.0, 12.0)`, `[1.0, 1.0)`, `[11.0, 11.0)`, `[0.0, 0.0)`, `[17.0, 17.0)`, `[7.0, 7.0)`, `[6.0, 6.0)`, `[13.0, 13.0)`
- **human_only_ability** (2 distincts) : `no`, `yes`
- **human_only_time** (25 distincts) : `None`, `[0.0, 70.0)`, `[770.0, 840.0)`, `[1330.0, 1400.0)`, `[1050.0, 1120.0)`, `[70.0, 140.0)`, `[630.0, 700.0)`, `[490.0, 560.0)`, `[420.0, 490.0)`, `[350.0, 420.0)`, `[1540.0, 1610.0)`, `[1400.0, 1470.0)`, `[1260.0, 1330.0)`, `[1610.0, 1680.0)`, `[700.0, 770.0)`, `[1120.0, 1190.0)`, `[210.0, 280.0)`, `[980.0, 1050.0)`, `[140.0, 210.0)`, `[1470.0, 1540.0)`, `[1190.0, 1260.0)`, `[280.0, 350.0)`, `[910.0, 980.0)`, `[840.0, 910.0)`, `[560.0, 630.0)`, `[1680.0, 1750.0)`
- **human_with_ai_time** (25 distincts) : `None`, `[2016.0, 2112.0)`, `[960.0, 1056.0)`, `[2304.0, 2400.0)`, `[192.0, 288.0)`, `[1536.0, 1632.0)`, `[96.0, 192.0)`, `[2208.0, 2304.0)`, `[1152.0, 1248.0)`, `[1728.0, 1824.0)`, `[0.0, 96.0)`, `[864.0, 960.0)`, `[2112.0, 2208.0)`, `[1632.0, 1728.0)`, `[1824.0, 1920.0)`, `[1440.0, 1536.0)`, `[1344.0, 1440.0)`, `[1248.0, 1344.0)`, `[1056.0, 1152.0)`, `[768.0, 864.0)`, `[672.0, 768.0)`, `[576.0, 672.0)`, `[480.0, 576.0)`, `[384.0, 480.0)`, `[288.0, 384.0)`, `[1920.0, 2016.0)`
- **multitasking** (2 distincts) : `no`, `yes`
- **onet_task** (2253 distincts) : `act as an intermediary in negotiations between buy`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `advise animal owners regarding sanitary measures, `, `advise clients on financial and legal matters such`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise or assist in obtaining patents or meeting o`, `analyze and interpret news and information receive`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze data from surveys, old records, or case st`, `analyze data such as interview notes, test results`, `analyze developments in specific field to determin`, `analyze employment-related data and prepare requir`, `analyze geographic distributions of physical and c`, `analyze information to determine, recommend, and p`, `analyze job requirements and content to establish `, `analyze or interpret logistics data involving cust`, `analyze performance data to determine effectivenes`, `analyze potential loan markets to find opportuniti`, `analyze prescribing trends to monitor patient comp`, `analyze problems to develop solutions involving co`, `analyze records, reports, test results, or examina`, `analyze the layout, instrumentation, or function o`, `analyze trends in sales prices, construction costs`, `answer customers' questions about products, prices`, `answer customers' questions about products, prices`, `answer inquiries concerning the progress of medica`, `answer inquiries from current or prospective custo`, `answer questions regarding examinations, eligibili`, `answer telephones and give information to callers,`, `answer telephones and schedule appointments.`, `answer telephones, responding to questions or requ`, `apply customer feedback to service improvement eff`, `appraise property values, assessing income potenti`, `arrange reservations for patrons of dining establi`, `assemble and compile documents for loan closings, `, `assess risks to mitigate potential consequences of`, `assess staffing needs and recruit staff, using met`
- **onet_task::ai_autonomy** (2303 distincts) : `adapt text to accommodate musical requirements of `, `administer highway planning, construction, or main`, `administer online purchasing systems.`, `administer treatments or therapies, such as homeop`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients on market conditions, prices, mortg`, `advise customers on use and care of merchandise.`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and maintain data logs for audio-visual ac`, `analyze and record test data to issue reports that`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze credit data and financial statements to de`, `analyze data to determine answers to questions fro`, `analyze details of sales territories to assess the`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze information processing or computation need`, `analyze information to determine, recommend, and p`, `analyze network data to determine network usage, d`, `analyze or evaluate dental needs to determine chan`, `analyze price proposals, financial reports, and ot`, `analyze training needs to develop new training pro`, `analyze user needs and software requirements to de`, `analyze, interpret, or create graphical representa`, `answer clients' questions about the purposes and d`, `answer customer inquiries or explain cost, availab`, `answer customers' questions about merchandise and `, `answer inquiries pertaining to hotel services, gue`, `answer inquiries regarding information such as sch`, `answer passengers' questions about flights, aircra`, `answer questions about records or files.`, `answer questions and provide future tax planning t`, `answer telephone calls and respond to inquiries or`, `answer telephone calls to take messages, answer qu`
- **onet_task::ai_education_years** (2255 distincts) : `adapt text to accommodate musical requirements of `, `administer highway planning, construction, or main`, `administer online purchasing systems.`, `administer treatments or therapies, such as homeop`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients on market conditions, prices, mortg`, `advise customers on use and care of merchandise.`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and maintain data logs for audio-visual ac`, `analyze and record test data to issue reports that`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze credit data and financial statements to de`, `analyze data to determine answers to questions fro`, `analyze details of sales territories to assess the`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze information processing or computation need`, `analyze information to determine, recommend, and p`, `analyze network data to determine network usage, d`, `analyze or evaluate dental needs to determine chan`, `analyze price proposals, financial reports, and ot`, `analyze training needs to develop new training pro`, `analyze user needs and software requirements to de`, `analyze, interpret, or create graphical representa`, `answer clients' questions about the purposes and d`, `answer customer inquiries or explain cost, availab`, `answer customers' questions about merchandise and `, `answer inquiries pertaining to hotel services, gue`, `answer inquiries regarding information such as sch`, `answer passengers' questions about flights, aircra`, `answer questions about records or files.`, `answer questions and provide future tax planning t`, `answer telephone calls and respond to inquiries or`, `answer telephone calls to take messages, answer qu`
- **onet_task::collaboration** (5556 distincts) : `adapt translations to students' cognitive and grad`, `address the relationships of quantities, magnitude`, `administer document and system access rights and r`, `administer document and system access rights and r`, `administer online purchasing systems.::directive`, `administer online purchasing systems.::not_classif`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise clients on how they could be helped by coun`, `advise corporations on issues involving corporate `, `advise management concerning personnel, managerial`, `advise patients and their families on nutritional `, `advise students on academic and vocational curricu`, `analyze all aspects of corporate logistics to dete`, `analyze all aspects of corporate logistics to dete`, `analyze and evaluate security operations to identi`, `analyze and evaluate security operations to identi`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze and maintain data logs for audio-visual ac`, `analyze and record personnel or operational data a`, `analyze and record test data to issue reports that`, `analyze and report computer network security breac`, `analyze and report computer network security breac`, `analyze characteristics of animals to identify and`, `analyze competitive market strategies through anal`, `analyze credit data and financial statements to de`, `analyze data from surveys, old records, or case st`, `analyze data from surveys, old records, or case st`, `analyze data to determine answers to questions fro`, `analyze data to determine validity, quality, and s`, `analyze details of sales territories to assess the`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze experimental data and interpret results to`
- **onet_task::completion_tokens** (2252 distincts) : `accompany buyers during visits to and inspections `, `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and maintain data logs for audio-visual ac`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or synthesize client data to draw conclusi`, `analyze performance data to determine effectivenes`, `analyze problems to develop solutions involving co`, `analyze target companies or investment opportuniti`, `analyze the probable outcomes of cases, using know`, `analyze training needs to design employee developm`, `analyze, interpret, or create graphical representa`, `answer applicants' questions about benefits and cl`, `answer clients' questions regarding construction w`, `answer customers' questions, and explain available`, `answer customers' questions, and provide informati`, `answer inquiries from the public concerning animal`, `answer inquiries regarding information such as sch`, `answer questions about product features and benefi`, `answer telephone calls to take messages, answer qu`
- **onet_task::cost** (2252 distincts) : `accompany buyers during visits to and inspections `, `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and maintain data logs for audio-visual ac`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or synthesize client data to draw conclusi`, `analyze performance data to determine effectivenes`, `analyze problems to develop solutions involving co`, `analyze target companies or investment opportuniti`, `analyze the probable outcomes of cases, using know`, `analyze training needs to design employee developm`, `analyze, interpret, or create graphical representa`, `answer applicants' questions about benefits and cl`, `answer clients' questions regarding construction w`, `answer customers' questions, and explain available`, `answer customers' questions, and provide informati`, `answer inquiries from the public concerning animal`, `answer inquiries regarding information such as sch`, `answer questions about product features and benefi`, `answer telephone calls to take messages, answer qu`
- **onet_task::human_education_years** (2252 distincts) : `adapt text to accommodate musical requirements of `, `administer highway planning, construction, or main`, `administer online purchasing systems.`, `administer treatments or therapies, such as homeop`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients on market conditions, prices, mortg`, `advise customers on use and care of merchandise.`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and maintain data logs for audio-visual ac`, `analyze and record test data to issue reports that`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze credit data and financial statements to de`, `analyze data to determine answers to questions fro`, `analyze details of sales territories to assess the`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze information processing or computation need`, `analyze information to determine, recommend, and p`, `analyze network data to determine network usage, d`, `analyze or evaluate dental needs to determine chan`, `analyze price proposals, financial reports, and ot`, `analyze training needs to develop new training pro`, `analyze user needs and software requirements to de`, `analyze, interpret, or create graphical representa`, `answer clients' questions about the purposes and d`, `answer customer inquiries or explain cost, availab`, `answer customers' questions about merchandise and `, `answer inquiries pertaining to hotel services, gue`, `answer inquiries regarding information such as sch`, `answer passengers' questions about flights, aircra`, `answer questions about records or files.`, `answer questions and provide future tax planning t`, `answer telephone calls and respond to inquiries or`, `answer telephone calls to take messages, answer qu`
- **onet_task::human_only_ability** (3928 distincts) : `access computerized financial information to answe`, `access computerized financial information to answe`, `act as an intermediary in negotiations between buy`, `act as an intermediary in negotiations between buy`, `adapt teaching methods and instructional materials`, `adapt text to accommodate musical requirements of `, `administer construction contracts.::yes`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise customers of necessary actions and strategi`, `advise customers of necessary actions and strategi`, `advise food service managers and organizations on `, `advise management regarding customer satisfaction,`, `advise patients and their families on nutritional `, `advise retail customers or internal users on the a`, `analyze and evaluate security operations to identi`, `analyze and interpret patient, nursing, or informa`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and record personnel or operational data a`, `analyze and record test data to issue reports that`, `analyze competitive market strategies through anal`, `analyze data from surveys, old records, or case st`, `analyze data such as interview notes, test results`, `analyze data to determine answers to questions fro`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`, `analyze experimental data and interpret results to`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze geographic information systems (gis) data `, `analyze geographic information systems (gis) data `, `analyze information from traffic counting programs`, `analyze information to determine, recommend, and p`, `analyze information to determine, recommend, and p`, `analyze laboratory findings to check the accuracy `, `analyze or synthesize client data to draw conclusi`, `analyze organic or inorganic compounds to determin`
- **onet_task::human_only_time** (2254 distincts) : `act as an intermediary in negotiations between buy`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `advise animal owners regarding sanitary measures, `, `advise clients on financial and legal matters such`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise or assist in obtaining patents or meeting o`, `analyze and interpret news and information receive`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze data from surveys, old records, or case st`, `analyze data such as interview notes, test results`, `analyze developments in specific field to determin`, `analyze employment-related data and prepare requir`, `analyze geographic distributions of physical and c`, `analyze information to determine, recommend, and p`, `analyze job requirements and content to establish `, `analyze or interpret logistics data involving cust`, `analyze performance data to determine effectivenes`, `analyze potential loan markets to find opportuniti`, `analyze prescribing trends to monitor patient comp`, `analyze problems to develop solutions involving co`, `analyze records, reports, test results, or examina`, `analyze the layout, instrumentation, or function o`, `analyze trends in sales prices, construction costs`, `answer customers' questions about products, prices`, `answer customers' questions about products, prices`, `answer inquiries concerning the progress of medica`, `answer inquiries from current or prospective custo`, `answer questions regarding examinations, eligibili`, `answer telephones and give information to callers,`, `answer telephones and schedule appointments.`, `answer telephones, responding to questions or requ`, `apply customer feedback to service improvement eff`, `appraise property values, assessing income potenti`, `arrange reservations for patrons of dining establi`, `assemble and compile documents for loan closings, `, `assess risks to mitigate potential consequences of`, `assess staffing needs and recruit staff, using met`
- **onet_task::human_with_ai_time** (2253 distincts) : `review scientific proposals and research papers.`, `review sets of photographs to select the best work`, `review written, audio, or video copy and correct e`, `review, evaluate, and approve specifications for i`, `schedule and make appointments.`, `schedule appointments and maintain and update appo`, `schedule or dispatch workers, work crews, equipmen`, `schedule patients for treatment times.`, `search scientific literature to select and modify `, `search standard reference materials, including onl`, `select and assemble books, materials, supplies, an`, `select and combine the most effective shots of eac`, `select and edit documents for publication and disp`, `select cartographic elements needed for effective `, `select or assist customers in selecting products b`, `select plays, scripts, books, or ideas to be produ`, `select qualified job applicants or refer them to m`, `sell, for a fee, real estate owned by others.`, `serve as liaisons between organizations, sharehold`, `solicit new business.`, `specify food portions and courses, production and `, `specify users and user access levels for each segm`, `study and analyze information about alternative co`, `study aquatic plants and animals and environmental`, `study blueprints, design specifications, or manufa`, `study documentation or other information for new s`, `suggest specific product purchases to meet custome`, `summarize pertinent legal or insurance details, or`, `take quote requests or orders from dealers or cust`, `tell jokes, perform comic dances, songs and skits,`, `test experimental models under simulated operating`, `test software systems or applications for software`, `test, maintain, and monitor computer programs and `, `track and analyze factors that affect price moveme`, `track program budgets and expenses and campaign re`, `track, compile, and analyze web site usage data.`, `train users and answer questions.`, `transcribe recorded proceedings in accordance with`, `troubleshoot network or connectivity problems for `, `type, file, and duplicate materials.`
- **onet_task::multitasking** (3706 distincts) : `act as an intermediary in negotiations between buy`, `adapt teaching methods and instructional materials`, `administer and score applicant and employee aptitu`, `administer document and system access rights and r`, `administer document and system access rights and r`, `administer treatments or therapies, such as homeop`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::not_classified`, `advise animal owners regarding sanitary measures, `, `advise clients on financial and legal matters such`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers on use and care of merchandise.::`, `advise farmers and demonstrate techniques in areas`, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise patients and their families on nutritional `, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and classify risks and investments to dete`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and interpret patients' histories, symptom`, `analyze and interpret patients' histories, symptom`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze characteristics of animals to identify and`, `analyze computer and information technologies to d`, `analyze credit data and financial statements to de`, `analyze data such as interview notes, test results`, `analyze data to assess distance learning program s`, `analyze data to determine validity, quality, and s`, `analyze details of sales territories to assess the`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`, `analyze equipment performance records to assess eq`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`
- **onet_task::prompt_tokens** (2252 distincts) : `accompany buyers during visits to and inspections `, `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and maintain data logs for audio-visual ac`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or synthesize client data to draw conclusi`, `analyze performance data to determine effectivenes`, `analyze problems to develop solutions involving co`, `analyze target companies or investment opportuniti`, `analyze the probable outcomes of cases, using know`, `analyze training needs to design employee developm`, `analyze, interpret, or create graphical representa`, `answer applicants' questions about benefits and cl`, `answer clients' questions regarding construction w`, `answer customers' questions, and explain available`, `answer customers' questions, and provide informati`, `answer inquiries from the public concerning animal`, `answer inquiries regarding information such as sch`, `answer questions about product features and benefi`, `answer telephone calls to take messages, answer qu`
- **onet_task::task_success** (4059 distincts) : `act as an intermediary in negotiations between buy`, `act as an intermediary in negotiations between buy`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `address the relationships of quantities, magnitude`, `administer and score applicant and employee aptitu`, `administer construction contracts.::not_classified`, `administer document and system access rights and r`, `administer document and system access rights and r`, `administer standardized ability and achievement te`, `advise and teach students.::not_classified`, `advise animal owners regarding sanitary measures, `, `advise animal owners regarding sanitary measures, `, `advise clients on how they could be helped by coun`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers on use and care of merchandise.::`, `advise or assist in obtaining patents or meeting o`, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and interpret news and information receive`, `analyze and interpret patients' histories, symptom`, `analyze and modify compensation and benefits polic`, `analyze and record test data to issue reports that`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze characteristics of animals to identify and`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze credit data and financial statements to de`, `analyze data such as interview notes, test results`, `analyze data to assess distance learning program s`, `analyze details of sales territories to assess the`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`, `analyze electronics system requirements, capacity,`, `analyze equipment performance records to assess eq`, `analyze financial information obtained from client`, `analyze geographic distributions of physical and c`, `analyze information processing or computation need`
- **onet_task::use_case** (4878 distincts) : `act as an intermediary in negotiations between buy`, `adapt instructional content or delivery methods fo`, `adapt teaching methods and instructional materials`, `address the relationships of quantities, magnitude`, `administer and score applicant and employee aptitu`, `administer document and system access rights and r`, `administer highway planning, construction, or main`, `administer online purchasing systems.::work`, `administer standardized ability and achievement te`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::not_classified`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on market conditions, prices, mortg`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers on use and care of merchandise.::`, `advise farmers and demonstrate techniques in areas`, `advise management concerning personnel, managerial`, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise retail customers or internal users on the a`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and evaluate security operations to identi`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret data to increase the underst`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze and interpret results from tests such as m`, `analyze and maintain data logs for audio-visual ac`, `analyze and modify compensation and benefits polic`, `analyze and record personnel or operational data a`, `analyze building codes, by-laws, space and site re`, `analyze characteristics of animals to identify and`
- **request** (423 distincts) : `not_classified`, `Develop and debug blockchain applications, smart c`, `Build and manage subscription billing and membersh`, `Debug and configure containerized applications and`, `Develop and use AI systems for tax document proces`, `Extract and structure financial data from document`, `Process and extract information from business and `, `Extract and structure data from insurance policy d`, `Analyze social media for sentiment, toxicity, and `, `Develop and debug image/video processing and compu`, `Remove unused and deprecated code from software co`, `Debug and implement GraphQL APIs and graph data st`, `Debug and fix payment processing system integratio`, `Provide customer support across payment, telecom, `, `Execute file operations and shell commands through`, `Conduct automated security and code quality review`, `Create and refine professional business presentati`, `Debug and implement API authentication systems and`, `Debug and implement backend API pagination, perfor`, `Debug and fix bugs in data visualization charts an`, `Debug and fix bugs in mathematical and scientific `, `Debug and fix bugs in parsing libraries and langua`, `Debug and implement PDF generation, conversion, pr`, `Debug and fix software bugs and technical issues i`, `Assist with video editing tasks and video producti`, `Debug and fix web application build and compilatio`, `Debug and fix workflow automation integration and `, `Analyze, compare, extract, and configure product a`, `Debug and refactor configuration files and setting`, `Design, build, and debug workflow automation and A`, `Develop and debug chat and messaging application f`, `Debug and develop React applications with componen`, `Assist with cybersecurity operations, security too`, `Create and modify technical visualizations, diagra`, `Debug audio software systems and perform audio fil`, `Debug and fix bugs in Python data analysis librari`, `Develop and customize customer relationship manage`, `Debug and fix date, time, and timestamp handling b`, `Debug and fix authentication and login issues in w`, `Analyze emails and draft replies for business corr`
- **request::ai_autonomy** (439 distincts) : `Analyze social media for sentiment, toxicity, and `, `Develop and debug blockchain applications, smart c`, `Debug and implement GraphQL APIs and graph data st`, `Build and manage subscription billing and membersh`, `Debug and fix payment processing system integratio`, `Extract and structure financial data from document`, `Remove unused and deprecated code from software co`, `Debug and configure containerized applications and`, `Develop and use AI systems for tax document proces`, `Execute file operations and shell commands through`, `Develop and debug image/video processing and compu`, `Extract and structure data from insurance policy d`, `Process and extract information from business and `, `Provide customer support across payment, telecom, `, `Assist with renewable energy and electricity marke`, `Automate web browser testing and form interactions`, `Build and maintain invoice processing systems and `, `Debug and fix software bugs across multiple codeba`, `Build gaming industry websites and manage game-rel`, `Conduct security audits and vulnerability analyses`, `Configure and troubleshoot load balancers, proxies`, `Convert diverse document and data sources into str`, `Debug and fix failing automated tests and test inf`, `Debug and develop machine learning code, infrastru`, `Analyze and triage cybersecurity threats, alerts, `, `Debug and fix bugs in chat/messaging application s`, `Debug and fix failing automated software tests acr`, `Analyze and generate technical documentation for i`, `Debug and fix text encoding, Unicode, and characte`, `Debug and fix database errors in backend applicati`, `Debug and implement search and indexing functional`, `Debug and fix software bugs including crashes, mem`, `Analyze and structure financial documents into for`, `Assist with software project planning, specificati`, `Debug and fix type checking, type safety, and type`, `Debug and implement database migration scripts and`, `Debug and implement keyboard input, focus manageme`, `Correct ASR transcripts and assign voice actors fo`, `Debug data display issues where database records d`, `Analyze and extract information from provided imag`
- **request::ai_education_years** (422 distincts) : `Develop and debug blockchain applications, smart c`, `Extract and structure financial data from document`, `Debug and fix payment processing system integratio`, `Debug and implement GraphQL APIs and graph data st`, `Remove unused and deprecated code from software co`, `Extract and structure data from insurance policy d`, `Develop and debug image/video processing and compu`, `Analyze social media for sentiment, toxicity, and `, `Process and extract information from business and `, `Build and manage subscription billing and membersh`, `Debug and configure containerized applications and`, `Execute file operations and shell commands through`, `Develop and use AI systems for tax document proces`, `Provide customer support across payment, telecom, `, `Debug and fix compilation errors and build-blockin`, `Configure and troubleshoot cloud infrastructure, D`, `Create and configure data visualizations, charts, `, `Debug and optimize web application performance and`, `Debug and develop embedded firmware and device dri`, `Debug and fix API and web application HTTP errors `, `Debug and fix CSS styling bugs and layout issues i`, `Automate business data enrichment, CRM workflows, `, `Develop and debug language models and NLP systems`, `Develop and configure AI agent systems and multi-a`, `Build and develop mobile applications with AI codi`, `Design and implement CI/CD pipelines and deploymen`, `Design and build complete websites and web applica`, `Automate property management and HOA administrativ`, `Debug and fix package dependencies and build confi`, `Debug and fix file upload/download features in web`, `Debug and fix data type, serialization, and valida`, `Analyze codebases and execute software development`, `Develop and debug transportation and mobility book`, `Deploy and troubleshoot web applications to produc`, `Debug and fix mobile application UI layout and sty`, `Debug and develop business and analytics dashboard`, `Debug and fix file system operations and path hand`, `Debug and fix URL routing, navigation, and redirec`, `Develop and debug trading software applications an`, `Conduct automated code reviews and manage pull req`
- **request::collaboration** (2483 distincts) : `Develop and debug image/video processing and compu`, `Process and extract information from business and `, `Debug and fix payment processing system integratio`, `Process and extract information from business and `, `Develop and debug image/video processing and compu`, `Debug and configure containerized applications and`, `Remove unused and deprecated code from software co`, `Process and extract information from business and `, `Develop and debug blockchain applications, smart c`, `Remove unused and deprecated code from software co`, `Execute file operations and shell commands through`, `Remove unused and deprecated code from software co`, `Debug and implement GraphQL APIs and graph data st`, `Build and manage subscription billing and membersh`, `Debug and configure containerized applications and`, `Develop and debug image/video processing and compu`, `Provide customer support across payment, telecom, `, `Debug and fix payment processing system integratio`, `Extract and structure data from insurance policy d`, `Develop and use AI systems for tax document proces`, `Develop and debug image/video processing and compu`, `Extract and structure data from insurance policy d`, `Develop and debug blockchain applications, smart c`, `Execute file operations and shell commands through`, `Process and extract information from business and `, `Analyze social media for sentiment, toxicity, and `, `Debug and implement GraphQL APIs and graph data st`, `Analyze social media for sentiment, toxicity, and `, `Develop and use AI systems for tax document proces`, `Extract and structure financial data from document`, `Develop and use AI systems for tax document proces`, `Extract and structure data from insurance policy d`, `Build and manage subscription billing and membersh`, `Remove unused and deprecated code from software co`, `Execute file operations and shell commands through`, `Analyze social media for sentiment, toxicity, and `, `Debug and implement GraphQL APIs and graph data st`, `Extract and structure data from insurance policy d`, `Process and extract information from business and `, `Develop and debug image/video processing and compu`
- **request::completion_tokens** (422 distincts) : `Extract and structure financial data from document`, `Extract and structure data from insurance policy d`, `Develop and debug blockchain applications, smart c`, `Analyze social media for sentiment, toxicity, and `, `Debug and configure containerized applications and`, `Debug and implement GraphQL APIs and graph data st`, `Execute file operations and shell commands through`, `Process and extract information from business and `, `Build and manage subscription billing and membersh`, `Debug and fix payment processing system integratio`, `Remove unused and deprecated code from software co`, `Develop and use AI systems for tax document proces`, `Provide customer support across payment, telecom, `, `Develop and debug image/video processing and compu`, `Configure and develop workflow automation system i`, `Debug and develop business and analytics dashboard`, `Debug and develop embedded firmware and device dri`, `Develop and test customer service chatbot systems `, `Debug and fix 3D graphics rendering and shader cod`, `Debug and fix UI interaction and visual feedback b`, `Debug and fix bugs in data visualization charts an`, `Debug and fix concurrency bugs in distributed task`, `Debug and implement PDF generation, conversion, pr`, `Debug and fix file system operations and path hand`, `Automate business data enrichment, CRM workflows, `, `Debug and fix technical issues in video game devel`, `Debug and fix mobile app build and compilation err`, `Assist with database development, SQL queries, sch`, `Develop and debug language models and NLP systems:`, `Debug and fix web application build and compilatio`, `Debug and fix workflow automation integration and `, `Debug and develop machine learning code, infrastru`, `Assist with fashion and clothing e-commerce operat`, `Debug and create automated tests for database func`, `Develop and debug personal finance management web `, `Develop and debug web scraping code and automation`, `Develop and enhance location-based applications wi`, `Develop and modify full-stack business web applica`, `Debug and write automated web application tests an`, `Analyze market research data and customer feedback`
- **request::cost** (422 distincts) : `Debug and implement GraphQL APIs and graph data st`, `Provide customer support across payment, telecom, `, `Debug and configure containerized applications and`, `Develop and use AI systems for tax document proces`, `Develop and debug image/video processing and compu`, `Extract and structure financial data from document`, `Remove unused and deprecated code from software co`, `Build and manage subscription billing and membersh`, `Execute file operations and shell commands through`, `Debug and fix payment processing system integratio`, `Extract and structure data from insurance policy d`, `Process and extract information from business and `, `Analyze social media for sentiment, toxicity, and `, `Develop and debug blockchain applications, smart c`, `Create and design complete websites with full desi`, `Debug and develop React applications with componen`, `Debug and develop video software applications and `, `Develop and debug trading software applications an`, `Debug and develop web application image display an`, `Debug and fix API and web application HTTP errors `, `Debug and fix UI component display and interaction`, `Debug and fix bugs in Python data analysis librari`, `Debug, monitor, and configure network infrastructu`, `Debug and fix file upload/download features in web`, `Analyze, compare, extract, and configure product a`, `Debug and implement search and indexing functional`, `Debug and fix package dependencies and build confi`, `Analyze codebase structure and refactor directory `, `Develop and debug data table components and genera`, `Debug and optimize system performance, memory usag`, `Debug, fix, refactor, and develop Python code and `, `Debug and develop web application code for address`, `Analyze codebases and execute software development`, `Create and refine professional business presentati`, `Develop and debug financial accounting software an`, `Develop and debug healthcare software applications`, `Develop and debug networking protocols and distrib`, `Develop and debug reservation/booking management s`, `Design and implement CI/CD pipelines and deploymen`, `Analyze and extract structured data from cryptocur`
- **request::human_education_years** (422 distincts) : `Analyze social media for sentiment, toxicity, and `, `Extract and structure financial data from document`, `Process and extract information from business and `, `Extract and structure data from insurance policy d`, `Remove unused and deprecated code from software co`, `Debug and implement GraphQL APIs and graph data st`, `Provide customer support across payment, telecom, `, `Debug and fix payment processing system integratio`, `Build and manage subscription billing and membersh`, `Develop and debug image/video processing and compu`, `Debug and configure containerized applications and`, `Execute file operations and shell commands through`, `Develop and use AI systems for tax document proces`, `Develop and debug blockchain applications, smart c`, `Debug and fix compilation errors and build-blockin`, `Configure and troubleshoot cloud infrastructure, D`, `Create and configure data visualizations, charts, `, `Debug and optimize web application performance and`, `Debug and develop embedded firmware and device dri`, `Debug and fix API and web application HTTP errors `, `Debug and fix CSS styling bugs and layout issues i`, `Automate business data enrichment, CRM workflows, `, `Develop and debug language models and NLP systems`, `Develop and configure AI agent systems and multi-a`, `Build and develop mobile applications with AI codi`, `Design and implement CI/CD pipelines and deploymen`, `Design and build complete websites and web applica`, `Automate property management and HOA administrativ`, `Debug and fix package dependencies and build confi`, `Debug and fix file upload/download features in web`, `Debug and fix data type, serialization, and valida`, `Analyze codebases and execute software development`, `Develop and debug transportation and mobility book`, `Deploy and troubleshoot web applications to produc`, `Debug and fix mobile application UI layout and sty`, `Debug and develop business and analytics dashboard`, `Debug and fix file system operations and path hand`, `Debug and fix URL routing, navigation, and redirec`, `Develop and debug trading software applications an`, `Conduct automated code reviews and manage pull req`
- **request::human_only_ability** (838 distincts) : `Remove unused and deprecated code from software co`, `Develop and debug blockchain applications, smart c`, `Analyze social media for sentiment, toxicity, and `, `Provide customer support across payment, telecom, `, `Process and extract information from business and `, `Analyze social media for sentiment, toxicity, and `, `Extract and structure financial data from document`, `Provide customer support across payment, telecom, `, `Debug and implement GraphQL APIs and graph data st`, `Develop and debug image/video processing and compu`, `Remove unused and deprecated code from software co`, `Execute file operations and shell commands through`, `Develop and debug image/video processing and compu`, `Build and manage subscription billing and membersh`, `Debug and fix payment processing system integratio`, `Extract and structure financial data from document`, `Process and extract information from business and `, `Debug and configure containerized applications and`, `Extract and structure data from insurance policy d`, `Develop and debug blockchain applications, smart c`, `Execute file operations and shell commands through`, `Debug and implement GraphQL APIs and graph data st`, `Debug and fix payment processing system integratio`, `Develop and use AI systems for tax document proces`, `Extract and structure data from insurance policy d`, `Debug and configure containerized applications and`, `Build and manage subscription billing and membersh`, `Develop and use AI systems for tax document proces`, `Convert diverse document and data sources into str`, `Debug and develop video software applications and `, `Debug and develop embedded firmware and device dri`, `Conduct automated security and code quality review`, `Classify and categorize emails into predefined lab`, `Debug and create automated tests for database func`, `Debug and develop video software applications and `, `Configure and develop workflow automation system i`, `Create and modify technical visualizations, diagra`, `Build fitness software applications and analyze at`, `Debug and fix failing automated software tests acr`, `Complete humanities and social sciences academic a`
- **request::human_only_time** (422 distincts) : `Debug and implement GraphQL APIs and graph data st`, `Develop and debug blockchain applications, smart c`, `Debug and configure containerized applications and`, `Develop and use AI systems for tax document proces`, `Extract and structure financial data from document`, `Debug and fix payment processing system integratio`, `Build and manage subscription billing and membersh`, `Analyze social media for sentiment, toxicity, and `, `Develop and debug image/video processing and compu`, `Provide customer support across payment, telecom, `, `Remove unused and deprecated code from software co`, `Extract and structure data from insurance policy d`, `Process and extract information from business and `, `Execute file operations and shell commands through`, `Assist with renewable energy and electricity marke`, `Automate web browser testing and form interactions`, `Build and maintain invoice processing systems and `, `Debug and fix software bugs across multiple codeba`, `Build gaming industry websites and manage game-rel`, `Conduct security audits and vulnerability analyses`, `Configure and troubleshoot load balancers, proxies`, `Convert diverse document and data sources into str`, `Debug and fix failing automated tests and test inf`, `Debug and develop machine learning code, infrastru`, `Analyze and triage cybersecurity threats, alerts, `, `Debug and fix bugs in chat/messaging application s`, `Debug and fix failing automated software tests acr`, `Analyze and generate technical documentation for i`, `Debug and fix text encoding, Unicode, and characte`, `Debug and fix database errors in backend applicati`, `Debug and implement search and indexing functional`, `Debug and fix software bugs including crashes, mem`, `Analyze and structure financial documents into for`, `Assist with software project planning, specificati`, `Debug and fix type checking, type safety, and type`, `Debug and implement database migration scripts and`, `Debug and implement keyboard input, focus manageme`, `Correct ASR transcripts and assign voice actors fo`, `Debug data display issues where database records d`, `Analyze and extract information from provided imag`
- **request::human_with_ai_time** (422 distincts) : `Develop and debug image/video processing and compu`, `Develop and debug blockchain applications, smart c`, `Debug and implement GraphQL APIs and graph data st`, `Build and manage subscription billing and membersh`, `Debug and fix payment processing system integratio`, `Debug and configure containerized applications and`, `Execute file operations and shell commands through`, `Remove unused and deprecated code from software co`, `Develop and use AI systems for tax document proces`, `Extract and structure financial data from document`, `Analyze social media for sentiment, toxicity, and `, `Extract and structure data from insurance policy d`, `Process and extract information from business and `, `Provide customer support across payment, telecom, `, `Assist with renewable energy and electricity marke`, `Automate web browser testing and form interactions`, `Build and maintain invoice processing systems and `, `Debug and fix software bugs across multiple codeba`, `Build gaming industry websites and manage game-rel`, `Conduct security audits and vulnerability analyses`, `Configure and troubleshoot load balancers, proxies`, `Convert diverse document and data sources into str`, `Debug and fix failing automated tests and test inf`, `Debug and develop machine learning code, infrastru`, `Analyze and triage cybersecurity threats, alerts, `, `Debug and fix bugs in chat/messaging application s`, `Debug and fix failing automated software tests acr`, `Analyze and generate technical documentation for i`, `Debug and fix text encoding, Unicode, and characte`, `Debug and fix database errors in backend applicati`, `Debug and implement search and indexing functional`, `Debug and fix software bugs including crashes, mem`, `Analyze and structure financial documents into for`, `Assist with software project planning, specificati`, `Debug and fix type checking, type safety, and type`, `Debug and implement database migration scripts and`, `Debug and implement keyboard input, focus manageme`, `Correct ASR transcripts and assign voice actors fo`, `Debug data display issues where database records d`, `Analyze and extract information from provided imag`
- **request::multitasking** (844 distincts) : `Debug and fix payment processing system integratio`, `Debug and configure containerized applications and`, `Extract and structure data from insurance policy d`, `Extract and structure financial data from document`, `Develop and use AI systems for tax document proces`, `Build and manage subscription billing and membersh`, `Extract and structure data from insurance policy d`, `Debug and fix payment processing system integratio`, `Debug and configure containerized applications and`, `Debug and implement GraphQL APIs and graph data st`, `Develop and debug blockchain applications, smart c`, `Debug and implement GraphQL APIs and graph data st`, `Execute file operations and shell commands through`, `Provide customer support across payment, telecom, `, `Develop and debug blockchain applications, smart c`, `Process and extract information from business and `, `Provide customer support across payment, telecom, `, `Develop and debug image/video processing and compu`, `Execute file operations and shell commands through`, `Remove unused and deprecated code from software co`, `Develop and use AI systems for tax document proces`, `Analyze social media for sentiment, toxicity, and `, `Process and extract information from business and `, `Analyze social media for sentiment, toxicity, and `, `Build and manage subscription billing and membersh`, `Remove unused and deprecated code from software co`, `Develop and debug image/video processing and compu`, `Build and operate AI-powered social media content `, `Build complete business web applications and softw`, `Assist with fashion and clothing e-commerce operat`, `Assist with cybersecurity operations, security too`, `Build and test food-related data systems, ML model`, `Build recruitment systems and process candidate re`, `Analyze mortgage and loan applications for underwr`, `Build complete business web applications and softw`, `Assist with academic research tasks including stat`, `Complete humanities and social sciences academic a`, `Assist with video editing tasks and video producti`, `Analyze, compare, extract, and configure product a`, `Assist with software project planning, specificati`
- **request::prompt_tokens** (422 distincts) : `Debug and fix payment processing system integratio`, `Provide customer support across payment, telecom, `, `Remove unused and deprecated code from software co`, `Execute file operations and shell commands through`, `Extract and structure financial data from document`, `Develop and debug image/video processing and compu`, `Build and manage subscription billing and membersh`, `Develop and use AI systems for tax document proces`, `Debug and configure containerized applications and`, `Develop and debug blockchain applications, smart c`, `Debug and implement GraphQL APIs and graph data st`, `Process and extract information from business and `, `Extract and structure data from insurance policy d`, `Analyze social media for sentiment, toxicity, and `, `Create and design complete websites with full desi`, `Debug and develop React applications with componen`, `Debug and develop video software applications and `, `Develop and debug trading software applications an`, `Debug and develop web application image display an`, `Debug and fix API and web application HTTP errors `, `Debug and fix UI component display and interaction`, `Debug and fix bugs in Python data analysis librari`, `Debug, monitor, and configure network infrastructu`, `Debug and fix file upload/download features in web`, `Analyze, compare, extract, and configure product a`, `Debug and implement search and indexing functional`, `Debug and fix package dependencies and build confi`, `Analyze codebase structure and refactor directory `, `Develop and debug data table components and genera`, `Debug and optimize system performance, memory usag`, `Debug, fix, refactor, and develop Python code and `, `Debug and develop web application code for address`, `Analyze codebases and execute software development`, `Create and refine professional business presentati`, `Develop and debug financial accounting software an`, `Develop and debug healthcare software applications`, `Develop and debug networking protocols and distrib`, `Develop and debug reservation/booking management s`, `Design and implement CI/CD pipelines and deploymen`, `Analyze and extract structured data from cryptocur`
- **request::task_success** (844 distincts) : `Develop and debug image/video processing and compu`, `Analyze social media for sentiment, toxicity, and `, `Execute file operations and shell commands through`, `Debug and implement GraphQL APIs and graph data st`, `Develop and use AI systems for tax document proces`, `Build and manage subscription billing and membersh`, `Extract and structure data from insurance policy d`, `Debug and fix payment processing system integratio`, `Debug and configure containerized applications and`, `Debug and configure containerized applications and`, `Build and manage subscription billing and membersh`, `Develop and debug blockchain applications, smart c`, `Execute file operations and shell commands through`, `Provide customer support across payment, telecom, `, `Develop and debug blockchain applications, smart c`, `Process and extract information from business and `, `Extract and structure financial data from document`, `Provide customer support across payment, telecom, `, `Develop and debug image/video processing and compu`, `Extract and structure data from insurance policy d`, `Debug and implement GraphQL APIs and graph data st`, `Process and extract information from business and `, `Analyze social media for sentiment, toxicity, and `, `Remove unused and deprecated code from software co`, `Remove unused and deprecated code from software co`, `Develop and use AI systems for tax document proces`, `Debug and fix payment processing system integratio`, `Extract and structure financial data from document`, `Assist with video editing tasks and video producti`, `Build complete business web applications and softw`, `Build and test food-related data systems, ML model`, `Assist with fashion and clothing e-commerce operat`, `Classify and extract structured information from b`, `Analyze, compare, extract, and configure product a`, `Build complete business web applications and softw`, `Assist with software project planning, specificati`, `Conduct automated code reviews and manage pull req`, `Analyze, extract, structure, and generate legal do`, `Build recruitment systems and process candidate re`, `Assist with cybersecurity operations, security too`
- **request::use_case** (1307 distincts) : `Execute file operations and shell commands through`, `Debug and fix payment processing system integratio`, `Develop and use AI systems for tax document proces`, `Debug and implement GraphQL APIs and graph data st`, `Build and manage subscription billing and membersh`, `Analyze social media for sentiment, toxicity, and `, `Build and manage subscription billing and membersh`, `Develop and debug image/video processing and compu`, `Extract and structure data from insurance policy d`, `Provide customer support across payment, telecom, `, `Debug and fix payment processing system integratio`, `Develop and use AI systems for tax document proces`, `Develop and debug blockchain applications, smart c`, `Execute file operations and shell commands through`, `Develop and debug blockchain applications, smart c`, `Remove unused and deprecated code from software co`, `Analyze social media for sentiment, toxicity, and `, `Extract and structure financial data from document`, `Develop and use AI systems for tax document proces`, `Extract and structure data from insurance policy d`, `Develop and debug blockchain applications, smart c`, `Debug and configure containerized applications and`, `Analyze social media for sentiment, toxicity, and `, `Develop and debug image/video processing and compu`, `Debug and configure containerized applications and`, `Develop and debug image/video processing and compu`, `Analyze social media for sentiment, toxicity, and `, `Debug and implement GraphQL APIs and graph data st`, `Process and extract information from business and `, `Execute file operations and shell commands through`, `Process and extract information from business and `, `Provide customer support across payment, telecom, `, `Execute file operations and shell commands through`, `Debug and fix payment processing system integratio`, `Build and manage subscription billing and membersh`, `Remove unused and deprecated code from software co`, `Debug and implement GraphQL APIs and graph data st`, `Remove unused and deprecated code from software co`, `Provide customer support across payment, telecom, `, `Debug and configure containerized applications and`
- **task_success** (2 distincts) : `no`, `yes`
- **use_case** (4 distincts) : `personal`, `coursework`, `work`, `not_classified`

Lignes pour les pays étudiés : 

Premières lignes :

```
   geo_id geography date_start   date_end platform_and_product        facet  level                   variable cluster_name          value
0  GLOBAL    global 2025-11-13 2025-11-20               1P API  ai_autonomy      0          ai_autonomy_count         None  971450.000000
1  GLOBAL    global 2025-11-13 2025-11-20               1P API  ai_autonomy      0           ai_autonomy_mean         None       2.843552
2  GLOBAL    global 2025-11-13 2025-11-20               1P API  ai_autonomy      0  ai_autonomy_mean_ci_lower         None       2.841252
3  GLOBAL    global 2025-11-13 2025-11-20               1P API  ai_autonomy      0  ai_autonomy_mean_ci_upper         None       2.845772
4  GLOBAL    global 2025-11-13 2025-11-20               1P API  ai_autonomy      0         ai_autonomy_median         None       3.000000
```

### `release_2026_01_15/data/intermediate/aei_raw_claude_ai_2025-11-13_to_2025-11-20.csv`

- Lignes : 458 778
- Taille : 89.7 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 1266 | 0 | `GLOBAL` (264808), `US` (4486), `IN` (2348), `US-CA` (2340), `GB` (2162), `JP` (2092), `GB-ENG` (2088), `FR` (2078), … |
| `geography` | VARCHAR | 3 | 0 | `global` (264808), `country-state` (129460), `country` (64510) |
| `date_start` | DATE | 1 | 0 | `2025-11-13` (458778) |
| `date_end` | DATE | 1 | 0 | `2025-11-20` (458778) |
| `platform_and_product` | VARCHAR | 1 | 0 | `Claude AI (Free and Pro)` (458778) |
| `facet` | VARCHAR | 34 | 0 | `request` (89726), `onet_task` (35510), `onet_task::human_only_time` (28533), `onet_task::human_with_ai_time` (28527), `onet_task::ai_education_years` (28521), `onet_task::ai_autonomy` (28521), `onet_task::human_education_years` (28521), `onet_task::collaboration` (16778), `onet_task::use_case` (13908), `onet_task::multitasking` (11830), `onet_task::task_success` (11540), `onet_task::human_only_ability` (11074), `human_with_ai_time` (9290), `human_only_time` (9290), `ai_education_years` (9282), `human_education_years` (9282), `ai_autonomy` (9250), `collaboration` (8850), `request::collaboration` (8832), `use_case` (5986), `request::human_only_time` (5293), `request::human_with_ai_time` (5263), `request::ai_autonomy` (5257), `request::ai_education_years` (5257), `request::human_education_years` (5257), `request::use_case` (4782), `multitasking` (4450), `human_only_ability` (4420), `task_success` (4218), `request::task_success` (3004), `request::human_only_ability` (3002), `request::multitasking` (2994), `country-state` (2182), `country` (348) |
| `level` | BIGINT | 3 | 0 | `0` (400164), `1` (38969), `2` (19645) |
| `variable` | VARCHAR | 166 | 0 | `request_count` (44863), `request_pct` (44863), `onet_task_pct` (17755), `onet_task_count` (17755), `onet_task_collaboration_pct` (8389), `onet_task_collaboration_count` (8389), `onet_task_use_case_count` (6954), `onet_task_use_case_pct` (6954), … |
| `cluster_name` | VARCHAR | 31057 | 48730 | `None` (48730), `not_classified` (8118), `yes` (5486), `no` (5362), `work` (1866), `personal` (1780), `directive` (1750), `task iteration` (1674), … |
| `value` | DOUBLE | 179358 | 0 | `100.0` (23389), `16.0` (7107), `15.0` (6200), `12.0` (5591), `4.0` (4884), `18.0` (4714), `17.0` (4580), `19.0` (3830), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| country | ai_autonomy | 1384 |
| country | ai_education_years | 1384 |
| country | collaboration | 1636 |
| country | country | 348 |
| country | human_education_years | 1384 |
| country | human_only_ability | 678 |
| country | human_only_time | 1384 |
| country | human_with_ai_time | 1384 |
| country | multitasking | 682 |
| country | onet_task | 14580 |
| country | request | 37960 |
| country | task_success | 672 |
| country | use_case | 1034 |
| country-state | ai_autonomy | 7848 |
| country-state | ai_education_years | 7848 |
| country-state | collaboration | 7202 |
| country-state | country-state | 2182 |
| country-state | human_education_years | 7848 |
| country-state | human_only_ability | 3738 |
| country-state | human_only_time | 7848 |
| country-state | human_with_ai_time | 7848 |
| country-state | multitasking | 3764 |
| country-state | onet_task | 14590 |
| country-state | request | 50258 |
| country-state | task_success | 3542 |
| country-state | use_case | 4944 |
| global | ai_autonomy | 18 |
| global | ai_education_years | 50 |
| global | collaboration | 12 |
| global | human_education_years | 50 |
| global | human_only_ability | 4 |
| global | human_only_time | 58 |
| global | human_with_ai_time | 58 |
| global | multitasking | 4 |
| global | onet_task | 6340 |
| global | onet_task::ai_autonomy | 28521 |
| global | onet_task::ai_education_years | 28521 |
| global | onet_task::collaboration | 16778 |
| global | onet_task::human_education_years | 28521 |
| global | onet_task::human_only_ability | 11074 |
| global | onet_task::human_only_time | 28533 |
| global | onet_task::human_with_ai_time | 28527 |
| global | onet_task::multitasking | 11830 |
| global | onet_task::task_success | 11540 |
| global | onet_task::use_case | 13908 |
| global | request | 1508 |
| global | request::ai_autonomy | 5257 |
| global | request::ai_education_years | 5257 |
| global | request::collaboration | 8832 |
| global | request::human_education_years | 5257 |
| global | request::human_only_ability | 3002 |
| global | request::human_only_time | 5293 |
| global | request::human_with_ai_time | 5263 |
| global | request::multitasking | 2994 |
| global | request::task_success | 3004 |
| global | request::use_case | 4782 |
| global | task_success | 4 |
| global | use_case | 8 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| ai_autonomy | ai_autonomy_count | 1155 |
| ai_autonomy | ai_autonomy_histogram_count | 5 |
| ai_autonomy | ai_autonomy_histogram_pct | 5 |
| ai_autonomy | ai_autonomy_mean | 1155 |
| ai_autonomy | ai_autonomy_mean_ci_lower | 1155 |
| ai_autonomy | ai_autonomy_mean_ci_upper | 1155 |
| ai_autonomy | ai_autonomy_median | 1155 |
| ai_autonomy | ai_autonomy_median_ci_lower | 1155 |
| ai_autonomy | ai_autonomy_median_ci_upper | 1155 |
| ai_autonomy | ai_autonomy_stdev | 1155 |
| ai_education_years | ai_education_years_count | 1155 |
| ai_education_years | ai_education_years_histogram_count | 21 |
| ai_education_years | ai_education_years_histogram_pct | 21 |
| ai_education_years | ai_education_years_mean | 1155 |
| ai_education_years | ai_education_years_mean_ci_lower | 1155 |
| ai_education_years | ai_education_years_mean_ci_upper | 1155 |
| ai_education_years | ai_education_years_median | 1155 |
| ai_education_years | ai_education_years_median_ci_lower | 1155 |
| ai_education_years | ai_education_years_median_ci_upper | 1155 |
| ai_education_years | ai_education_years_stdev | 1155 |
| collaboration | collaboration_count | 4425 |
| collaboration | collaboration_pct | 4425 |
| country | usage_count | 174 |
| country | usage_pct | 174 |
| country-state | usage_count | 1091 |
| country-state | usage_pct | 1091 |
| human_education_years | human_education_years_count | 1155 |
| human_education_years | human_education_years_histogram_count | 21 |
| human_education_years | human_education_years_histogram_pct | 21 |
| human_education_years | human_education_years_mean | 1155 |
| human_education_years | human_education_years_mean_ci_lower | 1155 |
| human_education_years | human_education_years_mean_ci_upper | 1155 |
| human_education_years | human_education_years_median | 1155 |
| human_education_years | human_education_years_median_ci_lower | 1155 |
| human_education_years | human_education_years_median_ci_upper | 1155 |
| human_education_years | human_education_years_stdev | 1155 |
| human_only_ability | human_only_ability_count | 2210 |
| human_only_ability | human_only_ability_pct | 2210 |
| human_only_time | human_only_time_count | 1155 |
| human_only_time | human_only_time_histogram_count | 25 |
| human_only_time | human_only_time_histogram_pct | 25 |
| human_only_time | human_only_time_mean | 1155 |
| human_only_time | human_only_time_mean_ci_lower | 1155 |
| human_only_time | human_only_time_mean_ci_upper | 1155 |
| human_only_time | human_only_time_median | 1155 |
| human_only_time | human_only_time_median_ci_lower | 1155 |
| human_only_time | human_only_time_median_ci_upper | 1155 |
| human_only_time | human_only_time_stdev | 1155 |
| human_with_ai_time | human_with_ai_time_count | 1155 |
| human_with_ai_time | human_with_ai_time_histogram_count | 25 |
| human_with_ai_time | human_with_ai_time_histogram_pct | 25 |
| human_with_ai_time | human_with_ai_time_mean | 1155 |
| human_with_ai_time | human_with_ai_time_mean_ci_lower | 1155 |
| human_with_ai_time | human_with_ai_time_mean_ci_upper | 1155 |
| human_with_ai_time | human_with_ai_time_median | 1155 |
| human_with_ai_time | human_with_ai_time_median_ci_lower | 1155 |
| human_with_ai_time | human_with_ai_time_median_ci_upper | 1155 |
| human_with_ai_time | human_with_ai_time_stdev | 1155 |
| multitasking | multitasking_count | 2225 |
| multitasking | multitasking_pct | 2225 |
| onet_task | onet_task_count | 17755 |
| onet_task | onet_task_pct | 17755 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_count | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_lower | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_upper | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_lower | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_upper | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_pct | 3169 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_stdev | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_count | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_lower | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_upper | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_median | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_lower | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_upper | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_pct | 3169 |
| onet_task::ai_education_years | onet_task_ai_education_years_stdev | 3169 |
| onet_task::collaboration | onet_task_collaboration_count | 8389 |
| onet_task::collaboration | onet_task_collaboration_pct | 8389 |
| onet_task::human_education_years | onet_task_human_education_years_count | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_mean | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_lower | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_upper | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_median | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_lower | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_upper | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_pct | 3169 |
| onet_task::human_education_years | onet_task_human_education_years_stdev | 3169 |
| onet_task::human_only_ability | onet_task_human_only_ability_count | 5537 |
| onet_task::human_only_ability | onet_task_human_only_ability_pct | 5537 |
| onet_task::human_only_time | onet_task_human_only_time_count | 3175 |
| onet_task::human_only_time | onet_task_human_only_time_mean | 3169 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_lower | 3169 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_upper | 3169 |
| onet_task::human_only_time | onet_task_human_only_time_median | 3169 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_lower | 3169 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_upper | 3169 |
| onet_task::human_only_time | onet_task_human_only_time_pct | 3175 |
| onet_task::human_only_time | onet_task_human_only_time_stdev | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_count | 3172 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_lower | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_upper | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_lower | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_upper | 3169 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_pct | 3172 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_stdev | 3169 |
| onet_task::multitasking | onet_task_multitasking_count | 5915 |
| onet_task::multitasking | onet_task_multitasking_pct | 5915 |
| onet_task::task_success | onet_task_task_success_count | 5770 |
| onet_task::task_success | onet_task_task_success_pct | 5770 |
| onet_task::use_case | onet_task_use_case_count | 6954 |
| onet_task::use_case | onet_task_use_case_pct | 6954 |
| request | request_count | 44863 |
| request | request_pct | 44863 |
| request::ai_autonomy | request_ai_autonomy_count | 751 |
| request::ai_autonomy | request_ai_autonomy_mean | 751 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_lower | 751 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_upper | 751 |
| request::ai_autonomy | request_ai_autonomy_median | 751 |
| request::ai_autonomy | request_ai_autonomy_pct | 751 |
| request::ai_autonomy | request_ai_autonomy_stdev | 751 |
| request::ai_education_years | request_ai_education_years_count | 751 |
| request::ai_education_years | request_ai_education_years_mean | 751 |
| request::ai_education_years | request_ai_education_years_mean_ci_lower | 751 |
| request::ai_education_years | request_ai_education_years_mean_ci_upper | 751 |
| request::ai_education_years | request_ai_education_years_median | 751 |
| request::ai_education_years | request_ai_education_years_pct | 751 |
| request::ai_education_years | request_ai_education_years_stdev | 751 |
| request::collaboration | request_collaboration_count | 4416 |
| request::collaboration | request_collaboration_pct | 4416 |
| request::human_education_years | request_human_education_years_count | 751 |
| request::human_education_years | request_human_education_years_mean | 751 |
| request::human_education_years | request_human_education_years_mean_ci_lower | 751 |
| request::human_education_years | request_human_education_years_mean_ci_upper | 751 |
| request::human_education_years | request_human_education_years_median | 751 |
| request::human_education_years | request_human_education_years_pct | 751 |
| request::human_education_years | request_human_education_years_stdev | 751 |
| request::human_only_ability | request_human_only_ability_count | 1501 |
| request::human_only_ability | request_human_only_ability_pct | 1501 |
| request::human_only_time | request_human_only_time_count | 769 |
| request::human_only_time | request_human_only_time_mean | 751 |
| request::human_only_time | request_human_only_time_mean_ci_lower | 751 |
| request::human_only_time | request_human_only_time_mean_ci_upper | 751 |
| request::human_only_time | request_human_only_time_median | 751 |
| request::human_only_time | request_human_only_time_pct | 769 |
| request::human_only_time | request_human_only_time_stdev | 751 |
| request::human_with_ai_time | request_human_with_ai_time_count | 754 |
| request::human_with_ai_time | request_human_with_ai_time_mean | 751 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_lower | 751 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_upper | 751 |
| request::human_with_ai_time | request_human_with_ai_time_median | 751 |
| request::human_with_ai_time | request_human_with_ai_time_pct | 754 |
| request::human_with_ai_time | request_human_with_ai_time_stdev | 751 |
| request::multitasking | request_multitasking_count | 1497 |
| request::multitasking | request_multitasking_pct | 1497 |
| request::task_success | request_task_success_count | 1502 |
| request::task_success | request_task_success_pct | 1502 |
| request::use_case | request_use_case_count | 2391 |
| request::use_case | request_use_case_pct | 2391 |
| task_success | task_success_count | 2109 |
| task_success | task_success_pct | 2109 |
| use_case | use_case_count | 2993 |
| use_case | use_case_pct | 2993 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| ai_autonomy | 0 | 9250 |
| ai_education_years | 0 | 9282 |
| collaboration | 0 | 8850 |
| country | 0 | 348 |
| country-state | 0 | 2182 |
| human_education_years | 0 | 9282 |
| human_only_ability | 0 | 4420 |
| human_only_time | 0 | 9290 |
| human_with_ai_time | 0 | 9290 |
| multitasking | 0 | 4450 |
| onet_task | 0 | 35510 |
| onet_task::ai_autonomy | 0 | 28521 |
| onet_task::ai_education_years | 0 | 28521 |
| onet_task::collaboration | 0 | 16778 |
| onet_task::human_education_years | 0 | 28521 |
| onet_task::human_only_ability | 0 | 11074 |
| onet_task::human_only_time | 0 | 28533 |
| onet_task::human_with_ai_time | 0 | 28527 |
| onet_task::multitasking | 0 | 11830 |
| onet_task::task_success | 0 | 11540 |
| onet_task::use_case | 0 | 13908 |
| request | 0 | 39974 |
| request | 1 | 31650 |
| request | 2 | 18102 |
| request::ai_autonomy | 0 | 4319 |
| request::ai_autonomy | 1 | 777 |
| request::ai_autonomy | 2 | 161 |
| request::ai_education_years | 0 | 4319 |
| request::ai_education_years | 1 | 777 |
| request::ai_education_years | 2 | 161 |
| request::collaboration | 0 | 7226 |
| request::collaboration | 1 | 1330 |
| request::collaboration | 2 | 276 |
| request::human_education_years | 0 | 4319 |
| request::human_education_years | 1 | 777 |
| request::human_education_years | 2 | 161 |
| request::human_only_ability | 0 | 2466 |
| request::human_only_ability | 1 | 444 |
| request::human_only_ability | 2 | 92 |
| request::human_only_time | 0 | 4331 |
| request::human_only_time | 1 | 789 |
| request::human_only_time | 2 | 173 |
| request::human_with_ai_time | 0 | 4321 |
| request::human_with_ai_time | 1 | 779 |
| request::human_with_ai_time | 2 | 163 |
| request::multitasking | 0 | 2458 |
| request::multitasking | 1 | 444 |
| request::multitasking | 2 | 92 |
| request::task_success | 0 | 2468 |
| request::task_success | 1 | 444 |
| request::task_success | 2 | 92 |
| request::use_case | 0 | 3852 |
| request::use_case | 1 | 758 |
| request::use_case | 2 | 172 |
| task_success | 0 | 4218 |
| use_case | 0 | 5986 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| Claude AI (Free and Pro) | ai_autonomy | 9250 |
| Claude AI (Free and Pro) | ai_education_years | 9282 |
| Claude AI (Free and Pro) | collaboration | 8850 |
| Claude AI (Free and Pro) | country | 348 |
| Claude AI (Free and Pro) | country-state | 2182 |
| Claude AI (Free and Pro) | human_education_years | 9282 |
| Claude AI (Free and Pro) | human_only_ability | 4420 |
| Claude AI (Free and Pro) | human_only_time | 9290 |
| Claude AI (Free and Pro) | human_with_ai_time | 9290 |
| Claude AI (Free and Pro) | multitasking | 4450 |
| Claude AI (Free and Pro) | onet_task | 35510 |
| Claude AI (Free and Pro) | onet_task::ai_autonomy | 28521 |
| Claude AI (Free and Pro) | onet_task::ai_education_years | 28521 |
| Claude AI (Free and Pro) | onet_task::collaboration | 16778 |
| Claude AI (Free and Pro) | onet_task::human_education_years | 28521 |
| Claude AI (Free and Pro) | onet_task::human_only_ability | 11074 |
| Claude AI (Free and Pro) | onet_task::human_only_time | 28533 |
| Claude AI (Free and Pro) | onet_task::human_with_ai_time | 28527 |
| Claude AI (Free and Pro) | onet_task::multitasking | 11830 |
| Claude AI (Free and Pro) | onet_task::task_success | 11540 |
| Claude AI (Free and Pro) | onet_task::use_case | 13908 |
| Claude AI (Free and Pro) | request | 89726 |
| Claude AI (Free and Pro) | request::ai_autonomy | 5257 |
| Claude AI (Free and Pro) | request::ai_education_years | 5257 |
| Claude AI (Free and Pro) | request::collaboration | 8832 |
| Claude AI (Free and Pro) | request::human_education_years | 5257 |
| Claude AI (Free and Pro) | request::human_only_ability | 3002 |
| Claude AI (Free and Pro) | request::human_only_time | 5293 |
| Claude AI (Free and Pro) | request::human_with_ai_time | 5263 |
| Claude AI (Free and Pro) | request::multitasking | 2994 |
| Claude AI (Free and Pro) | request::task_success | 3004 |
| Claude AI (Free and Pro) | request::use_case | 4782 |
| Claude AI (Free and Pro) | task_success | 4218 |
| Claude AI (Free and Pro) | use_case | 5986 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **ai_autonomy** (5 distincts) : `None`, `[5.0, 5.0)`, `[2.0, 2.0)`, `[3.0, 3.0)`, `[4.0, 4.0)`, `[1.0, 1.0)`
- **ai_education_years** (21 distincts) : `None`, `[2.0, 2.0)`, `[8.0, 8.0)`, `[5.0, 5.0)`, `[19.0, 19.0)`, `[18.0, 18.0)`, `[16.0, 16.0)`, `[15.0, 15.0)`, `[9.0, 9.0)`, `[4.0, 4.0)`, `[3.0, 3.0)`, `[10.0, 10.0)`, `[14.0, 14.0)`, `[20.0, 20.0)`, `[12.0, 12.0)`, `[1.0, 1.0)`, `[11.0, 11.0)`, `[0.0, 0.0)`, `[17.0, 17.0)`, `[7.0, 7.0)`, `[6.0, 6.0)`, `[13.0, 13.0)`
- **collaboration** (7 distincts) : `directive`, `task iteration`, `learning`, `feedback loop`, `not_classified`, `validation`, `none`
- **country** (0 distincts) : `None`
- **country-state** (0 distincts) : `None`
- **human_education_years** (21 distincts) : `None`, `[14.0, 14.0)`, `[17.0, 17.0)`, `[12.0, 12.0)`, `[1.0, 1.0)`, `[11.0, 11.0)`, `[0.0, 0.0)`, `[9.0, 9.0)`, `[4.0, 4.0)`, `[3.0, 3.0)`, `[2.0, 2.0)`, `[10.0, 10.0)`, `[8.0, 8.0)`, `[5.0, 5.0)`, `[20.0, 20.0)`, `[19.0, 19.0)`, `[18.0, 18.0)`, `[16.0, 16.0)`, `[15.0, 15.0)`, `[7.0, 7.0)`, `[6.0, 6.0)`, `[13.0, 13.0)`
- **human_only_ability** (3 distincts) : `yes`, `no`, `not_classified`
- **human_only_time** (25 distincts) : `None`, `[1323.199951171875, 1654.0)`, `[6946.7998046875, 7277.599609375)`, `[6285.19970703125, 6616.0)`, `[4631.19970703125, 4962.0)`, `[2646.39990234375, 2977.199951171875)`, `[1984.7999267578125, 2315.599853515625)`, `[7277.599609375, 7608.39990234375)`, `[661.5999755859375, 992.3999633789062)`, `[5954.39990234375, 6285.19970703125)`, `[3638.7998046875, 3969.599853515625)`, `[330.79998779296875, 661.5999755859375)`, `[2315.599853515625, 2646.39990234375)`, `[1654.0, 1984.7999267578125)`, `[7608.39990234375, 7939.19970703125)`, `[4962.0, 5292.7998046875)`, `[5292.7998046875, 5623.599609375)`, `[992.3999633789062, 1323.199951171875)`, `[2977.199951171875, 3308.0)`, `[3308.0, 3638.7998046875)`, `[0.0, 330.79998779296875)`, `[5623.599609375, 5954.39990234375)`, `[7939.19970703125, 8270.0)`, `[6616.0, 6946.7998046875)`, `[4300.39990234375, 4631.19970703125)`, `[3969.599853515625, 4300.39990234375)`
- **human_with_ai_time** (25 distincts) : `None`, `[1920.0, 2000.0)`, `[720.0, 800.0)`, `[640.0, 720.0)`, `[160.0, 240.0)`, `[1200.0, 1280.0)`, `[1040.0, 1120.0)`, `[960.0, 1040.0)`, `[880.0, 960.0)`, `[80.0, 160.0)`, `[400.0, 480.0)`, `[320.0, 400.0)`, `[240.0, 320.0)`, `[0.0, 80.0)`, `[1840.0, 1920.0)`, `[1760.0, 1840.0)`, `[800.0, 880.0)`, `[560.0, 640.0)`, `[1280.0, 1360.0)`, `[1360.0, 1440.0)`, `[1120.0, 1200.0)`, `[1680.0, 1760.0)`, `[480.0, 560.0)`, `[1600.0, 1680.0)`, `[1520.0, 1600.0)`, `[1440.0, 1520.0)`
- **multitasking** (3 distincts) : `no`, `yes`, `not_classified`
- **onet_task** (3170 distincts) : `not_classified`, `modify existing software to correct errors, allow `, `write new programs or modify existing programs to `, `none`, `assist students who need extra help with their cou`, `modify existing software to correct errors, to ada`, `diagnose, troubleshoot, and resolve hardware, soft`, `review class material with students by discussing `, `design, build, or maintain web sites, using author`, `write, update, and maintain computer programs or s`, `prepare, rewrite and edit copy to improve readabil`, `perform routine system administrative functions su`, `provide private instruction to individual or small`, `troubleshoot problems involving office equipment, `, `develop instructional materials to be used by educ`, `develop factors such as themes, plots, characteriz`, `correct errors by making appropriate changes and r`, `instruct individuals in career development techniq`, `edit, standardize, or make changes to material pre`, `develop instructional materials, such as lesson pl`, `develop or apply data mining and machine learning `, `write original or adapted material for dramas, com`, `compile and write documentation of program develop`, `write advertising copy for use by publication, bro`, `prepare and deliver lectures to undergraduate or g`, `confer with clients regarding the nature of the in`, `write supporting code for web applications or web `, `answer customers' questions, and provide informati`, `analyze user needs and software requirements to de`, `read manuals, periodicals, and technical reports t`, `provide feedback and recommendations to developers`, `guide clients in the development of skills or stra`, `edit or rewrite existing copy as necessary, and su`, `read written materials, such as legal documents, s`, `instruct through lectures, discussions, and demons`, `conduct classes, workshops, and demonstrations to `, `interact with clients to assist them in gaining in`, `test programs or databases, correct errors, and ma`, `develop briefings, brochures, multimedia presentat`, `determine sources of web page or server problems, `
- **onet_task::ai_autonomy** (3169 distincts) : `act as an intermediary in negotiations between buy`, `act as liaisons between on-site managers or tenant`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `adjust coaching techniques, based on the strengths`, `adjust machine components according to specificati`, `advise animal owners regarding sanitary measures, `, `advise clients on financial and legal matters such`, `advise clients or respond to inquiries about finan`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise farmers or growers of development programs `, `advise management on organizing, preparing, or imp`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise personnel about traffic problems, such as c`, `advise project teams on subjects such as premarket`, `advise students on academic and vocational curricu`, `advise students on course selection, career decisi`, `advise students on internships, prospective employ`, `analyze and evaluate patient data or test findings`, `analyze and interpret news and information receive`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze data from surveys, old records, or case st`, `analyze data such as interview notes, test results`, `analyze developments in specific field to determin`, `analyze employment-related data and prepare requir`, `analyze existing development or manufacturing proc`, `analyze genetic information to identify patients o`, `analyze geographic distributions of physical and c`, `analyze information to determine, recommend, and p`, `analyze large molecular datasets such as raw micro`, `analyze or interpret logistics data involving cust`, `analyze or manipulate bioinformatics data using so`, `analyze patrons' hair and other physical features `, `analyze performance data to determine effectivenes`, `analyze potential loan markets to find opportuniti`, `analyze problems to develop solutions involving co`, `analyze records, reports, test results, or examina`
- **onet_task::ai_education_years** (3169 distincts) : `prepare reports to be submitted to company's data `, `prepare research results for publication in form o`, `prepare responses to correspondence containing rou`, `prepare responses to customer requests for informa`, `prepare scientific atmospheric or climate reports,`, `prepare sketches of ideas, detailed drawings, illu`, `prepare specifications, designs, or sketches for m`, `prepare statistical reports, narrative reports, or`, `prepare students for further development by encour`, `prepare study-related documentation such as protoc`, `prepare summary statistics of information regardin`, `prepare technical reports and recommendations base`, `prepare technical reports for use by engineering, `, `prepare written and oral reports describing resear`, `prepare written reports on investigations.`, `prepare written reports that estimate property val`, `prepare, administer, and grade tests and assignmen`, `prepare, analyze, and verify annual reports, finan`, `prepare, examine, or analyze accounting records, f`, `prepare, maintain, or oversee the preparation and `, `prepare, manipulate, and manage extensive database`, `present clients with information required to make `, `present investment information, such as product ri`, `process and record new insurance policies and clai`, `process and review employment applications to eval`, `process large amounts of data for statistical mode`, `process, verify, and maintain personnel related do`, `procure, produce, and provide information on the s`, `produce detailed images or measurement of objects,`, `produce pharmaceutically or industrially useful pr`, `produce written summary reports of financial resea`, `program computerized numerical control machine too`, `provide advice and consultation on economic relati`, `provide advice on project costs, design concepts, `, `provide advice on proper standards and regulations`, `provide advice or information to park or reserve v`, `provide application or analytical support to resea`, `provide assistance in balancing books, tracking, m`, `provide assistance to craft workers, such as carpe`, `provide business services for guests, such as send`
- **onet_task::collaboration** (8389 distincts) : `act as an intermediary in negotiations between buy`, `act as liaisons between on-site managers or tenant`, `adapt instructional content or delivery methods fo`, `adapt instructional content or delivery methods fo`, `adapt translations to students' cognitive and grad`, `adjust sales scripts to better target the needs an`, `administer construction contracts.::not_classified`, `administer document and system access rights and r`, `administer standardized ability and achievement te`, `administer standardized ability and achievement te`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `administer, dispense, or prescribe natural medicin`, `administer, proctor, or score academic or diagnost`, `administer, proctor, or score academic or diagnost`, `advise and instruct teachers employed in school sy`, `advise and teach students.::directive`, `advise and teach students.::not_classified`, `advise animal owners regarding sanitary measures, `, `advise animal owners regarding sanitary measures, `, `advise animal owners regarding sanitary measures, `, `advise client on interior design factors such as s`, `advise clients about colors and types of makeup an`, `advise clients concerning business transactions, c`, `advise clients concerning business transactions, c`, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers on plant selection or care.::lear`, `advise customers on the selection of medication br`, `advise customers on the selection of medication br`
- **onet_task::human_education_years** (3169 distincts) : `adapt instructional content or delivery methods fo`, `adapt the quantity of ingredients to match the amo`, `address employee relations issues, such as harassm`, `adjust or replace defective or improperly function`, `adjust sales scripts to better target the needs an`, `administer construction contracts.`, `administer document and system access rights and r`, `administer, proctor, or score academic or diagnost`, `advise and teach students.`, `advise athletes on the proper use of equipment.`, `advise clients about proper clothing and shoes.`, `advise clients on how they could be helped by coun`, `advise customers of necessary actions and strategi`, `advise dealers and distributors on policies and op`, `advise farmers and demonstrate techniques in areas`, `advise management concerning personnel, managerial`, `advise management on short-term and long-term fina`, `advise or instruct patients regarding preventive d`, `advise patients about recommended courses of treat`, `advise producers about improved products and techn`, `advise students on academic and vocational curricu`, `advise students on issues such as course selection`, `analyze and evaluate robotic systems or prototypes`, `analyze and modify compensation and benefits polic`, `analyze characteristics of animals to identify and`, `analyze competitive market strategies through anal`, `analyze complex systems to determine potential for`, `analyze computer and information technologies to d`, `analyze corporate intelligence data to identify tr`, `analyze data to assess distance learning program s`, `analyze data to determine validity, quality, and s`, `analyze expenditures and other financial informati`, `analyze financial data such as income growth, qual`, `analyze geographic information systems (gis) data `, `analyze information obtained from management to co`, `analyze information to determine, recommend, and p`, `analyze market conditions to determine optimum tim`, `analyze or synthesize client data to draw conclusi`, `analyze organic or inorganic compounds to determin`, `analyze organizational, occupational, and industri`
- **onet_task::human_only_ability** (5537 distincts) : `act as an intermediary in negotiations between buy`, `adapt instructional content or delivery methods fo`, `adapt the quantity of ingredients to match the amo`, `adapt the quantity of ingredients to match the amo`, `address the relationships of quantities, magnitude`, `adjust or replace defective or improperly function`, `adjust, repair, or replace malfunctioning componen`, `administer highway planning, construction, or main`, `administer highway planning, construction, or main`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::yes`, `advise athletes on the proper use of equipment.::y`, `advise client on interior design factors such as s`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients on market conditions, prices, mortg`, `advise clients on transportation and payment metho`, `advise clients or community groups on issues relat`, `advise clients or community groups to ensure paren`, `advise construction firms or government agencies o`, `advise construction firms or government agencies o`, `advise customers on plant selection or care.::not_`, `advise customers on substitution or modification o`, `advise farmers and demonstrate techniques in areas`, `advise management concerning personnel, managerial`, `advise management on organizing, preparing, or imp`, `advise managers on organizational policy matters s`, `advise or consult with individuals and institution`, `advise or consult with individuals and institution`, `advise patients about recommended courses of treat`, `advise planning officials on project feasibility, `, `advise producers about improved products and techn`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on issues such as course selection`, `aid patients in performing tasks, such as bathing `, `allocate print space for story text, photos, and i`, `analyze and evaluate patient data or test findings`
- **onet_task::human_only_time** (3175 distincts) : `act as an intermediary in negotiations between buy`, `act as liaisons between on-site managers or tenant`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `adjust coaching techniques, based on the strengths`, `adjust machine components according to specificati`, `advise animal owners regarding sanitary measures, `, `advise clients on financial and legal matters such`, `advise clients or respond to inquiries about finan`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise farmers or growers of development programs `, `advise management on organizing, preparing, or imp`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise personnel about traffic problems, such as c`, `advise project teams on subjects such as premarket`, `advise students on academic and vocational curricu`, `advise students on course selection, career decisi`, `advise students on internships, prospective employ`, `analyze and evaluate patient data or test findings`, `analyze and interpret news and information receive`, `analyze and record personnel or operational data a`, `analyze and report computer network security breac`, `analyze data from surveys, old records, or case st`, `analyze data such as interview notes, test results`, `analyze developments in specific field to determin`, `analyze employment-related data and prepare requir`, `analyze existing development or manufacturing proc`, `analyze genetic information to identify patients o`, `analyze geographic distributions of physical and c`, `analyze information to determine, recommend, and p`, `analyze large molecular datasets such as raw micro`, `analyze or interpret logistics data involving cust`, `analyze or manipulate bioinformatics data using so`, `analyze patrons' hair and other physical features `, `analyze performance data to determine effectivenes`, `analyze potential loan markets to find opportuniti`, `analyze problems to develop solutions involving co`, `analyze records, reports, test results, or examina`
- **onet_task::human_with_ai_time** (3172 distincts) : `accompany buyers during visits to and inspections `, `act as an intermediary in negotiations between buy`, `address legal issues, such as child abuse and disc`, `address the relationships of quantities, magnitude`, `adjust, repair, or replace malfunctioning componen`, `administer standardized ability and achievement te`, `administer, dispense, or prescribe natural medicin`, `advise clients on nail care and use of products an`, `advise clients on transportation and payment metho`, `advise construction firms or government agencies o`, `advise customer about or perform maintenance of so`, `advise customers on substitution or modification o`, `advise customers on the selection of medication br`, `advise food service managers and organizations on `, `advise internal management or business partners on`, `advise licensees or other individuals or groups co`, `advise patients and their families on nutritional `, `advise retail customers or internal users on the a`, `allocate print space for story text, photos, and i`, `analyze all aspects of corporate logistics to dete`, `analyze and distill climate-related research findi`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze applicants' financial status, credit, and `, `analyze building codes, by-laws, space and site re`, `analyze completed police reports to determine what`, `analyze determinants responsible for specific inhe`, `analyze electronics system requirements, capacity,`, `analyze energy bills including utility rates or ta`, `analyze equipment performance records to assess eq`, `analyze equipment performance records to determine`, `analyze experimental data and interpret results to`, `analyze financial or operational performance of co`, `analyze laboratory findings to check the accuracy `, `analyze operations to evaluate performance of a co`, `analyze or synthesize client data to draw conclusi`, `analyze patrons' requests to determine needed info`, `analyze recipes to assign prices to menu items, ba`, `analyze regional energy markets, including energy `
- **onet_task::multitasking** (5915 distincts) : `act as liaisons between on-site managers or tenant`, `adapt instructional content or delivery methods fo`, `adapt text to accommodate musical requirements of `, `adapt translations to students' cognitive and grad`, `adjust coaching techniques, based on the strengths`, `adjust machine components according to specificati`, `adjust sales scripts to better target the needs an`, `administer online purchasing systems.::no`, `administer online purchasing systems.::yes`, `administer standardized ability and achievement te`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `advise and teach students.::no`, `advise clients about colors and types of makeup an`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise clients on market conditions, prices, mortg`, `advise clients on nail care and use of products an`, `advise clients on transportation and payment metho`, `advise clients or community groups on issues relat`, `advise clients or community groups on issues relat`, `advise clients or community groups to ensure paren`, `advise corporations on issues involving corporate `, `advise customer about or perform maintenance of so`, `advise customers on plant selection or care.::no`, `advise customers on the selection of medication br`, `advise farmers or growers of development programs `, `advise farmers or growers of development programs `, `advise or consult with individuals and institution`, `advise or instruct patients regarding preventive d`, `advise patients and their families on nutritional `, `advise personnel about traffic problems, such as c`, `advise planning officials on project feasibility, `, `advise producers about improved products and techn`, `advise project teams on subjects such as premarket`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `aid patients in performing tasks, such as bathing `, `allocate print space for story text, photos, and i`, `analyze all aspects of corporate logistics to dete`
- **onet_task::task_success** (5770 distincts) : `act as an intermediary in negotiations between buy`, `adapt instructional content or delivery methods fo`, `adapt the quantity of ingredients to match the amo`, `adapt the quantity of ingredients to match the amo`, `address the relationships of quantities, magnitude`, `adjust or replace defective or improperly function`, `administer highway planning, construction, or main`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::yes`, `advise athletes on the proper use of equipment.::n`, `advise athletes on the proper use of equipment.::y`, `advise client on interior design factors such as s`, `advise clients concerning business transactions, c`, `advise clients on market conditions, prices, mortg`, `advise clients on nail care and use of products an`, `advise clients or community groups on issues relat`, `advise clients or community groups to ensure paren`, `advise clients or respond to inquiries about finan`, `advise construction firms or government agencies o`, `advise construction firms or government agencies o`, `advise customers on product usage to improve produ`, `advise farmers and demonstrate techniques in areas`, `advise farmers and demonstrate techniques in areas`, `advise food service managers and organizations on `, `advise internal management or business partners on`, `advise management concerning personnel, managerial`, `advise management concerning personnel, managerial`, `advise management on organizing, preparing, or imp`, `advise managers on organizational policy matters s`, `advise or consult with individuals and institution`, `advise patients about recommended courses of treat`, `advise planning officials on project feasibility, `, `advise retail customers or internal users on the a`, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on course selection, career decisi`, `advise students on internships, prospective employ`, `aid patients in performing tasks, such as bathing `, `allocate print space for story text, photos, and i`, `analyze and evaluate patient data or test findings`
- **onet_task::use_case** (6954 distincts) : `accompany buyers during visits to and inspections `, `act as advisers to student organizations.::coursew`, `act as advisers to student organizations.::persona`, `act as an intermediary in negotiations between buy`, `act as liaisons between on-site managers or tenant`, `act as liaisons between on-site managers or tenant`, `adapt instructional content or delivery methods fo`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `address the relationships of quantities, magnitude`, `administer construction contracts.::not_classified`, `administer document and system access rights and r`, `administer highway planning, construction, or main`, `administer online purchasing systems.::work`, `administer standardized ability and achievement te`, `administer, proctor, or score academic or diagnost`, `advise and instruct teachers employed in school sy`, `advise and teach students.::not_classified`, `advise and teach students.::work`, `advise athletes on the proper use of equipment.::p`, `advise clients about colors and types of makeup an`, `advise clients about proper clothing and shoes.::p`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on market conditions, prices, mortg`, `advise clients or community groups on issues relat`, `advise corporations on issues involving corporate `, `advise customers concerning equipment operation, m`, `advise customers on the selection of medication br`, `advise customers on use and care of merchandise.::`, `advise customers on use and care of merchandise.::`, `advise dealers and distributors on policies and op`, `advise farmers and demonstrate techniques in areas`, `advise licensees or other individuals or groups co`, `advise management concerning personnel, managerial`, `advise management on organizing, preparing, or imp`, `advise management on short-term and long-term fina`, `advise or assist in obtaining patents or meeting o`, `advise or assist in obtaining patents or meeting o`, `advise patients, parents or guardians, and communi`
- **request** (738 distincts) : `not_classified`, `Help debug, develop, and optimize software across `, `Help with academic research, writing, and educatio`, `Assist with academic research, writing, and course`, `Troubleshoot IT infrastructure, systems, and assis`, `Create and edit diverse multimedia content across `, `Translate, edit, format, and summarize documents a`, `Debug and build web applications and fix CSS/HTML `, `Create and manage digital marketing, branding, and`, `Complete academic assignments and create education`, `Debug, fix, and refactor code across programming l`, `Assist with database management, data analysis, an`, `Provide health information and well-being support`, `Create and format professional business documents `, `Provide financial guidance and investment assistan`, `Complete humanities and social science academic as`, `Build, debug, and customize web applications and w`, `Assist with business planning, strategy, financial`, `Develop and implement AI/ML systems across multipl`, `Help research, compare, and select consumer produc`, `Assist with business planning, strategy, and entre`, `Write, develop, and edit original creative fiction`, `Assist with personal life management and everyday `, `Troubleshoot technical issues with hardware, softw`, `Debug and fix CSS, HTML, and UI layout and styling`, `Create and optimize marketing content across multi`, `Provide technical assistance with hardware, embedd`, `Help me learn programming languages and software d`, `Assist with career advancement and academic applic`, `Translate text and documents between various langu`, `Develop and troubleshoot business management softw`, `Assist with game development, graphics programming`, `Provide assistance, document drafting, and fraud i`, `Draft and revise professional workplace correspond`, `Create and optimize social media content and marke`, `Create technical documentation, diagrams, and arch`, `Assist with job searching, career planning, and pr`, `Develop automated trading systems and e-commerce p`, `Proofread, edit, and correct written documents and`, `Develop and troubleshoot AI systems including chat`
- **request::ai_autonomy** (737 distincts) : `Help with immigration, visa applications, and inte`, `Recommend movies and TV shows and build recommenda`, `Analyze and create political journalism and media `, `Configure and troubleshoot smart home automation a`, `Generate guidance for speculative and aleatory act`, `Assist with quantum mechanics and quantum computin`, `Draft and refine formal dispute, claim, and enforc`, `Help prepare for job interviews with questions, an`, `Respond to peer reviewers and revise manuscripts f`, `Provide advice and information about pet health, b`, `Create and format presentation slides, scripts, an`, `Debug and implement bioinformatics analysis code f`, `Evaluate arguments and develop debate positions or`, `Assist with microbiology and bacteriology academic`, `Assist with public administration, governance, and`, `Build and customize complete e-commerce websites a`, `Build and customize database-backed web applicatio`, `Create and implement map visualizations and mappin`, `Calculate interest, loan payments, and investment `, `Collaboratively write and develop ongoing creative`, `Compare multiple options and determine which is be`, `Assist with corporate finance, M&A transactions, a`, `Create and debug web scraping scripts to extract d`, `Complete academic assignments on corporate sustain`, `Assist with cultural anthropology, history, and in`, `Configure and troubleshoot DevOps infrastructure a`, `Conduct and interpret advanced statistical analyse`, `Assist with criminology, criminal justice, and dig`, `Create new spreadsheets, tables, or workbooks for `, `Configure and troubleshoot wireless network device`, `Create and debug custom visual effects, shaders, a`, `Answer multiple-choice questions about robotic arm`, `Assist with ecological research, environmental ana`, `Assist with professional agricultural research, bu`, `Create, format, and generate PDF documents and pri`, `Create, modify, convert, or restructure HTML docum`, `Create, revise, format, and optimize resumes and C`, `Debug and fix CSS/HTML styling and layout issues o`, `Create and manage employee scheduling, time tracki`, `Assist with academic theological research, religio`
- **request::ai_education_years** (737 distincts) : `Help with immigration, visa applications, and inte`, `Analyze and create political journalism and media `, `Generate guidance for speculative and aleatory act`, `Assist with quantum mechanics and quantum computin`, `Debug and implement bioinformatics analysis code f`, `Draft and refine formal dispute, claim, and enforc`, `Help prepare for job interviews with questions, an`, `Configure and troubleshoot smart home automation a`, `Evaluate arguments and develop debate positions or`, `Respond to peer reviewers and revise manuscripts f`, `Create and format presentation slides, scripts, an`, `Provide advice and information about pet health, b`, `Recommend movies and TV shows and build recommenda`, `Assist with public administration, governance, and`, `Build and customize complete e-commerce websites a`, `Build and customize database-backed web applicatio`, `Create and implement map visualizations and mappin`, `Calculate interest, loan payments, and investment `, `Collaboratively write and develop ongoing creative`, `Compare multiple options and determine which is be`, `Assist with corporate finance, M&A transactions, a`, `Assist with microbiology and bacteriology academic`, `Create and debug web scraping scripts to extract d`, `Complete academic assignments on corporate sustain`, `Assist with cultural anthropology, history, and in`, `Configure and troubleshoot DevOps infrastructure a`, `Conduct and interpret advanced statistical analyse`, `Assist with criminology, criminal justice, and dig`, `Create new spreadsheets, tables, or workbooks for `, `Configure and troubleshoot wireless network device`, `Create and debug custom visual effects, shaders, a`, `Answer multiple-choice questions about robotic arm`, `Assist with ecological research, environmental ana`, `Assist with professional agricultural research, bu`, `Create, format, and generate PDF documents and pri`, `Create, modify, convert, or restructure HTML docum`, `Create, revise, format, and optimize resumes and C`, `Debug and fix CSS/HTML styling and layout issues o`, `Create and manage employee scheduling, time tracki`, `Assist with academic theological research, religio`
- **request::collaboration** (4333 distincts) : `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Evaluate arguments and develop debate positions or`, `Analyze and create political journalism and media `, `Draft and refine formal dispute, claim, and enforc`, `Respond to peer reviewers and revise manuscripts f`, `Evaluate arguments and develop debate positions or`, `Debug and implement bioinformatics analysis code f`, `Analyze and create political journalism and media `, `Help prepare for job interviews with questions, an`, `Configure and troubleshoot smart home automation a`, `Help prepare for job interviews with questions, an`, `Evaluate arguments and develop debate positions or`, `Recommend movies and TV shows and build recommenda`, `Draft and refine formal dispute, claim, and enforc`, `Generate guidance for speculative and aleatory act`, `Recommend movies and TV shows and build recommenda`, `Respond to peer reviewers and revise manuscripts f`, `Respond to peer reviewers and revise manuscripts f`, `Generate guidance for speculative and aleatory act`, `Analyze and create political journalism and media `, `Draft and refine formal dispute, claim, and enforc`, `Recommend movies and TV shows and build recommenda`, `Respond to peer reviewers and revise manuscripts f`, `Respond to peer reviewers and revise manuscripts f`, `Configure and troubleshoot smart home automation a`, `Help prepare for job interviews with questions, an`, `Draft and refine formal dispute, claim, and enforc`, `Provide advice and information about pet health, b`, `Evaluate arguments and develop debate positions or`, `Draft and refine formal dispute, claim, and enforc`, `Evaluate arguments and develop debate positions or`, `Configure and troubleshoot smart home automation a`, `Create and format presentation slides, scripts, an`, `Evaluate arguments and develop debate positions or`, `Configure and troubleshoot smart home automation a`
- **request::human_education_years** (737 distincts) : `Help with immigration, visa applications, and inte`, `Help prepare for job interviews with questions, an`, `Configure and troubleshoot smart home automation a`, `Draft and refine formal dispute, claim, and enforc`, `Respond to peer reviewers and revise manuscripts f`, `Create and format presentation slides, scripts, an`, `Generate guidance for speculative and aleatory act`, `Assist with quantum mechanics and quantum computin`, `Analyze and create political journalism and media `, `Recommend movies and TV shows and build recommenda`, `Debug and implement bioinformatics analysis code f`, `Evaluate arguments and develop debate positions or`, `Provide advice and information about pet health, b`, `Build freelance career and optimize professional o`, `Calculate dates, times, ages, and durations for pe`, `Calculate percentages, proportions, ratios, and ba`, `Complete language exam questions and homework assi`, `Complete political science and political philosoph`, `Configure and troubleshoot e-commerce order manage`, `Assist with data engineering, analytics, and data `, `Create various marketing content and promotional m`, `Analyze and evaluate real estate properties for pu`, `Create and format HTML email templates and marketi`, `Create K-12 lesson plans, worksheets, and classroo`, `Create budget tracking systems and expense managem`, `Create and customize scientific data visualization`, `Create and edit religious ministry content, sermon`, `Assist with neuroscience research, brain data anal`, `Create, format, solve, or prepare materials for ex`, `Create marketing and social media content for heal`, `Create personalized meal plans with nutritional sp`, `Build and develop educational technology systems a`, `Create formatted study guides and educational docu`, `Assist with music composition, production, generat`, `Complete academic assignments about social media a`, `Create health, psychology, and self-improvement vi`, `Complete cybersecurity professional work, academic`, `Create meditation scripts, spiritual content, and `, `Create, write, or optimize website content and lan`, `Configure, troubleshoot, and understand DNS record`
- **request::human_only_ability** (1473 distincts) : `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Analyze and create political journalism and media `, `Respond to peer reviewers and revise manuscripts f`, `Help prepare for job interviews with questions, an`, `Recommend movies and TV shows and build recommenda`, `Create and format presentation slides, scripts, an`, `Debug and implement bioinformatics analysis code f`, `Generate guidance for speculative and aleatory act`, `Assist with quantum mechanics and quantum computin`, `Assist with quantum mechanics and quantum computin`, `Draft and refine formal dispute, claim, and enforc`, `Evaluate arguments and develop debate positions or`, `Evaluate arguments and develop debate positions or`, `Create and format presentation slides, scripts, an`, `Respond to peer reviewers and revise manuscripts f`, `Generate guidance for speculative and aleatory act`, `Help prepare for job interviews with questions, an`, `Configure and troubleshoot smart home automation a`, `Debug and implement bioinformatics analysis code f`, `Draft and refine formal dispute, claim, and enforc`, `Provide advice and information about pet health, b`, `Configure and troubleshoot smart home automation a`, `Analyze and create political journalism and media `, `Provide advice and information about pet health, b`, `Recommend movies and TV shows and build recommenda`, `Assist with neuroscience research, brain data anal`, `Build and develop educational technology systems a`, `Assist with physics and cosmology education, probl`, `Configure and set up servers, remote access, and n`, `Assist with public administration, governance, and`, `Configure and troubleshoot e-commerce order manage`, `Calculate dates, times, ages, and durations for pe`, `Assist with geoscience modeling, data analysis, an`, `Configure and automate email systems, campaigns, a`, `Configure and troubleshoot DevOps infrastructure a`, `Assist with supply chain, logistics, manufacturing`, `Analyze stocks and build portfolio tracking and ma`, `Assist with solar photovoltaic system design, anal`, `Assist with professional agricultural research, bu`
- **request::human_only_time** (755 distincts) : `Help with immigration, visa applications, and inte`, `Analyze and create political journalism and media `, `Respond to peer reviewers and revise manuscripts f`, `Draft and refine formal dispute, claim, and enforc`, `Recommend movies and TV shows and build recommenda`, `Assist with quantum mechanics and quantum computin`, `Generate guidance for speculative and aleatory act`, `Provide advice and information about pet health, b`, `Evaluate arguments and develop debate positions or`, `Debug and implement bioinformatics analysis code f`, `Create and format presentation slides, scripts, an`, `Configure and troubleshoot smart home automation a`, `Help prepare for job interviews with questions, an`, `Assist with professional agricultural research, bu`, `Assist with public administration, governance, and`, `Create and develop interactive games and education`, `Create and implement map visualizations and mappin`, `Build and optimize retrieval-augmented generation `, `Calculate interest, loan payments, and investment `, `Collaboratively write and develop ongoing creative`, `Assist with academic theological research, religio`, `Assist with medical and nursing education applicat`, `Create and debug custom visual effects, shaders, a`, `Complete academic assignments on corporate sustain`, `Build and customize complete e-commerce websites a`, `Configure and set up servers, remote access, and n`, `Complete grammar exercises and create grammar teac`, `Assist with corporate finance, M&A transactions, a`, `Create comprehensive educational materials, lesson`, `Configure and troubleshoot DevOps infrastructure a`, `Configure and troubleshoot wireless network device`, `Assist with criminology, criminal justice, and dig`, `Assist with cultural anthropology, history, and in`, `Assist with microbiology and bacteriology academic`, `Create new spreadsheets, tables, or workbooks for `, `Create, format, and generate PDF documents and pri`, `Create, modify, convert, or restructure HTML docum`, `Debug and fix CSS/HTML styling and layout issues o`, `Complete academic assignments and create education`, `Answer multiple-choice questions about robotic arm`
- **request::human_with_ai_time** (740 distincts) : `Help with immigration, visa applications, and inte`, `Analyze and create political journalism and media `, `Respond to peer reviewers and revise manuscripts f`, `Draft and refine formal dispute, claim, and enforc`, `Configure and troubleshoot smart home automation a`, `Evaluate arguments and develop debate positions or`, `Generate guidance for speculative and aleatory act`, `Assist with quantum mechanics and quantum computin`, `Provide advice and information about pet health, b`, `Debug and implement bioinformatics analysis code f`, `Create and format presentation slides, scripts, an`, `Recommend movies and TV shows and build recommenda`, `Help prepare for job interviews with questions, an`, `Assist with professional agricultural research, bu`, `Assist with public administration, governance, and`, `Create and develop interactive games and education`, `Create and implement map visualizations and mappin`, `Build and optimize retrieval-augmented generation `, `Calculate interest, loan payments, and investment `, `Collaboratively write and develop ongoing creative`, `Assist with academic theological research, religio`, `Assist with medical and nursing education applicat`, `Create and debug custom visual effects, shaders, a`, `Complete academic assignments on corporate sustain`, `Build and customize complete e-commerce websites a`, `Configure and set up servers, remote access, and n`, `Complete grammar exercises and create grammar teac`, `Assist with corporate finance, M&A transactions, a`, `Create comprehensive educational materials, lesson`, `Configure and troubleshoot DevOps infrastructure a`, `Configure and troubleshoot wireless network device`, `Assist with criminology, criminal justice, and dig`, `Assist with cultural anthropology, history, and in`, `Assist with microbiology and bacteriology academic`, `Create new spreadsheets, tables, or workbooks for `, `Create, format, and generate PDF documents and pri`, `Create, modify, convert, or restructure HTML docum`, `Debug and fix CSS/HTML styling and layout issues o`, `Complete academic assignments and create education`, `Answer multiple-choice questions about robotic arm`
- **request::multitasking** (1469 distincts) : `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Recommend movies and TV shows and build recommenda`, `Respond to peer reviewers and revise manuscripts f`, `Assist with quantum mechanics and quantum computin`, `Draft and refine formal dispute, claim, and enforc`, `Help prepare for job interviews with questions, an`, `Analyze and create political journalism and media `, `Recommend movies and TV shows and build recommenda`, `Provide advice and information about pet health, b`, `Help prepare for job interviews with questions, an`, `Respond to peer reviewers and revise manuscripts f`, `Analyze and create political journalism and media `, `Configure and troubleshoot smart home automation a`, `Draft and refine formal dispute, claim, and enforc`, `Debug and implement bioinformatics analysis code f`, `Evaluate arguments and develop debate positions or`, `Evaluate arguments and develop debate positions or`, `Assist with quantum mechanics and quantum computin`, `Generate guidance for speculative and aleatory act`, `Generate guidance for speculative and aleatory act`, `Create and format presentation slides, scripts, an`, `Provide advice and information about pet health, b`, `Configure and troubleshoot smart home automation a`, `Debug and implement bioinformatics analysis code f`, `Create and format presentation slides, scripts, an`, `Complete law school assignments and exam preparati`, `Build and optimize retrieval-augmented generation `, `Calculate food portions, nutritional values, and s`, `Assist with fine art and art history academic and `, `Assist with geoscience modeling, data analysis, an`, `Assist with legal research, document analysis, dra`, `Assist with music composition, production, generat`, `Assist with airline flights, bookings, policies, a`, `Assist with astronomy, astrophysics, and space sci`, `Build and develop educational technology systems a`, `Assist with solar photovoltaic system design, anal`, `Complete leadership and organizational management `, `Assist with water systems, plumbing, and water inf`, `Calculate percentages, proportions, ratios, and ba`
- **request::task_success** (1474 distincts) : `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Configure and troubleshoot smart home automation a`, `Configure and troubleshoot smart home automation a`, `Assist with quantum mechanics and quantum computin`, `Draft and refine formal dispute, claim, and enforc`, `Help prepare for job interviews with questions, an`, `Respond to peer reviewers and revise manuscripts f`, `Recommend movies and TV shows and build recommenda`, `Provide advice and information about pet health, b`, `Help prepare for job interviews with questions, an`, `Create and format presentation slides, scripts, an`, `Evaluate arguments and develop debate positions or`, `Analyze and create political journalism and media `, `Provide advice and information about pet health, b`, `Debug and implement bioinformatics analysis code f`, `Recommend movies and TV shows and build recommenda`, `Evaluate arguments and develop debate positions or`, `Assist with quantum mechanics and quantum computin`, `Generate guidance for speculative and aleatory act`, `Generate guidance for speculative and aleatory act`, `Respond to peer reviewers and revise manuscripts f`, `Analyze and create political journalism and media `, `Draft and refine formal dispute, claim, and enforc`, `Debug and implement bioinformatics analysis code f`, `Create and format presentation slides, scripts, an`, `Complete law school assignments and exam preparati`, `Build and optimize retrieval-augmented generation `, `Calculate food portions, nutritional values, and s`, `Assist with fine art and art history academic and `, `Assist with geoscience modeling, data analysis, an`, `Assist with legal research, document analysis, dra`, `Assist with music composition, production, generat`, `Assist with airline flights, bookings, policies, a`, `Assist with astronomy, astrophysics, and space sci`, `Build and develop educational technology systems a`, `Assist with solar photovoltaic system design, anal`, `Complete leadership and organizational management `, `Assist with water systems, plumbing, and water inf`, `Calculate percentages, proportions, ratios, and ba`
- **request::use_case** (2347 distincts) : `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Help with immigration, visa applications, and inte`, `Analyze and create political journalism and media `, `Create and format presentation slides, scripts, an`, `Configure and troubleshoot smart home automation a`, `Configure and troubleshoot smart home automation a`, `Draft and refine formal dispute, claim, and enforc`, `Create and format presentation slides, scripts, an`, `Draft and refine formal dispute, claim, and enforc`, `Assist with quantum mechanics and quantum computin`, `Respond to peer reviewers and revise manuscripts f`, `Respond to peer reviewers and revise manuscripts f`, `Evaluate arguments and develop debate positions or`, `Evaluate arguments and develop debate positions or`, `Recommend movies and TV shows and build recommenda`, `Assist with quantum mechanics and quantum computin`, `Help prepare for job interviews with questions, an`, `Provide advice and information about pet health, b`, `Analyze and create political journalism and media `, `Create and format presentation slides, scripts, an`, `Help prepare for job interviews with questions, an`, `Generate guidance for speculative and aleatory act`, `Debug and implement bioinformatics analysis code f`, `Debug and implement bioinformatics analysis code f`, `Provide advice and information about pet health, b`, `Create and format presentation slides, scripts, an`, `Analyze and create political journalism and media `, `Draft and refine formal dispute, claim, and enforc`, `Evaluate arguments and develop debate positions or`, `Help prepare for job interviews with questions, an`, `Generate guidance for speculative and aleatory act`, `Recommend movies and TV shows and build recommenda`, `Respond to peer reviewers and revise manuscripts f`, `Provide advice and information about pet health, b`, `Evaluate arguments and develop debate positions or`, `Recommend movies and TV shows and build recommenda`, `Configure and troubleshoot smart home automation a`, `Generate guidance for speculative and aleatory act`, `Debug and implement bioinformatics analysis code f`
- **task_success** (3 distincts) : `yes`, `no`, `not_classified`
- **use_case** (4 distincts) : `work`, `personal`, `coursework`, `not_classified`

Lignes pour les pays étudiés : 

Premières lignes :

```
  geo_id geography date_start   date_end      platform_and_product        facet  level                   variable cluster_name      value
0     AD   country 2025-11-13 2025-11-20  Claude AI (Free and Pro)  ai_autonomy      0          ai_autonomy_count         None  70.000000
1     AD   country 2025-11-13 2025-11-20  Claude AI (Free and Pro)  ai_autonomy      0           ai_autonomy_mean         None   3.300000
2     AD   country 2025-11-13 2025-11-20  Claude AI (Free and Pro)  ai_autonomy      0  ai_autonomy_mean_ci_lower         None   3.114286
3     AD   country 2025-11-13 2025-11-20  Claude AI (Free and Pro)  ai_autonomy      0  ai_autonomy_mean_ci_upper         None   3.485714
4     AD   country 2025-11-13 2025-11-20  Claude AI (Free and Pro)  ai_autonomy      0         ai_autonomy_median         None   3.000000
```

## Version 2026-03-24

| Fichier | Taille (Mo) |
|---|---|
| `release_2026_03_24/data/aei_raw_1p_api_2026-02-05_to_2026-02-12.csv` | 41.92 |
| `release_2026_03_24/data/aei_raw_claude_ai_2026-02-05_to_2026-02-12.csv` | 98.50 |
| `release_2026_03_24/data_documentation.md` | 0.02 |

### `release_2026_03_24/data/aei_raw_1p_api_2026-02-05_to_2026-02-12.csv`

- Lignes : 195 156
- Taille : 41.9 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 1 | 0 | `GLOBAL` (195156) |
| `geography` | VARCHAR | 1 | 0 | `global` (195156) |
| `date_start` | DATE | 1 | 0 | `2026-02-05` (195156) |
| `date_end` | DATE | 1 | 0 | `2026-02-12` (195156) |
| `platform_and_product` | VARCHAR | 1 | 0 | `1P API` (195156) |
| `facet` | VARCHAR | 38 | 0 | `onet_task::ai_education_years` (20682), `onet_task::human_education_years` (20682), `onet_task::human_only_time` (20678), `onet_task::human_with_ai_time` (20678), `onet_task::ai_autonomy` (20666), `onet_task::collaboration` (11660), `onet_task::use_case` (9874), `onet_task::task_success` (8256), `onet_task::human_only_ability` (8132), `onet_task::multitasking` (7782), `request::collaboration` (5728), `onet_task` (4598), `request::ai_autonomy` (3430), `request::human_with_ai_time` (3430), `request::human_only_time` (3430), `request::human_education_years` (3430), `request::ai_education_years` (3430), `request::use_case` (3042), `onet_task::prompt_tokens` (2298), `onet_task::completion_tokens` (2298), `onet_task::cost` (2298), `request::task_success` (1966), `request::multitasking` (1960), `request::human_only_ability` (1956), `request` (986), `request::prompt_tokens` (490), `request::cost` (490), `request::completion_tokens` (490), `human_education_years` (58), `ai_education_years` (58), `human_with_ai_time` (54), `human_only_time` (54), `ai_autonomy` (54), `collaboration` (12), `use_case` (8), `human_only_ability` (6), `multitasking` (6), `task_success` (6) |
| `level` | BIGINT | 3 | 0 | `0` (188082), `1` (5572), `2` (1502) |
| `variable` | VARCHAR | 155 | 0 | `onet_task_collaboration_count` (5830), `onet_task_collaboration_pct` (5830), `onet_task_use_case_count` (4937), `onet_task_use_case_pct` (4937), `onet_task_task_success_count` (4128), `onet_task_task_success_pct` (4128), `onet_task_human_only_ability_pct` (4066), `onet_task_human_only_ability_count` (4066), … |
| `cluster_name` | VARCHAR | 24279 | 28 | `Develop and debug multimedia applications including games, s` (76), `Debug, create, modify, and optimize shell and automation scr` (76), `Create and debug web scraping scripts to extract data from w` (76), `Remove unused and deprecated code from software codebases::v` (76), `Develop, deploy, and troubleshoot AI and machine learning sy` (76), `Translate diverse content types between languages with speci` (76), `Navigate and filter code repositories to locate and analyze ` (76), `Create and configure data visualizations, charts, and intera` (76), … |
| `value` | DOUBLE | 98720 | 0 | `100.0` (16531), `3.0` (2396), `12.0` (2351), `16.0` (2327), `2.0` (2318), `1.0` (1829), `15.0` (1489), `14.0` (1279), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| global | ai_autonomy | 54 |
| global | ai_education_years | 58 |
| global | collaboration | 12 |
| global | human_education_years | 58 |
| global | human_only_ability | 6 |
| global | human_only_time | 54 |
| global | human_with_ai_time | 54 |
| global | multitasking | 6 |
| global | onet_task | 4598 |
| global | onet_task::ai_autonomy | 20666 |
| global | onet_task::ai_education_years | 20682 |
| global | onet_task::collaboration | 11660 |
| global | onet_task::completion_tokens | 2298 |
| global | onet_task::cost | 2298 |
| global | onet_task::human_education_years | 20682 |
| global | onet_task::human_only_ability | 8132 |
| global | onet_task::human_only_time | 20678 |
| global | onet_task::human_with_ai_time | 20678 |
| global | onet_task::multitasking | 7782 |
| global | onet_task::prompt_tokens | 2298 |
| global | onet_task::task_success | 8256 |
| global | onet_task::use_case | 9874 |
| global | request | 986 |
| global | request::ai_autonomy | 3430 |
| global | request::ai_education_years | 3430 |
| global | request::collaboration | 5728 |
| global | request::completion_tokens | 490 |
| global | request::cost | 490 |
| global | request::human_education_years | 3430 |
| global | request::human_only_ability | 1956 |
| global | request::human_only_time | 3430 |
| global | request::human_with_ai_time | 3430 |
| global | request::multitasking | 1960 |
| global | request::prompt_tokens | 490 |
| global | request::task_success | 1966 |
| global | request::use_case | 3042 |
| global | task_success | 6 |
| global | use_case | 8 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| ai_autonomy | ai_autonomy_count | 1 |
| ai_autonomy | ai_autonomy_histogram_count | 25 |
| ai_autonomy | ai_autonomy_histogram_pct | 25 |
| ai_autonomy | ai_autonomy_mean | 1 |
| ai_autonomy | ai_autonomy_median | 1 |
| ai_autonomy | ai_autonomy_stdev | 1 |
| ai_education_years | ai_education_years_count | 1 |
| ai_education_years | ai_education_years_histogram_count | 25 |
| ai_education_years | ai_education_years_histogram_pct | 25 |
| ai_education_years | ai_education_years_mean | 1 |
| ai_education_years | ai_education_years_mean_ci_lower | 1 |
| ai_education_years | ai_education_years_mean_ci_upper | 1 |
| ai_education_years | ai_education_years_median | 1 |
| ai_education_years | ai_education_years_median_ci_lower | 1 |
| ai_education_years | ai_education_years_median_ci_upper | 1 |
| ai_education_years | ai_education_years_stdev | 1 |
| collaboration | collaboration_count | 6 |
| collaboration | collaboration_pct | 6 |
| human_education_years | human_education_years_count | 1 |
| human_education_years | human_education_years_histogram_count | 25 |
| human_education_years | human_education_years_histogram_pct | 25 |
| human_education_years | human_education_years_mean | 1 |
| human_education_years | human_education_years_mean_ci_lower | 1 |
| human_education_years | human_education_years_mean_ci_upper | 1 |
| human_education_years | human_education_years_median | 1 |
| human_education_years | human_education_years_median_ci_lower | 1 |
| human_education_years | human_education_years_median_ci_upper | 1 |
| human_education_years | human_education_years_stdev | 1 |
| human_only_ability | human_only_ability_count | 3 |
| human_only_ability | human_only_ability_pct | 3 |
| human_only_time | human_only_time_count | 1 |
| human_only_time | human_only_time_histogram_count | 25 |
| human_only_time | human_only_time_histogram_pct | 25 |
| human_only_time | human_only_time_mean | 1 |
| human_only_time | human_only_time_median | 1 |
| human_only_time | human_only_time_stdev | 1 |
| human_with_ai_time | human_with_ai_time_count | 1 |
| human_with_ai_time | human_with_ai_time_histogram_count | 25 |
| human_with_ai_time | human_with_ai_time_histogram_pct | 25 |
| human_with_ai_time | human_with_ai_time_mean | 1 |
| human_with_ai_time | human_with_ai_time_median | 1 |
| human_with_ai_time | human_with_ai_time_stdev | 1 |
| multitasking | multitasking_count | 3 |
| multitasking | multitasking_pct | 3 |
| onet_task | onet_task_count | 2299 |
| onet_task | onet_task_pct | 2299 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_count | 2298 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean | 2298 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_lower | 2294 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_upper | 2294 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median | 2298 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_lower | 2294 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_upper | 2294 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_pct | 2298 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_stdev | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_count | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_lower | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_upper | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_median | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_lower | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_upper | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_pct | 2298 |
| onet_task::ai_education_years | onet_task_ai_education_years_stdev | 2298 |
| onet_task::collaboration | onet_task_collaboration_count | 5830 |
| onet_task::collaboration | onet_task_collaboration_pct | 5830 |
| onet_task::completion_tokens | completion_tokens_index | 2298 |
| onet_task::cost | cost_index | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_count | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_mean | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_lower | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_upper | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_median | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_lower | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_upper | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_pct | 2298 |
| onet_task::human_education_years | onet_task_human_education_years_stdev | 2298 |
| onet_task::human_only_ability | onet_task_human_only_ability_count | 4066 |
| onet_task::human_only_ability | onet_task_human_only_ability_pct | 4066 |
| onet_task::human_only_time | onet_task_human_only_time_count | 2298 |
| onet_task::human_only_time | onet_task_human_only_time_mean | 2298 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_lower | 2297 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_upper | 2297 |
| onet_task::human_only_time | onet_task_human_only_time_median | 2298 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_lower | 2297 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_upper | 2297 |
| onet_task::human_only_time | onet_task_human_only_time_pct | 2298 |
| onet_task::human_only_time | onet_task_human_only_time_stdev | 2298 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_count | 2298 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean | 2298 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_lower | 2297 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_upper | 2297 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median | 2298 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_lower | 2297 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_upper | 2297 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_pct | 2298 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_stdev | 2298 |
| onet_task::multitasking | onet_task_multitasking_count | 3891 |
| onet_task::multitasking | onet_task_multitasking_pct | 3891 |
| onet_task::prompt_tokens | prompt_tokens_index | 2298 |
| onet_task::task_success | onet_task_task_success_count | 4128 |
| onet_task::task_success | onet_task_task_success_pct | 4128 |
| onet_task::use_case | onet_task_use_case_count | 4937 |
| onet_task::use_case | onet_task_use_case_pct | 4937 |
| request | request_count | 493 |
| request | request_pct | 493 |
| request::ai_autonomy | request_ai_autonomy_count | 490 |
| request::ai_autonomy | request_ai_autonomy_mean | 490 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_lower | 490 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_upper | 490 |
| request::ai_autonomy | request_ai_autonomy_median | 490 |
| request::ai_autonomy | request_ai_autonomy_pct | 490 |
| request::ai_autonomy | request_ai_autonomy_stdev | 490 |
| request::ai_education_years | request_ai_education_years_count | 490 |
| request::ai_education_years | request_ai_education_years_mean | 490 |
| request::ai_education_years | request_ai_education_years_mean_ci_lower | 490 |
| request::ai_education_years | request_ai_education_years_mean_ci_upper | 490 |
| request::ai_education_years | request_ai_education_years_median | 490 |
| request::ai_education_years | request_ai_education_years_pct | 490 |
| request::ai_education_years | request_ai_education_years_stdev | 490 |
| request::collaboration | request_collaboration_count | 2864 |
| request::collaboration | request_collaboration_pct | 2864 |
| request::completion_tokens | completion_tokens_index | 490 |
| request::cost | cost_index | 490 |
| request::human_education_years | request_human_education_years_count | 490 |
| request::human_education_years | request_human_education_years_mean | 490 |
| request::human_education_years | request_human_education_years_mean_ci_lower | 490 |
| request::human_education_years | request_human_education_years_mean_ci_upper | 490 |
| request::human_education_years | request_human_education_years_median | 490 |
| request::human_education_years | request_human_education_years_pct | 490 |
| request::human_education_years | request_human_education_years_stdev | 490 |
| request::human_only_ability | request_human_only_ability_count | 978 |
| request::human_only_ability | request_human_only_ability_pct | 978 |
| request::human_only_time | request_human_only_time_count | 490 |
| request::human_only_time | request_human_only_time_mean | 490 |
| request::human_only_time | request_human_only_time_mean_ci_lower | 490 |
| request::human_only_time | request_human_only_time_mean_ci_upper | 490 |
| request::human_only_time | request_human_only_time_median | 490 |
| request::human_only_time | request_human_only_time_pct | 490 |
| request::human_only_time | request_human_only_time_stdev | 490 |
| request::human_with_ai_time | request_human_with_ai_time_count | 490 |
| request::human_with_ai_time | request_human_with_ai_time_mean | 490 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_lower | 490 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_upper | 490 |
| request::human_with_ai_time | request_human_with_ai_time_median | 490 |
| request::human_with_ai_time | request_human_with_ai_time_pct | 490 |
| request::human_with_ai_time | request_human_with_ai_time_stdev | 490 |
| request::multitasking | request_multitasking_count | 980 |
| request::multitasking | request_multitasking_pct | 980 |
| request::prompt_tokens | prompt_tokens_index | 490 |
| request::task_success | request_task_success_count | 983 |
| request::task_success | request_task_success_pct | 983 |
| request::use_case | request_use_case_count | 1521 |
| request::use_case | request_use_case_pct | 1521 |
| task_success | task_success_count | 3 |
| task_success | task_success_pct | 3 |
| use_case | use_case_count | 4 |
| use_case | use_case_pct | 4 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| ai_autonomy | 0 | 54 |
| ai_education_years | 0 | 58 |
| collaboration | 0 | 12 |
| human_education_years | 0 | 58 |
| human_only_ability | 0 | 6 |
| human_only_time | 0 | 54 |
| human_with_ai_time | 0 | 54 |
| multitasking | 0 | 6 |
| onet_task | 0 | 4598 |
| onet_task::ai_autonomy | 0 | 20666 |
| onet_task::ai_education_years | 0 | 20682 |
| onet_task::collaboration | 0 | 11660 |
| onet_task::completion_tokens | 0 | 2298 |
| onet_task::cost | 0 | 2298 |
| onet_task::human_education_years | 0 | 20682 |
| onet_task::human_only_ability | 0 | 8132 |
| onet_task::human_only_time | 0 | 20678 |
| onet_task::human_with_ai_time | 0 | 20678 |
| onet_task::multitasking | 0 | 7782 |
| onet_task::prompt_tokens | 0 | 2298 |
| onet_task::task_success | 0 | 8256 |
| onet_task::use_case | 0 | 9874 |
| request | 0 | 782 |
| request | 1 | 160 |
| request | 2 | 44 |
| request::ai_autonomy | 0 | 2730 |
| request::ai_autonomy | 1 | 553 |
| request::ai_autonomy | 2 | 147 |
| request::ai_education_years | 0 | 2730 |
| request::ai_education_years | 1 | 553 |
| request::ai_education_years | 2 | 147 |
| request::collaboration | 0 | 4538 |
| request::collaboration | 1 | 938 |
| request::collaboration | 2 | 252 |
| request::completion_tokens | 0 | 390 |
| request::completion_tokens | 1 | 79 |
| request::completion_tokens | 2 | 21 |
| request::cost | 0 | 390 |
| request::cost | 1 | 79 |
| request::cost | 2 | 21 |
| request::human_education_years | 0 | 2730 |
| request::human_education_years | 1 | 553 |
| request::human_education_years | 2 | 147 |
| request::human_only_ability | 0 | 1556 |
| request::human_only_ability | 1 | 314 |
| request::human_only_ability | 2 | 86 |
| request::human_only_time | 0 | 2730 |
| request::human_only_time | 1 | 553 |
| request::human_only_time | 2 | 147 |
| request::human_with_ai_time | 0 | 2730 |
| request::human_with_ai_time | 1 | 553 |
| request::human_with_ai_time | 2 | 147 |
| request::multitasking | 0 | 1560 |
| request::multitasking | 1 | 316 |
| request::multitasking | 2 | 84 |
| request::prompt_tokens | 0 | 390 |
| request::prompt_tokens | 1 | 79 |
| request::prompt_tokens | 2 | 21 |
| request::task_success | 0 | 1562 |
| request::task_success | 1 | 318 |
| request::task_success | 2 | 86 |
| request::use_case | 0 | 2366 |
| request::use_case | 1 | 524 |
| request::use_case | 2 | 152 |
| task_success | 0 | 6 |
| use_case | 0 | 8 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| 1P API | ai_autonomy | 54 |
| 1P API | ai_education_years | 58 |
| 1P API | collaboration | 12 |
| 1P API | human_education_years | 58 |
| 1P API | human_only_ability | 6 |
| 1P API | human_only_time | 54 |
| 1P API | human_with_ai_time | 54 |
| 1P API | multitasking | 6 |
| 1P API | onet_task | 4598 |
| 1P API | onet_task::ai_autonomy | 20666 |
| 1P API | onet_task::ai_education_years | 20682 |
| 1P API | onet_task::collaboration | 11660 |
| 1P API | onet_task::completion_tokens | 2298 |
| 1P API | onet_task::cost | 2298 |
| 1P API | onet_task::human_education_years | 20682 |
| 1P API | onet_task::human_only_ability | 8132 |
| 1P API | onet_task::human_only_time | 20678 |
| 1P API | onet_task::human_with_ai_time | 20678 |
| 1P API | onet_task::multitasking | 7782 |
| 1P API | onet_task::prompt_tokens | 2298 |
| 1P API | onet_task::task_success | 8256 |
| 1P API | onet_task::use_case | 9874 |
| 1P API | request | 986 |
| 1P API | request::ai_autonomy | 3430 |
| 1P API | request::ai_education_years | 3430 |
| 1P API | request::collaboration | 5728 |
| 1P API | request::completion_tokens | 490 |
| 1P API | request::cost | 490 |
| 1P API | request::human_education_years | 3430 |
| 1P API | request::human_only_ability | 1956 |
| 1P API | request::human_only_time | 3430 |
| 1P API | request::human_with_ai_time | 3430 |
| 1P API | request::multitasking | 1960 |
| 1P API | request::prompt_tokens | 490 |
| 1P API | request::task_success | 1966 |
| 1P API | request::use_case | 3042 |
| 1P API | task_success | 6 |
| 1P API | use_case | 8 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **ai_autonomy** (25 distincts) : `None`, `[3.879999876022339, 4.039999961853027)`, `[3.7200000286102295, 3.879999876022339)`, `[3.0799999237060547, 3.240000009536743)`, `[2.440000057220459, 2.5999999046325684)`, `[3.559999942779541, 3.7200000286102295)`, `[3.3999998569488525, 3.559999942779541)`, `[1.159999966621399, 1.3199999332427979)`, `[1.3199999332427979, 1.4800000190734863)`, `[1.0, 1.159999966621399)`, `[4.840000152587891, 5.0)`, `[4.519999980926514, 4.679999828338623)`, `[4.199999809265137, 4.359999656677246)`, `[1.7999999523162842, 1.9600000381469727)`, `[2.759999990463257, 2.9200000762939453)`, `[2.5999999046325684, 2.759999990463257)`, `[1.9600000381469727, 2.119999885559082)`, `[1.6399999856948853, 1.7999999523162842)`, `[1.4800000190734863, 1.6399999856948853)`, `[4.679999828338623, 4.840000152587891)`, `[4.359999656677246, 4.519999980926514)`, `[4.039999961853027, 4.199999809265137)`, `[3.240000009536743, 3.3999998569488525)`, `[2.9200000762939453, 3.0799999237060547)`, `[2.2799999713897705, 2.440000057220459)`, `[2.119999885559082, 2.2799999713897705)`
- **ai_education_years** (25 distincts) : `None`, `[6.400000095367432, 7.200000286102295)`, `[8.800000190734863, 9.600000381469727)`, `[4.800000190734863, 5.599999904632568)`, `[2.4000000953674316, 3.200000047683716)`, `[19.200000762939453, 20.0)`, `[16.0, 16.80000114440918)`, `[10.40000057220459, 11.199999809265137)`, `[4.0, 4.800000190734863)`, `[12.800000190734863, 13.600000381469727)`, `[12.0, 12.800000190734863)`, `[0.800000011920929, 1.600000023841858)`, `[8.0, 8.800000190734863)`, `[13.600000381469727, 14.40000057220459)`, `[18.399999618530273, 19.200000762939453)`, `[17.600000381469727, 18.399999618530273)`, `[14.40000057220459, 15.199999809265137)`, `[11.199999809265137, 12.0)`, `[1.600000023841858, 2.4000000953674316)`, `[9.600000381469727, 10.40000057220459)`, `[7.200000286102295, 8.0)`, `[5.599999904632568, 6.400000095367432)`, `[3.200000047683716, 4.0)`, `[0.0, 0.800000011920929)`, `[16.80000114440918, 17.600000381469727)`, `[15.199999809265137, 16.0)`
- **collaboration** (6 distincts) : `feedback loop`, `none`, `learning`, `task iteration`, `directive`, `validation`
- **human_education_years** (25 distincts) : `None`, `[19.200000762939453, 20.0)`, `[9.600000381469727, 10.40000057220459)`, `[8.0, 8.800000190734863)`, `[6.400000095367432, 7.200000286102295)`, `[18.399999618530273, 19.200000762939453)`, `[17.600000381469727, 18.399999618530273)`, `[14.40000057220459, 15.199999809265137)`, `[1.600000023841858, 2.4000000953674316)`, `[0.0, 0.800000011920929)`, `[8.800000190734863, 9.600000381469727)`, `[4.800000190734863, 5.599999904632568)`, `[2.4000000953674316, 3.200000047683716)`, `[0.800000011920929, 1.600000023841858)`, `[16.0, 16.80000114440918)`, `[10.40000057220459, 11.199999809265137)`, `[7.200000286102295, 8.0)`, `[11.199999809265137, 12.0)`, `[3.200000047683716, 4.0)`, `[15.199999809265137, 16.0)`, `[16.80000114440918, 17.600000381469727)`, `[13.600000381469727, 14.40000057220459)`, `[5.599999904632568, 6.400000095367432)`, `[4.0, 4.800000190734863)`, `[12.800000190734863, 13.600000381469727)`, `[12.0, 12.800000190734863)`
- **human_only_ability** (3 distincts) : `no`, `not_classified`, `yes`
- **human_only_time** (25 distincts) : `None`, `[2000.0, 2200.0)`, `[4800.0, 5000.0)`, `[4000.0, 4200.0)`, `[2400.0, 2600.0)`, `[1800.0, 2000.0)`, `[0.0, 200.0)`, `[4200.0, 4400.0)`, `[3000.0, 3200.0)`, `[2600.0, 2800.0)`, `[2200.0, 2400.0)`, `[3800.0, 4000.0)`, `[1400.0, 1600.0)`, `[1200.0, 1400.0)`, `[1000.0, 1200.0)`, `[3400.0, 3600.0)`, `[800.0, 1000.0)`, `[600.0, 800.0)`, `[4600.0, 4800.0)`, `[4400.0, 4600.0)`, `[400.0, 600.0)`, `[3600.0, 3800.0)`, `[3200.0, 3400.0)`, `[2800.0, 3000.0)`, `[200.0, 400.0)`, `[1600.0, 1800.0)`
- **human_with_ai_time** (25 distincts) : `None`, `[384.0, 432.0)`, `[768.0, 816.0)`, `[672.0, 720.0)`, `[624.0, 672.0)`, `[48.0, 96.0)`, `[144.0, 192.0)`, `[1008.0, 1056.0)`, `[864.0, 912.0)`, `[576.0, 624.0)`, `[288.0, 336.0)`, `[912.0, 960.0)`, `[720.0, 768.0)`, `[0.0, 48.0)`, `[432.0, 480.0)`, `[1152.0, 1200.0)`, `[240.0, 288.0)`, `[960.0, 1008.0)`, `[96.0, 144.0)`, `[816.0, 864.0)`, `[528.0, 576.0)`, `[480.0, 528.0)`, `[336.0, 384.0)`, `[192.0, 240.0)`, `[1104.0, 1152.0)`, `[1056.0, 1104.0)`
- **multitasking** (3 distincts) : `no`, `not_classified`, `yes`
- **onet_task** (2299 distincts) : `act as an intermediary in negotiations between buy`, `address the relationships of quantities, magnitude`, `administer, dispense, or prescribe natural medicin`, `advise food service managers and organizations on `, `advise management regarding customer satisfaction,`, `advise patients and their families on nutritional `, `advise retail customers or internal users on the a`, `analyze all aspects of corporate logistics to dete`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze applicants' financial status, credit, and `, `analyze building codes, by-laws, space and site re`, `analyze completed police reports to determine what`, `analyze determinants responsible for specific inhe`, `analyze electronics system requirements, capacity,`, `analyze energy bills including utility rates or ta`, `analyze equipment performance records to assess eq`, `analyze experimental data and interpret results to`, `analyze financial or operational performance of co`, `analyze laboratory findings to check the accuracy `, `analyze menus or recipes, standardize recipes, or `, `analyze operations to evaluate performance of a co`, `analyze or synthesize client data to draw conclusi`, `analyze patrons' requests to determine needed info`, `analyze regional energy markets, including energy `, `analyze target companies or investment opportuniti`, `analyze test data, making computations as necessar`, `analyze the probable outcomes of cases, using know`, `answer customers' questions, and provide informati`, `answer incoming calls, greeting callers, providing`, `answer inquiries from the public concerning animal`, `answer inquiries pertaining to hotel policies and `, `answer patients' calls and determine how to assist`, `answer questions about product features and benefi`, `answer questions regarding the store and its merch`, `answer routine telephone or in-person reference in`, `answer user inquiries regarding computer software `, `apply relevant laws, regulations, policies, or pre`, `appraise, evaluate, and inventory real property an`
- **onet_task::ai_autonomy** (2298 distincts) : `access computerized financial information to answe`, `adapt translations to students' cognitive and grad`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise management regarding customer satisfaction,`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze system performance or operational requirem`, `analyze test data for automotive systems, subsyste`, `analyze the layout, instrumentation, or function o`, `analyze, interpret, or disseminate system performa`, `answer clients' questions about the purposes and d`, `answer customers' questions about merchandise and `, `answer customers' questions about products, prices`, `answer inquiries from current or prospective custo`, `answer inquiries pertaining to hotel policies and `, `answer questions about game rules or casino polici`, `answer telephone calls from potential customers wh`, `apply customer feedback to service improvement eff`, `ask questions that will help clients identify thei`, `assess cost effectiveness of products, projects or`, `assess employee performance.::value`, `assess nutritional needs, diet restrictions and cu`
- **onet_task::ai_education_years** (2298 distincts) : `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `advise students on issues such as course selection`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information gathered by investigation and `, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or manipulate bioinformatics data using so`, `analyze or synthesize client data to draw conclusi`, `analyze performance data to determine effectivenes`, `analyze problems to develop solutions involving co`, `analyze target companies or investment opportuniti`, `analyze the probable outcomes of cases, using know`, `analyze training needs to design employee developm`, `analyze, interpret, or create graphical representa`, `answer applicants' questions about benefits and cl`, `answer customers' questions, and explain available`, `answer customers' questions, and provide informati`, `answer inquiries from the public concerning animal`, `answer inquiries regarding information such as sch`, `answer inquiries regarding shipping or mailing pol`, `answer questions about product features and benefi`, `answer telephone calls to take messages, answer qu`
- **onet_task::collaboration** (5830 distincts) : `act as an intermediary in negotiations between buy`, `adapt instructional content or delivery methods fo`, `adapt translations to students' cognitive and grad`, `administer construction contracts.::not_classified`, `administer document and system access rights and r`, `administer document and system access rights and r`, `administer treatments or therapies, such as homeop`, `administer, proctor, or score academic or diagnost`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::not_classified`, `advise animal owners regarding sanitary measures, `, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise clients on market conditions, prices, mortg`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise management concerning personnel, managerial`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise patients and their families on nutritional `, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `analyze and classify risks and investments to dete`, `analyze and classify risks and investments to dete`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and interpret patients' histories, symptom`, `analyze and interpret patients' histories, symptom`, `analyze and interpret results from tests such as m`, `analyze and modify compensation and benefits polic`, `analyze and record test data to issue reports that`, `analyze and report computer network security breac`, `analyze available data and consult with other scie`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze characteristics of animals to identify and`
- **onet_task::completion_tokens** (2298 distincts) : `access computerized financial information to answe`, `adapt translations to students' cognitive and grad`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise management regarding customer satisfaction,`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze system performance or operational requirem`, `analyze test data for automotive systems, subsyste`, `analyze the layout, instrumentation, or function o`, `analyze, interpret, or disseminate system performa`, `answer clients' questions about the purposes and d`, `answer customers' questions about merchandise and `, `answer customers' questions about products, prices`, `answer inquiries from current or prospective custo`, `answer inquiries pertaining to hotel policies and `, `answer questions about game rules or casino polici`, `answer telephone calls from potential customers wh`, `apply customer feedback to service improvement eff`, `ask questions that will help clients identify thei`, `assess cost effectiveness of products, projects or`, `assess employee performance.::value`, `assess nutritional needs, diet restrictions and cu`
- **onet_task::cost** (2298 distincts) : `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `advise students on issues such as course selection`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information gathered by investigation and `, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or manipulate bioinformatics data using so`, `analyze or synthesize client data to draw conclusi`, `analyze performance data to determine effectivenes`, `analyze problems to develop solutions involving co`, `analyze target companies or investment opportuniti`, `analyze the probable outcomes of cases, using know`, `analyze training needs to design employee developm`, `analyze, interpret, or create graphical representa`, `answer applicants' questions about benefits and cl`, `answer customers' questions, and explain available`, `answer customers' questions, and provide informati`, `answer inquiries from the public concerning animal`, `answer inquiries regarding information such as sch`, `answer inquiries regarding shipping or mailing pol`, `answer questions about product features and benefi`, `answer telephone calls to take messages, answer qu`
- **onet_task::human_education_years** (2298 distincts) : `access computerized financial information to answe`, `adapt translations to students' cognitive and grad`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise management regarding customer satisfaction,`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze system performance or operational requirem`, `analyze test data for automotive systems, subsyste`, `analyze the layout, instrumentation, or function o`, `analyze, interpret, or disseminate system performa`, `answer clients' questions about the purposes and d`, `answer customers' questions about merchandise and `, `answer customers' questions about products, prices`, `answer inquiries from current or prospective custo`, `answer inquiries pertaining to hotel policies and `, `answer questions about game rules or casino polici`, `answer telephone calls from potential customers wh`, `apply customer feedback to service improvement eff`, `ask questions that will help clients identify thei`, `assess cost effectiveness of products, projects or`, `assess employee performance.::value`, `assess nutritional needs, diet restrictions and cu`
- **onet_task::human_only_ability** (4066 distincts) : `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `adjust coaching techniques, based on the strengths`, `administer online purchasing systems.::no`, `administer online purchasing systems.::yes`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `advise clients concerning business transactions, c`, `advise clients on market conditions, prices, mortg`, `advise corporations on issues involving corporate `, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise patients and their families on nutritional `, `analyze all aspects of corporate logistics to dete`, `analyze all aspects of corporate logistics to dete`, `analyze and classify risks and investments to dete`, `analyze and evaluate robotic systems or prototypes`, `analyze and interpret news and information receive`, `analyze and report computer network security breac`, `analyze and report computer network security breac`, `analyze applicants' financial status, credit, and `, `analyze applicants' financial status, credit, and `, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze corporate intelligence data to identify tr`, `analyze data from surveys, old records, or case st`, `analyze data to determine answers to questions fro`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze energy bills including utility rates or ta`, `analyze equipment performance records to assess eq`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze financial or operational performance of co`, `analyze information gathered by investigation and `, `analyze or evaluate dental needs to determine chan`, `analyze organic or inorganic compounds to determin`, `analyze organizational, occupational, and industri`, `analyze patrons' requests to determine needed info`, `analyze potential loan markets and develop referra`
- **onet_task::human_only_time** (2298 distincts) : `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `advise students on issues such as course selection`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze clinical data using appropriate statistica`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information gathered by investigation and `, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or manipulate bioinformatics data using so`, `analyze or synthesize client data to draw conclusi`, `analyze performance data to determine effectivenes`, `analyze problems to develop solutions involving co`, `analyze target companies or investment opportuniti`, `analyze the probable outcomes of cases, using know`, `analyze training needs to design employee developm`, `analyze, interpret, or create graphical representa`, `answer applicants' questions about benefits and cl`, `answer customers' questions, and explain available`, `answer customers' questions, and provide informati`, `answer inquiries from the public concerning animal`, `answer inquiries regarding information such as sch`, `answer inquiries regarding shipping or mailing pol`, `answer questions about product features and benefi`, `answer telephone calls to take messages, answer qu`
- **onet_task::human_with_ai_time** (2298 distincts) : `maintain knowledge of, comply with, and enforce al`, `maintain networks by performing activities such as`, `maintain or modify existing geographic information`, `maintain or update business intelligence tools, da`, `maintain or update records of client account activ`, `maintain records of business transactions and prod`, `maintain records of services provided and the effe`, `maintain regularly scheduled office hours to advis`, `make and confirm reservations for transportation a`, `make manuscript acceptance or revision recommendat`, `map data between source systems, data warehouses, `, `measure dimensions of finished workpieces to ensur`, `measure the effectiveness of marketing, advertisin`, `mediate between benefits providers and employees, `, `modify and customize commercial programs for inter`, `modify computer security files to incorporate new `, `modify existing databases and database management `, `modify existing programs to enhance efficiency.::v`, `modify, maintain, and repair electronics equipment`, `monitor alarm systems to detect emergencies such a`, `monitor and analyze network performance and data i`, `monitor and analyze sales records, trends, or econ`, `monitor competitors' sales activities by following`, `monitor establishment activities to ensure adheren`, `monitor how the wind, heat, or cold affect the cur`, `monitor industry websites or publications for info`, `monitor or evaluate medical conditions of patients`, `monitor personnel or equipment locations and utili`, `monitor raw data quality during collection and mak`, `monitor sales activities to ensure that customers `, `monitor shipments to ensure that goods come in on `, `monitor student performance or assist students in `, `monitor study activities to ensure compliance with`, `negotiate payment arrangements with customers who `, `observe action of microorganisms upon living tissu`, `observe and evaluate students' work to determine p`, `observe and evaluate students' work to determine p`, `observe the structure and properties of matter, an`, `obtain and record patients' medical histories.::va`, `obtain and study information about clients' produc`
- **onet_task::multitasking** (3891 distincts) : `adapt instructional content or delivery methods fo`, `adapt text to accommodate musical requirements of `, `administer online purchasing systems.::no`, `administer online purchasing systems.::yes`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `administer, dispense, or prescribe natural medicin`, `advise and teach students.::no`, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise students on academic and vocational curricu`, `analyze all aspects of corporate logistics to dete`, `analyze all aspects of corporate logistics to dete`, `analyze and evaluate robotic systems or prototypes`, `analyze and interpret data to increase the underst`, `analyze and report computer network security breac`, `analyze and report computer network security breac`, `analyze applicants' financial status, credit, and `, `analyze competitive market strategies through anal`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze data to assess distance learning program s`, `analyze data to determine answers to questions fro`, `analyze equipment performance records to assess eq`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze financial or operational performance of co`, `analyze laboratory findings to check the accuracy `, `analyze organic or inorganic compounds to determin`, `analyze organizational, occupational, and industri`, `analyze patrons' hair and other physical features `, `analyze patrons' requests to determine needed info`, `analyze potential loan markets and develop referra`, `analyze potential loan markets to find opportuniti`, `analyze potential loan markets to find opportuniti`, `analyze prescribing trends to monitor patient comp`, `analyze price proposals, financial reports, and ot`, `analyze product complaints and make recommendation`, `analyze records, reports, test results, or examina`
- **onet_task::prompt_tokens** (2298 distincts) : `access computerized financial information to answe`, `adapt translations to students' cognitive and grad`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise management regarding customer satisfaction,`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze system performance or operational requirem`, `analyze test data for automotive systems, subsyste`, `analyze the layout, instrumentation, or function o`, `analyze, interpret, or disseminate system performa`, `answer clients' questions about the purposes and d`, `answer customers' questions about merchandise and `, `answer customers' questions about products, prices`, `answer inquiries from current or prospective custo`, `answer inquiries pertaining to hotel policies and `, `answer questions about game rules or casino polici`, `answer telephone calls from potential customers wh`, `apply customer feedback to service improvement eff`, `ask questions that will help clients identify thei`, `assess cost effectiveness of products, projects or`, `assess employee performance.::value`, `assess nutritional needs, diet restrictions and cu`
- **onet_task::task_success** (4128 distincts) : `adapt instructional content or delivery methods fo`, `adapt translations to students' cognitive and grad`, `adjust coaching techniques, based on the strengths`, `administer online purchasing systems.::no`, `administer online purchasing systems.::yes`, `administer treatments or therapies, such as homeop`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise clients on how they could be helped by coun`, `advise clients on market conditions, prices, mortg`, `advise corporations on issues involving corporate `, `advise or instruct patients regarding preventive d`, `advise patients and their families on nutritional `, `advise students on academic and vocational curricu`, `analyze all aspects of corporate logistics to dete`, `analyze all aspects of corporate logistics to dete`, `analyze and classify risks and investments to dete`, `analyze and evaluate robotic systems or prototypes`, `analyze and evaluate robotic systems or prototypes`, `analyze and recommend chemical, biological, or oth`, `analyze and report computer network security breac`, `analyze and report computer network security breac`, `analyze applicants' financial status, credit, and `, `analyze competitive market strategies through anal`, `analyze completed police reports to determine what`, `analyze corporate intelligence data to identify tr`, `analyze data to assess distance learning program s`, `analyze data to determine answers to questions fro`, `analyze data to determine answers to questions fro`, `analyze details of sales territories to assess the`, `analyze energy bills including utility rates or ta`, `analyze equipment performance records to assess eq`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze financial or operational performance of co`, `analyze information gathered by investigation and `, `analyze laboratory findings to check the accuracy `, `analyze or evaluate dental needs to determine chan`
- **onet_task::use_case** (4937 distincts) : `adapt instructional content or delivery methods fo`, `adapt translations to students' cognitive and grad`, `adapt translations to students' cognitive and grad`, `adjust coaching techniques, based on the strengths`, `administer construction contracts.::work`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise animal owners regarding sanitary measures, `, `advise clients concerning business transactions, c`, `advise clients on financial and legal matters such`, `advise clients on market conditions, prices, mortg`, `advise corporations on issues involving corporate `, `advise students on academic and vocational curricu`, `advise students on academic and vocational curricu`, `advise students on issues such as course selection`, `analyze all aspects of corporate logistics to dete`, `analyze and classify risks and investments to dete`, `analyze and evaluate security operations to identi`, `analyze and interpret news and information receive`, `analyze and interpret news and information receive`, `analyze and record test data to issue reports that`, `analyze applicants' financial status, credit, and `, `analyze building codes, by-laws, space and site re`, `analyze characteristics of animals to identify and`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze developments in specific field to determin`, `analyze electronics system requirements, capacity,`, `analyze energy bills including utility rates or ta`, `analyze financial or operational performance of co`, `analyze geographic information systems (gis) data `, `analyze geographic information systems (gis) data `, `analyze information gathered by investigation and `, `analyze information obtained from management to co`, `analyze information processing or computation need`, `analyze market conditions to determine optimum tim`
- **request** (477 distincts) : `not_classified`, `Remove unused and deprecated code from software co`, `Translate diverse content types between languages `, `Assist with academic work relating to mental healt`, `Develop, deploy, and troubleshoot AI and machine l`, `Develop and debug multimedia applications includin`, `Debug, create, modify, and optimize shell and auto`, `Develop and use AI systems for tax document proces`, `Create and debug web scraping scripts to extract d`, `Create and configure data visualizations, charts, `, `Develop, debug, and customize web applications and`, `Assist with legal practice tasks including contrac`, `Navigate and filter code repositories to locate an`, `Extract and structure data from insurance policy d`, `Analyze text content for sentiment, toxicity, and `, `Configure and troubleshoot smart home automation a`, `Build and debug video streaming platforms and medi`, `Build and maintain invoice processing systems and `, `Debug and fix CI/CD pipeline failures and deployme`, `Classify incoming emails into predefined categorie`, `Conduct security code reviews and vulnerability au`, `Configure AI assistants for emotional support and `, `Debug and implement search and indexing functional`, `Debug and fix type checking, type safety, and type`, `Analyze and triage cybersecurity threats, alerts, `, `Debug and fix technical issues in video game devel`, `Debug and fix software bugs through autonomous cod`, `Build and maintain trading card collection managem`, `Debug and develop complex multi-component database`, `Correct ASR transcripts and assign voice actors fo`, `Control autonomous AI agents playing video games w`, `Analyze and explain content from uploaded images`, `Analyze and extract structured data from cryptocur`, `Debug and fix failing automated software tests acr`, `Create lesson plans, curriculum materials, and pro`, `Build e-commerce systems and automate product cata`, `Convert diverse document and data sources into str`, `Configure and deploy self-hosted AI assistant infr`, `Analyze and generate technical documentation for i`, `Automate web browser testing and form interactions`
- **request::ai_autonomy** (476 distincts) : `Develop and debug multimedia applications includin`, `Extract and structure data from insurance policy d`, `Develop, debug, and customize web applications and`, `Create and configure data visualizations, charts, `, `Assist with legal practice tasks including contrac`, `Debug, create, modify, and optimize shell and auto`, `Develop, deploy, and troubleshoot AI and machine l`, `Create and debug web scraping scripts to extract d`, `Remove unused and deprecated code from software co`, `Translate diverse content types between languages `, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Navigate and filter code repositories to locate an`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::ai_education_years** (476 distincts) : `Develop and debug multimedia applications includin`, `Extract and structure data from insurance policy d`, `Develop, debug, and customize web applications and`, `Create and configure data visualizations, charts, `, `Assist with legal practice tasks including contrac`, `Debug, create, modify, and optimize shell and auto`, `Develop, deploy, and troubleshoot AI and machine l`, `Create and debug web scraping scripts to extract d`, `Remove unused and deprecated code from software co`, `Translate diverse content types between languages `, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Navigate and filter code repositories to locate an`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::collaboration** (2780 distincts) : `Develop and use AI systems for tax document proces`, `Debug, create, modify, and optimize shell and auto`, `Extract and structure data from insurance policy d`, `Remove unused and deprecated code from software co`, `Develop and debug multimedia applications includin`, `Translate diverse content types between languages `, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop, deploy, and troubleshoot AI and machine l`, `Assist with academic work relating to mental healt`, `Extract and structure data from insurance policy d`, `Assist with academic work relating to mental healt`, `Debug, create, modify, and optimize shell and auto`, `Create and debug web scraping scripts to extract d`, `Develop and debug multimedia applications includin`, `Develop and use AI systems for tax document proces`, `Translate diverse content types between languages `, `Create and configure data visualizations, charts, `, `Create and configure data visualizations, charts, `, `Remove unused and deprecated code from software co`, `Extract and structure data from insurance policy d`, `Create and debug web scraping scripts to extract d`, `Develop, debug, and customize web applications and`, `Translate diverse content types between languages `, `Navigate and filter code repositories to locate an`, `Develop, deploy, and troubleshoot AI and machine l`, `Develop, debug, and customize web applications and`, `Develop, debug, and customize web applications and`, `Remove unused and deprecated code from software co`, `Develop and debug multimedia applications includin`, `Develop, deploy, and troubleshoot AI and machine l`, `Assist with legal practice tasks including contrac`, `Assist with academic work relating to mental healt`, `Create and debug web scraping scripts to extract d`, `Create and debug web scraping scripts to extract d`, `Assist with legal practice tasks including contrac`, `Analyze text content for sentiment, toxicity, and `, `Create and configure data visualizations, charts, `, `Remove unused and deprecated code from software co`, `Develop, debug, and customize web applications and`
- **request::completion_tokens** (476 distincts) : `Develop, debug, and customize web applications and`, `Extract and structure data from insurance policy d`, `Debug, create, modify, and optimize shell and auto`, `Remove unused and deprecated code from software co`, `Assist with legal practice tasks including contrac`, `Navigate and filter code repositories to locate an`, `Develop and debug multimedia applications includin`, `Translate diverse content types between languages `, `Create and configure data visualizations, charts, `, `Create and debug web scraping scripts to extract d`, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Develop, deploy, and troubleshoot AI and machine l`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::cost** (476 distincts) : `Debug, create, modify, and optimize shell and auto`, `Develop and debug multimedia applications includin`, `Navigate and filter code repositories to locate an`, `Develop, deploy, and troubleshoot AI and machine l`, `Create and configure data visualizations, charts, `, `Assist with academic work relating to mental healt`, `Create and debug web scraping scripts to extract d`, `Develop and use AI systems for tax document proces`, `Extract and structure data from insurance policy d`, `Analyze text content for sentiment, toxicity, and `, `Remove unused and deprecated code from software co`, `Translate diverse content types between languages `, `Assist with legal practice tasks including contrac`, `Develop, debug, and customize web applications and`, `Build and develop mobile applications with AI codi`, `Build fitness software applications and analyze at`, `Configure AI assistants for emotional support and `, `Develop and debug networking protocols and distrib`, `Convert diverse document and data sources into str`, `Create and refine professional business presentati`, `Create, format, and generate PDF documents and pri`, `Debug and develop React applications with componen`, `Debug and implement URL generation, validation, an`, `Debug and develop web application image display an`, `Analyze sentiment and generate or respond to custo`, `Debug and fix file upload/download features in web`, `Debug and fix API and web application HTTP errors `, `Analyze codebase structure and refactor directory `, `Debug, fix, refactor, and develop Python code and `, `Debug and fix package dependencies and build confi`, `Debug and fix software bugs through autonomous cod`, `Configure and troubleshoot AI coding assistant per`, `Analyze financial markets and develop forecasting `, `Build and test food-related data systems, ML model`, `Design strength training programs and build fitnes`, `Develop and debug data table components and genera`, `Develop and debug financial accounting software an`, `Develop and debug healthcare software applications`, `Debug and modify scientific computing simulation c`, `Analyze and extract structured data from cryptocur`
- **request::human_education_years** (476 distincts) : `Remove unused and deprecated code from software co`, `Extract and structure data from insurance policy d`, `Create and configure data visualizations, charts, `, `Navigate and filter code repositories to locate an`, `Assist with legal practice tasks including contrac`, `Debug, create, modify, and optimize shell and auto`, `Develop and debug multimedia applications includin`, `Translate diverse content types between languages `, `Create and debug web scraping scripts to extract d`, `Develop, deploy, and troubleshoot AI and machine l`, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Develop, debug, and customize web applications and`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::human_only_ability** (950 distincts) : `Develop and use AI systems for tax document proces`, `Remove unused and deprecated code from software co`, `Develop, deploy, and troubleshoot AI and machine l`, `Develop and use AI systems for tax document proces`, `Extract and structure data from insurance policy d`, `Develop, debug, and customize web applications and`, `Create and debug web scraping scripts to extract d`, `Analyze text content for sentiment, toxicity, and `, `Translate diverse content types between languages `, `Debug, create, modify, and optimize shell and auto`, `Navigate and filter code repositories to locate an`, `Assist with legal practice tasks including contrac`, `Create and configure data visualizations, charts, `, `Analyze text content for sentiment, toxicity, and `, `Translate diverse content types between languages `, `Create and debug web scraping scripts to extract d`, `Remove unused and deprecated code from software co`, `Develop, debug, and customize web applications and`, `Assist with legal practice tasks including contrac`, `Extract and structure data from insurance policy d`, `Create and configure data visualizations, charts, `, `Develop and debug multimedia applications includin`, `Develop and debug multimedia applications includin`, `Navigate and filter code repositories to locate an`, `Debug, create, modify, and optimize shell and auto`, `Assist with academic work relating to mental healt`, `Develop, deploy, and troubleshoot AI and machine l`, `Assist with academic work relating to mental healt`, `Build e-commerce systems and automate product cata`, `Conduct automated and manual code reviews identify`, `Conduct automated and manual code reviews identify`, `Build and deploy complete full-stack web applicati`, `Build and customize database-backed web applicatio`, `Assist with supply chain, logistics, manufacturing`, `Conduct automated security and code quality review`, `Build and manage subscription billing and membersh`, `Build task management applications and analyze act`, `Assist with video editing tasks and video producti`, `Build fitness software applications and analyze at`, `Build and customize database-backed web applicatio`
- **request::human_only_time** (476 distincts) : `Develop, debug, and customize web applications and`, `Extract and structure data from insurance policy d`, `Debug, create, modify, and optimize shell and auto`, `Remove unused and deprecated code from software co`, `Assist with legal practice tasks including contrac`, `Navigate and filter code repositories to locate an`, `Develop and debug multimedia applications includin`, `Translate diverse content types between languages `, `Create and configure data visualizations, charts, `, `Create and debug web scraping scripts to extract d`, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Develop, deploy, and troubleshoot AI and machine l`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::human_with_ai_time** (476 distincts) : `Translate diverse content types between languages `, `Extract and structure data from insurance policy d`, `Debug, create, modify, and optimize shell and auto`, `Remove unused and deprecated code from software co`, `Assist with legal practice tasks including contrac`, `Develop and debug multimedia applications includin`, `Create and configure data visualizations, charts, `, `Navigate and filter code repositories to locate an`, `Develop, debug, and customize web applications and`, `Create and debug web scraping scripts to extract d`, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Develop, deploy, and troubleshoot AI and machine l`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::multitasking** (952 distincts) : `Develop, deploy, and troubleshoot AI and machine l`, `Analyze text content for sentiment, toxicity, and `, `Extract and structure data from insurance policy d`, `Develop, debug, and customize web applications and`, `Translate diverse content types between languages `, `Extract and structure data from insurance policy d`, `Debug, create, modify, and optimize shell and auto`, `Navigate and filter code repositories to locate an`, `Debug, create, modify, and optimize shell and auto`, `Translate diverse content types between languages `, `Analyze text content for sentiment, toxicity, and `, `Develop and debug multimedia applications includin`, `Remove unused and deprecated code from software co`, `Assist with academic work relating to mental healt`, `Create and configure data visualizations, charts, `, `Assist with legal practice tasks including contrac`, `Develop, deploy, and troubleshoot AI and machine l`, `Navigate and filter code repositories to locate an`, `Develop and use AI systems for tax document proces`, `Assist with legal practice tasks including contrac`, `Develop, debug, and customize web applications and`, `Assist with academic work relating to mental healt`, `Remove unused and deprecated code from software co`, `Create and configure data visualizations, charts, `, `Create and debug web scraping scripts to extract d`, `Create and debug web scraping scripts to extract d`, `Develop and debug multimedia applications includin`, `Develop and use AI systems for tax document proces`, `Build and debug video streaming platforms and medi`, `Automate freight forwarding and logistics operatio`, `Assist with geoscience modeling, data analysis, an`, `Assist with cybersecurity vulnerability analysis, `, `Build and execute automated calendar and meeting m`, `Analyze security logs and investigate threats usin`, `Analyze market research data and customer feedback`, `Assist with airline flights, bookings, policies, a`, `Assist with fashion and clothing e-commerce operat`, `Build and test food-related data systems, ML model`, `Automate web browser testing and form interactions`, `Automated security vulnerability scanning and mana`
- **request::prompt_tokens** (476 distincts) : `Remove unused and deprecated code from software co`, `Extract and structure data from insurance policy d`, `Create and configure data visualizations, charts, `, `Navigate and filter code repositories to locate an`, `Assist with legal practice tasks including contrac`, `Debug, create, modify, and optimize shell and auto`, `Develop and debug multimedia applications includin`, `Translate diverse content types between languages `, `Create and debug web scraping scripts to extract d`, `Develop, deploy, and troubleshoot AI and machine l`, `Analyze text content for sentiment, toxicity, and `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Develop, debug, and customize web applications and`, `Configure and develop workflow automation system i`, `Assist with supply chain, logistics, manufacturing`, `Automate business data enrichment, CRM workflows, `, `Build and maintain invoice processing systems and `, `Conduct automated and manual code reviews of pull `, `Conduct security code reviews and vulnerability an`, `Conduct security code reviews and vulnerability au`, `Analyze communications to track action item comple`, `Debug and implement automated tests for backend AP`, `Debug and fix mobile app build and compilation err`, `Analyze security logs and investigate threats usin`, `Debug and fix file system operations and path hand`, `Debug and fix workflow automation integration and `, `Analyze market research data and customer feedback`, `Create new spreadsheets, tables, or workbooks for `, `Create and generate videos using AI video generati`, `Configure and troubleshoot infrastructure monitori`, `Analyze and explain content from uploaded images::`, `Debug data integrity and calculation errors in bus`, `Debug and fix UI interaction and visual feedback b`, `Create and optimize prompts for AI image generatio`, `Debug and fix authentication and authorization err`, `Configure and troubleshoot smart home automation a`, `Configure and automate email systems, campaigns, a`, `Debug UI component display and rendering issues in`, `Assist with real estate business operations, marke`
- **request::task_success** (955 distincts) : `Develop, deploy, and troubleshoot AI and machine l`, `Analyze text content for sentiment, toxicity, and `, `Extract and structure data from insurance policy d`, `Develop, debug, and customize web applications and`, `Translate diverse content types between languages `, `Develop and use AI systems for tax document proces`, `Debug, create, modify, and optimize shell and auto`, `Navigate and filter code repositories to locate an`, `Debug, create, modify, and optimize shell and auto`, `Translate diverse content types between languages `, `Analyze text content for sentiment, toxicity, and `, `Develop and debug multimedia applications includin`, `Remove unused and deprecated code from software co`, `Extract and structure data from insurance policy d`, `Create and configure data visualizations, charts, `, `Assist with legal practice tasks including contrac`, `Develop, deploy, and troubleshoot AI and machine l`, `Navigate and filter code repositories to locate an`, `Assist with academic work relating to mental healt`, `Assist with legal practice tasks including contrac`, `Develop, debug, and customize web applications and`, `Assist with academic work relating to mental healt`, `Remove unused and deprecated code from software co`, `Create and configure data visualizations, charts, `, `Create and debug web scraping scripts to extract d`, `Create and debug web scraping scripts to extract d`, `Develop and debug multimedia applications includin`, `Develop and use AI systems for tax document proces`, `Automated security vulnerability scanning and mana`, `Assist with workplace management tasks including p`, `Assist with fashion and clothing e-commerce operat`, `Assist with airline flights, bookings, policies, a`, `Analyze security logs and investigate threats usin`, `Analyze market research data and customer feedback`, `Analyze financial markets and develop forecasting `, `Build and test food-related data systems, ML model`, `Assist with cybersecurity vulnerability analysis, `, `Build and operate AI-powered social media content `, `Automate freight forwarding and logistics operatio`, `Automate web browser testing and form interactions`
- **request::use_case** (1475 distincts) : `Create and configure data visualizations, charts, `, `Assist with legal practice tasks including contrac`, `Debug, create, modify, and optimize shell and auto`, `Create and debug web scraping scripts to extract d`, `Navigate and filter code repositories to locate an`, `Translate diverse content types between languages `, `Remove unused and deprecated code from software co`, `Debug, create, modify, and optimize shell and auto`, `Develop, deploy, and troubleshoot AI and machine l`, `Develop, deploy, and troubleshoot AI and machine l`, `Navigate and filter code repositories to locate an`, `Develop and use AI systems for tax document proces`, `Analyze text content for sentiment, toxicity, and `, `Develop, debug, and customize web applications and`, `Develop and debug multimedia applications includin`, `Remove unused and deprecated code from software co`, `Assist with academic work relating to mental healt`, `Translate diverse content types between languages `, `Debug, create, modify, and optimize shell and auto`, `Extract and structure data from insurance policy d`, `Create and debug web scraping scripts to extract d`, `Analyze text content for sentiment, toxicity, and `, `Develop, deploy, and troubleshoot AI and machine l`, `Extract and structure data from insurance policy d`, `Debug, create, modify, and optimize shell and auto`, `Analyze text content for sentiment, toxicity, and `, `Translate diverse content types between languages `, `Assist with academic work relating to mental healt`, `Develop and use AI systems for tax document proces`, `Remove unused and deprecated code from software co`, `Develop and debug multimedia applications includin`, `Develop, debug, and customize web applications and`, `Extract and structure data from insurance policy d`, `Develop, debug, and customize web applications and`, `Develop, debug, and customize web applications and`, `Develop, deploy, and troubleshoot AI and machine l`, `Assist with legal practice tasks including contrac`, `Develop and use AI systems for tax document proces`, `Assist with legal practice tasks including contrac`, `Develop and debug multimedia applications includin`
- **task_success** (3 distincts) : `no`, `not_classified`, `yes`
- **use_case** (4 distincts) : `coursework`, `work`, `none`, `personal`

Lignes pour les pays étudiés : 

Premières lignes :

```
   geo_id geography date_start   date_end platform_and_product        facet  level                     variable              cluster_name           value
0  GLOBAL    global 2026-02-05 2026-02-12               1P API  ai_autonomy      0            ai_autonomy_count                       NaN  1000000.000000
1  GLOBAL    global 2026-02-05 2026-02-12               1P API  ai_autonomy      0             ai_autonomy_mean                       NaN        2.694321
2  GLOBAL    global 2026-02-05 2026-02-12               1P API  ai_autonomy      0           ai_autonomy_median                       NaN        3.000000
3  GLOBAL    global 2026-02-05 2026-02-12               1P API  ai_autonomy      0            ai_autonomy_stdev                       NaN        1.126905
4  GLOBAL    global 2026-02-05 2026-02-12               1P API  ai_autonomy      0  ai_autonomy_histogram_count  [1.0, 1.159999966621399)   163797.000000
```

### `release_2026_03_24/data/aei_raw_claude_ai_2026-02-05_to_2026-02-12.csv`

- Lignes : 477 717
- Taille : 98.5 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `geo_id` | VARCHAR | 1435 | 0 | `GLOBAL` (271313), `US` (4664), `IN` (2434), `US-CA` (2400), `GB` (2268), `GB-ENG` (2218), `FR` (2150), `DE` (2084), … |
| `geography` | VARCHAR | 3 | 0 | `global` (271313), `country-state` (143918), `country` (62486) |
| `date_start` | DATE | 1 | 0 | `2026-02-05` (477717) |
| `date_end` | DATE | 1 | 0 | `2026-02-12` (477717) |
| `platform_and_product` | VARCHAR | 1 | 0 | `Claude AI (Free, Pro, and Max)` (477717) |
| `facet` | VARCHAR | 34 | 0 | `request` (90556), `onet_task` (37516), `onet_task::ai_autonomy` (29331), `onet_task::human_education_years` (29331), `onet_task::ai_education_years` (29327), `onet_task::human_with_ai_time` (29307), `onet_task::human_only_time` (29291), `onet_task::collaboration` (17530), `onet_task::use_case` (14430), `onet_task::multitasking` (12300), `onet_task::task_success` (12060), `onet_task::human_only_ability` (11592), `human_education_years` (10570), `ai_autonomy` (10570), `ai_education_years` (10558), `human_with_ai_time` (10526), `human_only_time` (10514), `collaboration` (9430), `request::collaboration` (8694), `use_case` (6716), `request::human_with_ai_time` (5236), `request::human_education_years` (5236), `request::ai_autonomy` (5236), `request::human_only_time` (5236), `request::ai_education_years` (5236), `multitasking` (5062), `human_only_ability` (5010), `task_success` (4840), `request::use_case` (4690), `request::task_success` (2992), `request::multitasking` (2972), `request::human_only_ability` (2954), `country-state` (2512), `country` (356) |
| `level` | BIGINT | 3 | 0 | `0` (418475), `1` (38737), `2` (20505) |
| `variable` | VARCHAR | 166 | 0 | `request_pct` (45278), `request_count` (45278), `onet_task_count` (18758), `onet_task_pct` (18758), `onet_task_collaboration_pct` (8765), `onet_task_collaboration_count` (8765), `onet_task_use_case_pct` (7215), `onet_task_use_case_count` (7215), … |
| `cluster_name` | VARCHAR | 35605 | 55356 | `None` (55356), `not_classified` (9582), `yes` (6146), `no` (5772), `work` (2066), `personal` (2046), `directive` (1884), `task iteration` (1768), … |
| `value` | DOUBLE | 189254 | 0 | `100.0` (23600), `16.0` (6544), `15.0` (6286), `12.0` (5734), `4.0` (5149), `17.0` (4760), `18.0` (4452), `19.0` (4047), … |

Croisement `geography` × `facet` :

| geography | facet | lignes |
|---|---|---|
| country | ai_autonomy | 1416 |
| country | ai_education_years | 1412 |
| country | collaboration | 1662 |
| country | country | 356 |
| country | human_education_years | 1416 |
| country | human_only_ability | 698 |
| country | human_only_time | 1392 |
| country | human_with_ai_time | 1400 |
| country | multitasking | 702 |
| country | onet_task | 14970 |
| country | request | 35314 |
| country | task_success | 680 |
| country | use_case | 1068 |
| country-state | ai_autonomy | 9096 |
| country-state | ai_education_years | 9092 |
| country-state | collaboration | 7756 |
| country-state | country-state | 2512 |
| country-state | human_education_years | 9096 |
| country-state | human_only_ability | 4308 |
| country-state | human_only_time | 9068 |
| country-state | human_with_ai_time | 9072 |
| country-state | multitasking | 4356 |
| country-state | onet_task | 16026 |
| country-state | request | 53740 |
| country-state | task_success | 4156 |
| country-state | use_case | 5640 |
| global | ai_autonomy | 58 |
| global | ai_education_years | 54 |
| global | collaboration | 12 |
| global | human_education_years | 58 |
| global | human_only_ability | 4 |
| global | human_only_time | 54 |
| global | human_with_ai_time | 54 |
| global | multitasking | 4 |
| global | onet_task | 6520 |
| global | onet_task::ai_autonomy | 29331 |
| global | onet_task::ai_education_years | 29327 |
| global | onet_task::collaboration | 17530 |
| global | onet_task::human_education_years | 29331 |
| global | onet_task::human_only_ability | 11592 |
| global | onet_task::human_only_time | 29291 |
| global | onet_task::human_with_ai_time | 29307 |
| global | onet_task::multitasking | 12300 |
| global | onet_task::task_success | 12060 |
| global | onet_task::use_case | 14430 |
| global | request | 1502 |
| global | request::ai_autonomy | 5236 |
| global | request::ai_education_years | 5236 |
| global | request::collaboration | 8694 |
| global | request::human_education_years | 5236 |
| global | request::human_only_ability | 2954 |
| global | request::human_only_time | 5236 |
| global | request::human_with_ai_time | 5236 |
| global | request::multitasking | 2972 |
| global | request::task_success | 2992 |
| global | request::use_case | 4690 |
| global | task_success | 4 |
| global | use_case | 8 |

Croisement `facet` × `variable` :

| facet | variable | lignes |
|---|---|---|
| ai_autonomy | ai_autonomy_count | 1315 |
| ai_autonomy | ai_autonomy_histogram_count | 25 |
| ai_autonomy | ai_autonomy_histogram_pct | 25 |
| ai_autonomy | ai_autonomy_mean | 1315 |
| ai_autonomy | ai_autonomy_mean_ci_lower | 1315 |
| ai_autonomy | ai_autonomy_mean_ci_upper | 1315 |
| ai_autonomy | ai_autonomy_median | 1315 |
| ai_autonomy | ai_autonomy_median_ci_lower | 1315 |
| ai_autonomy | ai_autonomy_median_ci_upper | 1315 |
| ai_autonomy | ai_autonomy_stdev | 1315 |
| ai_education_years | ai_education_years_count | 1315 |
| ai_education_years | ai_education_years_histogram_count | 25 |
| ai_education_years | ai_education_years_histogram_pct | 25 |
| ai_education_years | ai_education_years_mean | 1315 |
| ai_education_years | ai_education_years_mean_ci_lower | 1312 |
| ai_education_years | ai_education_years_mean_ci_upper | 1312 |
| ai_education_years | ai_education_years_median | 1315 |
| ai_education_years | ai_education_years_median_ci_lower | 1312 |
| ai_education_years | ai_education_years_median_ci_upper | 1312 |
| ai_education_years | ai_education_years_stdev | 1315 |
| collaboration | collaboration_count | 4715 |
| collaboration | collaboration_pct | 4715 |
| country | usage_count | 178 |
| country | usage_pct | 178 |
| country-state | usage_count | 1256 |
| country-state | usage_pct | 1256 |
| human_education_years | human_education_years_count | 1315 |
| human_education_years | human_education_years_histogram_count | 25 |
| human_education_years | human_education_years_histogram_pct | 25 |
| human_education_years | human_education_years_mean | 1315 |
| human_education_years | human_education_years_mean_ci_lower | 1315 |
| human_education_years | human_education_years_mean_ci_upper | 1315 |
| human_education_years | human_education_years_median | 1315 |
| human_education_years | human_education_years_median_ci_lower | 1315 |
| human_education_years | human_education_years_median_ci_upper | 1315 |
| human_education_years | human_education_years_stdev | 1315 |
| human_only_ability | human_only_ability_count | 2505 |
| human_only_ability | human_only_ability_pct | 2505 |
| human_only_time | human_only_time_count | 1315 |
| human_only_time | human_only_time_histogram_count | 25 |
| human_only_time | human_only_time_histogram_pct | 25 |
| human_only_time | human_only_time_mean | 1315 |
| human_only_time | human_only_time_mean_ci_lower | 1301 |
| human_only_time | human_only_time_mean_ci_upper | 1301 |
| human_only_time | human_only_time_median | 1315 |
| human_only_time | human_only_time_median_ci_lower | 1301 |
| human_only_time | human_only_time_median_ci_upper | 1301 |
| human_only_time | human_only_time_stdev | 1315 |
| human_with_ai_time | human_with_ai_time_count | 1315 |
| human_with_ai_time | human_with_ai_time_histogram_count | 25 |
| human_with_ai_time | human_with_ai_time_histogram_pct | 25 |
| human_with_ai_time | human_with_ai_time_mean | 1315 |
| human_with_ai_time | human_with_ai_time_mean_ci_lower | 1304 |
| human_with_ai_time | human_with_ai_time_mean_ci_upper | 1304 |
| human_with_ai_time | human_with_ai_time_median | 1315 |
| human_with_ai_time | human_with_ai_time_median_ci_lower | 1304 |
| human_with_ai_time | human_with_ai_time_median_ci_upper | 1304 |
| human_with_ai_time | human_with_ai_time_stdev | 1315 |
| multitasking | multitasking_count | 2531 |
| multitasking | multitasking_pct | 2531 |
| onet_task | onet_task_count | 18758 |
| onet_task | onet_task_pct | 18758 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_count | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_lower | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_mean_ci_upper | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_lower | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_median_ci_upper | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_pct | 3259 |
| onet_task::ai_autonomy | onet_task_ai_autonomy_stdev | 3259 |
| onet_task::ai_education_years | onet_task_ai_education_years_count | 3259 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean | 3259 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_lower | 3258 |
| onet_task::ai_education_years | onet_task_ai_education_years_mean_ci_upper | 3258 |
| onet_task::ai_education_years | onet_task_ai_education_years_median | 3259 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_lower | 3258 |
| onet_task::ai_education_years | onet_task_ai_education_years_median_ci_upper | 3258 |
| onet_task::ai_education_years | onet_task_ai_education_years_pct | 3259 |
| onet_task::ai_education_years | onet_task_ai_education_years_stdev | 3259 |
| onet_task::collaboration | onet_task_collaboration_count | 8765 |
| onet_task::collaboration | onet_task_collaboration_pct | 8765 |
| onet_task::human_education_years | onet_task_human_education_years_count | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_mean | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_lower | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_mean_ci_upper | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_median | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_lower | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_median_ci_upper | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_pct | 3259 |
| onet_task::human_education_years | onet_task_human_education_years_stdev | 3259 |
| onet_task::human_only_ability | onet_task_human_only_ability_count | 5796 |
| onet_task::human_only_ability | onet_task_human_only_ability_pct | 5796 |
| onet_task::human_only_time | onet_task_human_only_time_count | 3259 |
| onet_task::human_only_time | onet_task_human_only_time_mean | 3259 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_lower | 3249 |
| onet_task::human_only_time | onet_task_human_only_time_mean_ci_upper | 3249 |
| onet_task::human_only_time | onet_task_human_only_time_median | 3259 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_lower | 3249 |
| onet_task::human_only_time | onet_task_human_only_time_median_ci_upper | 3249 |
| onet_task::human_only_time | onet_task_human_only_time_pct | 3259 |
| onet_task::human_only_time | onet_task_human_only_time_stdev | 3259 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_count | 3259 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean | 3259 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_lower | 3253 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_mean_ci_upper | 3253 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median | 3259 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_lower | 3253 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_median_ci_upper | 3253 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_pct | 3259 |
| onet_task::human_with_ai_time | onet_task_human_with_ai_time_stdev | 3259 |
| onet_task::multitasking | onet_task_multitasking_count | 6150 |
| onet_task::multitasking | onet_task_multitasking_pct | 6150 |
| onet_task::task_success | onet_task_task_success_count | 6030 |
| onet_task::task_success | onet_task_task_success_pct | 6030 |
| onet_task::use_case | onet_task_use_case_count | 7215 |
| onet_task::use_case | onet_task_use_case_pct | 7215 |
| request | request_count | 45278 |
| request | request_pct | 45278 |
| request::ai_autonomy | request_ai_autonomy_count | 748 |
| request::ai_autonomy | request_ai_autonomy_mean | 748 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_lower | 748 |
| request::ai_autonomy | request_ai_autonomy_mean_ci_upper | 748 |
| request::ai_autonomy | request_ai_autonomy_median | 748 |
| request::ai_autonomy | request_ai_autonomy_pct | 748 |
| request::ai_autonomy | request_ai_autonomy_stdev | 748 |
| request::ai_education_years | request_ai_education_years_count | 748 |
| request::ai_education_years | request_ai_education_years_mean | 748 |
| request::ai_education_years | request_ai_education_years_mean_ci_lower | 748 |
| request::ai_education_years | request_ai_education_years_mean_ci_upper | 748 |
| request::ai_education_years | request_ai_education_years_median | 748 |
| request::ai_education_years | request_ai_education_years_pct | 748 |
| request::ai_education_years | request_ai_education_years_stdev | 748 |
| request::collaboration | request_collaboration_count | 4347 |
| request::collaboration | request_collaboration_pct | 4347 |
| request::human_education_years | request_human_education_years_count | 748 |
| request::human_education_years | request_human_education_years_mean | 748 |
| request::human_education_years | request_human_education_years_mean_ci_lower | 748 |
| request::human_education_years | request_human_education_years_mean_ci_upper | 748 |
| request::human_education_years | request_human_education_years_median | 748 |
| request::human_education_years | request_human_education_years_pct | 748 |
| request::human_education_years | request_human_education_years_stdev | 748 |
| request::human_only_ability | request_human_only_ability_count | 1477 |
| request::human_only_ability | request_human_only_ability_pct | 1477 |
| request::human_only_time | request_human_only_time_count | 748 |
| request::human_only_time | request_human_only_time_mean | 748 |
| request::human_only_time | request_human_only_time_mean_ci_lower | 748 |
| request::human_only_time | request_human_only_time_mean_ci_upper | 748 |
| request::human_only_time | request_human_only_time_median | 748 |
| request::human_only_time | request_human_only_time_pct | 748 |
| request::human_only_time | request_human_only_time_stdev | 748 |
| request::human_with_ai_time | request_human_with_ai_time_count | 748 |
| request::human_with_ai_time | request_human_with_ai_time_mean | 748 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_lower | 748 |
| request::human_with_ai_time | request_human_with_ai_time_mean_ci_upper | 748 |
| request::human_with_ai_time | request_human_with_ai_time_median | 748 |
| request::human_with_ai_time | request_human_with_ai_time_pct | 748 |
| request::human_with_ai_time | request_human_with_ai_time_stdev | 748 |
| request::multitasking | request_multitasking_count | 1486 |
| request::multitasking | request_multitasking_pct | 1486 |
| request::task_success | request_task_success_count | 1496 |
| request::task_success | request_task_success_pct | 1496 |
| request::use_case | request_use_case_count | 2345 |
| request::use_case | request_use_case_pct | 2345 |
| task_success | task_success_count | 2420 |
| task_success | task_success_pct | 2420 |
| use_case | use_case_count | 3358 |
| use_case | use_case_pct | 3358 |

Croisement `facet` × `level` :

| facet | level | lignes |
|---|---|---|
| ai_autonomy | 0 | 10570 |
| ai_education_years | 0 | 10558 |
| collaboration | 0 | 9430 |
| country | 0 | 356 |
| country-state | 0 | 2512 |
| human_education_years | 0 | 10570 |
| human_only_ability | 0 | 5010 |
| human_only_time | 0 | 10514 |
| human_with_ai_time | 0 | 10526 |
| multitasking | 0 | 5062 |
| onet_task | 0 | 37516 |
| onet_task::ai_autonomy | 0 | 29331 |
| onet_task::ai_education_years | 0 | 29327 |
| onet_task::collaboration | 0 | 17530 |
| onet_task::human_education_years | 0 | 29331 |
| onet_task::human_only_ability | 0 | 11592 |
| onet_task::human_only_time | 0 | 29291 |
| onet_task::human_with_ai_time | 0 | 29307 |
| onet_task::multitasking | 0 | 12300 |
| onet_task::task_success | 0 | 12060 |
| onet_task::use_case | 0 | 14430 |
| request | 0 | 39738 |
| request | 1 | 31970 |
| request | 2 | 18848 |
| request::ai_autonomy | 0 | 4340 |
| request::ai_autonomy | 1 | 721 |
| request::ai_autonomy | 2 | 175 |
| request::ai_education_years | 0 | 4340 |
| request::ai_education_years | 1 | 721 |
| request::ai_education_years | 2 | 175 |
| request::collaboration | 0 | 7162 |
| request::collaboration | 1 | 1232 |
| request::collaboration | 2 | 300 |
| request::human_education_years | 0 | 4340 |
| request::human_education_years | 1 | 721 |
| request::human_education_years | 2 | 175 |
| request::human_only_ability | 0 | 2442 |
| request::human_only_ability | 1 | 412 |
| request::human_only_ability | 2 | 100 |
| request::human_only_time | 0 | 4340 |
| request::human_only_time | 1 | 721 |
| request::human_only_time | 2 | 175 |
| request::human_with_ai_time | 0 | 4340 |
| request::human_with_ai_time | 1 | 721 |
| request::human_with_ai_time | 2 | 175 |
| request::multitasking | 0 | 2460 |
| request::multitasking | 1 | 412 |
| request::multitasking | 2 | 100 |
| request::task_success | 0 | 2480 |
| request::task_success | 1 | 412 |
| request::task_success | 2 | 100 |
| request::use_case | 0 | 3814 |
| request::use_case | 1 | 694 |
| request::use_case | 2 | 182 |
| task_success | 0 | 4840 |
| use_case | 0 | 6716 |

Croisement `platform_and_product` × `facet` :

| platform_and_product | facet | lignes |
|---|---|---|
| Claude AI (Free, Pro, and Max) | ai_autonomy | 10570 |
| Claude AI (Free, Pro, and Max) | ai_education_years | 10558 |
| Claude AI (Free, Pro, and Max) | collaboration | 9430 |
| Claude AI (Free, Pro, and Max) | country | 356 |
| Claude AI (Free, Pro, and Max) | country-state | 2512 |
| Claude AI (Free, Pro, and Max) | human_education_years | 10570 |
| Claude AI (Free, Pro, and Max) | human_only_ability | 5010 |
| Claude AI (Free, Pro, and Max) | human_only_time | 10514 |
| Claude AI (Free, Pro, and Max) | human_with_ai_time | 10526 |
| Claude AI (Free, Pro, and Max) | multitasking | 5062 |
| Claude AI (Free, Pro, and Max) | onet_task | 37516 |
| Claude AI (Free, Pro, and Max) | onet_task::ai_autonomy | 29331 |
| Claude AI (Free, Pro, and Max) | onet_task::ai_education_years | 29327 |
| Claude AI (Free, Pro, and Max) | onet_task::collaboration | 17530 |
| Claude AI (Free, Pro, and Max) | onet_task::human_education_years | 29331 |
| Claude AI (Free, Pro, and Max) | onet_task::human_only_ability | 11592 |
| Claude AI (Free, Pro, and Max) | onet_task::human_only_time | 29291 |
| Claude AI (Free, Pro, and Max) | onet_task::human_with_ai_time | 29307 |
| Claude AI (Free, Pro, and Max) | onet_task::multitasking | 12300 |
| Claude AI (Free, Pro, and Max) | onet_task::task_success | 12060 |
| Claude AI (Free, Pro, and Max) | onet_task::use_case | 14430 |
| Claude AI (Free, Pro, and Max) | request | 90556 |
| Claude AI (Free, Pro, and Max) | request::ai_autonomy | 5236 |
| Claude AI (Free, Pro, and Max) | request::ai_education_years | 5236 |
| Claude AI (Free, Pro, and Max) | request::collaboration | 8694 |
| Claude AI (Free, Pro, and Max) | request::human_education_years | 5236 |
| Claude AI (Free, Pro, and Max) | request::human_only_ability | 2954 |
| Claude AI (Free, Pro, and Max) | request::human_only_time | 5236 |
| Claude AI (Free, Pro, and Max) | request::human_with_ai_time | 5236 |
| Claude AI (Free, Pro, and Max) | request::multitasking | 2972 |
| Claude AI (Free, Pro, and Max) | request::task_success | 2992 |
| Claude AI (Free, Pro, and Max) | request::use_case | 4690 |
| Claude AI (Free, Pro, and Max) | task_success | 4840 |
| Claude AI (Free, Pro, and Max) | use_case | 6716 |

Exemples de `cluster_name` par `facet` (40 max, par fréquence) :

- **ai_autonomy** (25 distincts) : `None`, `[3.240000009536743, 3.3999998569488525)`, `[3.559999942779541, 3.7200000286102295)`, `[3.3999998569488525, 3.559999942779541)`, `[1.159999966621399, 1.3199999332427979)`, `[1.3199999332427979, 1.4800000190734863)`, `[1.0, 1.159999966621399)`, `[3.7200000286102295, 3.879999876022339)`, `[3.0799999237060547, 3.240000009536743)`, `[2.440000057220459, 2.5999999046325684)`, `[4.679999828338623, 4.840000152587891)`, `[4.359999656677246, 4.519999980926514)`, `[4.039999961853027, 4.199999809265137)`, `[1.4800000190734863, 1.6399999856948853)`, `[2.9200000762939453, 3.0799999237060547)`, `[2.2799999713897705, 2.440000057220459)`, `[2.119999885559082, 2.2799999713897705)`, `[1.7999999523162842, 1.9600000381469727)`, `[4.840000152587891, 5.0)`, `[4.519999980926514, 4.679999828338623)`, `[4.199999809265137, 4.359999656677246)`, `[3.879999876022339, 4.039999961853027)`, `[2.759999990463257, 2.9200000762939453)`, `[2.5999999046325684, 2.759999990463257)`, `[1.9600000381469727, 2.119999885559082)`, `[1.6399999856948853, 1.7999999523162842)`
- **ai_education_years** (25 distincts) : `None`, `[6.400000095367432, 7.200000286102295)`, `[4.0, 4.800000190734863)`, `[12.800000190734863, 13.600000381469727)`, `[12.0, 12.800000190734863)`, `[0.800000011920929, 1.600000023841858)`, `[8.800000190734863, 9.600000381469727)`, `[4.800000190734863, 5.599999904632568)`, `[2.4000000953674316, 3.200000047683716)`, `[19.200000762939453, 20.0)`, `[16.0, 16.80000114440918)`, `[10.40000057220459, 11.199999809265137)`, `[8.0, 8.800000190734863)`, `[13.600000381469727, 14.40000057220459)`, `[18.399999618530273, 19.200000762939453)`, `[17.600000381469727, 18.399999618530273)`, `[14.40000057220459, 15.199999809265137)`, `[11.199999809265137, 12.0)`, `[1.600000023841858, 2.4000000953674316)`, `[9.600000381469727, 10.40000057220459)`, `[7.200000286102295, 8.0)`, `[5.599999904632568, 6.400000095367432)`, `[3.200000047683716, 4.0)`, `[0.0, 0.800000011920929)`, `[16.80000114440918, 17.600000381469727)`, `[15.199999809265137, 16.0)`
- **collaboration** (7 distincts) : `directive`, `task iteration`, `learning`, `feedback loop`, `not_classified`, `validation`, `none`
- **country** (0 distincts) : `None`
- **country-state** (0 distincts) : `None`
- **human_education_years** (25 distincts) : `None`, `[10.40000057220459, 11.199999809265137)`, `[7.200000286102295, 8.0)`, `[5.599999904632568, 6.400000095367432)`, `[3.200000047683716, 4.0)`, `[15.199999809265137, 16.0)`, `[16.80000114440918, 17.600000381469727)`, `[13.600000381469727, 14.40000057220459)`, `[8.800000190734863, 9.600000381469727)`, `[4.800000190734863, 5.599999904632568)`, `[2.4000000953674316, 3.200000047683716)`, `[19.200000762939453, 20.0)`, `[16.0, 16.80000114440918)`, `[0.0, 0.800000011920929)`, `[4.0, 4.800000190734863)`, `[12.800000190734863, 13.600000381469727)`, `[12.0, 12.800000190734863)`, `[0.800000011920929, 1.600000023841858)`, `[9.600000381469727, 10.40000057220459)`, `[8.0, 8.800000190734863)`, `[6.400000095367432, 7.200000286102295)`, `[18.399999618530273, 19.200000762939453)`, `[17.600000381469727, 18.399999618530273)`, `[14.40000057220459, 15.199999809265137)`, `[11.199999809265137, 12.0)`, `[1.600000023841858, 2.4000000953674316)`
- **human_only_ability** (3 distincts) : `yes`, `no`, `not_classified`
- **human_only_time** (25 distincts) : `None`, `[2880.0, 3200.0)`, `[960.0, 1280.0)`, `[7680.0, 8000.0)`, `[7360.0, 7680.0)`, `[5440.0, 5760.0)`, `[2560.0, 2880.0)`, `[2240.0, 2560.0)`, `[7040.0, 7360.0)`, `[6400.0, 6720.0)`, `[5760.0, 6080.0)`, `[4480.0, 4800.0)`, `[3200.0, 3520.0)`, `[1280.0, 1600.0)`, `[1920.0, 2240.0)`, `[0.0, 320.0)`, `[6720.0, 7040.0)`, `[5120.0, 5440.0)`, `[4800.0, 5120.0)`, `[3840.0, 4160.0)`, `[1600.0, 1920.0)`, `[640.0, 960.0)`, `[6080.0, 6400.0)`, `[3520.0, 3840.0)`, `[4160.0, 4480.0)`, `[320.0, 640.0)`
- **human_with_ai_time** (25 distincts) : `None`, `[806.3999633789062, 864.0)`, `[115.19999694824219, 172.79998779296875)`, `[576.0, 633.5999755859375)`, `[1382.39990234375, 1440.0)`, `[1324.7999267578125, 1382.39990234375)`, `[1209.5999755859375, 1267.199951171875)`, `[1036.7999267578125, 1094.4000244140625)`, `[0.0, 57.599998474121094)`, `[979.199951171875, 1036.7999267578125)`, `[864.0, 921.5999755859375)`, `[633.5999755859375, 691.199951171875)`, `[460.79998779296875, 518.3999633789062)`, `[288.0, 345.5999755859375)`, `[518.3999633789062, 576.0)`, `[403.1999816894531, 460.79998779296875)`, `[345.5999755859375, 403.1999816894531)`, `[1267.199951171875, 1324.7999267578125)`, `[230.39999389648438, 288.0)`, `[1152.0, 1209.5999755859375)`, `[1094.4000244140625, 1152.0)`, `[921.5999755859375, 979.199951171875)`, `[748.7999877929688, 806.3999633789062)`, `[691.199951171875, 748.7999877929688)`, `[57.599998474121094, 115.19999694824219)`, `[172.79998779296875, 230.39999389648438)`
- **multitasking** (3 distincts) : `no`, `not_classified`, `yes`
- **onet_task** (3260 distincts) : `not_classified`, `modify existing software to correct errors, allow `, `none`, `write new programs or modify existing programs to `, `assist students who need extra help with their cou`, `modify existing software to correct errors, to ada`, `diagnose, troubleshoot, and resolve hardware, soft`, `design, build, or maintain web sites, using author`, `prepare, rewrite and edit copy to improve readabil`, `review class material with students by discussing `, `perform routine system administrative functions su`, `troubleshoot problems involving office equipment, `, `write, update, and maintain computer programs or s`, `instruct individuals in career development techniq`, `edit, standardize, or make changes to material pre`, `develop instructional materials to be used by educ`, `provide private instruction to individual or small`, `confer with clients regarding the nature of the in`, `compile and write documentation of program develop`, `develop factors such as themes, plots, characteriz`, `answer customers' questions, and provide informati`, `correct errors by making appropriate changes and r`, `write advertising copy for use by publication, bro`, `develop instructional materials, such as lesson pl`, `develop or apply data mining and machine learning `, `analyze user needs and software requirements to de`, `guide clients in the development of skills or stra`, `write original or adapted material for dramas, com`, `write supporting code for web applications or web `, `prepare and deliver lectures to undergraduate or g`, `provide feedback and recommendations to developers`, `read manuals, periodicals, and technical reports t`, `develop briefings, brochures, multimedia presentat`, `conduct logical analyses of business, scientific, `, `read written materials, such as legal documents, s`, `determine sources of web page or server problems, `, `assess the usefulness of pre-developed application`, `provide information and advice to the public regar`, `use computers for various applications, such as da`, `interact with clients to assist them in gaining in`
- **onet_task::ai_autonomy** (3259 distincts) : `act as advisers to student organizations.::value`, `adapt the quantity of ingredients to match the amo`, `adapt translations to students' cognitive and grad`, `adjust or replace defective or improperly function`, `adjust sales scripts to better target the needs an`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients about proper clothing and shoes.::v`, `advise clients concerning business transactions, c`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise managers and employees on state and federal`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise or consult with individuals and institution`, `advise or instruct patients regarding preventive d`, `advise patients and community members concerning d`, `advise producers about improved products and techn`, `advise students on academic and vocational curricu`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze customer bills and utility rate structures`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze large molecular datasets such as raw micro`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze recipes to assign prices to menu items, ba`, `analyze system performance or operational requirem`, `analyze the layout, instrumentation, or function o`
- **onet_task::ai_education_years** (3259 distincts) : `act as advisers to student organizations.::value`, `adapt the quantity of ingredients to match the amo`, `adapt translations to students' cognitive and grad`, `adjust or replace defective or improperly function`, `adjust sales scripts to better target the needs an`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients about proper clothing and shoes.::v`, `advise clients concerning business transactions, c`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise managers and employees on state and federal`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise or consult with individuals and institution`, `advise or instruct patients regarding preventive d`, `advise patients and community members concerning d`, `advise producers about improved products and techn`, `advise students on academic and vocational curricu`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze customer bills and utility rate structures`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze large molecular datasets such as raw micro`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze recipes to assign prices to menu items, ba`, `analyze system performance or operational requirem`, `analyze the layout, instrumentation, or function o`
- **onet_task::collaboration** (8765 distincts) : `review papers or serve on editorial boards for sci`, `review papers or serve on editorial boards for sci`, `review papers or serve on editorial boards for sci`, `review papers or serve on editorial boards for sci`, `review plans for new construction with clients, en`, `review procedures in database management system ma`, `review procedures in database management system ma`, `review procedures in database management system ma`, `review property listings, trade journals, and rele`, `review proposed study protocols to evaluate factor`, `review published materials and recommend revisions`, `review research or literature in art therapy, psyc`, `review research or literature in art therapy, psyc`, `review scientific proposals and research papers.::`, `review software documentation to ensure technical `, `review software documentation to ensure technical `, `review, approve, or interpret genetic laboratory r`, `review, evaluate, and approve specifications for i`, `revise programs or tapes to eliminate errors, and `, `revise programs or tapes to eliminate errors, and `, `rewrite original musical scores in different music`, `rewrite original musical scores in different music`, `schedule and confirm appointments for clients, cus`, `schedule events and organize details, including re`, `schedule special events such as camps, conferences`, `script, plan, and create animated narrative sequen`, `script, plan, and create animated narrative sequen`, `search electronic sources, such as databases or re`, `search for specific sets of stored, typed characte`, `search public records for transactions such as sal`, `search scientific literature to select and modify `, `search standard reference materials, including onl`, `search standard reference materials, including onl`, `search standard reference materials, including onl`, `seek and provide information to help companies det`, `seek out new clients and develop clientele by netw`, `select and apply cosmetic products such as creams,`, `select and edit documents for publication and disp`, `select and obtain materials and supplies such as t`, `select and purchase lumber and hardware necessary `
- **onet_task::human_education_years** (3259 distincts) : `accompany buyers during visits to and inspections `, `act as an intermediary in negotiations between buy`, `administer construction contracts.::value`, `administer highway planning, construction, or main`, `advise athletes on the proper use of equipment.::v`, `advise business or other groups on local, national`, `advise clients about colors and types of makeup an`, `advise clients on transportation and payment metho`, `advise clients or community groups on issues relat`, `advise clients or community groups on issues relat`, `advise clients or community groups to ensure paren`, `advise corporations on issues involving corporate `, `advise food service managers and organizations on `, `advise management on organizing, preparing, or imp`, `advise management on short-term and long-term fina`, `advise participants in use of heat or ultraviolet `, `advise patients about therapeutic exercise and nut`, `advise planning officials on project feasibility, `, `advise students on academic and vocational curricu`, `advise students on course selection, career decisi`, `advise students on internships, prospective employ`, `advise students on issues such as course selection`, `analyze and evaluate security operations to identi`, `analyze and interpret data to increase the underst`, `analyze and interpret patient, nursing, or informa`, `analyze and report computer network security breac`, `analyze building codes, by-laws, space and site re`, `analyze business operations, trends, costs, revenu`, `analyze completed police reports to determine what`, `analyze data from surveys, old records, or case st`, `analyze details of sales territories to assess the`, `analyze electronics system requirements, capacity,`, `analyze experimental data and interpret results to`, `analyze financial data to detect irregularities in`, `analyze financial information obtained from client`, `analyze financial or operational performance of co`, `analyze information gathered by investigation and `, `analyze information processing or computation need`, `analyze laboratory findings to check the accuracy `, `analyze or synthesize client data to draw conclusi`
- **onet_task::human_only_ability** (5796 distincts) : `accompany buyers during visits to and inspections `, `act as advisers to student organizations.::yes`, `act as an intermediary in negotiations between buy`, `act as liaisons between on-site managers or tenant`, `act as liaisons between on-site managers or tenant`, `adapt software and accompanying technical document`, `adapt software and accompanying technical document`, `adapt teaching methods and instructional materials`, `adapt translations to students' cognitive and grad`, `address the relationships of quantities, magnitude`, `adjust coaching techniques, based on the strengths`, `administer and score applicant and employee aptitu`, `administer construction contracts.::not_classified`, `administer document and system access rights and r`, `administer document and system access rights and r`, `administer standardized ability and achievement te`, `administer, dispense, or prescribe natural medicin`, `administer, proctor, or score academic or diagnost`, `advise and instruct teachers employed in school sy`, `advise animal owners regarding sanitary measures, `, `advise animal owners regarding sanitary measures, `, `advise clients about colors and types of makeup an`, `advise clients about colors and types of makeup an`, `advise clients on how they could be helped by coun`, `advise clients or community groups on issues relat`, `advise clients or community groups on issues relat`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers on use and care of merchandise.::`, `advise customers on use and care of merchandise.::`, `advise dealers and distributors on policies and op`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise licensees or other individuals or groups co`, `advise management on short-term and long-term fina`, `advise management on short-term and long-term fina`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise or instruct patients regarding preventive d`, `advise participants in use of heat or ultraviolet `
- **onet_task::human_only_time** (3259 distincts) : `act as advisers to student organizations.::value`, `adapt the quantity of ingredients to match the amo`, `adapt translations to students' cognitive and grad`, `adjust or replace defective or improperly function`, `adjust sales scripts to better target the needs an`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients about proper clothing and shoes.::v`, `advise clients concerning business transactions, c`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise managers and employees on state and federal`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise or consult with individuals and institution`, `advise or instruct patients regarding preventive d`, `advise patients and community members concerning d`, `advise producers about improved products and techn`, `advise students on academic and vocational curricu`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze customer bills and utility rate structures`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze large molecular datasets such as raw micro`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze recipes to assign prices to menu items, ba`, `analyze system performance or operational requirem`, `analyze the layout, instrumentation, or function o`
- **onet_task::human_with_ai_time** (3259 distincts) : `act as advisers to student organizations.::value`, `adapt the quantity of ingredients to match the amo`, `adapt translations to students' cognitive and grad`, `adjust or replace defective or improperly function`, `adjust sales scripts to better target the needs an`, `administer online purchasing systems.::value`, `administer, proctor, or score academic or diagnost`, `advise animal owners regarding sanitary measures, `, `advise clients about proper clothing and shoes.::v`, `advise clients concerning business transactions, c`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise farmers and demonstrate techniques in areas`, `advise farmers or growers of development programs `, `advise managers and employees on state and federal`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise or consult with individuals and institution`, `advise or instruct patients regarding preventive d`, `advise patients and community members concerning d`, `advise producers about improved products and techn`, `advise students on academic and vocational curricu`, `analyze and interpret news and information receive`, `analyze and interpret results from tests such as m`, `analyze compensation policies, government regulati`, `analyze corporate intelligence data to identify tr`, `analyze customer bills and utility rate structures`, `analyze data to determine feasibility of product p`, `analyze determinants responsible for specific inhe`, `analyze equipment performance records to assess eq`, `analyze expenditures and other financial informati`, `analyze information to determine, recommend, and p`, `analyze large molecular datasets such as raw micro`, `analyze operations to evaluate performance of a co`, `analyze organic or inorganic compounds to determin`, `analyze patrons' requests to determine needed info`, `analyze prescribing trends to monitor patient comp`, `analyze recipes to assign prices to menu items, ba`, `analyze system performance or operational requirem`, `analyze the layout, instrumentation, or function o`
- **onet_task::multitasking** (6150 distincts) : `act as advisers to student organizations.::no`, `act as advisers to student organizations.::yes`, `act as an intermediary in negotiations between buy`, `act as liaisons between on-site managers or tenant`, `adapt software and accompanying technical document`, `adapt teaching methods and instructional materials`, `adapt the quantity of ingredients to match the amo`, `address legal issues, such as child abuse and disc`, `address the relationships of quantities, magnitude`, `adjust coaching techniques, based on the strengths`, `adjust or replace defective or improperly function`, `administer and score applicant and employee aptitu`, `administer construction contracts.::not_classified`, `administer document and system access rights and r`, `administer document and system access rights and r`, `administer standardized ability and achievement te`, `administer treatments or therapies, such as homeop`, `administer, dispense, or prescribe natural medicin`, `advise and instruct teachers employed in school sy`, `advise and instruct teachers employed in school sy`, `advise animal owners regarding sanitary measures, `, `advise animal owners regarding sanitary measures, `, `advise clients about colors and types of makeup an`, `advise clients about proper clothing and shoes.::n`, `advise clients on how they could be helped by coun`, `advise clients on transportation and payment metho`, `advise customer about or perform maintenance of so`, `advise customers concerning equipment operation, m`, `advise customers concerning equipment operation, m`, `advise customers on the selection of medication br`, `advise customers on use and care of merchandise.::`, `advise dealers and distributors on policies and op`, `advise farmers and demonstrate techniques in areas`, `advise management on short-term and long-term fina`, `advise managers on organizational policy matters s`, `advise or assist in obtaining patents or meeting o`, `advise or assist in obtaining patents or meeting o`, `advise patients about recommended courses of treat`, `advise patients and community members concerning d`, `advise patients and community members concerning d`
- **onet_task::task_success** (6030 distincts) : `maintain talent files that include information suc`, `make adjustments or minor repairs, such as tighten`, `make reservations for patrons, such as for dinner,`, `make reservations for patrons, such as for dinner,`, `make travel arrangements for executives.::no`, `make travel arrangements for sightseeing or other `, `manage budgets and direct case service allocations`, `manage newborn care during the first weeks of life`, `manage timely flow of business intelligence inform`, `manage user access to systems and equipment throug`, `mark copy to indicate and correct errors in type, `, `market or promote the casino to bring in business.`, `measure amount of body fat, using such equipment a`, `measure and analyze system performance and operati`, `measure and analyze system performance and operati`, `measure and analyze web site usage data to maximiz`, `measure and mark surfaces to lay out work, accordi`, `measure or weigh flour or other ingredients to pre`, `measure velocity, horsepower, revolutions per minu`, `mediate between benefits providers and employees, `, `mediate between benefits providers and employees, `, `meet with clients to negotiate management and serv`, `meet with clients to schedule and plan details of `, `meet with prospective tenants to show properties, `, `meet with prospective tenants to show properties, `, `mix ingredients, such as liquor, soda, water, suga`, `modify and customize commercial programs for inter`, `modify existing software to correct errors, to ada`, `modify patient treatment plans as indicated by pat`, `modify treatment plans according to changes in cli`, `modify, update, and process existing policies and `, `monitor and analyze energy consumption.::yes`, `monitor and analyze sales promotion results to det`, `monitor and analyze sales records, trends, or econ`, `monitor and follow applicable laws and regulations`, `monitor bug resolution efforts and track successes`, `monitor changes affecting supply and demand, track`, `monitor clients' use of medications.::not_classifi`, `monitor equipment to ensure proper operation.::yes`, `monitor fundamental economic, industrial, and corp`
- **onet_task::use_case** (7215 distincts) : `accompany buyers during visits to and inspections `, `adapt text to accommodate musical requirements of `, `adapt text to accommodate musical requirements of `, `adapt the quantity of ingredients to match the amo`, `address employee relations issues, such as harassm`, `address employee relations issues, such as harassm`, `address legal issues, such as child abuse and disc`, `address the relationships of quantities, magnitude`, `adjust apertures, shutter speeds, and camera focus`, `adjust or replace defective or improperly function`, `adjust sales scripts to better target the needs an`, `adjust, repair, or replace malfunctioning componen`, `adjust, repair, or replace malfunctioning componen`, `administer document and system access rights and r`, `administer online purchasing systems.::personal`, `administer standardized ability and achievement te`, `administer treatments or therapies, such as homeop`, `administer treatments or therapies, such as homeop`, `administer, proctor, or score academic or diagnost`, `advise and teach students.::coursework`, `advise animal owners regarding sanitary measures, `, `advise business or other groups on local, national`, `advise business or other groups on local, national`, `advise client on interior design factors such as s`, `advise clients on nail care and use of products an`, `advise clients or community groups on issues relat`, `advise construction firms or government agencies o`, `advise customers concerning equipment operation, m`, `advise customers of necessary actions and strategi`, `advise customers of necessary actions and strategi`, `advise customers on plant selection or care.::pers`, `advise customers on product usage to improve produ`, `advise customers on the selection of medication br`, `advise food service managers and organizations on `, `advise licensees or other individuals or groups co`, `advise management concerning personnel, managerial`, `advise managers and employees on state and federal`, `advise or assist in obtaining patents or meeting o`, `advise or consult with individuals and institution`, `advise or instruct patients regarding preventive d`
- **request** (731 distincts) : `not_classified`, `Assist with software development, debugging, and p`, `Assist with translation, writing, editing, and doc`, `Provide technical support across IT infrastructure`, `Assist with mathematics, physics, and STEM homewor`, `Assist with academic research, scientific writing,`, `Assist with creative content, marketing, and media`, `Get help with daily life tasks, personal informati`, `Assist with academic assignments and coursework ac`, `Develop, debug, and modify websites and web applic`, `Assist with game development, gaming software, and`, `Provide health, fitness, medical, and mental healt`, `Assist with business development, analysis, resear`, `Troubleshoot and configure hardware, software, and`, `Provide financial information, tax guidance, and c`, `Assist with civic information, government services`, `Implement and troubleshoot authentication, authori`, `Create professional presentations and draft workpl`, `Develop and manage business software applications `, `Assist with SQL databases, data analysis, and visu`, `Assist with job applications, career transitions, `, `Develop comprehensive business strategy documents `, `Create marketing content, advertising campaigns, a`, `Extract and structure data from documents, images,`, `Draft and refine professional workplace emails and`, `Provide medical information and health information`, `Develop, deploy, and debug machine learning and AI`, `Help research, compare, and select consumer produc`, `Create educational materials and explain concepts `, `Develop and debug automated trading bots and block`, `Create, convert, format, and manipulate documents `, `Provide legal services and fraud investigation ass`, `Debug, fix, and refactor code across multiple lang`, `Create and optimize social media content and marke`, `Provide language learning assistance, translation,`, `Edit, proofread, and reformat documents and writte`, `Assist with video, audio, and script content creat`, `Assist with creative fiction writing, editing, and`, `Help with programming, software development, and c`, `Create religious content, spiritual guidance, poet`
- **request::ai_autonomy** (730 distincts) : `Develop and use AI systems for tax document proces`, `Build and manage subscription billing and membersh`, `Debug and fix machine learning and AI system error`, `Assist with quantum mechanics and quantum computin`, `Assist with civic information, government services`, `Develop and debug blockchain applications, smart c`, `Get technical help deploying and running large lan`, `Provide advice and information about pet health, b`, `Implement and troubleshoot authentication, authori`, `Respond to peer reviewers and revise manuscripts f`, `Analyze and extract structured data from cryptocur`, `Build recruitment software and resume processing s`, `Provide current soccer standings, predictions, tra`, `Debug and fix automated cryptocurrency and forex t`, `Configure and troubleshoot smart home automation a`, `Resolve payment, billing, subscription, and accoun`, `Draft and refine graduate school and academic job `, `Assist with game development, gaming software, and`, `Answer multiple-choice exam and quiz questions acr`, `Assist with criminal law academic writing, case an`, `Assist with engineering career development, applic`, `Create and refine professional business presentati`, `Create educational and professional content about `, `Build and develop mobile applications with AI codi`, `Calculate dates, times, ages, and durations for pe`, `Calculate percentages, proportions, ratios, and ba`, `Analyze and edit historical, philosophical, and cl`, `Complete urban geography and development economics`, `Compare multiple options and determine which is be`, `Debug and develop React applications with componen`, `Create, format, and generate PDF documents and pri`, `Create social media marketing content and advertis`, `Convert between different units of measurement and`, `Analyze sports betting opportunities and create pr`, `Debug and develop web application image display an`, `Create academic papers and professional materials `, `Create professional business documents, templates,`, `Create and manage employee scheduling, time tracki`, `Create K-12 lesson plans, worksheets, and classroo`, `Create and design presentation slide decks with sp`
- **request::ai_education_years** (730 distincts) : `Get technical help deploying and running large lan`, `Build recruitment software and resume processing s`, `Provide current soccer standings, predictions, tra`, `Develop and use AI systems for tax document proces`, `Draft and refine graduate school and academic job `, `Resolve payment, billing, subscription, and accoun`, `Assist with game development, gaming software, and`, `Develop and debug blockchain applications, smart c`, `Analyze and extract structured data from cryptocur`, `Debug and fix automated cryptocurrency and forex t`, `Implement and troubleshoot authentication, authori`, `Assist with civic information, government services`, `Provide advice and information about pet health, b`, `Build and manage subscription billing and membersh`, `Respond to peer reviewers and revise manuscripts f`, `Configure and troubleshoot smart home automation a`, `Debug and fix machine learning and AI system error`, `Assist with quantum mechanics and quantum computin`, `Assist with nursing academic assignments and profe`, `Create, analyze, convert, or manipulate entire spr`, `Assist with software project planning, specificati`, `Debug, create, modify, and optimize shell and auto`, `Calculate, evaluate, and negotiate employment sala`, `Complete academic assignments about social inequal`, `Conduct and interpret advanced statistical analyse`, `Build and operate AI-powered social media content `, `Adjust visual styling and layout of web applicatio`, `Analyze and process diverse professional documents`, `Configure and set up servers, remote access, and n`, `Create and explain technical visualizations for co`, `Build freelance career and optimize professional o`, `Create and modify card and carousel UI components:`, `Assist with practical political campaign work and `, `Debug and write tests for authentication and secur`, `Create and debug web scraping scripts to extract d`, `Create and implement analytics dashboards with vis`, `Create formatted study guides and educational docu`, `Debug and fix bugs in parsing libraries and langua`, `Debug and troubleshoot software applications, APIs`, `Debug and fix syntax, compilation, and runtime err`
- **request::collaboration** (4241 distincts) : `Analyze and extract structured data from cryptocur`, `Debug and fix machine learning and AI system error`, `Develop and use AI systems for tax document proces`, `Provide advice and information about pet health, b`, `Build and manage subscription billing and membersh`, `Assist with game development, gaming software, and`, `Assist with quantum mechanics and quantum computin`, `Draft and refine graduate school and academic job `, `Assist with game development, gaming software, and`, `Respond to peer reviewers and revise manuscripts f`, `Debug and fix automated cryptocurrency and forex t`, `Assist with quantum mechanics and quantum computin`, `Build recruitment software and resume processing s`, `Draft and refine graduate school and academic job `, `Build recruitment software and resume processing s`, `Configure and troubleshoot smart home automation a`, `Configure and troubleshoot smart home automation a`, `Debug and fix automated cryptocurrency and forex t`, `Build and manage subscription billing and membersh`, `Analyze and extract structured data from cryptocur`, `Respond to peer reviewers and revise manuscripts f`, `Debug and fix machine learning and AI system error`, `Build recruitment software and resume processing s`, `Debug and fix automated cryptocurrency and forex t`, `Get technical help deploying and running large lan`, `Assist with civic information, government services`, `Respond to peer reviewers and revise manuscripts f`, `Implement and troubleshoot authentication, authori`, `Debug and fix machine learning and AI system error`, `Develop and use AI systems for tax document proces`, `Build and manage subscription billing and membersh`, `Debug and fix machine learning and AI system error`, `Implement and troubleshoot authentication, authori`, `Build recruitment software and resume processing s`, `Get technical help deploying and running large lan`, `Implement and troubleshoot authentication, authori`, `Respond to peer reviewers and revise manuscripts f`, `Develop and debug blockchain applications, smart c`, `Develop and debug blockchain applications, smart c`, `Analyze and extract structured data from cryptocur`
- **request::human_education_years** (730 distincts) : `Draft and refine graduate school and academic job `, `Build and manage subscription billing and membersh`, `Build recruitment software and resume processing s`, `Implement and troubleshoot authentication, authori`, `Provide current soccer standings, predictions, tra`, `Develop and use AI systems for tax document proces`, `Assist with civic information, government services`, `Assist with game development, gaming software, and`, `Debug and fix automated cryptocurrency and forex t`, `Get technical help deploying and running large lan`, `Analyze and extract structured data from cryptocur`, `Respond to peer reviewers and revise manuscripts f`, `Resolve payment, billing, subscription, and accoun`, `Configure and troubleshoot smart home automation a`, `Develop and debug blockchain applications, smart c`, `Assist with quantum mechanics and quantum computin`, `Provide advice and information about pet health, b`, `Debug and fix machine learning and AI system error`, `Complete political science and political philosoph`, `Assist with higher education research, administrat`, `Assist with general legal professional work, resea`, `Assist with medical and nursing education applicat`, `Assist with real estate business operations, marke`, `Build and maintain invoice processing systems and `, `Create personalized exam study plans and preparati`, `Analyze and optimize video content strategy for pl`, `Assist with fine art and art history academic and `, `Analyze narrative scenes for characters and locati`, `Calculate costs, revenues, profits, and financial `, `Configure and develop workflow automation system i`, `Assist with public administration, governance, and`, `Complete grammar exercises and create grammar teac`, `Create and optimize prompts for AI image generatio`, `Create and refine cybersecurity professional docum`, `Configure and automate email systems, campaigns, a`, `Configure and troubleshoot build systems, project `, `Correct spelling and grammar errors in short messa`, `Create and refine technical diagrams in various fo`, `Create comprehensive marketing materials and promo`, `Create health, psychology, and self-improvement vi`
- **request::human_only_ability** (1441 distincts) : `Assist with quantum mechanics and quantum computin`, `Assist with civic information, government services`, `Build recruitment software and resume processing s`, `Draft and refine graduate school and academic job `, `Debug and fix automated cryptocurrency and forex t`, `Get technical help deploying and running large lan`, `Develop and debug blockchain applications, smart c`, `Provide advice and information about pet health, b`, `Build and manage subscription billing and membersh`, `Resolve payment, billing, subscription, and accoun`, `Develop and use AI systems for tax document proces`, `Develop and debug blockchain applications, smart c`, `Assist with civic information, government services`, `Provide advice and information about pet health, b`, `Provide current soccer standings, predictions, tra`, `Assist with quantum mechanics and quantum computin`, `Debug and fix machine learning and AI system error`, `Analyze and extract structured data from cryptocur`, `Debug and fix machine learning and AI system error`, `Resolve payment, billing, subscription, and accoun`, `Assist with game development, gaming software, and`, `Develop and use AI systems for tax document proces`, `Analyze and extract structured data from cryptocur`, `Draft and refine graduate school and academic job `, `Implement and troubleshoot authentication, authori`, `Implement and troubleshoot authentication, authori`, `Build and manage subscription billing and membersh`, `Debug and fix automated cryptocurrency and forex t`, `Respond to peer reviewers and revise manuscripts f`, `Build recruitment software and resume processing s`, `Assist with game development, gaming software, and`, `Respond to peer reviewers and revise manuscripts f`, `Provide current soccer standings, predictions, tra`, `Get technical help deploying and running large lan`, `Configure and troubleshoot smart home automation a`, `Configure and troubleshoot smart home automation a`, `Analyze financial markets and develop forecasting `, `Assist with physics and cosmology education, probl`, `Assist with fine art and art history academic and `, `Analyze market research data and customer feedback`
- **request::human_only_time** (730 distincts) : `Assist with quantum mechanics and quantum computin`, `Build and manage subscription billing and membersh`, `Build recruitment software and resume processing s`, `Implement and troubleshoot authentication, authori`, `Provide current soccer standings, predictions, tra`, `Develop and use AI systems for tax document proces`, `Assist with civic information, government services`, `Assist with game development, gaming software, and`, `Debug and fix automated cryptocurrency and forex t`, `Get technical help deploying and running large lan`, `Draft and refine graduate school and academic job `, `Respond to peer reviewers and revise manuscripts f`, `Resolve payment, billing, subscription, and accoun`, `Configure and troubleshoot smart home automation a`, `Develop and debug blockchain applications, smart c`, `Analyze and extract structured data from cryptocur`, `Provide advice and information about pet health, b`, `Debug and fix machine learning and AI system error`, `Complete political science and political philosoph`, `Assist with higher education research, administrat`, `Assist with general legal professional work, resea`, `Assist with medical and nursing education applicat`, `Assist with real estate business operations, marke`, `Build and maintain invoice processing systems and `, `Create personalized exam study plans and preparati`, `Analyze and optimize video content strategy for pl`, `Assist with fine art and art history academic and `, `Analyze narrative scenes for characters and locati`, `Calculate costs, revenues, profits, and financial `, `Configure and develop workflow automation system i`, `Assist with public administration, governance, and`, `Complete grammar exercises and create grammar teac`, `Create and optimize prompts for AI image generatio`, `Create and refine cybersecurity professional docum`, `Configure and automate email systems, campaigns, a`, `Configure and troubleshoot build systems, project `, `Correct spelling and grammar errors in short messa`, `Create and refine technical diagrams in various fo`, `Create comprehensive marketing materials and promo`, `Create health, psychology, and self-improvement vi`
- **request::human_with_ai_time** (730 distincts) : `Provide current soccer standings, predictions, tra`, `Develop and debug blockchain applications, smart c`, `Build recruitment software and resume processing s`, `Implement and troubleshoot authentication, authori`, `Respond to peer reviewers and revise manuscripts f`, `Develop and use AI systems for tax document proces`, `Build and manage subscription billing and membersh`, `Draft and refine graduate school and academic job `, `Assist with civic information, government services`, `Get technical help deploying and running large lan`, `Debug and fix automated cryptocurrency and forex t`, `Assist with quantum mechanics and quantum computin`, `Resolve payment, billing, subscription, and accoun`, `Configure and troubleshoot smart home automation a`, `Analyze and extract structured data from cryptocur`, `Debug and fix machine learning and AI system error`, `Provide advice and information about pet health, b`, `Assist with game development, gaming software, and`, `Complete political science and political philosoph`, `Assist with higher education research, administrat`, `Assist with general legal professional work, resea`, `Assist with medical and nursing education applicat`, `Assist with real estate business operations, marke`, `Build and maintain invoice processing systems and `, `Create personalized exam study plans and preparati`, `Analyze and optimize video content strategy for pl`, `Assist with fine art and art history academic and `, `Analyze narrative scenes for characters and locati`, `Calculate costs, revenues, profits, and financial `, `Configure and develop workflow automation system i`, `Assist with public administration, governance, and`, `Complete grammar exercises and create grammar teac`, `Create and optimize prompts for AI image generatio`, `Create and refine cybersecurity professional docum`, `Configure and automate email systems, campaigns, a`, `Configure and troubleshoot build systems, project `, `Correct spelling and grammar errors in short messa`, `Create and refine technical diagrams in various fo`, `Create comprehensive marketing materials and promo`, `Create health, psychology, and self-improvement vi`
- **request::multitasking** (1450 distincts) : `Develop and debug blockchain applications, smart c`, `Analyze and extract structured data from cryptocur`, `Develop and use AI systems for tax document proces`, `Draft and refine graduate school and academic job `, `Configure and troubleshoot smart home automation a`, `Assist with civic information, government services`, `Configure and troubleshoot smart home automation a`, `Provide advice and information about pet health, b`, `Get technical help deploying and running large lan`, `Resolve payment, billing, subscription, and accoun`, `Assist with game development, gaming software, and`, `Assist with quantum mechanics and quantum computin`, `Respond to peer reviewers and revise manuscripts f`, `Draft and refine graduate school and academic job `, `Build and manage subscription billing and membersh`, `Develop and debug blockchain applications, smart c`, `Assist with game development, gaming software, and`, `Implement and troubleshoot authentication, authori`, `Get technical help deploying and running large lan`, `Build recruitment software and resume processing s`, `Build and manage subscription billing and membersh`, `Develop and use AI systems for tax document proces`, `Assist with quantum mechanics and quantum computin`, `Debug and fix machine learning and AI system error`, `Provide current soccer standings, predictions, tra`, `Build recruitment software and resume processing s`, `Debug and fix automated cryptocurrency and forex t`, `Assist with civic information, government services`, `Debug and fix machine learning and AI system error`, `Analyze and extract structured data from cryptocur`, `Provide current soccer standings, predictions, tra`, `Provide advice and information about pet health, b`, `Debug and fix automated cryptocurrency and forex t`, `Respond to peer reviewers and revise manuscripts f`, `Implement and troubleshoot authentication, authori`, `Resolve payment, billing, subscription, and accoun`, `Analyze financial markets and develop forecasting `, `Assist with software project planning, specificati`, `Assist with physics and cosmology education, probl`, `Analyze market research data and customer feedback`
- **request::task_success** (1460 distincts) : `Build recruitment software and resume processing s`, `Configure and troubleshoot smart home automation a`, `Debug and fix automated cryptocurrency and forex t`, `Debug and fix machine learning and AI system error`, `Debug and fix automated cryptocurrency and forex t`, `Provide current soccer standings, predictions, tra`, `Respond to peer reviewers and revise manuscripts f`, `Assist with civic information, government services`, `Get technical help deploying and running large lan`, `Resolve payment, billing, subscription, and accoun`, `Assist with civic information, government services`, `Analyze and extract structured data from cryptocur`, `Develop and debug blockchain applications, smart c`, `Get technical help deploying and running large lan`, `Draft and refine graduate school and academic job `, `Debug and fix machine learning and AI system error`, `Implement and troubleshoot authentication, authori`, `Assist with game development, gaming software, and`, `Provide advice and information about pet health, b`, `Develop and use AI systems for tax document proces`, `Analyze and extract structured data from cryptocur`, `Configure and troubleshoot smart home automation a`, `Develop and debug blockchain applications, smart c`, `Draft and refine graduate school and academic job `, `Implement and troubleshoot authentication, authori`, `Build and manage subscription billing and membersh`, `Provide advice and information about pet health, b`, `Assist with quantum mechanics and quantum computin`, `Resolve payment, billing, subscription, and accoun`, `Build and manage subscription billing and membersh`, `Assist with game development, gaming software, and`, `Respond to peer reviewers and revise manuscripts f`, `Provide current soccer standings, predictions, tra`, `Assist with quantum mechanics and quantum computin`, `Build recruitment software and resume processing s`, `Develop and use AI systems for tax document proces`, `Assist with criminology, criminal justice, and dig`, `Complete law school assignments and exam preparati`, `Assist with real estate business operations, marke`, `Assist with cybersecurity vulnerability analysis, `
- **request::use_case** (2288 distincts) : `Implement and troubleshoot authentication, authori`, `Get technical help deploying and running large lan`, `Build and manage subscription billing and membersh`, `Configure and troubleshoot smart home automation a`, `Configure and troubleshoot smart home automation a`, `Draft and refine graduate school and academic job `, `Debug and fix automated cryptocurrency and forex t`, `Debug and fix automated cryptocurrency and forex t`, `Implement and troubleshoot authentication, authori`, `Resolve payment, billing, subscription, and accoun`, `Assist with game development, gaming software, and`, `Debug and fix machine learning and AI system error`, `Analyze and extract structured data from cryptocur`, `Implement and troubleshoot authentication, authori`, `Build recruitment software and resume processing s`, `Develop and use AI systems for tax document proces`, `Assist with quantum mechanics and quantum computin`, `Respond to peer reviewers and revise manuscripts f`, `Build and manage subscription billing and membersh`, `Configure and troubleshoot smart home automation a`, `Assist with game development, gaming software, and`, `Assist with civic information, government services`, `Resolve payment, billing, subscription, and accoun`, `Provide current soccer standings, predictions, tra`, `Assist with quantum mechanics and quantum computin`, `Provide advice and information about pet health, b`, `Get technical help deploying and running large lan`, `Develop and debug blockchain applications, smart c`, `Develop and debug blockchain applications, smart c`, `Draft and refine graduate school and academic job `, `Assist with civic information, government services`, `Assist with game development, gaming software, and`, `Build and manage subscription billing and membersh`, `Assist with game development, gaming software, and`, `Assist with civic information, government services`, `Resolve payment, billing, subscription, and accoun`, `Provide current soccer standings, predictions, tra`, `Draft and refine graduate school and academic job `, `Debug and fix machine learning and AI system error`, `Provide advice and information about pet health, b`
- **task_success** (3 distincts) : `yes`, `no`, `not_classified`
- **use_case** (5 distincts) : `work`, `personal`, `coursework`, `not_classified`, `none`

Lignes pour les pays étudiés : 

Premières lignes :

```
  geo_id geography date_start   date_end            platform_and_product          facet  level             variable    cluster_name      value
0     AD   country 2026-02-05 2026-02-12  Claude AI (Free, Pro, and Max)  collaboration      0  collaboration_count       directive  15.000000
1     AD   country 2026-02-05 2026-02-12  Claude AI (Free, Pro, and Max)  collaboration      0    collaboration_pct       directive  20.270270
2     AD   country 2026-02-05 2026-02-12  Claude AI (Free, Pro, and Max)  collaboration      0  collaboration_count        learning  20.000000
3     AD   country 2026-02-05 2026-02-12  Claude AI (Free, Pro, and Max)  collaboration      0    collaboration_pct        learning  27.027027
4     AD   country 2026-02-05 2026-02-12  Claude AI (Free, Pro, and Max)  collaboration      0  collaboration_count  not_classified  16.000000
```

## Version 2026-06-26

| Fichier | Taille (Mo) |
|---|---|
| `release_2026_06_26/data/aei_1p_api_2026-06-26.csv` | 73.70 |
| `release_2026_06_26/data/aei_claude_ai_2026-06-26.csv` | 209.02 |
| `release_2026_06_26/data_documentation.md` | 0.01 |

### `release_2026_06_26/data/aei_1p_api_2026-06-26.csv`

- Lignes : 491 705
- Taille : 73.7 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `date_start` | DATE | 2 | 0 | `2026-05-01` (256786), `2026-04-01` (234919) |
| `date_end` | DATE | 2 | 0 | `2026-06-01` (256786), `2026-05-01` (234919) |
| `geo_id` | VARCHAR | 1 | 0 | `GLOBAL` (491705) |
| `geo_level` | VARCHAR | 1 | 0 | `global` (491705) |
| `category_name` | VARCHAR | 4 | 0 | `onet` (314096), `request` (106831), `soc_occupation` (70674), `overall` (104) |
| `hierarchy_level` | BIGINT | 4 | 0 | `0` (373297), `1` (91687), `2` (22947), `3` (3774) |
| `metric_id` | VARCHAR | 53 | 0 | `artifact_ml_or_ai_system_pct` (9645), `artifact_document_or_report_pct` (9645), `artifact_data_or_spreadsheet_pct` (9645), `artifact_audio_or_music_pct` (9645), `artifact_math_or_calculation_pct` (9645), `artifact_code_fix_or_debug_pct` (9645), `artifact_blog_or_article_pct` (9645), `artifact_plan_or_strategy_pct` (9645), `artifact_video_or_animation_pct` (9645), `artifact_email_or_message_pct` (9645), `artifact_analysis_or_summary_pct` (9645), `artifact_advice_or_recommendation_pct` (9645), `artifact_sql_or_database_query_pct` (9645), `artifact_app_or_website_pct` (9645), `artifact_game_or_interactive_pct` (9645), `artifact_chart_or_visualization_pct` (9645), `artifact_resume_or_job_application_pct` (9645), `artifact_script_or_snippet_pct` (9645), `artifact_config_or_infra_pct` (9645), `artifact_marketing_or_social_content_pct` (9645), `artifact_image_or_graphic_pct` (9645), `artifact_educational_material_pct` (9645), `artifact_creative_writing_pct` (9645), `artifact_academic_paper_or_thesis_pct` (9645), `artifact_recipe_or_meal_plan_pct` (9645), `artifact_ui_or_design_mockup_pct` (9645), `ai_autonomy_mean` (9645), `ai_education_years_mean` (9645), `artifact_idea_or_brainstorm_pct` (9645), `artifact_other_pct` (9645), `artifact_translation_pct` (9645), `artifact_explanation_or_answer_pct` (9645), `human_education_years_mean` (9645), `artifact_presentation_or_slides_pct` (9645), `human_only_ability_pct` (9645), `artifact_none_pct` (9645), `use_case_work_pct` (9644), `use_case_personal_pct` (9644), `multitasking_pct` (9644), `use_case_coursework_pct` (9644), `collaboration_none_pct` (9643), `collaboration_learning_pct` (9643), `collaboration_feedback_loop_pct` (9643), `collaboration_validation_pct` (9643), `collaboration_directive_pct` (9643), `collaboration_task_iteration_pct` (9643), `pct` (9643), `human_with_ai_time_mean` (9638), `human_only_time_mean` (9636), `collaboration_bucket_augmentation_pct` (9565), `collaboration_bucket_automation_pct` (9565), `usage_pct` (2), `usage_per_capita_index` (2) |
| `value` | DOUBLE | 9497 | 0 | `0.0` (173820), `0.01` (4892), `0.02` (3881), `0.03` (3279), `0.04` (2768), `0.05` (2436), `0.06` (2162), `0.07` (2126), … |
| `node_name` | VARCHAR | 5215 | 0 | `Investigate illegal or suspicious activities.` (204), `Threat detection` (204), `API debugging` (204), `Spirituality and metaphysical practices` (204), `Prepare financial documents, reports, or budgets.` (204), `Schedule appointments.` (204), `Astronomy` (204), `Bilingual drafting` (204), … |
| `node_external_id` | VARCHAR | 5241 | 0 | `21` (204), `67049d9d-f5ae-5ee4-bbcc-5729cb26e80b` (204), `4a2abe54-7c72-5425-91bd-bfe1eb474219` (204), `34e66821-6e6d-55ad-87cb-d9c05fbeded1` (204), `e71ede6e-00ee-56e9-bd6d-dd7b47bbce31` (204), `54180b18-a1d2-54f7-aebd-218bf3bd0fd7` (204), `41` (204), `c2977b03-3af8-5b46-b932-763c40ac11b3` (204), … |

Croisement `geo_level` × `category_name` :

| geo_level | category_name | lignes |
|---|---|---|
| global | onet | 314096 |
| global | overall | 104 |
| global | request | 106831 |
| global | soc_occupation | 70674 |

Croisement `category_name` × `metric_id` :

| category_name | metric_id | lignes |
|---|---|---|
| onet | ai_autonomy_mean | 6162 |
| onet | ai_education_years_mean | 6162 |
| onet | artifact_academic_paper_or_thesis_pct | 6162 |
| onet | artifact_advice_or_recommendation_pct | 6162 |
| onet | artifact_analysis_or_summary_pct | 6162 |
| onet | artifact_app_or_website_pct | 6162 |
| onet | artifact_audio_or_music_pct | 6162 |
| onet | artifact_blog_or_article_pct | 6162 |
| onet | artifact_chart_or_visualization_pct | 6162 |
| onet | artifact_code_fix_or_debug_pct | 6162 |
| onet | artifact_config_or_infra_pct | 6162 |
| onet | artifact_creative_writing_pct | 6162 |
| onet | artifact_data_or_spreadsheet_pct | 6162 |
| onet | artifact_document_or_report_pct | 6162 |
| onet | artifact_educational_material_pct | 6162 |
| onet | artifact_email_or_message_pct | 6162 |
| onet | artifact_explanation_or_answer_pct | 6162 |
| onet | artifact_game_or_interactive_pct | 6162 |
| onet | artifact_idea_or_brainstorm_pct | 6162 |
| onet | artifact_image_or_graphic_pct | 6162 |
| onet | artifact_marketing_or_social_content_pct | 6162 |
| onet | artifact_math_or_calculation_pct | 6162 |
| onet | artifact_ml_or_ai_system_pct | 6162 |
| onet | artifact_none_pct | 6162 |
| onet | artifact_other_pct | 6162 |
| onet | artifact_plan_or_strategy_pct | 6162 |
| onet | artifact_presentation_or_slides_pct | 6162 |
| onet | artifact_recipe_or_meal_plan_pct | 6162 |
| onet | artifact_resume_or_job_application_pct | 6162 |
| onet | artifact_script_or_snippet_pct | 6162 |
| onet | artifact_sql_or_database_query_pct | 6162 |
| onet | artifact_translation_pct | 6162 |
| onet | artifact_ui_or_design_mockup_pct | 6162 |
| onet | artifact_video_or_animation_pct | 6162 |
| onet | collaboration_bucket_augmentation_pct | 6094 |
| onet | collaboration_bucket_automation_pct | 6094 |
| onet | collaboration_directive_pct | 6160 |
| onet | collaboration_feedback_loop_pct | 6160 |
| onet | collaboration_learning_pct | 6160 |
| onet | collaboration_none_pct | 6160 |
| onet | collaboration_task_iteration_pct | 6160 |
| onet | collaboration_validation_pct | 6160 |
| onet | human_education_years_mean | 6162 |
| onet | human_only_ability_pct | 6162 |
| onet | human_only_time_mean | 6154 |
| onet | human_with_ai_time_mean | 6156 |
| onet | multitasking_pct | 6161 |
| onet | pct | 6162 |
| onet | use_case_coursework_pct | 6161 |
| onet | use_case_personal_pct | 6161 |
| onet | use_case_work_pct | 6161 |
| overall | ai_autonomy_mean | 2 |
| overall | ai_education_years_mean | 2 |
| overall | artifact_academic_paper_or_thesis_pct | 2 |
| overall | artifact_advice_or_recommendation_pct | 2 |
| overall | artifact_analysis_or_summary_pct | 2 |
| overall | artifact_app_or_website_pct | 2 |
| overall | artifact_audio_or_music_pct | 2 |
| overall | artifact_blog_or_article_pct | 2 |
| overall | artifact_chart_or_visualization_pct | 2 |
| overall | artifact_code_fix_or_debug_pct | 2 |
| overall | artifact_config_or_infra_pct | 2 |
| overall | artifact_creative_writing_pct | 2 |
| overall | artifact_data_or_spreadsheet_pct | 2 |
| overall | artifact_document_or_report_pct | 2 |
| overall | artifact_educational_material_pct | 2 |
| overall | artifact_email_or_message_pct | 2 |
| overall | artifact_explanation_or_answer_pct | 2 |
| overall | artifact_game_or_interactive_pct | 2 |
| overall | artifact_idea_or_brainstorm_pct | 2 |
| overall | artifact_image_or_graphic_pct | 2 |
| overall | artifact_marketing_or_social_content_pct | 2 |
| overall | artifact_math_or_calculation_pct | 2 |
| overall | artifact_ml_or_ai_system_pct | 2 |
| overall | artifact_none_pct | 2 |
| overall | artifact_other_pct | 2 |
| overall | artifact_plan_or_strategy_pct | 2 |
| overall | artifact_presentation_or_slides_pct | 2 |
| overall | artifact_recipe_or_meal_plan_pct | 2 |
| overall | artifact_resume_or_job_application_pct | 2 |
| overall | artifact_script_or_snippet_pct | 2 |
| overall | artifact_sql_or_database_query_pct | 2 |
| overall | artifact_translation_pct | 2 |
| overall | artifact_ui_or_design_mockup_pct | 2 |
| overall | artifact_video_or_animation_pct | 2 |
| overall | collaboration_bucket_augmentation_pct | 2 |
| overall | collaboration_bucket_automation_pct | 2 |
| overall | collaboration_directive_pct | 2 |
| overall | collaboration_feedback_loop_pct | 2 |
| overall | collaboration_learning_pct | 2 |
| overall | collaboration_none_pct | 2 |
| overall | collaboration_task_iteration_pct | 2 |
| overall | collaboration_validation_pct | 2 |
| overall | human_education_years_mean | 2 |
| overall | human_only_ability_pct | 2 |
| overall | human_only_time_mean | 2 |
| overall | human_with_ai_time_mean | 2 |
| overall | multitasking_pct | 2 |
| overall | usage_pct | 2 |
| overall | usage_per_capita_index | 2 |
| overall | use_case_coursework_pct | 2 |
| overall | use_case_personal_pct | 2 |
| overall | use_case_work_pct | 2 |
| request | ai_autonomy_mean | 2095 |
| request | ai_education_years_mean | 2095 |
| request | artifact_academic_paper_or_thesis_pct | 2095 |
| request | artifact_advice_or_recommendation_pct | 2095 |
| request | artifact_analysis_or_summary_pct | 2095 |
| request | artifact_app_or_website_pct | 2095 |
| request | artifact_audio_or_music_pct | 2095 |
| request | artifact_blog_or_article_pct | 2095 |
| request | artifact_chart_or_visualization_pct | 2095 |
| request | artifact_code_fix_or_debug_pct | 2095 |
| request | artifact_config_or_infra_pct | 2095 |
| request | artifact_creative_writing_pct | 2095 |
| request | artifact_data_or_spreadsheet_pct | 2095 |
| request | artifact_document_or_report_pct | 2095 |
| request | artifact_educational_material_pct | 2095 |
| request | artifact_email_or_message_pct | 2095 |
| request | artifact_explanation_or_answer_pct | 2095 |
| request | artifact_game_or_interactive_pct | 2095 |
| request | artifact_idea_or_brainstorm_pct | 2095 |
| request | artifact_image_or_graphic_pct | 2095 |
| request | artifact_marketing_or_social_content_pct | 2095 |
| request | artifact_math_or_calculation_pct | 2095 |
| request | artifact_ml_or_ai_system_pct | 2095 |
| request | artifact_none_pct | 2095 |
| request | artifact_other_pct | 2095 |
| request | artifact_plan_or_strategy_pct | 2095 |
| request | artifact_presentation_or_slides_pct | 2095 |
| request | artifact_recipe_or_meal_plan_pct | 2095 |
| request | artifact_resume_or_job_application_pct | 2095 |
| request | artifact_script_or_snippet_pct | 2095 |
| request | artifact_sql_or_database_query_pct | 2095 |
| request | artifact_translation_pct | 2095 |
| request | artifact_ui_or_design_mockup_pct | 2095 |
| request | artifact_video_or_animation_pct | 2095 |
| request | collaboration_bucket_augmentation_pct | 2088 |
| request | collaboration_bucket_automation_pct | 2088 |
| request | collaboration_directive_pct | 2095 |
| request | collaboration_feedback_loop_pct | 2095 |
| request | collaboration_learning_pct | 2095 |
| request | collaboration_none_pct | 2095 |
| request | collaboration_task_iteration_pct | 2095 |
| request | collaboration_validation_pct | 2095 |
| request | human_education_years_mean | 2095 |
| request | human_only_ability_pct | 2095 |
| request | human_only_time_mean | 2095 |
| request | human_with_ai_time_mean | 2095 |
| request | multitasking_pct | 2095 |
| request | pct | 2095 |
| request | use_case_coursework_pct | 2095 |
| request | use_case_personal_pct | 2095 |
| request | use_case_work_pct | 2095 |
| soc_occupation | ai_autonomy_mean | 1386 |
| soc_occupation | ai_education_years_mean | 1386 |
| soc_occupation | artifact_academic_paper_or_thesis_pct | 1386 |
| soc_occupation | artifact_advice_or_recommendation_pct | 1386 |
| soc_occupation | artifact_analysis_or_summary_pct | 1386 |
| soc_occupation | artifact_app_or_website_pct | 1386 |
| soc_occupation | artifact_audio_or_music_pct | 1386 |
| soc_occupation | artifact_blog_or_article_pct | 1386 |
| soc_occupation | artifact_chart_or_visualization_pct | 1386 |
| soc_occupation | artifact_code_fix_or_debug_pct | 1386 |
| soc_occupation | artifact_config_or_infra_pct | 1386 |
| soc_occupation | artifact_creative_writing_pct | 1386 |
| soc_occupation | artifact_data_or_spreadsheet_pct | 1386 |
| soc_occupation | artifact_document_or_report_pct | 1386 |
| soc_occupation | artifact_educational_material_pct | 1386 |
| soc_occupation | artifact_email_or_message_pct | 1386 |
| soc_occupation | artifact_explanation_or_answer_pct | 1386 |
| soc_occupation | artifact_game_or_interactive_pct | 1386 |
| soc_occupation | artifact_idea_or_brainstorm_pct | 1386 |
| soc_occupation | artifact_image_or_graphic_pct | 1386 |
| soc_occupation | artifact_marketing_or_social_content_pct | 1386 |
| soc_occupation | artifact_math_or_calculation_pct | 1386 |
| soc_occupation | artifact_ml_or_ai_system_pct | 1386 |
| soc_occupation | artifact_none_pct | 1386 |
| soc_occupation | artifact_other_pct | 1386 |
| soc_occupation | artifact_plan_or_strategy_pct | 1386 |
| soc_occupation | artifact_presentation_or_slides_pct | 1386 |
| soc_occupation | artifact_recipe_or_meal_plan_pct | 1386 |
| soc_occupation | artifact_resume_or_job_application_pct | 1386 |
| soc_occupation | artifact_script_or_snippet_pct | 1386 |
| soc_occupation | artifact_sql_or_database_query_pct | 1386 |
| soc_occupation | artifact_translation_pct | 1386 |
| soc_occupation | artifact_ui_or_design_mockup_pct | 1386 |
| soc_occupation | artifact_video_or_animation_pct | 1386 |
| soc_occupation | collaboration_bucket_augmentation_pct | 1381 |
| soc_occupation | collaboration_bucket_automation_pct | 1381 |
| soc_occupation | collaboration_directive_pct | 1386 |
| soc_occupation | collaboration_feedback_loop_pct | 1386 |
| soc_occupation | collaboration_learning_pct | 1386 |
| soc_occupation | collaboration_none_pct | 1386 |
| soc_occupation | collaboration_task_iteration_pct | 1386 |
| soc_occupation | collaboration_validation_pct | 1386 |
| soc_occupation | human_education_years_mean | 1386 |
| soc_occupation | human_only_ability_pct | 1386 |
| soc_occupation | human_only_time_mean | 1385 |
| soc_occupation | human_with_ai_time_mean | 1385 |
| soc_occupation | multitasking_pct | 1386 |
| soc_occupation | pct | 1386 |
| soc_occupation | use_case_coursework_pct | 1386 |
| soc_occupation | use_case_personal_pct | 1386 |
| soc_occupation | use_case_work_pct | 1386 |

Croisement `category_name` × `hierarchy_level` :

| category_name | hierarchy_level | lignes |
|---|---|---|
| onet | 0 | 218485 |
| onet | 1 | 70930 |
| onet | 2 | 20907 |
| onet | 3 | 3774 |
| overall | 0 | 104 |
| request | 0 | 86176 |
| request | 1 | 18615 |
| request | 2 | 2040 |
| soc_occupation | 0 | 68532 |
| soc_occupation | 1 | 2142 |

Exemples de `node_name` par `category_name` (40 max, par fréquence) :

- **onet** (3408 distincts) : `Gather information for news stories.`, `Develop safety standards, policies, or procedures.`, `Coach others.`, `Prepare financial documents, reports, or budgets.`, `Advise others on business or operational matters.`, `Advise others on financial matters.`, `Promote products, services, or programs.`, `Maintain operational records.`, `Assist individuals with paperwork.`, `Conduct amusement or gaming activities.`, `Design structures or facilities.`, `Implement security measures for computer or inform`, `Develop financial or business plans.`, `Mark materials or objects for identification.`, `Evaluate employee performance.`, `Schedule appointments.`, `Investigate illegal or suspicious activities.`, `Develop and interpret organizational goals, polici`, `Calculate financial data.`, `Analyze business or financial data.`, `Explain regulations, policies, or procedures.`, `Obtain information about goods or services.`, `Perform human resources activities.`, `Sort materials or products.`, `Develop professional relationships or networks.`, `Maintain inventory records.`, `Store, retrieve, and manipulate data for analysis `, `Report to management about asset utilization and a`, `Adapt or design computer hardware or software for `, `Counsel others about personal matters.`, `Assign duties or work schedules to employees.`, `Identify or develop business rules or standard ope`, `Estimating the Quantifiable Characteristics of Pro`, `Advise others regarding green practices or environ`, `Prepare documents, such as invoices or warranties.`, `Identify new applications for existing technologie`, `Confer with network users about solutions to exist`, `Use the computer in the analysis and solution of b`, `Counsel clients on mental health or personal achie`, `Communicate with others about operational plans or`
- **overall** (1 distincts) : `Overall`
- **request** (1083 distincts) : `Digital forensics`, `Literary analysis`, `Debugging`, `Alert routing`, `Astronomy`, `Reverse engineering`, `Emotional Wellbeing and Support`, `Security operations`, `Financial modeling`, `Translation`, `Philosophy`, `Memory retrieval`, `Instructional design`, `Gaming`, `API debugging`, `Bilingual drafting`, `Animal behavior`, `Prompt engineering`, `Infant care`, `Business telephony`, `Empty inputs`, `Opinion writing`, `Threat detection`, `Spirituality and metaphysical practices`, `Parts sourcing`, `Internship reports`, `Product development`, `Numerical methods`, `Travel documents`, `Business registration`, `Workplace conflict`, `Digital products`, `Test execution`, `Changelog notes`, `Recipe requests`, `Industry and technology`, `Financial data validation`, `Geography`, `Trivia`, `Exam preparation`
- **soc_occupation** (723 distincts) : `Securities, Commodities, and Financial Services Sa`, `Pharmacists`, `Textile Bleaching and Dyeing Machine Operators and`, `Coating, Painting, and Spraying Machine Setters, O`, `Crushing, Grinding, and Polishing Machine Setters,`, `Biostatisticians`, `Recreation Workers`, `Lawyers`, `Service Unit Operators, Oil and Gas`, `Emergency Medical Technicians`, `Property, Real Estate, and Community Association M`, `Pediatric Surgeons`, `Insurance Sales Agents`, `Low Vision Therapists, Orientation and Mobility Sp`, `Climate Change Policy Analysts`, `Environmental Engineering Technologists and Techni`, `Personal Financial Advisors`, `Bus Drivers, School`, `Desktop Publishers`, `Dermatologists`, `Industrial Ecologists`, `Medical Secretaries and Administrative Assistants`, `Librarians and Media Collections Specialists`, `Ushers, Lobby Attendants, and Ticket Takers`, `Construction and Building Inspectors`, `Health and Safety Engineers, Except Mining Safety `, `Nurse Practitioners`, `Electric Motor, Power Tool, and Related Repairers`, `Recreational Therapists`, `Food Preparation Workers`, `Parking Enforcement Workers`, `Computer and Information Research Scientists`, `Urban and Regional Planners`, `Engineering Teachers, Postsecondary`, `Switchboard Operators, Including Answering Service`, `Mechanical Door Repairers`, `Dietitians and Nutritionists`, `Energy Engineers, Except Wind and Solar`, `Retail Salespersons`, `Cooks, Institution and Cafeteria`

Lignes pour les pays étudiés : 

Premières lignes :

```
  date_start   date_end  geo_id geo_level category_name  hierarchy_level                         metric_id  value                                node_name node_external_id
0 2026-05-01 2026-06-01  GLOBAL    global          onet                0             use_case_personal_pct   2.67  Write speeches, press releases, or o...            18924
1 2026-05-01 2026-06-01  GLOBAL    global          onet                0  collaboration_task_iteration_pct  11.33  Write speeches, press releases, or o...            18924
2 2026-05-01 2026-06-01  GLOBAL    global          onet                3  artifact_game_or_interactive_pct   4.88              Handling and Moving Objects        4.A.3.a.2
3 2026-05-01 2026-06-01  GLOBAL    global          onet                3   collaboration_feedback_loop_pct  14.63              Handling and Moving Objects        4.A.3.a.2
4 2026-05-01 2026-06-01  GLOBAL    global          onet                3          artifact_translation_pct   0.98              Handling and Moving Objects        4.A.3.a.2
```

### `release_2026_06_26/data/aei_claude_ai_2026-06-26.csv`

- Lignes : 1 636 573
- Taille : 209.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `date_start` | DATE | 2 | 0 | `2026-05-01` (892804), `2026-04-01` (743769) |
| `date_end` | DATE | 2 | 0 | `2026-06-01` (892804), `2026-05-01` (743769) |
| `geo_id` | VARCHAR | 774 | 0 | `GLOBAL` (554941), `USA` (15786), `IND` (12833), `FRA` (12210), `GBR` (12125), `JPN` (11883), `CAN` (11839), `DEU` (11699), … |
| `geo_level` | VARCHAR | 3 | 0 | `country` (673272), `global` (554941), `subregion` (408360) |
| `category_name` | VARCHAR | 4 | 0 | `onet` (744544), `request` (465202), `soc_occupation` (353817), `overall` (73010) |
| `hierarchy_level` | BIGINT | 4 | 0 | `0` (791737), `1` (403029), `2` (240931), `3` (200876) |
| `metric_id` | VARCHAR | 53 | 0 | `pct` (532491), `use_case_coursework_pct` (22061), `use_case_personal_pct` (22061), `multitasking_pct` (22061), `human_education_years_mean` (22061), `use_case_work_pct` (22061), `ai_autonomy_mean` (22060), `human_only_ability_pct` (22060), `ai_education_years_mean` (22060), `artifact_script_or_snippet_pct` (22059), `artifact_ui_or_design_mockup_pct` (22059), `artifact_app_or_website_pct` (22059), `artifact_other_pct` (22059), `artifact_image_or_graphic_pct` (22059), `artifact_data_or_spreadsheet_pct` (22059), `artifact_sql_or_database_query_pct` (22059), `artifact_academic_paper_or_thesis_pct` (22059), `artifact_creative_writing_pct` (22059), `artifact_audio_or_music_pct` (22059), `artifact_chart_or_visualization_pct` (22059), `artifact_ml_or_ai_system_pct` (22059), `artifact_game_or_interactive_pct` (22059), `artifact_marketing_or_social_content_pct` (22059), `artifact_document_or_report_pct` (22059), `artifact_blog_or_article_pct` (22059), `artifact_code_fix_or_debug_pct` (22059), `artifact_math_or_calculation_pct` (22059), `artifact_recipe_or_meal_plan_pct` (22059), `artifact_email_or_message_pct` (22059), `artifact_analysis_or_summary_pct` (22059), `artifact_plan_or_strategy_pct` (22059), `artifact_resume_or_job_application_pct` (22059), `artifact_config_or_infra_pct` (22059), `artifact_educational_material_pct` (22059), `artifact_video_or_animation_pct` (22059), `artifact_idea_or_brainstorm_pct` (22059), `artifact_presentation_or_slides_pct` (22059), `artifact_translation_pct` (22059), `artifact_advice_or_recommendation_pct` (22059), `artifact_none_pct` (22059), `artifact_explanation_or_answer_pct` (22059), `collaboration_learning_pct` (22043), `collaboration_feedback_loop_pct` (22043), `collaboration_none_pct` (22043), `collaboration_task_iteration_pct` (22043), `collaboration_directive_pct` (22043), `collaboration_validation_pct` (22043), `human_with_ai_time_mean` (22038), `human_only_time_mean` (22035), `collaboration_bucket_augmentation_pct` (21809), `collaboration_bucket_automation_pct` (21809), `usage_pct` (1421), `usage_per_capita_index` (339) |
| `value` | DOUBLE | 10182 | 0 | `0.0` (303138), `0.01` (16740), `0.02` (15679), `0.03` (14926), `0.04` (13515), `0.07` (13112), `0.05` (12948), `0.09` (12906), … |
| `node_name` | VARCHAR | 5784 | 0 | `Overall` (73010), `Content Creation & Copywriting` (9781), `Arts, Design, Entertainment, Sports, and Media` (9781), `Education & Learning` (9781), `Thinking Creatively` (9781), `Working with Computers` (9781), `Providing Consultation and Advice to Others` (9781), `Documenting/Recording Information` (9781), … |
| `node_external_id` | VARCHAR | 5810 | 0 | `-` (73010), `41` (9883), `13` (9835), `4.A.1.a.1` (9781), `4.A.4.b.6` (9781), `43` (9781), `4.A.2.b.2` (9781), `4.A.3.b.1` (9781), … |

Croisement `geo_level` × `category_name` :

| geo_level | category_name | lignes |
|---|---|---|
| country | onet | 251062 |
| country | overall | 12220 |
| country | request | 213640 |
| country | soc_occupation | 196350 |
| global | onet | 356252 |
| global | overall | 104 |
| global | request | 124234 |
| global | soc_occupation | 74351 |
| subregion | onet | 137230 |
| subregion | overall | 60686 |
| subregion | request | 127328 |
| subregion | soc_occupation | 83116 |

Croisement `category_name` × `metric_id` :

| category_name | metric_id | lignes |
|---|---|---|
| onet | ai_autonomy_mean | 10548 |
| onet | ai_education_years_mean | 10548 |
| onet | artifact_academic_paper_or_thesis_pct | 10547 |
| onet | artifact_advice_or_recommendation_pct | 10547 |
| onet | artifact_analysis_or_summary_pct | 10547 |
| onet | artifact_app_or_website_pct | 10547 |
| onet | artifact_audio_or_music_pct | 10547 |
| onet | artifact_blog_or_article_pct | 10547 |
| onet | artifact_chart_or_visualization_pct | 10547 |
| onet | artifact_code_fix_or_debug_pct | 10547 |
| onet | artifact_config_or_infra_pct | 10547 |
| onet | artifact_creative_writing_pct | 10547 |
| onet | artifact_data_or_spreadsheet_pct | 10547 |
| onet | artifact_document_or_report_pct | 10547 |
| onet | artifact_educational_material_pct | 10547 |
| onet | artifact_email_or_message_pct | 10547 |
| onet | artifact_explanation_or_answer_pct | 10547 |
| onet | artifact_game_or_interactive_pct | 10547 |
| onet | artifact_idea_or_brainstorm_pct | 10547 |
| onet | artifact_image_or_graphic_pct | 10547 |
| onet | artifact_marketing_or_social_content_pct | 10547 |
| onet | artifact_math_or_calculation_pct | 10547 |
| onet | artifact_ml_or_ai_system_pct | 10547 |
| onet | artifact_none_pct | 10547 |
| onet | artifact_other_pct | 10547 |
| onet | artifact_plan_or_strategy_pct | 10547 |
| onet | artifact_presentation_or_slides_pct | 10547 |
| onet | artifact_recipe_or_meal_plan_pct | 10547 |
| onet | artifact_resume_or_job_application_pct | 10547 |
| onet | artifact_script_or_snippet_pct | 10547 |
| onet | artifact_sql_or_database_query_pct | 10547 |
| onet | artifact_translation_pct | 10547 |
| onet | artifact_ui_or_design_mockup_pct | 10547 |
| onet | artifact_video_or_animation_pct | 10547 |
| onet | collaboration_bucket_augmentation_pct | 10417 |
| onet | collaboration_bucket_automation_pct | 10417 |
| onet | collaboration_directive_pct | 10535 |
| onet | collaboration_feedback_loop_pct | 10535 |
| onet | collaboration_learning_pct | 10535 |
| onet | collaboration_none_pct | 10535 |
| onet | collaboration_task_iteration_pct | 10535 |
| onet | collaboration_validation_pct | 10535 |
| onet | human_education_years_mean | 10549 |
| onet | human_only_ability_pct | 10548 |
| onet | human_only_time_mean | 10529 |
| onet | human_with_ai_time_mean | 10529 |
| onet | multitasking_pct | 10549 |
| onet | pct | 217549 |
| onet | use_case_coursework_pct | 10549 |
| onet | use_case_personal_pct | 10549 |
| onet | use_case_work_pct | 10549 |
| overall | ai_autonomy_mean | 1425 |
| overall | ai_education_years_mean | 1425 |
| overall | artifact_academic_paper_or_thesis_pct | 1425 |
| overall | artifact_advice_or_recommendation_pct | 1425 |
| overall | artifact_analysis_or_summary_pct | 1425 |
| overall | artifact_app_or_website_pct | 1425 |
| overall | artifact_audio_or_music_pct | 1425 |
| overall | artifact_blog_or_article_pct | 1425 |
| overall | artifact_chart_or_visualization_pct | 1425 |
| overall | artifact_code_fix_or_debug_pct | 1425 |
| overall | artifact_config_or_infra_pct | 1425 |
| overall | artifact_creative_writing_pct | 1425 |
| overall | artifact_data_or_spreadsheet_pct | 1425 |
| overall | artifact_document_or_report_pct | 1425 |
| overall | artifact_educational_material_pct | 1425 |
| overall | artifact_email_or_message_pct | 1425 |
| overall | artifact_explanation_or_answer_pct | 1425 |
| overall | artifact_game_or_interactive_pct | 1425 |
| overall | artifact_idea_or_brainstorm_pct | 1425 |
| overall | artifact_image_or_graphic_pct | 1425 |
| overall | artifact_marketing_or_social_content_pct | 1425 |
| overall | artifact_math_or_calculation_pct | 1425 |
| overall | artifact_ml_or_ai_system_pct | 1425 |
| overall | artifact_none_pct | 1425 |
| overall | artifact_other_pct | 1425 |
| overall | artifact_plan_or_strategy_pct | 1425 |
| overall | artifact_presentation_or_slides_pct | 1425 |
| overall | artifact_recipe_or_meal_plan_pct | 1425 |
| overall | artifact_resume_or_job_application_pct | 1425 |
| overall | artifact_script_or_snippet_pct | 1425 |
| overall | artifact_sql_or_database_query_pct | 1425 |
| overall | artifact_translation_pct | 1425 |
| overall | artifact_ui_or_design_mockup_pct | 1425 |
| overall | artifact_video_or_animation_pct | 1425 |
| overall | collaboration_bucket_augmentation_pct | 1425 |
| overall | collaboration_bucket_automation_pct | 1425 |
| overall | collaboration_directive_pct | 1425 |
| overall | collaboration_feedback_loop_pct | 1425 |
| overall | collaboration_learning_pct | 1425 |
| overall | collaboration_none_pct | 1425 |
| overall | collaboration_task_iteration_pct | 1425 |
| overall | collaboration_validation_pct | 1425 |
| overall | human_education_years_mean | 1425 |
| overall | human_only_ability_pct | 1425 |
| overall | human_only_time_mean | 1425 |
| overall | human_with_ai_time_mean | 1425 |
| overall | multitasking_pct | 1425 |
| overall | usage_pct | 1421 |
| overall | usage_per_capita_index | 339 |
| overall | use_case_coursework_pct | 1425 |
| overall | use_case_personal_pct | 1425 |
| overall | use_case_work_pct | 1425 |
| request | ai_autonomy_mean | 5466 |
| request | ai_education_years_mean | 5466 |
| request | artifact_academic_paper_or_thesis_pct | 5466 |
| request | artifact_advice_or_recommendation_pct | 5466 |
| request | artifact_analysis_or_summary_pct | 5466 |
| request | artifact_app_or_website_pct | 5466 |
| request | artifact_audio_or_music_pct | 5466 |
| request | artifact_blog_or_article_pct | 5466 |
| request | artifact_chart_or_visualization_pct | 5466 |
| request | artifact_code_fix_or_debug_pct | 5466 |
| request | artifact_config_or_infra_pct | 5466 |
| request | artifact_creative_writing_pct | 5466 |
| request | artifact_data_or_spreadsheet_pct | 5466 |
| request | artifact_document_or_report_pct | 5466 |
| request | artifact_educational_material_pct | 5466 |
| request | artifact_email_or_message_pct | 5466 |
| request | artifact_explanation_or_answer_pct | 5466 |
| request | artifact_game_or_interactive_pct | 5466 |
| request | artifact_idea_or_brainstorm_pct | 5466 |
| request | artifact_image_or_graphic_pct | 5466 |
| request | artifact_marketing_or_social_content_pct | 5466 |
| request | artifact_math_or_calculation_pct | 5466 |
| request | artifact_ml_or_ai_system_pct | 5466 |
| request | artifact_none_pct | 5466 |
| request | artifact_other_pct | 5466 |
| request | artifact_plan_or_strategy_pct | 5466 |
| request | artifact_presentation_or_slides_pct | 5466 |
| request | artifact_recipe_or_meal_plan_pct | 5466 |
| request | artifact_resume_or_job_application_pct | 5466 |
| request | artifact_script_or_snippet_pct | 5466 |
| request | artifact_sql_or_database_query_pct | 5466 |
| request | artifact_translation_pct | 5466 |
| request | artifact_ui_or_design_mockup_pct | 5466 |
| request | artifact_video_or_animation_pct | 5466 |
| request | collaboration_bucket_augmentation_pct | 5371 |
| request | collaboration_bucket_automation_pct | 5371 |
| request | collaboration_directive_pct | 5465 |
| request | collaboration_feedback_loop_pct | 5465 |
| request | collaboration_learning_pct | 5465 |
| request | collaboration_none_pct | 5465 |
| request | collaboration_task_iteration_pct | 5465 |
| request | collaboration_validation_pct | 5465 |
| request | human_education_years_mean | 5466 |
| request | human_only_ability_pct | 5466 |
| request | human_only_time_mean | 5465 |
| request | human_with_ai_time_mean | 5466 |
| request | multitasking_pct | 5466 |
| request | pct | 192099 |
| request | use_case_coursework_pct | 5466 |
| request | use_case_personal_pct | 5466 |
| request | use_case_work_pct | 5466 |
| soc_occupation | ai_autonomy_mean | 4621 |
| soc_occupation | ai_education_years_mean | 4621 |
| soc_occupation | artifact_academic_paper_or_thesis_pct | 4621 |
| soc_occupation | artifact_advice_or_recommendation_pct | 4621 |
| soc_occupation | artifact_analysis_or_summary_pct | 4621 |
| soc_occupation | artifact_app_or_website_pct | 4621 |
| soc_occupation | artifact_audio_or_music_pct | 4621 |
| soc_occupation | artifact_blog_or_article_pct | 4621 |
| soc_occupation | artifact_chart_or_visualization_pct | 4621 |
| soc_occupation | artifact_code_fix_or_debug_pct | 4621 |
| soc_occupation | artifact_config_or_infra_pct | 4621 |
| soc_occupation | artifact_creative_writing_pct | 4621 |
| soc_occupation | artifact_data_or_spreadsheet_pct | 4621 |
| soc_occupation | artifact_document_or_report_pct | 4621 |
| soc_occupation | artifact_educational_material_pct | 4621 |
| soc_occupation | artifact_email_or_message_pct | 4621 |
| soc_occupation | artifact_explanation_or_answer_pct | 4621 |
| soc_occupation | artifact_game_or_interactive_pct | 4621 |
| soc_occupation | artifact_idea_or_brainstorm_pct | 4621 |
| soc_occupation | artifact_image_or_graphic_pct | 4621 |
| soc_occupation | artifact_marketing_or_social_content_pct | 4621 |
| soc_occupation | artifact_math_or_calculation_pct | 4621 |
| soc_occupation | artifact_ml_or_ai_system_pct | 4621 |
| soc_occupation | artifact_none_pct | 4621 |
| soc_occupation | artifact_other_pct | 4621 |
| soc_occupation | artifact_plan_or_strategy_pct | 4621 |
| soc_occupation | artifact_presentation_or_slides_pct | 4621 |
| soc_occupation | artifact_recipe_or_meal_plan_pct | 4621 |
| soc_occupation | artifact_resume_or_job_application_pct | 4621 |
| soc_occupation | artifact_script_or_snippet_pct | 4621 |
| soc_occupation | artifact_sql_or_database_query_pct | 4621 |
| soc_occupation | artifact_translation_pct | 4621 |
| soc_occupation | artifact_ui_or_design_mockup_pct | 4621 |
| soc_occupation | artifact_video_or_animation_pct | 4621 |
| soc_occupation | collaboration_bucket_augmentation_pct | 4596 |
| soc_occupation | collaboration_bucket_automation_pct | 4596 |
| soc_occupation | collaboration_directive_pct | 4618 |
| soc_occupation | collaboration_feedback_loop_pct | 4618 |
| soc_occupation | collaboration_learning_pct | 4618 |
| soc_occupation | collaboration_none_pct | 4618 |
| soc_occupation | collaboration_task_iteration_pct | 4618 |
| soc_occupation | collaboration_validation_pct | 4618 |
| soc_occupation | human_education_years_mean | 4621 |
| soc_occupation | human_only_ability_pct | 4621 |
| soc_occupation | human_only_time_mean | 4616 |
| soc_occupation | human_with_ai_time_mean | 4618 |
| soc_occupation | multitasking_pct | 4621 |
| soc_occupation | pct | 122843 |
| soc_occupation | use_case_coursework_pct | 4621 |
| soc_occupation | use_case_personal_pct | 4621 |
| soc_occupation | use_case_work_pct | 4621 |

Croisement `category_name` × `hierarchy_level` :

| category_name | hierarchy_level | lignes |
|---|---|---|
| onet | 0 | 340069 |
| onet | 1 | 134864 |
| onet | 2 | 68735 |
| onet | 3 | 200876 |
| overall | 0 | 73010 |
| request | 0 | 204398 |
| request | 1 | 88608 |
| request | 2 | 172196 |
| soc_occupation | 0 | 174260 |
| soc_occupation | 1 | 179557 |

Exemples de `node_name` par `category_name` (40 max, par fréquence) :

- **onet** (3846 distincts) : `Working with Computers`, `Thinking Creatively`, `Documenting/Recording Information`, `Providing Consultation and Advice to Others`, `Getting Information`, `Making Decisions and Solving Problems`, `Analyzing Data or Information`, `Interpreting the Meaning of Information for Others`, `Training and Teaching Others`, `Performing for or Working Directly with the Public`, `Communicating with People Outside the Organization`, `Judging the Qualities of Objects, Services, or Peo`, `Processing Information`, `Performing Administrative Activities`, `Estimating the Quantifiable Characteristics of Pro`, `Evaluating Information to Determine Compliance wit`, `Communicating with Supervisors, Peers, or Subordin`, `Organizing, Planning, and Prioritizing Work`, `Developing Objectives and Strategies`, `Coaching and Developing Others`, `Assisting and Caring for Others`, `Monitoring Processes, Materials, or Surroundings`, `Scheduling Work and Activities`, `Inspecting Equipment, Structures, or Materials`, `Selling or Influencing Others`, `Advise others on business or operational matters.`, `Updating and Using Relevant Knowledge`, `Advise others on financial matters.`, `Identifying Objects, Actions, and Events`, `Advise others on the design or use of technologies`, `Gather information from physical or electronic sou`, `Advise others on products or services.`, `Prepare informational or instructional materials.`, `Provide technical support for software maintenance`, `Edit written materials or documents.`, `Write material for artistic or commercial purposes`, `Resolve computer problems.`, `Search information sources to find specific data.`, `Program computer systems or production equipment.`, `Explain regulations, policies, or procedures.`
- **overall** (1 distincts) : `Overall`
- **request** (1197 distincts) : `Software Development`, `Content Creation & Copywriting`, `Education & Learning`, `Research & Intelligence`, `Hobbies & Lifestyle`, `Document Processing & Extraction`, `Knowledge Retrieval & Enterprise Search`, `Business Process & Operations`, `Data Analysis & Business Intelligence`, `Existential, Relational, and Emotional Support`, `DevOps & Infrastructure Operations`, `Personal AI Assistant`, `Companionship & General Conversation`, `Customer Support & Service Operations`, `Compliance & Regulatory`, `Sales & Revenue Operations`, `Cybersecurity & Threat Detection`, `Other / Unclear`, `Conversation & Meeting Intelligence`, `Trust & Safety / Platform Integrity`, `Instructional design`, `Emotional Wellbeing and Support`, `API debugging`, `Homework`, `Web front-end`, `Promotional writing`, `Self-presentation writing`, `Financial modeling`, `Starting a business`, `Workplace writing`, `Gaming`, `Study materials`, `Translation`, `Slide decks`, `Formatted writing`, `Code design`, `Thesis writing`, `Structured extraction`, `Math and CS theory`, `Quiz assistance`
- **soc_occupation** (740 distincts) : `Computer and Mathematical`, `Office and Administrative Support`, `Educational Instruction and Library`, `Arts, Design, Entertainment, Sports, and Media`, `Sales and Related`, `Management`, `Life, Physical, and Social Science`, `Business and Financial Operations`, `Architecture and Engineering`, `Healthcare Practitioners and Technical`, `Community and Social Service`, `Personal Care and Service`, `Production`, `Healthcare Support`, `Legal`, `Installation, Maintenance, and Repair`, `Food Preparation and Serving Related`, `Transportation and Material Moving`, `Protective Service`, `Building and Grounds Cleaning and Maintenance`, `Construction and Extraction`, `Farming, Fishing, and Forestry`, `Document Management Specialists`, `Librarians and Media Collections Specialists`, `Editors`, `Writers and Authors`, `Computer User Support Specialists`, `Web and Digital Interface Designers`, `Counter and Rental Clerks`, `Computer Systems Analysts`, `Poets, Lyricists and Creative Writers`, `Data Warehousing Specialists`, `Computer Programmers`, `Technical Writers`, `News Analysts, Reporters, and Journalists`, `Software Quality Assurance Analysts and Testers`, `Substitute Teachers, Short-Term`, `Tutors`, `Web Developers`, `Library Technicians`

Lignes pour les pays étudiés : `BEL` (8524), `DEU` (11699), `ESP` (10956), `FRA` (12210), `GBR` (12125), `ITA` (10275), `NLD` (9602), `USA` (15786)

Premières lignes :

```
  date_start   date_end  geo_id  geo_level category_name  hierarchy_level metric_id  value                                node_name   node_external_id
0 2026-05-01 2026-06-01   ZA-WC  subregion          onet                2       pct   0.25  Prepare financial documents, reports...      4.A.3.b.6.I01
1 2026-05-01 2026-06-01   ZA-WC  subregion          onet                0       pct   0.40  Locate unusual or unique information...              22420
2 2026-05-01 2026-06-01   ZA-WC  subregion          onet                0       pct   0.68  Answer customers' questions, and pro...               2408
3 2026-05-01 2026-06-01  ZA-KZN  subregion          onet                1       pct   0.94  Advise others on business or operati...  4.A.4.b.6.I05.D10
4 2026-05-01 2026-06-01  ZA-KZN  subregion          onet                1       pct   2.18  Tutor students who need extra assist...  4.A.4.b.3.I02.D10
```

## Tables labor_market_impacts

| Fichier | Taille (Mo) |
|---|---|
| `labor_market_impacts/job_exposure.csv` | 0.04 |
| `labor_market_impacts/task_penetration.csv` | 1.80 |

### `labor_market_impacts/job_exposure.csv`

- Lignes : 756
- Taille : 0.0 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `occ_code` | VARCHAR | 756 | 0 | `11-3012` (1), `11-3051` (1), `11-9013` (1), `11-9031` (1), `11-9071` (1), `11-9081` (1), `11-9111` (1), `11-9131` (1), … |
| `title` | VARCHAR | 756 | 0 | `Public Relations Managers` (1), `Industrial Production Managers` (1), `Purchasing Managers` (1), `Transportation, Storage, and Distribution Managers` (1), `Human Resources Managers` (1), `Farmers, Ranchers, and Other Agricultural Managers` (1), `Postmasters and Mail Superintendents` (1), `Managers, All Other` (1), … |
| `observed_exposure` | DOUBLE | 329 | 0 | `0.0` (411), `0.0539` (2), `0.0659` (2), `0.0058` (2), `0.0333` (2), `0.0513` (2), `0.0108` (2), `0.0257` (2), … |

Premières lignes :

```
  occ_code                                title  observed_exposure
0  11-1011                     Chief Executives             0.0333
1  11-1021      General and Operations Managers             0.1378
2  11-1031                          Legislators             0.0000
3  11-2011  Advertising and Promotions Managers             0.1731
4  11-2021                   Marketing Managers             0.3195
```

### `labor_market_impacts/task_penetration.csv`

- Lignes : 17 998
- Taille : 1.8 Mo

| Colonne | Type | Distinctes | NULL | Modalités / exemples |
|---|---|---|---|---|
| `task` | VARCHAR | 17992 | 0 | `Write interesting and effective press releases, prepare info` (4), `Write interesting and effective press releases, prepare info` (4), `Act as a liaison between talent and directors, providing inf` (1), `Accept credit applications and verify credit references to p` (1), `Act as advisers to student organizations.` (1), `Accompany aircraft on flights to make in-flight adjustments ` (1), `Accompany children to and from school, on outings, and to me` (1), `Acquire, distribute and store supplies.` (1), … |
| `penetration` | DOUBLE | 870 | 0 | `0.0` (16644), `1.0` (204), `0.7239` (100), `0.7263` (8), `0.5` (4), `0.972` (4), `0.9561` (4), `0.9216` (3), … |

Premières lignes :

```
                                      task  penetration
0  Accept and check containers of mail ...          0.0
1  Accept and check containers of mail ...          0.0
2  Accept credit applications and verif...          0.0
3  Accept music requests from event gue...          0.0
4  Accept payment from customers, and m...          0.0
```
