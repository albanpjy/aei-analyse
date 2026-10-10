"""
tools/explorer_schema.py — Inspection des VRAIES données de l'AEI.

POURQUOI : la règle du projet est de ne jamais supposer un nom de colonne, de
facette ou de variable. Ce script, exécuté par GitHub Actions (seul endroit
avec accès à Hugging Face), inventorie chaque version épinglée et décrit chaque
CSV : colonnes, types, effectifs, modalités des colonnes catégorielles et
croisements clés. Le résultat est versionné dans docs/exploration/.

POURQUOI PYTHON ici, alors que le projet est en R : c'est un outil ponctuel de
reconnaissance. Le paquet Python `duckdb` s'installe en quelques secondes, alors
que le package R duckdb se compile depuis les sources en CI (près d'une heure).
Le pipeline du projet, lui, est entièrement en R.

Mêmes URL que le package R {aieconindex} (R/utilities.R) :
  liste   : https://huggingface.co/api/datasets/Anthropic/EconomicIndex/tree/main/<chemin>
  fichier : https://huggingface.co/datasets/Anthropic/EconomicIndex/resolve/main/<chemin>
"""
import csv
import datetime as dt
import json
import pathlib
import urllib.request

import duckdb

API = "https://huggingface.co/api/datasets/Anthropic/EconomicIndex/tree/main"
RESOLVE = "https://huggingface.co/datasets/Anthropic/EconomicIndex/resolve/main"
# Versions épinglées : identiques à aei_versions_epinglees() (R/config.R).
RELEASES = ["2025-02-10", "2025-03-27", "2025-09-15",
            "2026-01-15", "2026-03-24", "2026-06-26"]
SORTIE = pathlib.Path("docs/exploration")
CACHE = pathlib.Path("data/raw")
SORTIE.mkdir(parents=True, exist_ok=True)
con = duckdb.connect()


def lister(chemin):
    """Liste récursive d'un dossier du dépôt Hugging Face."""
    with urllib.request.urlopen(f"{API}/{chemin}") as r:
        items = json.load(r)
    out = []
    for it in items:
        if it["type"] == "directory":
            out += lister(it["path"])
        else:
            out.append({"path": it["path"], "size": it.get("size")})
    return out


def telecharger(chemin):
    dest = CACHE / chemin
    if not dest.exists():
        dest.parent.mkdir(parents=True, exist_ok=True)
        urllib.request.urlretrieve(f"{RESOLVE}/{chemin}", dest)
    return dest


def md_table(entetes, lignes):
    out = ["| " + " | ".join(entetes) + " |", "|" + "---|" * len(entetes)]
    for l in lignes:
        out.append("| " + " | ".join(str(x).replace("|", "\\|") for x in l) + " |")
    return out


def decrire_csv(chemin, titre):
    con.execute(f"CREATE OR REPLACE TABLE t AS SELECT * FROM read_csv('{chemin}', sample_size=-1)")
    n = con.execute("SELECT count(*) FROM t").fetchone()[0]
    schema = con.execute("DESCRIBE t").fetchall()
    out = [f"### `{titre}`", "", f"- Lignes : {n:,}".replace(",", " "),
           f"- Taille : {chemin.stat().st_size / 1024**2:.1f} Mo", ""]
    lignes = []
    cols = [s[0] for s in schema]
    for col, typ, *_ in schema:
        q = '"' + col.replace('"', '""') + '"'
        nd = con.execute(f"SELECT count(DISTINCT {q}) FROM t").fetchone()[0]
        nnull = con.execute(f"SELECT count(*) FROM t WHERE {q} IS NULL").fetchone()[0]
        lim = nd if nd <= 60 else 8
        ex = con.execute(f"SELECT CAST({q} AS VARCHAR), count(*) n FROM t GROUP BY 1 ORDER BY n DESC LIMIT {lim}").fetchall()
        txt = ", ".join(f"`{str(v)[:60]}` ({c})" for v, c in ex) + (", …" if nd > lim else "")
        lignes.append([f"`{col}`", typ, nd, nnull, txt])
    out += md_table(["Colonne", "Type", "Distinctes", "NULL", "Modalités / exemples"], lignes)
    # Croisements des colonnes structurantes (schémas « long » et « monthly »).
    paires = [("geography", "facet"), ("facet", "variable"), ("facet", "level"),
              ("geo_level", "category_name"), ("category_name", "metric_id"),
              ("category_name", "hierarchy_level"), ("platform_and_product", "facet")]
    for a, b in paires:
        if a in cols and b in cols:
            x = con.execute(f'SELECT "{a}", "{b}", count(*) FROM t GROUP BY ALL ORDER BY 1, 2').fetchall()
            out += ["", f"Croisement `{a}` × `{b}` :", ""] + md_table([a, b, "lignes"], x)
    # Modalités de l'item (cluster_name / node_name) par facette : on veut voir
    # par exemple les modes de collaboration réels.
    for fac, item in [("facet", "cluster_name"), ("category_name", "node_name")]:
        if fac in cols and item in cols:
            facs = [r[0] for r in con.execute(f'SELECT DISTINCT "{fac}" FROM t ORDER BY 1').fetchall()]
            out += ["", f"Exemples de `{item}` par `{fac}` (40 max, par fréquence) :", ""]
            for f in facs:
                nb = con.execute(f'SELECT count(DISTINCT "{item}") FROM t WHERE "{fac}" IS NOT DISTINCT FROM ?', [f]).fetchone()[0]
                ex = con.execute(f'SELECT "{item}", count(*) n FROM t WHERE "{fac}" IS NOT DISTINCT FROM ? GROUP BY 1 ORDER BY n DESC LIMIT 40', [f]).fetchall()
                out.append(f"- **{f}** ({nb} distincts) : " + ", ".join(f"`{str(v)[:50]}`" for v, _ in ex))
    if "geo_id" in cols:
        pays = con.execute("SELECT geo_id, count(*) FROM t WHERE geo_id IN ('FRA','DEU','GBR','ESP','ITA','BEL','NLD','USA') GROUP BY 1 ORDER BY 1").fetchall()
        out += ["", "Lignes pour les pays étudiés : " + ", ".join(f"`{p}` ({c})" for p, c in pays)]
    head = con.execute("SELECT * FROM t LIMIT 5").fetchdf().to_string(max_colwidth=40)
    return out + ["", "Premières lignes :", "", "```", head, "```", ""]


journal = ["# Exploration des données réelles de l'AEI", "",
           f"*Généré par `tools/explorer_schema.py` le {dt.datetime.utcnow():%Y-%m-%d %H:%M} UTC (GitHub Actions).*", ""]

racine = lister("")
with open(SORTIE / "racine_huggingface.json", "w") as f:
    json.dump(racine[:2000], f, indent=1)

for rel in RELEASES:
    rid = "release_" + rel.replace("-", "_")
    print("==", rel, flush=True)
    fichiers = lister(rid)
    with open(SORTIE / f"fichiers_{rel}.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["path", "size_bytes"])
        w.writerows([[x["path"], x["size"]] for x in fichiers])
    journal += [f"## Version {rel}", ""] + md_table(
        ["Fichier", "Taille (Mo)"], [[f"`{x['path']}`", f"{(x['size'] or 0) / 1024**2:.2f}"] for x in fichiers]) + [""]
    for x in fichiers:
        p = x["path"]
        if p.endswith(".md"):
            dest = SORTIE / rel / pathlib.Path(p).relative_to(rid)
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes(telecharger(p).read_bytes())
        elif p.endswith(".csv"):
            print("  ", p, flush=True)
            try:
                journal += decrire_csv(telecharger(p), p)
            except Exception as e:  # noqa: BLE001 — on consigne et on continue
                journal += [f"### `{p}` : ERREUR {e}", ""]

journal += ["## Tables labor_market_impacts", ""]
lm = lister("labor_market_impacts")
journal += md_table(["Fichier", "Taille (Mo)"], [[f"`{x['path']}`", f"{(x['size'] or 0) / 1024**2:.2f}"] for x in lm]) + [""]
for x in lm:
    if x["path"].endswith(".csv"):
        journal += decrire_csv(telecharger(x["path"]), x["path"])
    elif x["path"].endswith(".md"):
        (SORTIE / "labor_market_impacts").mkdir(exist_ok=True)
        (SORTIE / "labor_market_impacts" / pathlib.Path(x["path"]).name).write_bytes(telecharger(x["path"]).read_bytes())

(SORTIE / "exploration.md").write_text("\n".join(journal), encoding="utf-8")

# Test de l'API Banque mondiale (source externe envisagée : PIB/hab. PPA, population).
res = []
for ind in ["NY.GDP.PCAP.PP.KD", "SP.POP.TOTL", "SP.POP.1564.TO"]:
    try:
        with urllib.request.urlopen(f"https://api.worldbank.org/v2/country/FRA;DEU;USA/indicator/{ind}?format=json&date=2022:2025") as r:
            d = json.load(r)
        res.append(f"{ind}: OK, {len(d[1] or [])} lignes, ex. {d[1][0] if d[1] else None}")
    except Exception as e:  # noqa: BLE001
        res.append(f"{ind}: ÉCHEC {e}")
(SORTIE / "test_banque_mondiale.txt").write_text("\n".join(res), encoding="utf-8")
print("Terminé.")
