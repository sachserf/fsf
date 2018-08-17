#' Insert Image (markdown)
#' @description This function will copy a specified image (file) and write predefined text in markdown-style.
#'
#' @param caption Write a caption (optional).
#' @param path2image Specify filepath. Opens a window to choose a file per default.
#' @param assets_dir Specify name for a target directory to copy the image.
#'
#' @export
iimg <- function(caption = "Enter caption here.", path2image = file.choose(), assets_dir = "_assets") {
  # prerequisites
  dir_dest <- file.path(getwd(), assets_dir)
  img_name <- basename(path2image)
  img_dest <- file.path(dir_dest, img_name)
  # copy file to destination
  dir.create(dir_dest, showWarnings = FALSE)
  file.copy(from = path2image, to = img_dest)
  # write predefined text for convenience
  mytext <- paste0("![", caption, "](", img_dest, ")\n\n")
  if (rstudioapi::isAvailable()) {
    rstudioapi::insertText(location = c(c(rstudioapi::getSourceEditorContext()$selection[[1]]$range)$end) + c(1, 0),
                           text = mytext,
                           id = rstudioapi::getSourceEditorContext()$id)
  } else {
    message(mytext)
  }
}
