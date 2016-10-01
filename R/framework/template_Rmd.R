#' Create a template Rmd-file
#' 
#' @description This function will create an Rmd-file including some predefined 
#'   lines. By using this template for Rmd-files within a framework-project it 
#'   is straightforward to save all plots you will specify within the script as 
#'   pdf and png version (using rmarkdown::render). The function is designed to
#'   save some time writing the same input again and again (e.g. Author, date
#'   and other things).
#' @param file Character. Specify the path to save the new file. Use relative 
#'   file paths and specify the file extension; e.g. 
#'   'in/src/new_dir/myfile.Rmd'.
#' @param Author Character. Optionally customize the name of the Author (used 
#'   for the YAML header). Default is the effective user of the system info.
#' @param Date Character. Optionally customize the date (used for the YAML 
#'   header). Default is the current Date (format YYYY-MM-DD).
#' @param open Logical. If TRUE the file will be opened (via `file.edit``).
#' @note Missing directories will be created recursively.
#' @note It is not possible to overwrite existing files.
#' @note Other YAML header options will be choosen automatically. Edit the 
#'   resulting file to customize the YAML header.
#' @seealso \code{\link{template_R}}
#' @author Frederik Sachser
#' @export
template_Rmd <-
  function(file,
            Author = Sys.info()["effective_user"],
            Date = "`r Sys.Date()`", open = TRUE)
  {
    if (dir.exists(paths = dirname(file)) == FALSE) {
      dir.create(path = dirname(file), recursive = TRUE)
    }
    header <-
      substr(x = basename(file),
             start = 1,
             stop = nchar(basename(file)) - 4)
    if (file.exists(file) == TRUE) {
      warning("File exists.")
    }
    else {
      cat("---\ntitle: '", header, "'\nauthor: '",Author, "'\ndate: '",Date, "'\noutput: \n  html_document: \n    number_sections: yes\n    toc: yes\n    toc_float: yes\n    theme: cosmo\n    highlight: textmate\n---\n\n```{r setup, include=FALSE}\n# additional pdf-output of figures\nknitr::opts_chunk$set(dev = c('png', 'pdf'), dpi = 100) # first 'dev'-value should be suitable for output format specifies in YAML metadata (e.g.: html_document and word_document: png or jpeg, pdf_document: pdf)  \n```\n\n# Note\nThis file was created by calling the function 'template_Rmd'.\n\n",
          file = file,
          sep = ""
      )
      if (open == TRUE) {
        file.edit(file)
      }
    }
  }
