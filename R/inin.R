#' insert in
#' @description function for RStudio addin. Assign it to some custom shortcut to insert '%in%' to yout current cursor position.
#' @export
inin <- function() {
  text <- "%in%"
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

