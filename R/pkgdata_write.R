#' Write dataframe
#' @description This function provides a fast way to write multiple dataframes into a directory. File extension will be RData.
#' @param listofdf Character. Character vector of the data frame object(s).
#' @param target_dir Character. Specify target directory (default 'inst/extdata')
#'
#' @note directory will be written recursively and existing files of the same name will be overwritten.
#' @seealso \code{\link[sf]{pkgdata_ls}}, \code{\link[sf]{pkgdata_yank}}
#' @export
pkgdata_write <- function(listofdf, target_dir = 'inst/extdata') {

  dir.create(path = target_dir, showWarnings = FALSE, recursive = TRUE)

  RData_fun <- function(objectname) {
    filename <- paste(file.path(target_dir, objectname),
                      'RData', sep = '.')
    save(file = filename, list = objectname)
  }

  lapply(listofdf, FUN = RData_fun)

  writeLines(text = paste0("Wrote the following data frames into diretory '", target_dir, "':
", paste(listofdf, collapse = "
")), con = stdout())
}
