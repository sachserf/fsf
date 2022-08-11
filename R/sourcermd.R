#' convert Rmd to R and source
#'
#' @param rmd_file Character. Specify file_path to Rmd-document
#'
#' @export
#'
sourcermd <- function(rmd_file = NULL) {
  if (is.null(rmd_file)) {
    if (rstudioapi::isAvailable()) {
      rmd_file <- rstudioapi::getSourceEditorContext()$path
    } else {
      stop("Specify input file and retry.")
    }
  }

  r_file <- strtrim(rmd_file, nchar(rmd_file)-2)
  if (file.exists(r_file)) stop("R-file exists. Delete/move file manually and retry.")

  knitr::purl(rmd_file, r_file)

  source(r_file)
  file.remove(r_file)
}
