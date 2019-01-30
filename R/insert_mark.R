#' insert html mark
#' @description function for RStudio addin. Assign it to some custom shortcut to insert <mark></mark> to yout current cursor position.
#' @export
insert_mark <- function() {
  text <- "<mark></mark>"
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
