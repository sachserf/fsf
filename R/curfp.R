#' Get current file path
#'
#' @description This function will determine and return the path of the executing script.
#' @note 'curfp' stands for 'current file path'.
#' @seealso \url{http://stackoverflow.com/a/36777602/7613841}, \url{http://stackoverflow.com/a/32016824/2292993}, \url{http://stackoverflow.com/a/35842176/2292993}, \url{http://stackoverflow.com/a/15373917/7613841}, \url{http://stackoverflow.com/a/1815743/7613841}, \url{http://stackoverflow.com/a/1816487/7613841}
#' @author Jerry T, aprstar, Richie Cotton, steamer25, Suppressingfire, hadley, Frederik Sachser
#' @export
curfp <- function() {
  # http://stackoverflow.com/a/36777602/7613841
  # http://stackoverflow.com/a/32016824/2292993
  cmdArgs <- commandArgs(trailingOnly = FALSE)
  needle <- '--file='
  match <- grep(needle, cmdArgs)
  if (length(match) > 0) {
    # Rscript via command line
    current_file_path <-
      normalizePath(sub(needle, '', cmdArgs[match]))
  } else {
    ls_vars = ls(sys.frames()[[1]])
    if ('fileName' %in% ls_vars) {
      # Source'd via RStudio
      current_file_path <- normalizePath(sys.frames()[[1]]$fileName)
    } else {
      if (!is.null(sys.frames()[[1]]$ofile)) {
        # Source'd via R console
        current_file_path <- normalizePath(sys.frames()[[1]]$ofile)
      } else {
        # RStudio Run Selection
        # http://stackoverflow.com/a/35842176/2292993
        current_file_path <-
          suppressWarnings(normalizePath(rstudioapi::getActiveDocumentContext()$path))
        if (nchar(current_file_path) == 0) {
          return(message('Failed to specify active document.'))
        }
      }
    }
  }
  return(current_file_path)
}



