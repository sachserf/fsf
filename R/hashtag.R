#' insert hashtag
#' @description function for RStudio addin. Assign it to some custom shortcut to insert 'a hashtag comment' to your current cursor position.
#' @export
hashtag <- function() {
  text <- paste0(c(rep("#", 80), "\n# \n", rep("#", 80), "\n"), collapse = "")
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
