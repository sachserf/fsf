#' trim summary output from jagsUI
#'
#' @param jagsobject Specify object of class jagsUI you want to print.
#' @param summaryrows Integer vector. Specify rows of summary table of the object.
#' @param digi Integer. Specify digits to trim the output.
#' @param summarycolumns Integer vector. Specify columns of summary table of the object.
#'
#' @export
jagsprint <- function(jagsobject, summaryrows = 1:20, digi = 2, summarycolumns = c(1,3,7:10)) {
  print(jagsobject$summary[summaryrows,summarycolumns], dig = digi)
}
