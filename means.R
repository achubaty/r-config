geometric.mean = function(x, ...) {
    gm = prod(x, ...) ^ (1 / length(x))
    return(gm)
}

harmonic.mean = function(x, ...) {
    if (length(x[x == 0])) stop("Error: contains zero values.")
    hm = 1 / mean(1 / x, ...)
    return(hm)
}
