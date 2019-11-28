#' Copy all dataframes of an installed R-package
#'
#' @param pkg Character. Name of the installed package.
#' @param target_dir Character. Specify target directory for dataframes (one RData-file for each dataframe).
#' @param listofdf Character. Specify subset of dataframes.
#'
#' @seealso \code{\link[fsf]{pkgdata_ls}}, \code{\link[fsf]{pkgdata_write}}
#' @export
#'
pkgdata_yank <- function(pkg, target_dir = 'inst/extdata', listofdf = NULL) {

  if (is.null(listofdf)) {
    listofdf <- fsf::pkgdata_ls(pkg)
  }

  if (length(listofdf) == 0) {
    stop("No data was found in package.")
  } else {

  utils::data(list = listofdf, package = pkg, envir = environment())
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
}
