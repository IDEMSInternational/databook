% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_functions.R
\name{summary_cor}
\alias{summary_cor}
\title{Calculate Correlation}
\usage{
summary_cor(
  x,
  y,
  na.rm = FALSE,
  na_type = "",
  weights = NULL,
  method = c("pearson", "kendall", "spearman"),
  cor_use = c("everything", "all.obs", "complete.obs", "na.or.complete",
    "pairwise.complete.obs"),
  ...
)
}
\arguments{
\item{x}{A numeric vector.}

\item{y}{A numeric vector.}

\item{na.rm}{Logical. Should missing values be removed? Defaults to \code{FALSE}.}

\item{na_type}{Character string indicating the type of NA check to perform.}

\item{weights}{Optional weights for the data.}

\item{method}{Character. Correlation method ("pearson", "kendall", "spearman"). Defaults to \code{"pearson"}.}

\item{cor_use}{Character. How missing data is handled ("everything", "all.obs", etc.). Defaults to \code{"everything"}.}

\item{...}{Additional arguments passed to \code{na_check}.}
}
\value{
The correlation or weighted correlation.
}
\description{
Computes the correlation or weighted correlation between two datasets.
}
