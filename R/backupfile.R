#' backup a file
#'
#' @param filepath Character. Specify file path you want to copy.
#'
#' @export
backupfile <- function(filepath = NULL) {
  # set filepath if not specified
  if (is.null(filepath)) filepath <- fsf::curfp()

  # create dir
  dirpath <- file.path(dirname(filepath), "backup")
  if (!dir.exists(dirpath)) dir.create(dirpath, recursive = TRUE)

  # specify target
  target <- file.path(dirpath, paste0(tools::file_path_sans_ext(basename(filepath)), "_", fsf::now(), ".", tools::file_ext(filepath)))
  file.copy(from = filepath, to = target)

  message("copied file to: \n", target)
}
