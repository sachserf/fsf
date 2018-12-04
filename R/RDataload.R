#' load RData-files to globalenv
#'
#' @description load all RData-files within a directory (recursive) into globalenv.
#'
#' @param path Character. Specify file path where RData-files are stored.
#'
#' @author Frederik Sachser

RDataload <- function(path = "inst/extdata") {
  sapply(list.files(path = path, pattern = ".RData", full.names = TRUE, recursive = TRUE), load, envir = .GlobalEnv)
}
