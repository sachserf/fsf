#' merge pdfs within dir
#'
#' @param path Character. File path to directory containing pdfs.
#'
#' @export
pdftk_merge <- function(path) {
  fils <- list.files(path, pattern = ".pdf", full.names = TRUE)

  system(paste0("pdftk ", paste0("'",paste(sort(fils), collapse = "' '"),"'"), " cat output ", file.path(path, "merged.pdf")))
}
