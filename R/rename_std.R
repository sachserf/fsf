#' Rename df columns
#' @description rename all variables within a data frame (standardized syntax).
#'
#' @param .data An object of class data.frame
#'
#'@references see https://www.r-bloggers.com/clean-consistent-column-names/
#'
#' @export
rename_std <- function(.data) {
  # inspired by
  # https://www.r-bloggers.com/clean-consistent-column-names/
  n <- if (is.data.frame(.data)) colnames(.data) else .data

  n <- gsub("[^a-zA-Z0-9_]+", "_", n)
  n <- gsub("([A-Z][a-z])", "_\\1", n)
  n <- toupper(trimws(n))

  n <- gsub("(^_+|_+$)", "", n)

  n <- gsub("_+", "_", n)
}
