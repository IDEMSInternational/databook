% Documentation for the ghana dataset
\name{ghana}
\docType{data}
\alias{ghana}
\title{Ghana example dataset}

\description{A set of data frames named \code{ghana} included with the package for examples and tests.}

\usage{data(ghana, package = "databook")}

\source{Provided with the package for testing and examples.}

\examples{
# Load in the data
data(ghana)

# See the data frame names in the data
ghana$get_data_names()

# Call the data frames themselves
ghana_df <- ghana$get_data_frame("ghana")
ghana_df_by_station_year <- ghana$get_data_frame("ghana_by_station_year")
crop_prop <- ghana$get_data_frame("crop_prop")
crop_def <- ghana$get_data_frame("crop_def")
}