#' copy files from zotero into a single dir
#'
#' @param CSV Character. Specify file path to a csv-file containing metadata of selected publications. You need to export this preformatted csv-file from zotero beforehand.
#'
#' @export
zotero_cp_pdf2dir <- function(CSV) {

  mydir <- file.path(dirname(CSV), format(Sys.time(), "%Y%m%d%H%M%S"))
  dir.create(mydir)

  filesource <- rio::import(CSV)$`File Attachments`

  file.copy(filesource, mydir)
}
