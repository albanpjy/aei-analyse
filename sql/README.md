# sql/ — requêtes DuckDB nommées

Une requête par fichier `.sql`, chargée par son nom depuis R. Garder le SQL hors
du code R le rend lisible, testable dans le client `duckdb` en ligne de commande,
et suivi par `{targets}` : modifier une requête invalide les résultats qui en
dépendent. Les requêtes sont ajoutées en phase 2.
