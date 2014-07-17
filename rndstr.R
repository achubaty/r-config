### generate n random strings of length len
rndstr <- function(n=1, len=8) {
  sapply(character(n), function(x) {
    x <- paste(sample(c(0:9, letters, LETTERS), size=len, replace=TRUE), collapse="")
  })
}
