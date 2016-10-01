#' Write a file with current session info
#' 
#' @description The function writes the current timestamp and session info to a
#'   file.
#' @param file Character. File path to the target.
#' @note Directories will be created recursively.
#' @author Frederik Sachser
#' @export
session_info <- 
function(file = "session_info.txt") 
{
    if (dir.exists(dirname(file)) == FALSE) {
        dir.create(dirname(file), recursive = TRUE)
    }
    sink(file)
    print(Sys.time())
    print(utils::sessionInfo(package = NULL))
    sink()
}

