#' Source a file hosted in a pubic or private github repo
#'
#' @param repo   Name of the GitHub repository in the form \code{"user/repo"}.
#'
#' @param branch Branch from which to source the file (default master).
#'
#' @param file   Filename to source, including relative path.
#'
#' @param auth   Personal Access Token to use for authorization.
#'               Required to access files in private repositories.
#'               See \url{https://help.github.com/articles/creating-an-access-token-for-command-line-use/}.
#'
#' @improtFrom base64enc base64decode
#' @importFrom httr add_headers content GET stop_for_status
#' @importFrom magrittr %>%
#'
#' @example
#' \dontrun{
#' repo = "PredictiveEcology/SpaDES"
#' branch = "development"
#' file = "_ignore/thinSpatialPolygons.R"
#' auth = "" ## your Personal Access Token
#'
#' source_github(repo, branch, file, auth)
#' }
source_github <- function(repo, branch="master", file, auth=NULL) {
  stopifnot(
    all(sapply(c(repo, branch, file), is.character)),
    all(sapply(c(repo, branch, file), length) == 1)
  )

  header_accept <- "application/vnd.github.v3.raw"
  header_auth <- if (is.null(auth)) { NULL } else { paste0("auth") }

  tmpfile <- tempfile()
  on.exit(unlink(tmpfile))

  url <- paste0("https://api.github.com/repos/", repo, "/contents/", file,
                "?ref=", branch)

  r <- httr::GET(url, config = list(
    add_headers(Accept = header_accept, Authorization = header_auth)
  ))
  httr::stop_for_status(r)

  httr::content(r)$content %>%
    base64enc::base64decode %>%
    writeBin(tmpfile)

  source(f)
}
