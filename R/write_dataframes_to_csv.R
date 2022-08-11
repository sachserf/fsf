#' Write multiple dataframes to a single CSV file
#'
#' @param df_list list of dataframes
#' @param file filename
#'
#' @details This function was originally developed by an unkown author (github-username 'd-notebook') and hosted via github. The repository 'sheetr' and associated account 'd-notebook' has been removed recently. Because another function (xview) depends on the code and the package is not available any longer I decided to include it directly within this package.
#' @author d-notebook
#' @export
write_dataframes_to_csv <- function (df_list, file)
{
  headings <- names(df_list)
  seperator <- paste(replicate(50, "_"), collapse = "")
  sink(file)
  for (df.i in seq_along(df_list)) {
    if (headings[df.i] != "") {
      cat(headings[df.i])
      cat("\n")
    }
    write.csv(df_list[[df.i]])
    cat(seperator)
    cat("\n\n")
  }
  sink()
  return(file)
}
