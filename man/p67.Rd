% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_functions.R
\name{p67}
\alias{p67}
\title{Calculate 67th Percentile}
\usage{
p67(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...)
}
\arguments{
\item{x}{A numeric vector, ordered factor, or date.}

\item{na.rm}{Logical. Should missing values be removed? Defaults to \code{FALSE}.}

\item{na_type}{Character string indicating the type of NA check to perform.}

\item{weights}{Optional weights for the data.}

\item{na_max_prop}{Optional. Maximum allowed proportion of missing values (in percentage).}

\item{...}{Additional arguments passed to \code{na_check}.}
}
\value{
The 67th percentile of the dataset.
}
\description{
Computes the 67th percentile of a dataset using \code{summary_quantile}.
}
