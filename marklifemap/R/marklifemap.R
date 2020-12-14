#' Add markers on the lifemap
#'
#' Add markers from user's data on the lifemap.
#'
#' @param data a data.frame with taxids in vector 1 and data to view in vectors after
#' @param map a character string, corresponding to a basemap among 'standard', virus', 'ncbi' and 'french' version of lifemap
#' @param descendant a boolean to choose the display of descendant groups
#' @param ascendant a boolean to choose the display of ascendant groups
#' @param popup a character string to choose the type of popup among 'dataframe', 'sci_info' and 'none'; 'none' by default
#' @param form a character string to choose the form of markers among 'dataframe', 'nbdesc' and 'none'; 'none' by default
#' @param cluster a character sting to choose the type of cluster among 'sum' and 'none'; 'none' by default
#'
#' @return mark_lifemap
#'
#' @export
#'
#' @examples marklifemap(data.frame(list(c(2,9443,2087),c('A','B','C'),c(300,20,109))), 'ncbi')
#'
marklifemap<-function(data, map='standard', minimap=FALSE, ascendant=FALSE, descendant=FALSE, popup="none", form="none", cluster="none"){
  n<-length(data)
  taxids<-as.vector(t(data[1])) # first vector is taxids, converted in vector
  marks<-data[,2:n] # others are marks, in data.frame
  if (descendant) {
    DATA<-get_descend(taxids)
    taxids<-append(taxids,DATA) #add taxids of descendant groups if option is selected
  }
  if (ascendant) {
    DATA<-get_ascend(taxids)
    taxids<-append(taxids,DATA)
  }
  coordinates<-solr_request(taxids, map)
  lifemap<-newmap(coordinates, map) # create lifemap
  mark_lifemap<-add_markers(marks, lifemap,popup=popup,form=form,cluster=cluster) # marks lifemap
  if (minimap) {
    mark_lifemap<-add_minimap(mark_lifemap, map)
  }
  return(mark_lifemap)
}
