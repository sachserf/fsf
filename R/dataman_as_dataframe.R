#' create a template for a data manual for multiple dataframes
#'
#' @description rows merged by variable names
#'
#' @param named_list_of_dataframes object of class 'list' with named elements containing dataframes
#'
#' @export
#'
#' @examples
#' dataman_as_dataframe(data2list(c("chickwts", "ChickWeight")))
dataman_as_dataframe <- function(named_list_of_dataframes) {

  dataman_df <- data.frame(TABLE = rep(names(named_list_of_dataframes), sapply(named_list_of_dataframes, length)),
                           variable = unlist(sapply(named_list_of_dataframes, names)),
                           row.names = NULL) %>%
    dplyr::group_by(variable) %>%
    dplyr::summarize(datasources = paste(TABLE, collapse = ", ")) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(description = as.character(NA),
                  units = as.character(NA))
  return(dataman_df)
}
