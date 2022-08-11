#' Write and View dataframe as flextable html
#'
#' @param table Object of class data.frame.
#' @param target Specify target filepath for the html-table.
#' @param open logical. Open document if open = TRUE (default).
#'
#'@seealso \code{\link[flextable]{save_as_html}}
#'
#' @export
xflex <- function(table, target = "/tmp/foo.html", open = TRUE) {
  table %>%
    flextable::flextable(data = .) %>%
    flextable::save_as_html(path = target)

  if (open == TRUE) {
    system(paste0("xdg-open ", target))
  }
}
