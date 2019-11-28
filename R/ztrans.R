#' simple Z transformation
#'
#' @param x Numeric. Input vector for z transformation
#'
#' @author Frederik Sachser
#' @export
ztrans <- function(x) {
  if (!is.numeric(x)) stop("Only numeric input allowed.")
  xz <- (x-mean(x))/sd(x)
  return(xz)
}
