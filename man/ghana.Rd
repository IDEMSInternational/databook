% Documentation for the ghana dataset
\name{ghana}
\docType{data}
\alias{ghana}
\title{Ghana example dataset}

\description{A set of data frames named \code{ghana} included with the package for examples and tests.}

\usage{data(ghana, package = "databook")}

\source{Provided with the package for testing and examples.}

\examples{
data_book <- DataBook$new()
data(ghana)
data_book$import_RDS(data_RDS=ghana)
ghana$get_data_names()

ghana_df <- ghana$get_data_frame("ghana")
ghana_df_by_station_year <- ghana$get_data_frame("ghana_by_station_year")
crop_prop <- ghana$get_data_frame("crop_prop")
crop_def <- ghana$get_data_frame("crop_def")
}
