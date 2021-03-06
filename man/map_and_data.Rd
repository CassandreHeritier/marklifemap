% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_and_data.R
\name{map_and_data}
\alias{map_and_data}
\title{Map and data}
\usage{
map_and_data(data_sub, taxids, i, wrongs)
}
\arguments{
\item{data_sub}{a dataframe resulting from a JSON query}

\item{taxids}{a vector of numeric corresponding to taxids}

\item{i}{a numeric tracking the position of the taxids}

\item{wrongs}{a vector of unfound taxids}
}
\value{
a vector of uncorresponding taxid
}
\description{
If there are taxids which do not exist in the chosen map, prints the unfound
taxids.
}
\examples{
library(jsonlite)
}
