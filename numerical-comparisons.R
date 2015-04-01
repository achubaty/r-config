################################################################################
#' Relational operators
#'
#' Binary operators which allow the comparison of values in atomic vectors.
#'
#' These are similar to their counterparts in \code{base}, except a tolerance
#' \code{epsilon} can be specified to account for floating point errors.
#'
#' @param x An object for which methods have been written.
#' @param y An object for which methods have been written.
#' @param epsilon Tolerance value (default=\code{.Machine$double.eps^0.5})
#'
#' @return A logical vector indicating the result of the element by element comparison.
#'         The elements of shorter vectors are recycled as necessary.
#'
#' @seealso \code{epsilon}
#'
#' @export
#' @docType methods
#' @rdname relational-operators
#'
#' @author Alex Chubaty
#'
`%>=%` <- function(x, y, epsilon=.Machine$double.eps^0.5) {
  (x + epsilon > y)
}

#' @export
#' @rdname relational-operators
`%<=%` <- function(x, y, epsilon=.Machine$double.eps^0.5) {
  (x < y + epsilon)
}

#' @export
#' @rdname relational-operators
`%==%` <- function(x, y, epsilon=.Machine$double.eps^0.5) {
  (abs(x-y) < epsilon)
}

#' @export
#' @rdname relational-operators
`%!=%` <- function(x, y, epsilon=.Machine$double.eps^0.5) {
  (abs(x-y) > epsilon)
}
