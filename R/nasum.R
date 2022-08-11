#' NA sum
#' @description obtain the rows and columns of a dataframe, that contain missing data only
#' @param dataframe Object of class dataframe.
#'
#' @export
nasum <- function(dataframe) {
  foo <- list()
  foo[[1]] <- which(rowSums(is.na(dataframe)) == ncol(dataframe))
  foo[[2]] <- which(colSums(is.na(dataframe)) == nrow(dataframe))
  names(foo) <- c("NA_rows", "NA_cols")
  return(foo)
}
