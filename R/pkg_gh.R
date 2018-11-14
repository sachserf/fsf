#' Install and attach packages
#'
#' @description The function checks whether the specified packages are installed
#'   or not. Packages that are not installed on your machine are going to be
#'   installed.
#' @inheritParams pkg_cran
#' @param ... Further parameters passed to devtools::install_github().
#' @note pkg_names must be specified in the following format: username/repo[/subdir][@ref|#pull] see ?devtools::install_github
#' @author Frederik Sachser
#' @seealso \code{\link{pkg_cran}}, \code{\link[devtools]{install_github}}
#' @export
pkg_gh <-
  function(pkg_names, attach = TRUE, ...)
  {
    github_reponames <-
      #      sapply(strsplit(sapply(strsplit(paste0(pkg_names), "/"), "[[", 2), "\u0040"), "[[", 1)
      sapply(strsplit(paste0(pkg_names), "/"), "[[", 2)
    exist_pack <-
      github_reponames %in% rownames(utils::installed.packages())
    if (any(!exist_pack))
      devtools::install_github(repo = pkg_names[!exist_pack], ...)
    if (attach == TRUE)
      lapply(pkg_names, library, character.only = TRUE)
  }
