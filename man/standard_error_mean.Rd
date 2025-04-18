% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_functions.R
\name{standard_error_mean}
\alias{standard_error_mean}
\title{Calculate Standard Error of the Mean}
\usage{
standard_error_mean(x, na.rm = FALSE, na_type = "", ...)
}
\arguments{
\item{x}{A numeric vector.}

\item{na.rm}{Logical. Should missing values be removed? Defaults to \code{FALSE}.}

\item{na_type}{Character string indicating the type of NA check to perform.}

\item{...}{Additional arguments passed to \code{na_check}.}
}
\value{
The standard error of the mean.
}
\description{
Computes the standard error of the mean for a dataset.
}
