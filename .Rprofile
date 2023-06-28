local({
  options(Ncpus = min(parallel::detectCores() / 2, 120),
          repos = c(CRAN = "https://cloud.r-project.org",
                    PE = "https://PredictiveEcology.r-universe.dev"))

  if (Sys.info()["sysname"] == "Linux" && grepl("Ubuntu", utils::osVersion)) {
    if (!grepl("R Under development", R.version.string)) {
      .os.version <- system("lsb_release -cs", intern = TRUE)

      options(
        repos = c(
          CRAN = paste0("https://packagemanager.posit.co/all/__linux__/", .os.version, "/latest"),
          getOption("repos")
        )
      )
    }
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

  if (FALSE) {
    # check for package updates and notify user (but don't install them)
    libPaths <- if (.os == "darwin") normalizePath(.Library) else .Library.site[1]
    libPaths <- c(libPaths, .Library.user)
    op <- utils::old.packages(lib.loc = libPaths)
    if (is.null(op)) {
      message("All CRAN packages up to date.")
    } else {
      message("Package updates available:\n ",
              paste(rownames(op), collapse = ", "))
    }
    rm(libPaths)
  }

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
    if (!require("rdoc", character.only = TRUE, quietly = TRUE)) {
      utils::install.packages("rdoc")
    }
    rdoc::use_rdoc()
  }

  ## load devtools and set dev library
  if (isRstudio) {
    if (!require("devtools", character.only = TRUE, quietly = TRUE)) {
      utils::install.packages("devtools")
    }
    suppressMessages(require(devtools))
    options(
      usethis.full_name = "Alex Chubaty",
      usethis.description = list(
        "Authors@R" = utils::person(
          c("Alex", "M"), "Chubaty",
          email = "achubaty@for-cast.ca",
          role = c("aut", "cre"),
          comment = c(ORCID = "0000-0001-7146-8135")
        ),
        version = "0.0.0.9000"
      ),
      usethis.destdir = "~/GitHub"
    )
  }
}
