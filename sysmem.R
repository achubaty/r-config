##############################################################
#' Check system memory
#'
#' This is a *very* rough estimate of the **TOTAL** RAM available.
#' Other processes running on the computer will eat into this total,
#' and as such, you should take these numbers with a grain of salt.
#' 
#' NOTE: this *should* work on OSX but hasn't been tested yet.
#' 
#' @param  x  Units to use for output. One of either "kb", "mb", "gb".
#' 
#' @return Total amount of system memory (RAM) in \code{GB}.
#' 
#' @export
#' @docType methods
#' @rdname sysmem-method
#'
#' @examples
#' sysmem()
#' 
sysmem = function(x="gb") {
  x = tolower(as.character(x))
  allowed = c("kb", "mb", "gb")
  if (!(x %in% allowed)) {
    last = length(allowed)
    err.msg = paste("specify", paste(allowed[-last], collapse=", "), "or", allowed[last], sep=" ")
    stop(err.msg)
  }
  
  # check OS and determine total RAM
  OS = Sys.info()[["sysname"]] 
  if ((OS=="Darwin") || (OS=="Linux")) {
    mem <- system("grep MemTotal /proc/meminfo", intern=TRUE)
    mem <- strsplit(mem, " ")
    mem <- mem[[1]][which(mem[[1]]!="")]
    ram.kb <- as.numeric(mem[2])
    ram.mb <- floor(ram.kb / 1024)
    ram.gb <- floor(ram.mb / 1024)
  } else if (OS=="Windows") {
    ram.mb <- memory.limit() # total RAM in MB
    ram.gb <- floor(ram.mb / 1024)
    ram.kb <- floor(ram.mb * 1024)
  } else {
    stop("Unable to determine total RAM: Which operating system are you using?")
  }
  
  if (x=="kb") {
    return(ram.kb)
  } else if (x=="mb") {
    return(ram.mb)
  } else if (x=="gb") {
    return(ram.gb)
  } else {
    stop() # error checking happens at start of function
  }
}

##############################################################
#' Guesstimate the number of cpus for cluster opreations
#'
#' Take a wild stab at guessing how many cpus to use in cluster when you
#' have some idea of how much ram is needed per cpu.
#' 
#' Tries to be conservative by assuming no more than 80% system memory use.
#' You should take these numbers with a grain of salt.
#' 
#' @param  ram  How much ram is required per cpu.
#' 
#' @param  units  Units of memory. One of either "kb", "mb", "gb".
#' 
#' @return number of cpus to allocate to cluster.
#' 
#' @export
#' @docType methods
#' @rdname sysmem-method
#'
#' @examples
#' guesstimate(4, "gb")
#' 
guesstimate = function(ram, units="gb") {
  if (ram>=sysmem(units)) {
    stop("Not enough system memory.")
  } else {
    # 80% of sysmem may be too conservative / not conservative enough
    # - adjust as needed.
    if (ram>=0.8*sysmem(units)) {
      warning("High RAM requirement for this system!", immediate.=TRUE)
    }
    cpus = floor( 0.8*sysmem(units) / ram )
    if (cpus<1) cpus=1
    return(cpus)
  }
}
