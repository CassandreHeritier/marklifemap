% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_markers.R
\name{add_markers}
\alias{add_markers}
\title{Add markers}
\usage{
add_markers(
  marks = NULL,
  lifemap,
  radius = 10,
  popup = "none",
  form = "none",
  cluster = "none"
)
}
\arguments{
\item{marks}{dataframe of markers to view on the lifemap given by the user ; NULL by default}

\item{lifemap}{a map widget created from \code{leaflet()}, moddified by \code{add_markers()}}

\item{radius}{a numeric for the size of markers if form use a circle}

\item{popup}{a character string used for the name of the popup option when clicking markers ; "none" by default}

\item{form}{a character string used for the name of the shape option of the marker ; "none" by default}

\item{cluster}{a character string used for the name of the cluster options of markers; "none" by default}
}
\value{
mark_lifemap the lifemap with markers
}
\description{
Add markers to a lifemap using \code{leaflet}. Options \code{popup}, \code{form} and \code{cluster} allow to change graphic representation.
}
\examples{
library(jsonlite)
add_markers(lifemap=newmap(solr_request(2, "taxid", "ncbi")))

}
