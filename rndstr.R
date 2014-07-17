### generate n random strings of length len
rndstr <- function(n=1, len=8) {
  unlist(lapply(character(n), function(x) {
    x <- paste0(sample(c(0:9, letters, LETTERS), size=len, replace=TRUE), collapse="")
  }))
}

######################
### profile/benchmark
# N <- 1e3
# M <- 12
# mb <- microbenchmark(rndstr(n=N, len=M))
# autoplot.microbenchmark(mb)
# mb
# 
# lp <- line_profile(rndstr(n=N, len=M))
# shine(lp)
