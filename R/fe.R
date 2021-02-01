#' write custom Rmd-template or open existing file
#'
#' @description This function will open existing files or create a new one.
#' @param file Character. Specify full file path to open or create a file.
#'
#' @param ... Arguments passed to 'utils::file.edit'.
#'
#' @seealso \code{\link[utils]{file.edit}}
#'
#' @author Frederik Sachser
#' @export
fe <- function(file, ...) {
  file <- gsub(" $", "", file) # trim trailing whitespace

  if (file.exists(file)) {
    if (Sys.readlink(file) != "") {
      file.edit(Sys.readlink(file), ...)
    } else {
      file.edit(file, ...)
    }
  } else {
    dir.create(path = dirname(file), recursive = TRUE, showWarnings = FALSE)
    writeLines(text = paste0("---\noutput: github_document\n---\n\n```{r setup, include=FALSE}\nknitr::opts_chunk$set(dev = c('png', 'pdf'), dpi = 300, dev.args = list(bg = 'transparent'))\n```\n\n"), con = file)
    file.edit(file, ...)
  }
}

