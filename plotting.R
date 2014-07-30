##############################################################
#' Specify where to plot
#'
#' Switch to an existing plot device, or if not already open,
#' launch a new graphics device based on operating system used.
#' 
#' For example, \code{dev(6)} switches the active plot device to device #6.
#' If it doesn't exist, it opens it. NOTE: if devices 1-5 don't exist
#' they will be opened too.
#' 
#' @param ... Additional arguments passed to quartz(), x11(), or windows().
#' 
#' @return Opens a new plot device on the screen.
#' 
#' @export
#' @docType methods
#' @rdname plot2dev-method
#'
# @examples
# needs examples
dev = function(x, ...) {
  if(is.null(dev.list())) newPlot(...)
  while (dev.set(x)!=x) newPlot(...)
}

##############################################################
#' Open a new plotting window
#'
#' Launch a new graphics device based on operating system used.
#' - Mac OS: open device with \code{quartz()}.
#' - Linux: open device with \code{x11()}.
#' - Windows: open device with \code{windows()}.
#' 
#' NOTE: dev.new() would normally be OS-independent but it fails in RStudio.
#' 
#' @param ... Additional arguments passed to quartz(), x11(), or windows().
#' 
#' @return Opens a new plot device on the screen.
#' 
#' @export
#' @docType methods
#' @rdname plot2dev-method
#'
# @examples
# needs examples
newPlot = function(...) {
  OS = Sys.info()[["sysname"]]
  if (OS=="Darwin") {
    quartz(...)
  } else if (OS=="Linux") {
    x11(...)
  } else if (OS=="Windows") {
    windows(...)
  } else {
    dev.new(...) # try dev.new() to see if it works
    warning("Which operating system are you using?")
  }
}
