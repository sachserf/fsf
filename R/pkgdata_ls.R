#' Return vector of data within package
#'
#' @description Contrary to utils::data the function will only return a character vector of data within a package.
#' @param pkg Character. Specify Name of an installed package.
#'
#' @seealso \code{\link[sf]{pkgdata_yank}}, \code{\link[sf]{pkgdata_write}}
#' @author Frederik Sachser
#' @export
pkgdata_ls <- function(pkg) {
  any_data <- system.file("data/Rdata.rds", package = pkg)

  if (any_data == "") {
    message("No data was found in package.")
    } else {
      pkg_chr <- unlist(readRDS(any_data))
      return(as.vector(pkg_chr))
    }
}


