#' Add minimap
#'
#' Function to add a little map at the right top of the window, to see
#' where you are navigating on the lifemap.
#'
#' @param lifemap a lifemap object
#' @param map a character string for a lifemap, "standard" by default
#'
#' @return with_minimap the lifemap with the minimap
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
           tiles="http://lifemap-ncbi.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tiles, group = "ncbi version")
         },
         "virus"={
           tuiles="http://virusmap.univ-lyon1.fr/osm_tiles/{z}/{x}/{y}.png"
           lifemap<-addTiles(lifemap, tuiles, group = "virus version")
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
  with_minimap <- addMiniMap(lifemap, position = "topright", width = 200, height = 200, tiles = tiles, zoomLevelOffset = -6, toggleDisplay = TRUE)
  return(with_minimap)
}
