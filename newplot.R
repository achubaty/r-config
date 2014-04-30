##############################################################
#' Open a new plotting window
#'
#' Launch a new graphics device based on operating system used.
#' Mac OS: open device with \code{quartz()}.
#' Linux: open device with \code{x11()}.
#' Windows: open device with \code{windows()}.
#' 
#' @param ... Additional arguments passed to quartz(), x11(), or windows().
#' 
#' @return Opens a new plot device on the screen.
#' 
#' @export
#' @docType methods
#' @rdname plot2
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

##############################################################
#' Specify where to plot
#'
#' Switch to an existing plot device, or if not already open,
#' launch a new graphics device based on operating system used.
#' 
#' For example, \code{plot2(6)} switches tho active plot device to device #6.
#' If it doesn't exist, it opens it. NOTE: if devices 1-5 don't exist
#' they will be opened too.
#' 
#' @param ... Additional arguments passed to quartz(), x11(), or windows().
#' 
#' @return Opens a new plot device on the screen.
#' 
#' @export
#' @docType methods
#' @rdname plot2-method
#'
# @examples
# needs examples
plot2dev = function(x, ...) {
  if(is.null(dev.list())) newPlot(...)
  while (dev.set(x)!=x) newPlot(...)
}
