#' Install and attach packages
#'
#' @description The function checks whether the specified packages are installed
#'   or not. Packages that are not installed on your machine are going to be
#'   installed.
#' @param pkg_names Character. A vector specifying the names of packages you
#'   want to install.
#' @param attach Logical. If TRUE the packages will be loaded.
#' @param ... Further parameters passed to install.packages().
#' @seealso \code{\link{pkg_gh}}, \code{\link{install.packages}}
#' @author Frederik Sachser
#' @export
pkg_cran <-
  function(pkg_names, attach = TRUE, ...)
  {
    exist_pack <- pkg_names %in% rownames(utils::installed.packages())
    if (any(!exist_pack))
      utils::install.packages(pkg_names[!exist_pack], ...)
    if (attach == TRUE)
      lapply(pkg_names, library, character.only = TRUE)
  }
