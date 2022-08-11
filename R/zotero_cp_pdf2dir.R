#' copy files from zotero into a single dir
#'
#' @param CSV Character. Specify file path to a csv-file containing metadata of selected publications. You need to export this preformatted csv-file from zotero beforehand.
#' @param symlink_only Logical. Set True if files should be linked and not copied.
#'
#' @export
zotero_cp_pdf2dir <- function(CSV, symlink_only = TRUE) {

  mydir <- file.path(dirname(CSV), format(Sys.time(), "%Y%m%d%H%M%S"))
  dir.create(mydir)

  filesource <- rio::import(CSV)$`File Attachments`
  df <- tibble::tibble(filesource) %>%
    tibble::rowid_to_column() %>%
    dplyr::group_nest(rowid) %>%
    dplyr::mutate(split = strsplit(filesource, ";")) %>%
    tidyr::unnest(split) %>%
    dplyr::mutate(split = stringr::str_trim(split)) %>%
    dplyr::filter(grepl("pdf$", split)) %>%
    dplyr::mutate(size = file.size(split)) %>%
    dplyr::group_by(rowid) %>%
    dplyr::arrange(dplyr::desc(size)) %>% # if there are multiple versions: choose the largest file
    dplyr::slice(1) %>%
    dplyr::ungroup()

  filesource <- df$split

  if (isTRUE(symlink_only)) {
    file.symlink(filesource, mydir)
  } else {
    file.copy(filesource, mydir)
  }
}

