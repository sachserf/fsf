#' Find lines in a bunch of files
#'
#' @description Works like grep or which for a bunch of files (line by line). Useful example: 1. Always use the same predefined word(s) to mark positions in scripts where you should review something at some time (e.g. 'TODO'). 2. Search for those words within a bunch of files to get an overview.
#'
#' @param expression Character. Specify expression to match the line.
#' @param exclusive Logical. If TRUE use which, else grep.
#' @param path Character. Specify path to the directory including the files.
#' @param filepattern Character. Specify file pattern.
#' @param recursive Logical.
#'
#' @note If exclusive == FALSE you can use regular expressions (and therefore multiple expressions at a time).
#' @author Frederik Sachser
#' @export
findlines <- function(expression = "# magic word", exclusive = FALSE, path = ".", filepattern = "\\.R$|\\.Rmd$", recursive = TRUE) {
  filelist <- list.files(path = path, pattern = filepattern, recursive = recursive, full.names = TRUE)
  readlist <- lapply(filelist, readLines)
  names(readlist) <- filelist

  for (i in seq_along(filelist)) {
    if (exclusive == TRUE) {
      expressionindex <- which(readlist[[i]] == expression)
    } else {
      expressionindex <- grep(expression, readlist[[i]])
    }
    if (length(expressionindex) != 0) {
      cat(names(readlist)[i], "\n", paste(expressionindex, sep = ", "), "\n")
    }
  }
}

