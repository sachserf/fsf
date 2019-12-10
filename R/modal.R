#' compute modal value
#'
#' @param x Numeric.
#'
#' @export
modal <- function(x) {
  names(which.max(table(x)))
}
