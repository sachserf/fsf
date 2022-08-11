#' Undo last Test
#'
#' @param test_df A dataframe of specific format (output from fsf::atest).
#'
#'@seealso \code{\link[fsf]{atest}}, \code{\link[fsf]{stest}}
#' @export
utest <- function(test_df = test_dataframe) {
  out <- deparse(substitute(test_df))
  test_df <- test_df[-nrow(test_df),]
  assign(out, test_df, envir = .GlobalEnv)
}
