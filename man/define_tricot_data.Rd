% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/databook_functions.R
\name{define_tricot_data}
\alias{define_tricot_data}
\title{Define Tricot Data in a Data Book}
\usage{
define_tricot_data(output_data_levels, variety_cols = NULL, trait_cols = NULL)
}
\arguments{
\item{output_data_levels}{A data frame summarising datasets and their key columns,
typically produced by \code{instatExtras::summarise_data_levels()} or
\code{create_tricot_datasets()}.}

\item{variety_cols}{Character vector of variety columns for detection (optional).}

\item{trait_cols}{Optional character vector of trait column names to assign at the
plot level. If \code{NULL}, traits are inferred from the dataset after loading.}
}
\value{
Invisibly returns \code{NULL}; registers metadata in \code{data_book}.
}
\description{
Registers tricot experiment datasets (ID-, plot-, and variety-level) into a
\code{data_book} object, setting key identifiers and variable roles for each level
based on detected or provided suffix conventions.
}
\details{
\enumerate{
\item Detects tricot structure (options names, trait suffixes, rank set) using
\code{detect_tricot_structure()} on the ID-level dataset.
\item Calls \code{data_book$define_as_tricot()} for each dataset at the "id", "plot",
and "variety" levels, supplying the appropriate key columns and type mapping
(e.g. \verb{id=}, \verb{variety=}, \verb{traits=}).
}
}
\examples{
# Given a data book and output_data_levels:
#define_tricot_data(output_data_levels)

}
