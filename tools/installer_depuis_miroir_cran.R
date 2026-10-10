# -----------------------------------------------------------------------------
# installer_depuis_miroir_cran.R
#
# POURQUOI : dans le conteneur de développement, CRAN et Posit Package Manager
# sont bloqués, mais le miroir en lecture seule github.com/cran/<package> est
# accessible via git. Ce script installe des packages depuis ce miroir en
# résolvant récursivement les dépendances ET leurs versions minimales (>=).
#
# À N'UTILISER QUE LOCALEMENT. En CI (GitHub Actions), on passe par renv et les
# dépôts officiels.
#
# Usage : MAKEFLAGS=-j4 Rscript tools/installer_depuis_miroir_cran.R pkg1 'pkg2>=1.2' ...
# Variable d'environnement facultative : AEI_SRC_DIR (dossier des sources clonées).
# -----------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
src  <- Sys.getenv("AEI_SRC_DIR", file.path(tempdir(), "sources_cran"))
dir.create(src, showWarnings = FALSE, recursive = TRUE)

# Les packages "base" sont fournis par R lui-même : jamais à installer.
base <- rownames(installed.packages(priority = "base"))

# Lit Depends / Imports / LinkingTo d'un DESCRIPTION et renvoie un data.frame
# (nom, version minimale éventuelle).
# Piège évité : na.omit() sur la matrice de read.dcf() supprimerait TOUTE la
# ligne dès qu'un champ est absent ; on filtre donc élément par élément.
deps_of <- function(dir) {
  d <- read.dcf(file.path(dir, "DESCRIPTION"),
                fields = c("Depends", "Imports", "LinkingTo"))
  x <- trimws(unlist(strsplit(paste(d[!is.na(d)], collapse = ","), ",")))
  x <- x[x != ""]
  nm  <- trimws(sub("\\(.*", "", x))
  ver <- ifelse(grepl(">=", x), trimws(sub(".*>=\\s*([^)]*)\\).*", "\\1", x)), NA)
  keep <- nm != "R" & !nm %in% base
  data.frame(nm = nm[keep], ver = ver[keep])
}

# Un package est satisfaisant s'il est installé et assez récent.
ok <- function(p, v) {
  iv <- tryCatch(packageVersion(p), error = function(e) NULL)
  !is.null(iv) && (is.na(v) || iv >= package_version(v))
}

deja_vus <- character()
installer <- function(p, v = NA) {
  if (p %in% deja_vus || ok(p, v)) return(invisible())
  deja_vus <<- c(deja_vus, p)
  dir <- file.path(src, p)
  if (!dir.exists(dir)) {
    system2("git", c("clone", "-q", "--depth", "1",
                     paste0("https://github.com/cran/", p), dir))
  }
  dd <- deps_of(dir)
  for (i in seq_len(nrow(dd))) installer(dd$nm[i], dd$ver[i])
  message(">>> installation de ", p)
  # --preclean : évite de réutiliser des objets compilés avec d'autres options.
  if (system2("R", c("CMD", "INSTALL", "--preclean", dir)) != 0) {
    message("!!! ECHEC ", p)
  }
}

# Un argument peut imposer une version minimale : "knitr>=1.50".
for (a in args) {
  p <- sub(">=.*", "", a)
  v <- if (grepl(">=", a)) sub(".*>=", "", a) else NA
  installer(p, v)
}
