#' Externally open tiff-file after writing via ggsave
#'
#' @param copy2target Character. Optionally specify file path to copy the resulting file
#' @param ... specify further arguments for ggsave
#'
#' @export
xggsave <- function(filename = NULL, ...) {
  if (is.null(filename)) filename <- file.path(tempdir(), "fsfggsave.tiff")
  ggsave(filename = filename, ..., dpi = 600, compression = "lzw+p")
  system(paste0("xdg-open ", filename))
}
