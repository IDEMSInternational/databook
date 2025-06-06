% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary_functions.R
\name{PODy}
\alias{PODy}
\title{Calculate Probability of Detection (PODy)}
\usage{
PODy(x, y, frcst.type, obs.type, ...)
}
\arguments{
\item{x}{Observed values.}

\item{y}{Predicted values.}

\item{frcst.type}{Character. The type of forecast (e.g., "binary").}

\item{obs.type}{Character. The type of observation (e.g., "binary").}

\item{...}{Additional arguments passed to \code{verification::verify}.}
}
\value{
The probability of detection.
}
\description{
Computes the probability of detection (PODy) using the \code{verification::verify} function.
}
