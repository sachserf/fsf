#' Copy pdf files from subdirectories to root dir
#'
#' @param path Character. Specify root directory.
#'
#' @export
pdf_copy2root <- function(path) {
  #path <- "~/Downloads/top-articles"
  pdf <- list.files(path, pattern = ".pdf$", recursive = TRUE, full.names = TRUE)
  file.copy(pdf, file.path(path, basename(pdf)))
}
