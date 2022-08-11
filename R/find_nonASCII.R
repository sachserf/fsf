#' find Non-ASCII characters within a file
#'
#'
#' @param filepath Character. Specify path to the file that you want to check for Non-ASCII characters.
#'
#' @note use sapply to search for non ASCII characters in multiple files.
#'
#' @seealso \code{\link[tools]{showNonASCIIfile}}
#' @export
find_nonASCII <- function(filepath) {
  inputfile <- readLines(filepath)

  # find non-ascii chars
  foo <- gregexpr("[^\001-\177]", inputfile)
  bar <- regmatches(inputfile, foo)

  # prepare dataframe
  thelines <- which(sapply(bar, length) != 0)
  chars <- bar[thelines]
  raw <- sapply(sapply(lapply(unlist(chars), charToRaw), paste, collapse = " "), paste0)

  # create dataframe
  df_out <-
    data.frame(Line = rep(thelines, sapply(chars, length)), char = unlist(chars), raw = raw)
  return(df_out)
}

