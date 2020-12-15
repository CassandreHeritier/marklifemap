#' Add markers on the lifemap
#'
#' Add markers from user's data on the lifemap.
#' Tool to visualize your own dataset on the lifemap, for chosen taxons.
#'
#' @param data a data.frame with taxids in vector 1 and data to view in vectors after
#' @param type a character string to choose the type of data used for solr_request
#' @param map a character string, corresponding to a basemap among 'standard', virus', 'ncbi' and 'french' version of lifemap
#' @param minimap a boolean to choose the display of a little map at the top right of the window
#' @param descendant a boolean to choose the display of descendant groups
#' @param ascendant a boolean to choose the display of ascendant groups
#' @param popup a character string to choose the type of popup among 'dataframe', 'sci_info' and 'none'; 'none' by default
#' @param form a character string to choose the form of markers among 'dataframe', 'nbdesc' and 'none'; 'none' by default
#' @param cluster a character sting to choose the type of cluster among 'sum' and 'none'; 'none' by default
#' @param minimap a character string to choose of the minimap should be displayed
#'
#' @return mark_lifemap the lifemap with markers
#'
#' @import curl
#'
#' @export
#'
#' @examples marklifemap(data.frame(list("taxid"=c(2,9443,2087),
#' "name"=c('A','B','C'),"nbdesc"=c(300,20,109))), map='ncbi')
#'
marklifemap<-function(data,type="taxid", map='standard', minimap=FALSE, ascendant=FALSE, descendant=FALSE, popup="none", form="none", cluster="none"){
  if (typeof(data)=="list"){
    datanames<-colnames(data)
    datanames<-datanames[datanames!=type]
    taxids<-as.vector(t(data[type]))
    marks<-data[datanames]
  }
  else {
    taxids<-data
  }
  coordinates<-solr_request(taxids,type, map)
  if (descendant) {
    DATA<-get_descend(taxids)
    desc<-solr_request(DATA,type,map) #add taxids of descendant groups if option is selected
    coordinates<-merge(coordinates,desc,all=TRUE)
  }
  if (ascendant) {
    DATA<-get_ascend(taxids)
    asc<-solr_request(DATA,type,map)
    coordinates<-merge(coordinates,asc,all=TRUE)
  }
  lifemap<-newmap(coordinates, map) # create lifemap
  mark_lifemap<-add_markers(marks, lifemap,popup=popup,form=form,cluster=cluster) # marks lifemap
  if (minimap) {
    mark_lifemap<-add_minimap(mark_lifemap, map) # adds a little map if option is selected
  }
  return(mark_lifemap)
}
