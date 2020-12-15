#' Newmap
#'
#' Function to create a new lifemap according to the chosen map.
#' Keeps coordinates of taxons in memory if there are.
#'
#' @param coordinates of taxids, the result of Solr request; NULL by default
#' @param map the version of lifemap among 'standard', 'ncbi', 'french' and
#' 'virus' version; 'standard' by default
#'
#' @return lifemap
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

