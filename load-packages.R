##############################################################
#' Load packages.
#'
#' Load and optionally install additional packages.
#'
#' @param package.list    A list of character strings specifying
#'                        the names of packages to be loaded.
#'
#' @param install         Logical flag. If required packages are not
#'                        already installed, should they be installed?
#'
#' @param quiet           Logical flag. Should the final "packages loaded"
#'                        message be suppressed?
#'
#' @return Nothing is returned. Specified packages are loaded and attached using \code{library()}.
#' 
#' @seealso \code{\link{library}}.
#' 
#' @export
#' @docType methods
#' @rdname loadpackages-method
#'
#' @examples
#' \dontrun{pkgs <- list("ggplot2", "lme4")}
#' \dontrun{load.packages(pkgs) # loads packages if installed}
#' \dontrun{load.packages(pkgs, install=TRUE) # loads packages after installation (if needed)}
setGeneric("loadPackages", function(packageList, install, quiet) {
  standardGeneric("loadPackages")
})

#' @rdname loadpackages-method
setMethod("loadPackages",
          signature(packageList="list", install="logical", quiet="logical"),
          definition = function(packageList, install, quiet) {
              load <- function(name, install) {
                  if (!require(name, character.only=TRUE)) {
                      if (install) {
                          install.packages(name, repos="http://cran.r-project.org")
                          library(name, character.only=TRUE)
                      } else {
                          warning(paste("Warning: unable to load package ", name, ". Is it installed?", sep=""))
                      }
                  }
              }
              lapply(packageList, load, install)
              if (!quiet) print(paste("Loaded", length(packageList), "packages.", sep=" "))
})

#' @rdname loadpackages-method
setMethod("loadPackages",
          signature(packageList="list", install="missing", quiet="missing"),
          definition = function(package.list) {
            load.packages(packageList=packageList, install=FALSE, quiet=FALSE)
})

#' @rdname loadpackages-method
setMethod("loadPackages",
          signature(packageList="list", install="missing", quiet="logical"),
          definition = function(packageList, quiet) {
            load.packages(packageList=packageList, install=FALSE, quiet=quiet)
})

#' @rdname loadpackages-method
setMethod("loadPackages",
          signature(packageList="list", install="logical", quiet="missing"),
          definition = function(packageList, install) {
            load.packages(packageList=packageList, install=install, quiet=FALSE)
})
