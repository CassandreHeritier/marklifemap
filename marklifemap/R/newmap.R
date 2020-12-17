#' Newmap
#'
#' Create a new lifemap according to the chosen \code{map}.
#' Requires a connection to \url{http://lifemap.univ-lyon1.fr/} and its database.
#'
#' @param coordinates of groups, as a dataframe with a \emph{coordinate} column being the result of Solr request; NULL by default
#' @param map a character string for the version of lifemap among 'standard', 'ncbi', 'french' and virus' version; 'standard' by default
#'
#' @return A new map widget used by \code{leaflet} and \code{marklifemap}.
#'
#' @import leaflet
#'
#' @export
#'
#' @examples newmap(map='virus')
#'
newmap <- function(coordinates=NULL, map='standard'){
  lifemap<-leaflet(coordinates)
  switch(map,
         "ncbi"={
           tiles="http://lifemap-ncbi.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tiles, group = "ncbi version")
         },
         "virus"={
           tiles="http://virusmap.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tiles, group = "virus version")
         },
         "standard"={
           tiles="http://lifemap.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tiles, group = "standard version")
         },
         "french"={
           tiles="http://lifemap-fr.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tiles, group = "french version")
         }
  )
  return(lifemap)
}

