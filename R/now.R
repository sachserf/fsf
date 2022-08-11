#' return current timestamp as integer
#'
#' @author Frederik Sachser
#' @export
now <- function() {
  return(format(Sys.time(), "%Y%m%d%H%M%S"))
}

