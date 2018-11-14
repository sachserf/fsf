#' framework version of file.edit
#'
#' @description This function will open existing files or create a new one by calling 'framework::template_rmd'.
#' @param file Character or integer. Specify full file path to open or create a file. If the value is an integer and 'framework_params' is in your search path it will look up the index of the input_file (at the point in time of the last processing) to open it.
#' @param ... Arguments passed to 'utile::file_edit'.
#'
#' @seealso \code{\link[utils]{file.edit}}, \code{\link{template_rmd}}
#' @export
fe <- function(file, ...) {
  if (file.exists(file)) {
    if (Sys.readlink(file) != "") {
      file.edit(Sys.readlink(file), ...)
    } else {
      file.edit(file, ...)
    }
  } else {
    writeLines(text = paste0("---\noutput: github_document\n---\n\n"), con = file)
    file.edit(file, ...)
  }
}




