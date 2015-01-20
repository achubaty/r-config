# wrapper for `readOGR` that allows reading a file in a directory
# that is not the current working directory.
getOGR <- function(layer, dir) {
  orig.dir = getwd()
  setwd(dir)
  out = readOGR(dsn=".", layer=layer)
  setwd(orig.dir)
  return(out)
}
