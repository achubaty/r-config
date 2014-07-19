# Test whether a number lies within range [a,b]
inRange <- function(x, a=0, b=1) {
  if (is.na(a) || is.na(b)) stop("invalid (NA) bounds.")
  if (!is.numeric(a) || !is.numeric(b)) stop("invalid (non-numeric) bounds.")
  if (a>=b) stop("a cannot be greater than b.")
  if (!is.numeric(x)) stop("x must be numeric.")
  if (is.null(x)) return(NULL) # is this desired behaviour?
  return((x - a)  *  (b - x) >= 0) # NAs will propagate -- is this desired?
}
