#' Structure as a data frame
#'
#' @description similar to utils::str(), but organized in a dataframe. Additionally to the class the amount of NA-values is returned.
#'
#' @param data Object of class data.frame.
#' @param n Number of rows to be printed.
#'
#' @author Frederik Sachser
#' @export
sdf <- function(data, n = 3) {
  foo <- cbind(data.frame(varname = names(data), class = t(data.frame(lapply(lapply(data, class), paste, collapse = ", ")))[,1, drop = FALSE]),
               data.frame("NA_sum" = colSums(sapply(data, is.na))),
               data.frame(t(utils::head(data, n = n))))
  row.names(foo) <- NULL
  message("nrow: ", nrow(data), "      ncol: ", ncol(data))
  return(foo)
}


