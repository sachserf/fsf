#' Split a string into multiple rows
#'
#' @param dataframe Object of class "data.frame" or tibble.
#' @param columnname Character. Name of the column containing a string for splitting.
#' @param separator Character. Specify the separator that should be used to split the string.
#' @param affix Character. Specify affix for the new column.
#'
#' @author Frederik Sachser
#' @export
strsplitunnest <- function(dataframe, columnname, separator = ",", affix = "_split") {
  dataframe <- as_tibble(dataframe)
  splitname <- paste0(columnname, affix)
  vector <- as.data.frame(dataframe[,columnname])

  dataframe$tempvar <- sapply(vector, strsplit, ",")
  dataframe <- dataframe %>%
    unnest(tempvar) #%>% select(-columnname)

  names(dataframe)[which(names(dataframe) == "tempvar")] <- splitname
  return(dataframe)
}
