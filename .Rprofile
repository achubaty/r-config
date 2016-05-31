local({
  options("repos" = c(CRAN="https://cran.rstudio.com"))
})

if (interactive()) {
  .os <- tolower(Sys.info()[["sysname"]])
  .detach <- function(package) {
    pkg <- deparse(substitute(package))
    pkg <- paste(unlist(strsplit(pkg, "\"")), collapse="")
    expr <- paste0("detach(package:", pkg, ", unload=TRUE)")
    tryCatch(
      eval(parse(text=expr)),
      error = function(c) {
        c$message <- paste0("Package ", pkg, " is not attached.\n")
        message(c)
      }
    )
  }

  exit <- Q <- function(save = "no", status = 0, runLast = TRUE) {
    q(save = save, status = 0, runLast = TRUE)
  }

  # package libraries
  .Library.user <- Sys.getenv('R_LIBS_USER')
  .Library.dev  <- "~/R-dev"

  # check for package updates and notify user (but don't install them)
  if (!is.null(utils::old.packages())) print("Package updates available.")

  # load devtools and set dev library
  suppressMessages(require(devtools))
}
