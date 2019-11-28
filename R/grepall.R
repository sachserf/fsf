#' grep string for all columns of type character
#'
#' @param dataframe Object of class data.frame
#' @param string Character. Specify string to search for
#' @param ... further arguments passed to grep
#' @param print_values Logical. Choose wether to print values.
#'
#' @export
#'
#' @examples testdata <- data.frame(a = c(1, "?"), b = 1:2, C = c("?", "?"), d = c("?", "a"), stringsAsFactors = FALSE)
#' index <- which(as.matrix(testdata) == "?", arr.ind = TRUE)
#' testdata[index]
grepall <- function(dataframe, string, ..., print_values = TRUE) {

  foo <- as.matrix(dataframe)
  index1d <- which(grepl(pattern = string, x = foo, ...), arr.ind = TRUE)

  fooma <- matrix(data = 0, nrow = dim(foo)[1], ncol = dim(foo)[2])
  fooma[index1d] <- 1
  index2d <- which(fooma == 1, arr.ind = TRUE)

  if (print_values == TRUE) {
    print(dataframe[index2d])
  }

  message("List with index returned invisible")
  return(invisible(index2d))

#     dataframe <- dplyr::as_tibble(dataframe)
#   charlist <- as.list(dataframe[sapply(dataframe, is.character)])
#   emptylist <- as.list(rep(NA, length(charlist)))
#   names(emptylist) <- names(charlist)
#
#   for (i in 1:length(charlist)) {
#     emptylist[[i]] <- grep(string, charlist[[i]], ...)
#   }
#
#   if (print_values == TRUE) {
#     for (i in names(charlist)) {
#       foo <- dataframe[emptylist[[i]], i]
#       if (nrow(foo) > 0)
#         print(foo)
#     }
#   }
#   invisible(emptylist)
#   message("List with index returned invisible")


}

