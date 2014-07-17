# Test whether a number lies within range [a,b]
inRange <- function(x, a=0, b=1) {
  if (a>=b) stop("a cannot be greater than b.")
  if (!is.numeric(x)) stop("x must be numeric.")
  return((x - a)  *  (b - x) >= 0)
}
