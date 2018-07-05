local({
  options("repos" = c(CRAN = "https://cran.rstudio.com"))
  options(Ncpus = parallel::detectCores() / 2)
})

if (interactive()) {
  .os <- tolower(Sys.info()[['sysname']])

  exit <- Q <- function(save = "no", status = 0, runLast = TRUE) {
    q(save = save, status = 0, runLast = TRUE)
  }

  # package libraries
  .Library.user <- Sys.getenv('R_LIBS_USER')
  .Library.dev  <- '~/R-dev'

  # check for package updates and notify user (but don't install them)
  if (is.null(utils::old.packages(lib.loc = c(.Library.site[1], .Library.user)))) {
    message("All CRAN packages up to date.")
  } else {
    message("Package updates available:\n ",
            paste(rownames(utils::old.packages()), collapse = ", "))
  }

  # load devtools and set dev library
  suppressMessages(library(devtools))
  options(devtools.name = "Alex Chubaty",
          devtools.desc.author = 'person(c("Alex", "M"), "Chubaty", email = "alex.chubaty@gmail.com", role = c("aut", "cre"))')
}
