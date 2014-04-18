##############################################################
#' Open a new plotting window
#'
#' Launch a new graphics device based on operating system used.
#' Mac OS: open device with \code{quartz()}.
#' Linux: open device with \code{x11()}.
#' Windows: open device with \code{windows()}.
#' 
#' @return Opens a new plot device on the screen.
#' 
#' @param ... Additional arguments passed to quartz(), x11(), or windows().
#' 
#' @export
#' @docType methods
#' @rdname newPlot
#'
# @examples
# needs examples
newPlot = function(...) {
  if (Sys.info()[["sysname"]]=="Darwin") {
    quartz(...)
  } else if (Sys.info()[["sysname"]]=="Linux") {
    x11(...)
  } else if (Sys.info()[["sysname"]]=="Windows") {
    windows(...)
  } else {
    x11(...) # try x11() to see if it works
    print("Which operating system are you using?")
  }
}
