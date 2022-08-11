#' merge multiple image files into one pdf
#' @description files should be named 1.gif, 2.gif and so on. output will be named according to the directory name
#' @param thedir Character. Specify file path of the directory containing image files (e.g. jpg, gif,...)
#'
#' @export
img2pdfmerge <- function(thedir = ".") {

  absdir <- tools::file_path_as_absolute(thedir)
  #setwd(absdir)
  df <- data.frame(img = list.files(absdir, full.names = TRUE), stringsAsFactors = FALSE)
  df$noextfull <- tools::file_path_sans_ext(df$img)
  df$noextbase <- basename(df$noextfull)
  df$pdf <- file.path(paste0(df$noextfull, ".pdf"))
  df <- df[order(as.integer(df$noextbase)),]

  filext <- unique(tools::file_ext(df$img))

  # need imagemagick installed on your system

  for (i in filext) {
    system(paste0("mogrify -format pdf *.", i))
  }

  out_file <- paste0(basename(absdir), ".pdf")

  system(paste0("pdftk ", paste(df$pdf, collapse =" "), " cat output ", out_file))

  # need ocrmypdf installed on your system

  # see https://decatec.de/it/linux-ocr-texterkennung-fuer-pdf-dateien-und-bilder/
  out_file_ocr <- paste0(basename(absdir), "_ocr.pdf")
  system(paste0("ocrmypdf ", out_file, " ", out_file_ocr))
}

