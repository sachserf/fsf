#' create Rmd with predefined text for quick notes on articles
#'
#' @description This function will open existing files or create a new one with predefined text.
#' @param file Character. Specify full file path to open or create a file.
#' @param ... Arguments passed to 'utils::file.edit'.
#' @export
#' @seealso \code{\link[utils]{file.edit}}, \code{\link[fsf]{fe}}
#' @author Frederik Sachser

template4articles <- function(file = file.path(tempdir(), "example.Rmd"), ...) {
  file <- gsub(" $", "", file) # trim trailing whitespace

  if (file.exists(file)) {
    if (Sys.readlink(file) != "") {
      file.edit(Sys.readlink(file), ...)
    } else {
      file.edit(file, ...)
    }
  } else {
    dir.create(path = dirname(file), recursive = TRUE, showWarnings = FALSE)
    writeLines(text = paste0("---\ntitle: 'mytitle'\nauthor: \"`r Sys.info()['user']`\"\ndate: \"`r Sys.Date()`\"\noutput: pdf_document\n---\n\n```{r setup, include=FALSE}\nknitr::opts_chunk$set(dev = c('png', 'pdf'), dpi = 300, dev.args = list(bg = 'transparent'))\n```\n\n#Abstract  \n# Introduction  \n# Material & Methods  \n# Results  \n# Discussion  \n# References  \n# Links  \n# Miscellany  \n\n"), con = file)
    file.edit(file, ...)
  }
}
