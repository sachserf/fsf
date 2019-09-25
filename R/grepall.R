#' grep string for all columns of type character
#'
#' @param dataframe Object of class data.frame
#' @param string Character. Specify string to search for
#' @param ... further arguments passed to grep
#' @param print_values Logical. Choose wether to print values.
#'
#' @export
grepall <- function(dataframe, string, ..., print_values = TRUE) {
  charlist <- as.list(dataframe[sapply(dataframe, is.character)])
  emptylist <- as.list(rep(NA, length(charlist)))
  names(emptylist) <- names(charlist)

  for (i in 1:length(charlist)) {
    emptylist[[i]] <- grep(string, charlist[[i]], ...)
  }

  if (print_values == TRUE) {
    for (i in names(charlist)) {
      foo <- dataframe[emptylist[[i]], i]
      if (nrow(foo) > 0)
        print(foo)
    }
  }
  invisible(emptylist)
  message("List with index returned invisible")

  # possible better/faster alternative:
  # testdata <- data.frame(a = c(1, "?"), b = 1:2, C = c("?", "?"), d = c("?", "a"))
  #
  #index <- which(as.matrix(testdata) == "?", arr.ind = TRUE)
  #testdata[index]

}





