#' Convert ics files to data.frame
#'
#' @param calendar_ics Character. Path (or URL) to ics-file.
#' @param calname Character. If specified an additional column will be written containing the calname (might be useful for further processing).
#'
#' @importFrom magrittr "%>%"
#' @note Reoccurring events are not supported!
#' @return data.frame
#'
#' @author Frederik Sachser
#' @export
ics2table <- function(calendar_ics, calname = NULL) {
  x <- readLines(calendar_ics, warn = FALSE)
  x <- x[min(grep("^BEGIN:VEVENT*", x)):length(x)]
  x <-
    x[grepl("^SUMMARY:*|^DESCRIPTION:*|^DTSTART*|^DTEND*|^LOCATION:*", #|^RRULE:*
            x = x)]
  #  x <- gsub(",", ";", x)
  # see https://stackoverflow.com/a/43574682
  value <-
    do.call(rbind, regmatches(x, regexpr(":", x, fixed = TRUE), invert = TRUE))

  dfcal <- data.frame(value)
  names(dfcal) <- c("KEY", "VALUE")
  row.names(dfcal) <- 1:nrow(dfcal)

  foo <- grep("^DTSTART*", dfcal$KEY)

  foo <- c(foo, nrow(dfcal) + 1)
  foo <- diff(foo)
  dfcal$GROUP <- rep(1:length(foo), foo)

  dfcal <- tidyr::spread(data = dfcal, key = KEY, value = VALUE) #

  names(dfcal) <- gsub(";|=|/" , "", names(dfcal))
  foo <- which(startsWith(names(dfcal), "DTSTART"))
  bar <- which(startsWith(names(dfcal), "DTEND"))

  dfcal$START_DATE <- do.call(paste0, dfcal[min(foo):max(foo)])
  dfcal$END_DATE <- do.call(paste0, dfcal[min(bar):max(bar)])

  dfcal$START_DATE <- gsub("NA", "", dfcal$START_DATE)
  dfcal$END_DATE <- gsub("NA", "", dfcal$END_DATE)


  dfcal$GROUP <- NULL
  dfcal$START_DATE <-
    as.Date(substr(dfcal$START_DATE, 1, 8), format = "%Y%m%d")
  dfcal$END_DATE <-
    as.Date(substr(dfcal$END_DATE, 1, 8), format = "%Y%m%d")
  dfcal$DURATION <- difftime(dfcal$END_DATE, dfcal$START_DATE, units = "days") + 1


  dfcal$START_TIME <- ifelse(nchar(as.character(dfcal$DTSTART)) > 8, substr(dfcal$DTSTART, 10, 13), NA)
  dfcal$END_TIME <- ifelse(nchar(as.character(dfcal$DTEND)) > 8, substr(dfcal$DTEND, 10, 13), NA)

  dfcal <- dfcal %>%
    dplyr::select(-dplyr::starts_with("DTSTART") , -dplyr::starts_with("DTEND"))

  if (!is.null(calname)) {
    dfcal$CALENDAR <- calname
  }

  return(dfcal)

}
