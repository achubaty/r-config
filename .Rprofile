local({
  options(Ncpus = parallel::detectCores() / 2)
  options("repos" = c(CRAN = "https://cran.rstudio.com"))

  if (Sys.info()["sysname"] == "Linux" && grepl("Ubuntu", utils::osVersion)) {
    .os.version <- strsplit(system("lsb_release -c", intern = TRUE), ":\t")[[1]][[2]]
    .user.agent <- paste0(
      "R/", getRversion(), " R (",
      paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"]),
      ")"
    )
    options(repos = c(CRAN = paste0("https://packagemanager.rstudio.com/all/__linux__/",
                                    .os.version, "/latest")))
    options(HTTPUserAgent = .user.agent)
  }
})

if (interactive()) {
  .os <- tolower(Sys.info()[["sysname"]])

  exit <- Q <- function(save = "no", status = 0, runLast = TRUE) {
    q(save = save, status = 0, runLast = TRUE)
  }

  # package libraries
  .Library.user <- Sys.getenv("R_LIBS_USER")
  .Library.dev  <- "~/R-dev"

  # check for package updates and notify user (but don't install them)
  libPaths <- if (.os == "darwin") normalizePath(.Library) else .Library.site[1]
  libPaths <- c(libPaths, .Library.user)
  if (is.null(utils::old.packages(lib.loc = libPaths))) {
    message("All CRAN packages up to date.")
  } else {
    message("Package updates available:\n ",
            paste(rownames(utils::old.packages()), collapse = ", "))
  }
  rm(libPaths)

  ## check to see if being run in Rstudio
  ## based on https://stackoverflow.com/q/12389158/1380598
  isRstudio <- Sys.getenv("RSTUDIO") == 1 ||
    .Platform$GUI == "RStudio" ||
    if (suppressWarnings(requireNamespace("rstudioapi", quietly = TRUE))) {
      rstudioapi::isAvailable()
    } else {
      FALSE
    }

  ## use rdoc package for pretty R help files when not in Rstudio
  if (!isRstudio) {
    library(utils)
    if (!require("rdoc", character.only = TRUE, quietly = TRUE)) {
      install.packages("rdoc")
    }
    rdoc::use_rdoc()
  }

  ## load devtools and set dev library
  suppressMessages(library(devtools))
  options(devtools.name = "Alex Chubaty",
          devtools.desc.author = utils::person(c("Alex", "M"), "Chubaty",
                                               email = "achubaty@for-cast.ca",
                                               role = c("aut", "cre"),
                                               comment = c(ORCID = "0000-0001-7146-8135"))
  )

  ## (re)install spatial packages
  installSpatialPackages <- function(repos = "https://cran.rstudio.com") {
    ## rgdal and sf need additional args for homebrew on macOS
    if (Sys.info()[["sysname"]] == "Darwin") {
      stopifnot(nzchar(Sys.which("brew")))

      install.packages("rgdal", type = "source", repos = repos,
                       configure.args = c("--with-proj-lib=/usr/local/lib/",
                                          "--with-proj-include=/usr/local/include/"))
      install.packages("sf", type = "source", repos = repos,
                       configure.args = "--with-proj-lib=/usr/local/lib/")
    } else {
      install.packages("rgdal", type = "source", repos = repos)
      install.packages("sf", type = "source", repos = "https://cran.rstudio.com")
    }

    # other spatial packages ----------------------------------------------------------------------

    otherSpatialPackages <- c("rgeos", "sp", "raster", "terra", "lwgeom")
    install.packages(otherSpatialPackages, type = "source", repos = repos)
  }
}
