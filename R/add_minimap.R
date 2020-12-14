#' add_minimap
#' adds a minimap
#'
#' @param lifemap a lifemap object
#' @param map a character string for a lifemap, "standard" by default
#'
#' @return withMiniMap
#'
#' @import leaflet
#'
#' @export
#'
#' @examples add_minimap(newmap())
#'
add_minimap <- function(lifemap, map='standard'){
  switch(map,
         "ncbi"={
           tuiles="http://lifemap-ncbi.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tuiles, group = "ncbi version")
         },
         "virus"={
           tuiles="http://virusmap.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tuiles, group = "virus version")
         },
         "standard"={
           tuiles="http://lifemap.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tuiles, group = "standard version")
         },
         "french"={
           tuiles="http://lifemap-fr.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tuiles, group = "french version")
         }
  )
  withMiniMap <- addMiniMap(lifemap, position = "topright", width = 200, height = 200, tiles = tuiles, zoomLevelOffset = -6, toggleDisplay = TRUE)
  return(withMiniMap)
}
