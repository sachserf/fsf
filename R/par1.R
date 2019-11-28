#' par temporary
#'
#' @param theplots. List of plots that should be processesed
#' @param ... specify parameters of par().
#'
#' @export
#'
#' @examples par1(plot(glm(Sepal.Width ~ ., data = iris)), mfrow = c(2,2))
par1 <- function(theplots, ...) {
  if (length(list(...)) != 0) {
    opar <- par(no.readonly = TRUE)
    par(...)
    theplots
    par(opar)
  } else {
    opar <- par(no.readonly = TRUE)
    par(mfrow = c(2,2))
    theplots
    par(opar)
  }
}
