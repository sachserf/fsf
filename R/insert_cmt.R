#' insert docx comment
#' @description function for RStudio addin. Assign it to some custom shortcut to insert a docx comment to yout current cursor position.
#' @export
incmt <- function() {
  text <- "`r fsf::cmt(highlight = '', comment = '')`"
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
