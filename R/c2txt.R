#' Convert vector as text
#'
#' @param vector Vector that should be represented as text.
#' @param frame Character. Specify character that should be printed before and after each element of the vector.
#' @param separator Character. Specify character that should be printed between each element of the vector.
#'
#' @return Text representation of the vector.
#'
#' @author Frederik Sachser
#' @export
#'
#' @examples c2txt(names(iris)); c2txt(paste0(letters, "='", 1:length(letters), "'"), separator = ",", frame = "")
c2txt <- function(vector, frame = "\"", separator = ", ") {
  cat(paste0(frame, vector, frame, collapse = separator))
}
