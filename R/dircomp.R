#' compare files in directories
#'
#' @param dir1 Character. Specify path to directory 1.
#' @param dir2 Character. Specify path to directory 2.
#'
#' @export
dircomp <- function(dir1, dir2) {
  dir1files <- basename(list.files(path = dir1, recursive = TRUE, full.names = FALSE))
  dir2files <- basename(list.files(path = dir2, recursive = TRUE, full.names = FALSE))

  dir1alsoindir2 <- dir1files[dir1files %in% dir2files]
  dir1only <- dir1files[!dir1files %in% dir2files]
  dir2alsoindir1 <- dir2files[dir2files %in% dir1files]
  dir2only <- dir2files[!dir2files %in% dir1files]
  invisible(list(dir1alsoindir2,
              dir1only,
              dir2alsoindir1,
              dir2only))
  message("Nr of files:\ndir1: ", length(dir1files),
          "\ndir2: ", length(dir2files),
          "\ndir1alsoindir2: ", length(dir1alsoindir2),
        "\ndir1only: ", length(dir1only),
        "\ndir2alsoindir1: ", length(dir2alsoindir1),
        "\ndir2only: ", length(dir2only))
}
