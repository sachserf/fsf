#' print Summary of test_df
#'
#' @param test_df A dataframe of specific format (output from sf::atest).
#' @param return Logical. Specify if test_df should be returned.
#'
#' @export
#'
#' @seealso \code{\link[sf]{atest}}
stest <- function(test_df = test_dataframe, return = TRUE) {
  diffs <- which(test_df$EVALUATION == FALSE)
  if (length(diffs) == 0) {
    message("All values as expected.")
  } else {
    warning(
      "The returned values of the following expectations were not as expected:\n",
      paste(test_df$DESCRIPTION[diffs], collapse = "\n")
    )
  }
  if (isTRUE(return)) return(test_df)
}
