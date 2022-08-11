#' create a template for a data manual for multiple dataframes
#'
#' @description rows separated by dataframe
#'
#' @param named_list_of_dataframes
#'
#' @export
#'
#' @examples
#' dataman_as_dataframe(data2list(c("chickwts", "ChickWeight")))
dataman_as_dataframe_skim <- function(named_list_of_dataframes) {
  foo <- lapply(named_list_of_dataframes, fsf::skimview, xview = FALSE)

  for (i in 1:length(foo)) {
    foo[[i]]$dataframe <- names(foo[i])
  }

  dfout <- dplyr::bind_rows(foo) %>%
    tibble::as_tibble() %>%
    dplyr::group_by(skim_variable) %>%
    dplyr::mutate(datasources = paste0(unique(dataframe), collapse = ",")) %>%
    dplyr::ungroup() %>%
    dplyr::select(skim_variable, datasources, tidyselect::everything()) %>%
    dplyr::arrange(skim_variable) %>%
    dplyr::rename(variable = skim_variable)

  return(dfout)
}
