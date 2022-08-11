#' mp3topng
#'
#' @param path Character. File path to source/target dir.
#'
#' @export
mp3topng <- function(path) {
  #install.packages("soundgen")

  # 10 kHz
  soundgen::spectrogramFolder(myfolder = path,
                              ylim = c(0,10),
                              htmlPlots = FALSE)
  autonames <- list.files(path = path,
                          pattern = "png$",
                          full.names = TRUE)
  autonames <- autonames[!grepl("_20kHz\\.png", autonames)]
  file.rename(from = autonames,
              gsub("\\.png", "_10kHz\\.png", autonames))

  # 20 kHz
  soundgen::spectrogramFolder(myfolder = path)
  autonames <- list.files(path = path,
                          pattern = "png$",
                          full.names = TRUE)
  # nach rename: html verlinkungen broken
  #file.rename(from = autonames, gsub("\\.png", "_20kHz\\.png", autonames))



  # copy png to image directory:
  newpng <- list.files(path = path,
                       pattern = "*png$",
                       full.names = TRUE)
  target <- file.path(dirname(dirname(newpng)), "images")
  lapply(unique(target), dir.create, showWarnings = FALSE)
  target <- file.path(target, basename(newpng))
  file.copy(from = newpng, to = target)

}
