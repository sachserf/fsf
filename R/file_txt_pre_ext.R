#' insert text before extension of filename
#'
#' @param filename Character. Specify filename (including extension).
#' @param txt_pre_ext Character. Specify text to paste right before the file extension.
#'
#' @author Frederik Sachser
#' @export
txt_pre_ext <- function(filename, txt_pre_ext = now()) {
  file_name_se <- tools::file_path_sans_ext(filename)
  file_ext <- stringr::str_sub(filename, nchar(file_name_se) + 1, nchar(filename))
  file_dest <- file.path(paste0(file_name_se, txt_pre_ext, file_ext))
  return(file_dest)
}
