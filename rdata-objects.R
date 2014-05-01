##############################################################
#' Load, save, and remove .RData objects
#'
#' Wrapper functions to \code{\link{load}} and \code{\link{save}} permitting
#' lists of objects to be loaded/saved at once. By default, \code{.RData} is used.
#' 
#' Also provides wrappers to remove objects from the global environment when no
#' path specified, or, if path specified, delete their associated data files
#' but not the objects themselves.
#' 
#' @param  objects  A character list or character vector of object names
#' 
#' @param  path     The filepath to the directory in which to save or
#'                  from which to load the objects. The path should be
#'                  constructed using \code{\link{file.path}}.
#' 
#' @param  extension  The file extension to use (default is \code{.RData}).
#' 
#' @return A list of the objects loaded or an empty list 
#' 
#' @seealso \code{\link{file.path}}, \code{\link{load}}, \code{\link{save}}, \code{\link{unlink}}
#' 
#' @export
#' @docType methods
#' @rdname rdata-Objects-method
#'
# @examples
# needs examples
loadObjects <- function(objects, path, extension=".RData") {
  lapply(objects, function(x) load(file=paste(rdata.path, "/", x, extension, sep=""), env=globalenv()))
}

#' @rdname rdata-Objects-method
saveObjects <- function(objects, path, extension=".RData") {
  lapply(objects, function(x) save(list=x, file=paste(path, "/", x, extension, sep="")))
}

#' @rdname rdata-Objects-method
rmObjects <- function(objects, path=NULL, extension=".RData") {
  if (is.null(path)) {
    # only remove object from environment
    rm(list=objects)
  } else {
    # delete the .RData files
    files = lapply(objects, function(x) paste(path, "/", x, extension, sep=""))
    unlink(files)
  }
}
