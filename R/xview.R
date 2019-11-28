#' External View
#'
#' @description This function will export an object to a file (using package "rio"). A system command is invoked to open the file afterwards.
#'
#' @param x Object to export (e.g. data.frame)
#' @param file Specify filename. Directories will not be created.
#' @param deldep Logical. Specify if deprecated files should be deleted. works only if file_path begins with "xview_" followed by 14 integer values (default for exporting new files).
#' @param open_doc Logical. Should document be opened afterwards?
#' @param ... Further params passed to rio::export (e.g. overwrite, row.names, etc.)
#' @param list_collapse Logical. Collapse list of dataframes? (depends on github-package d-notebook/sheetr)
#'
#' @seealso \code{\link[rio]{export}}, \code{\link[sheetr]{write_dataframes_to_csv}}
#'
#' @author Frederik Sachser
#' @export
xview <- function(x, file = paste0("xview_", now(), ".xlsx"), deldep = TRUE, list_collapse = TRUE, open_doc = TRUE, ...) {
  if (deldep == TRUE) {
    lapply(list.files(path = ".", pattern = "^xview_\\d{14}"), file.remove, recursive = TRUE)
  }
  if (Sys.info()["sysname"] == "Linux") {
    cmd <- "xdg-open"
  } else if (Sys.info()["sysname"] == "Windows") {
    cmd <- "shell.exec" # start
  } else if (Sys.info()["sysname"] == "Darwin") {
    cmd <- "open"
  } else if (Sys.info()["sysname"] %in% c("Linux", "Darwin", "Windows") == FALSE) {
    stop("Operating system not supported.")
  }
  message("Exporting file to: ", file, " ...")

  if (list_collapse == TRUE & "list" %in% class(x)) {
    file <- paste0(tools::file_path_sans_ext(file), ".csv")
    sheetr::write_dataframes_to_csv(x, file) ## devtools::install_github('d-notebook/sheetr') , na = "na"
  } else {
    rio::export(x = x, file = file, ...)
  }
  if (open_doc == TRUE) {
    system(paste(cmd, file))
  }
}

