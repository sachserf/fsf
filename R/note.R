#' Create a template Rmd-file for taking notes
#'
#' @description This function will create an Rmd-file including some predefined
#'   lines. The function is designed to save some time writing the same input
#'   again and again (e.g. Author, date and other things).
#' @param filename Character. Specify the filename to save the new file.
#' @param dir Character. Specify directory where to save the new file. Default
#'   will be "Schreibtisch" or "Desktop".
#' @param add_date Logical. If TRUE the filename will be complemented by the
#'   current date.
#' @param Author Character. Optionally customize the name of the Author (used
#'   for the YAML header). Default is the effective user of the system info.
#' @param Date Character. Optionally customize the date (used for the YAML
#'   header). Default is the current Date (format YYYY-MM-DD).
#' @note Missing directories will be created recursively.
#' @note It is not possible to overwrite existing files.
#' @note Other YAML header options will be choosen automatically. Edit the
#'   resulting file to customize the YAML header.
#' @author Frederik Sachser
#' @export
note <-
  function(filename = "note.Rmd",
           dir = "default",
           add_date = TRUE,
           Author = Sys.info()["effective_user"],
           Date = "`r Sys.Date()`")
  {
    if (dir == "default") {
      if (dir.exists("~/Schreibtisch")) { # dir.exists was added in R 3.2.0
        file <-
          file.path("~/Schreibtisch")
      } else {
        file <-
          file.path("~/Desktop")
      }
    }
    file <- file.path(file, filename)

    if (add_date == TRUE) {
      file <- paste0(dirname(file), "/", Sys.Date(), "_", basename(file))
    }

    check_ext <-
      length(grep(
        pattern = ".Rmd",
        x = file,
        fixed = TRUE
      ))
    if (check_ext == 0) {
      file <- paste0(tools::file_path_sans_ext(file), ".Rmd")
    }

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
      cat(
        "---\ntitle: '",
        header,
        "'\nauthor: '",
        Author,
        "'\ndate: '",
        Date,
        "'\noutput: \n  html_document: \n    number_sections: yes\n    toc: yes\n    toc_float: yes\n    theme: cosmo\n    highlight: textmate\n---\n\n```{r setup, include=FALSE}\n# additional pdf-output of figures\nknitr::opts_chunk$set(dev = c('png', 'pdf'), dpi = 100)\n```\n\n# Status Quo\n\n## Completed\n\n## Work in Progress\n\n# Future Planning\n\n## Immature Concepts\n\n## Mature Concepts\n\n",
        file = file,
        sep = ""
      )
      utils::file.edit(file)
    }
  }
