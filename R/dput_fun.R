#' Dput a function
#'
#' @description Choose a function of an installed R-package and save it to the specified target.
#' @param pkg_fun Character. Name of a package and function separated by '::'. E.g. fsf::dput_fun. Do not use quotation marks.
#' @param target_dir Character. Specify the file path, where you want to write the file.
#' @param rm_pattern Character. Choose any pattern that should be removed. E.g. 'fsf::' to exclude the name of the package sf.
#' @author Frederik Sachser
#' @export
dput_fun <-
function(pkg_fun, target_dir, rm_pattern = FALSE)
{
    if (dir.exists(target_dir) == FALSE) {
        dir.create(target_dir, recursive = TRUE)
    }
    function_name <- paste(substitute(pkg_fun))[3]
    function_call <- paste0(function_name, " <- ")
    filename <- paste0(target_dir, "/", function_name, ".R")
    if (file.exists(filename) == TRUE) {
        warning("filename of function already exists.")
    }
    else {
        dput(x = pkg_fun, file = filename)
        thefun <- readLines(filename)
        if (rm_pattern != FALSE) {
            thefun <- gsub(pattern = rm_pattern, replacement = "",
                x = thefun)
        }
        cat(function_call, thefun, sep = "\n", file = filename)
    }
}
