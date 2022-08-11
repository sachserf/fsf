#' Word Count
#'
#' @param string Character. String for word count.
#'
#' @export
#'
wc <- function(string) {
  sapply(strsplit(string, " "), length)
}
