#' First letter to upper
#'
#' @param string Character (vector).
#'
#' @export
camelcase <- function(string) {
  sub('^(\\w?)', '\\U\\1', string, perl=T)
}
