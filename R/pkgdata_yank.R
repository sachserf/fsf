#' Copy all dataframes of an installed R-package
#'
#' @param pkg Character. Name of the installed package.
#' @param target_dir Character. Specify target directory for dataframes (one RData-file for each dataframe).
#'
#' @seealso \code{\link[sf]{pkgdata_ls}}, \code{\link[sf]{pkgdata_write}}
#' @export
#'
pkgdata_yank <- function(pkg, target_dir = 'inst/extdata') {

  listofdf <- ls_pkgdata(pkg)
  if (length(listofdf) == 0) stop("No data was found in package.")

  dir.create(path = target_dir, showWarnings = FALSE, recursive = TRUE)

  RData_fun <- function(objectname) {
    filename <- paste(file.path(target_dir, objectname),
                      'RData', sep = '.')
    save(file = filename, list = objectname)
  }

  lapply(listofdf, FUN = RData_fun)

  message(paste0("Wrote the following data frames into directory '", target_dir, "':
", paste(listofdf, collapse = "
")))
}
