#' Preformatted text to embed xeno-canto recordings
#'
#' @param kat_nr. Integer. Specify Kat. Nr. of xeno-canto recording.
#'
#' @export
xc <- function(kat_nr) {
  text <-
    paste0("<iframe src='https://www.xeno-canto.org/",kat_nr,"/embed' scrolling='no' frameborder='0' width='340' height='220'></iframe>\n")

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
