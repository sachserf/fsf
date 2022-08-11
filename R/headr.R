#' insert preformatted header in Rscript-style
#'
#' @param mytext Character. Specify text for the header.
#'
#' @export
headr <- function(mytext = "this is random text") {

  mynchar <- 80
  beforeandaftertext <- (mynchar - (nchar(mytext) + 2))/2

  text <- paste0(c(rep("#", mynchar), "\n", rep("#", beforeandaftertext) , " ", mytext, " ", rep("#", beforeandaftertext), "\n", rep("#", mynchar), "\n\n"), collapse = "")

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
