#' import many files using rio::import
#'
#' @param files character vector. Specify multiple file paths of data for import.
#'
#' @author Frederik Sachser
#' @seealso \code{\link[rio]{import}}
#' @export
readc <- function(files) {
  mylist <- list()
  for (i in seq_along(files)) {
    mylist[[i]] <- rio::import(files[i])
  }
  names(mylist) <- tools::file_path_sans_ext(basename(files))
  return(mylist)
}
