#' External View
#'
#' @description This function will export an object to a file (using package "rio"). A system command is invoked to open the file afterwards.
#'
#' @param x Object to export (e.g. a data.frame)
#' @param file Specify filename. Directories will not be created.
#' @param deldep Logical. Specify if deprecated files should be deleted.
#' @param ... Further params passed to rio::export (e.g. overwrite, row.names, etc.)
#'
#' @seealso \code{\link[rio]{export}}
#'
#' @export
xview <- function(x, file = gsub("-|\\ |:", "", paste0("xview_", Sys.time(), ".xlsx")), deldep = TRUE, list_collapse = TRUE, ...) {
  if (deldep == TRUE) {
    lapply(list.files(path = ".", pattern = "^xview_\\d{14}"), file.remove, recursive = TRUE)
  }
  if (Sys.info()["sysname"] == "Linux") {
    cmd <- "xdg-open"
  } else if (Sys.info()["sysname"] == "Windows") {
    cmd <- "start"
  } else if (Sys.info()["sysname"] == "Darwin") {
    cmd <- "open"
  } else if (Sys.info()["sysname"] %in% c("Linux", "Darwin", "Windows") == FALSE) {
    stop("Operating system not supported.")
  }
  message("Exporting file to: ", file, " ...")

  if (list_collapse == TRUE & class(x) == "list") {
    file <- paste0(tools::file_path_sans_ext(file), ".csv")
    write_dataframes_to_csv(x, file, na = na) ## devtools::install_github('d-notebook/sheetr')
  } else {
    rio::export(x = x, file = file, ...)
  }
  system(paste(cmd, file))
}

