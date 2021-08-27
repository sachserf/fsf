#' skim data in excel
#' @description Wrapper for skimr::skim and fsf::xview
#'
#' @param dataframe Object of class dataframe
#' @param xview logical. TRUE will open the file via xview.
#'
#' @seealso \code{\link[fsf]{xview}}
#' @export
skimview <- function(dataframe, xview = TRUE) {
  foo <- skimr::skim(dataframe)
#  dfname <- paste(substitute(dataframe))

  dfout <- base::as.data.frame(foo) %>% dplyr::select(dplyr::any_of(c("skim_type", "skim_variable", "n_missing", "complete_rate", "factor.n_unique", "factor.top_counts", "logical.count", "numeric.p0", "numeric.p50", "numeric.p100", "numeric.hist"))) #%>%    dplyr::mutate(dataframe2 = dfname)

  if (isTRUE(xview)) {
    xview(dfout)
  } else {
    return(dfout)
    }
}


