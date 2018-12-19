local({
  Sys.setenv("cranRepo" = "https://cran.rstudio.com") ## needed for automated testing e.g., reproducible
  options("repos" = c(CRAN = "https://cran.rstudio.com"))
  options(Ncpus = parallel::detectCores() / 2)
})

if (interactive()) {
  .os <- tolower(Sys.info()[["sysname"]])

  exit <- Q <- function(save = "no", status = 0, runLast = TRUE) {
    q(save = save, status = 0, runLast = TRUE)
  }

  CC <- function(time = 60) reproducible::clearCache(after = Sys.time() - time)

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

  # load devtools and set dev library
  suppressMessages(library(devtools))
  options(devtools.name = "Alex Chubaty",
          devtools.desc.author = 'person(c("Alex", "M"), "Chubaty", email = "alex.chubaty@gmail.com", role = c("aut", "cre"), comments = c(ORCID = "0000-0001-7146-8135"))')
}
