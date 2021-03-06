% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dput_fun.R
\name{dput_fun}
\alias{dput_fun}
\title{Dput a function}
\usage{
dput_fun(pkg_fun, target_dir = "R", rm_pattern = FALSE)
}
\arguments{
\item{pkg_fun}{Character. Name of a package and function separated by '::'. E.g. fsf::dput_fun. Do not use quotation marks.}

\item{target_dir}{Character. Specify the file path, where you want to write the file.}

\item{rm_pattern}{Character. Choose any pattern that should be removed. E.g. 'fsf::' to exclude the name of the package sf.}
}
\description{
Choose a function of an installed R-package and save it to the specified target.
}
\author{
Frederik Sachser
}
