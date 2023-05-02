#' cheatsheet for handling NA in dataframes
#'
#' @export
#' @author Frederik Sachser
NA_cheatsheet <- function() {
  cat("
      # filter: all rows NA,
      foo %>% filter(if_any(everything(), ~ !is.na(.))), \n
      #select: only columns != NA,
      foo %>% select(where(~!all(is.na(.x))))")
}
