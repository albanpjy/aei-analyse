#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# installer_env_local.sh — reconstruit l'environnement de développement dans le
# conteneur Claude Code (Ubuntu 24.04, CRAN et Hugging Face bloqués).
# Voir docs/diagnostic_env.md pour le contexte. Durée : ~1 h (DuckDB compilé).
# NE PAS utiliser en CI : GitHub Actions passe par renv + dépôts officiels.
# -----------------------------------------------------------------------------
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive MAKEFLAGS="-j$(nproc)"
ICI="$(cd "$(dirname "$0")" && pwd)"

# 1. R, packages R disponibles dans Ubuntu, LaTeX et bibliothèques système.
apt-get update -qq
apt-get install -y -qq \
  r-base-core r-base-dev r-cran-tidyverse r-cran-dbplyr r-cran-testthat \
  r-cran-factominer r-cran-mclust r-cran-factoextra r-cran-renv r-cran-lintr \
  r-cran-plotly r-cran-roxygen2 r-cran-crosstalk r-cran-htmlwidgets \
  r-cran-kableextra r-cran-dbi \
  texlive-xetex texlive-luatex texlive-lang-french texlive-latex-extra \
  texlive-fonts-recommended biber \
  libglpk-dev libgmp-dev libxml2-dev libuv1-dev

# 2. Quarto, distribué sur PyPI (quarto.org est bloqué).
pip install -q quarto-cli

# 3. arrow : la libarrow C++ précompilée n'est pas téléchargeable. On réutilise
#    celle de pyarrow, de MÊME version que le package R arrow (25.0.1).
pip install -q pyarrow==25.0.1
P=$(python3 -c "import pyarrow,os;print(os.path.dirname(pyarrow.__file__))")
H=/opt/arrow-from-pyarrow
mkdir -p "$H/lib/pkgconfig" "$H/lib/cmake/Arrow"
ln -sfn "$P/include" "$H/include"
for l in arrow arrow_acero arrow_compute arrow_dataset parquet; do
  ln -sf "$P/lib$l.so.2500" "$H/lib/lib$l.so"
done
pc() { # nom, bibliothèque, dépendances pkg-config
  printf 'prefix=%s\nlibdir=${prefix}/lib\nincludedir=${prefix}/include\nName: %s\nDescription: %s\nVersion: 25.0.1\nRequires: %s\nLibs: -L${libdir} -l%s -Wl,-rpath,%s\nCflags: -I${includedir}\n' \
    "$H" "$1" "$1" "$3" "$2" "$P" > "$H/lib/pkgconfig/$1.pc"
}
pc arrow arrow ""; pc arrow-compute arrow_compute arrow
pc arrow-acero arrow_acero arrow-compute; pc parquet parquet arrow
pc arrow-dataset arrow_dataset "arrow-acero parquet"
# Le configure d'arrow lit ce fichier pour activer Parquet/Dataset/Acero.
printf 'set(ARROW_%s "ON")\n' PARQUET COMPUTE DATASET ACERO JSON WITH_ZSTD \
  > "$H/lib/cmake/Arrow/ArrowOptions.cmake"
ARROW_HOME="$H" LIBARROW_BINARY=false LIBARROW_BUILD=false \
  Rscript "$ICI/installer_depuis_miroir_cran.R" arrow

# 4. Le reste depuis le miroir github.com/cran (knitr/rmarkdown d'apt sont trop
#    anciens pour les xfun récents : on les met aussi à jour).
Rscript "$ICI/installer_depuis_miroir_cran.R" \
  aieconindex duckdb targets tarchetypes gt reactable echarts4r leaflet quarto visNetwork
Rscript "$ICI/installer_depuis_miroir_cran.R" 'knitr>=1.50' 'rmarkdown>=2.30'
