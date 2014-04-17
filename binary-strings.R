### convert integer to binary string
binary.string <- function(i, bits.max=NA) {
    # i must be positive integers (<= 2^53) only!
    # bits.max is how many bits to print; default "as needed"
    if(is.na(bits.max)) bits.max <- ceiling(log2(max(i)))
    a <- 2^({bits.max-1}:0)
    b <- 2*a
    sapply(i, function(x) paste(as.integer((x %% b)>=a),collapse=""))
}

### alternate (but slower) conversion to binary string
if(!require(R.utils)) install.packages("R.utils")
library(R.utils)
intToBin(x)

### convert binary string to integer value (very fast)
#   e.g., to extract ints encoded in binary string:
#       strtoi(substr(y, 1, 4), base=2)
#       strtoi(substr(y, 5, 8), base=2)
#       strtoi(substr(y, 9, 11), base=2)
#       strtoi(substr(y, 12, 14), base=2)
strtoi(x, base=2)


# see also `binary()` and `unbinary()` in the `composition` package (requires x11)



### BENCHMARKING
library(ggplot2)
library(microbenchmark)
x <- sample(0:9999, 10000)
y <- binary.string(x) # length is 14 bits
z <- intToBin(x) # length is 14 bits

mb <- microbenchmark(binary.string(x), intToBin(x)times=100)
autoplot.microbenchmark(mb)

# can get a slight speedup by precompiling the slower functions
library(compiler)
binstr <- cmpfun(binary.string)

mbc <- microbenchmark(binstr(x), binary.string(x), times=100)
autoplot.microbenchmark(mbc)
