## update R packages following major version update
libDir <- "~/R/x86_64-pc-linux-gnu-library"
oldVer <- "3.6"
newVer <- "4.0"

oldLibDir <- file.path(libDir, oldVer)
newLibDir <- file.path(libDir, newVer)

pkgs <- as.data.frame(installed.packages(oldLibDir), stringsAsFactors = FALSE)
ids <- which(!(pkgs$Priority %in% c("base", "recommended")))
pkgs <- pkgs[ids, ]
pkgs <- pkgs$Package

## install CRAN packages
install.packages(pkgs[amc::pkgSrc(pkgs, oldLibDir) == "CRAN"], newLibDir)

## install GitHub packages
ids <- which(!(amc::pkgSrc(pkgs, oldLibDir) %in% c("CRAN", "Bioconductor", "Other")))
sapply(amc::pkgSrc(pkgs, oldLibDir)[ids], devtools::install_github, force = TRUE)

