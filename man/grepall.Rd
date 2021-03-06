% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grepall.R
\name{grepall}
\alias{grepall}
\title{grep string for all columns of type character}
\usage{
grepall(dataframe, string, print_values = FALSE, ...)
}
\arguments{
\item{dataframe}{Object of class data.frame}

\item{string}{Character. Specify string to search for}

\item{print_values}{Logical. Choose wether to print values.}

\item{...}{further arguments passed to grep}
}
\description{
grep string for all columns of type character
}
\examples{
testdata <- data.frame(a = c(1, "?"), b = 1:2, C = c("?", "?"), d = c("?", "a"), stringsAsFactors = FALSE)
index <- which(as.matrix(testdata) == "?", arr.ind = TRUE)
testdata[index]
}
