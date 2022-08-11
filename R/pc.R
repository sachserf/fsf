#' Paste Character
#'
#' @param char Character. Specify Character to paste.
#' @param times Repeat character n times. Default = 80
#'
#' @export
pc <- function(char = "-", times = 80) {
  text <- paste(rep(char, times), collapse = "")

  if (rstudioapi::isAvailable()) {
    rstudioapi::insertText(
      location = c(
        c(rstudioapi::getSourceEditorContext()$selection[[1]]$range)$end
      ),
      text = text,
      id = rstudioapi::getSourceEditorContext()$id
    )
  }
}
