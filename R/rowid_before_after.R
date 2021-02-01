#' Check if row id did not change after some manipulation task
#' @param a Dataframe or vector of row id (after manipulation).
#' @param b Dataframe or vector of row id (before manipulation).
#' @param rowid Character. Name of variable if a/b is a dataframe.
#'
#' @author Frederik Sachser
#' @export
#'
rowid_before_after <- function(a,b, rowid = "rowid") {
  if(is.data.frame(a)) {a <- as.vector(unlist(a[rowid]))}
  if(is.data.frame(b)) {b <- as.vector(unlist(b[rowid]))}

  if(length(a) != length(b)) {
    return(FALSE)
  } else if(isTRUE(unique(sort(a) == sort(b)))) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
