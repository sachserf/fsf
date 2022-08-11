#' clean the console, leave a message
#'
#' @param message Character Specify a message
#'
#' @export
mess <- function(message = "\013\017\013\013\013\017\013\013\017 \nJazz up your day") {
  cat(paste0("\014", message))
}
