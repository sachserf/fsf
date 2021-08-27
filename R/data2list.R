#' Combine multiple dataframes into a named list
#'
#' @param df character. Character vector of dataframe-objects.
#'
#' @export
#'
#' @examples
#' data2list(c("iris", "mtcars"))
data2list <- function(df) {
  dflist <- lapply(df, get)
  names(dflist) <- df
  return(dflist)
}
