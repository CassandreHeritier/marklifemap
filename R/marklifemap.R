#' Create markers on a Lifemap.
#'
#' Create a Lifemap using \code{leaflet()} and add markers from \code{data} depending on the options choosed by user.
#' Requires a connexion to \url{http://lifemap.univ-lyon1.fr/} and its database.
#'
#' @param data a dataframe or vector of information
#' @param type a character string to choose the type of data used for \code{solr_request} ; must be identical to an attribute from the SolR database, and at least one column name if \code{data} is a dataframe
#' @param map a character string : basemap among 'standard', virus', 'ncbi' and 'french' versions of lifemap
#' @param minimap a boolean to choose the display of a little map at the top right of the window
#' @param descendant a boolean to choose the display of descendant groups
#' @param ascendant a boolean to choose the display of ascendant groups
#' @param popup a character string to choose the type of popup among 'dataframe', 'sci_info' and 'none'; 'none' by default
#' @param form a character string to choose the form of markers among 'dataframe', 'nbdesc' and 'none'; 'none' by default
#' @param cluster a character sting to choose the type of cluster among 'sum' and 'none'; 'none' by default
#' @param minimap a boolean to choose if the minimap should be displayed
#' @param output a character string to choose if search result should be displayed among 'file', 'merge_file', 'console' and 'merge_console'; no output by default
#' @param filename a character string to name the output file if 'file' is chosen for \code{output} ; written in working directory
#'
#' @return the lifemap widget with markers
#'
#' @import utils
#'
#' @export
#'
#' @examples marklifemap(data.frame(list("taxid"=c(2,9443,2087),"name"=c('A','B','C'),"nbdesc"=c(300,20,109))), map='ncbi')
#'
marklifemap<-function(data, type="taxid", map='standard', minimap=FALSE, ascendant=FALSE, descendant=FALSE, popup="none", form="none", cluster="none",output=FALSE, filename="result.csv"){
  # if user gives a data.frame
  if (typeof(data)=="list"){
    datanames<-colnames(data)
    datanames<-datanames[datanames!=type]
    info<-as.vector(t(data[type]))
    marks<-data[datanames]
  }
  # if user gives a vector of information
  else {
    taxids<-data
  }
  coordinates<-solr_request(info,type, map)
  # option for descendants
  if (descendant) {
    DATA<-get_descend(info)
    desc<-solr_request(DATA,type,map,input=FALSE) #add taxids of descendant groups if option is selected
    coordinates<-merge(coordinates,desc,all=TRUE)
  }
  # option for ascendants
  if (ascendant) {
    DATA<-get_ascend(info)
    asc<-solr_request(DATA,type,map,input=FALSE) #input allow to not erase the error file from initial search, discarding all inherent error in database
    coordinates<-merge(coordinates,asc,all=TRUE)
  }
  lifemap<-newmap(coordinates, map) # create lifemap
  mark_lifemap<-add_markers(marks, lifemap,popup=popup,form=form,cluster=cluster) # marks lifemap
  # option for minimap
  if (minimap) {
    mark_lifemap<-add_minimap(mark_lifemap, map) # adds a little map if option is selected
  }
  # option for output
  switch(output,
         "file"={
           write.csv(coordinates,filename)
         },
         "merge_file"={
           result=merge(coordinates,data,by=type)
           write.csv(result,filename)
         },
         "console"={
           print(coordinates)
         },
         "merge_console"={
           result=merge(coordinates,data,by=type)
           print(result)
         }
  )
  return(mark_lifemap)
}
