#' trim print output
#'
#' @param object2print Object that should be printed.
#' @param maxprint Integer. Specify for temporary change of max.print option. Choose 0 (zero) to set maximum possible.
#' @param digi Integer. Specify digits to trim the output.
#'
#' @export
tprint <- function(object2print, maxprint = 100, digi = 2) {
  if(maxprint == 0) {
    maxprint <- .Machine$integer.max
  }
  foo <- getOption("max.print")
  options(max.print = maxprint)
  print(object2print, dig = digi)
  options(max.print = foo)
}
