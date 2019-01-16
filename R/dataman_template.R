#' print template for data manual
#'
#' @description print roxygen2 template for data documentation.
#'
#' @param data Object of class data.frame.
#'
#' @export
#'
dataman_template <- function(data) {
  x <- names(data)
  foo <- list()
  foo[[1]] <- paste("#' I am a title\n#'\n#' a short description\n#'\n#' \\itemize{")
  for (i in (1:length(x) + 1)) {
    foo[[i]] <- paste0("#'    \\item ", x[i], ". DESCRIPTION")
  }
  foo[[length(x) + 1]] <- paste0("#' }\n#'\n#' @docType data\n#' @keywords dataset\n#' @name ", substitute(data), "\n#' @usage data(", substitute(data), ")\n#' @format A data frame with ", nrow(data), " rows and ", ncol(data), " variables.\n'", substitute(data), "'")
    writeLines(unlist(foo))
}
