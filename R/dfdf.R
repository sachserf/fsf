#' dfdf - differences between dataframes
#'
#' @param df1 A dataframe
#' @param df2 Another dataframe (similar but probably not the identical to df1)
#' @param df1target Character. Optional. Specify filepath to write df1.
#' @param df2target Character. Optional. Specify filepath to write df2.
#' @param software Character. Specify system command to invoke external software. Tested only with Meld (see http://meldmerge.org/).
#'
#' @export

dfdf <- function(df1, df2, df1target = "/tmp/R2meld1.csv", df2target = "/tmp/R2meld2.csv", software = "meld") {
  rio::export(df1, file = df1target)
  rio::export(df2, file = df2target)
  system(paste(software, df1target, df2target))
}
