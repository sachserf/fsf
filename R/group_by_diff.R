#' create groups by numerical difference threshold
#'
#' @param x numeric. Vector that should be binned into groups. Also possible with Dates.
#' @param difference Integer. Specify maximum within-group difference.
#'
#' @export
#'
#' @note vector should be arranged (sorted) prior to group_by_diff.
group_by_diff <- function(x, difference = 1) {
  # https://stackoverflow.com/a/51385903
  cumsum(c(TRUE, diff(x) > difference))
}
