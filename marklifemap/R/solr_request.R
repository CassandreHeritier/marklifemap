#' Solr request
#'
#' Search in the \url{http://lifemap.univ-lyon1.fr/} database for \code{info} in the \code{type} column.
#' Call \code{map_and_data} to write all elements of \code{info} not found in the database in an \code{unfound.txt} file in working directory.
#'
#' @param info a vector of information
#' @param type a character string for the type of data used
#' @param map a character string for a lifemap, "standard" by default
#' @param input a boolean to avoid overwriting "unfound.txt"
#'
#' @return A dataframe with information from the query extracted. Can be used for a leaflet, lifemap or marklifemap map.
#'
#' @import jsonlite
#'
#' @export
#'
#' @examples solr_request(c(2,9443,2087), map='ncbi')

solr_request<-function(info,type="taxid", map='standard', input=TRUE) {
  taxids<-as.character(info) # change to characters
  coordinates<-NULL # coordinates of detected groups in the lifemap
  wrongs <- vector()  # vector that will contain unfound groups from info
  i<-1
  while(i<=length(info)) {
    # url cannot be too long, so that we need to cut the taxids
    # (100 max in one chunk)
    # and make as many requests as necessary
    cat(".")
    taxids_sub<-info[i:(i+99)]
    taxids_sub<-taxids_sub[!is.na(taxids_sub)]
    taxids_sub<-paste(taxids_sub, collapse="%20") # accepted space separator in url
    switch(map,
           "ncbi"={
             url<-paste("http://lifemap-ncbi.univ-lyon1.fr/solr/taxo/select?q=",type,":(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           },
           "standard"={
             url<-paste("http://lifemap.univ-lyon1.fr/solr/taxo/select?q=",type,":(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           },
           "virus"={
             url<-paste("http://virusmap.univ-lyon1.fr/solr/taxo/select?q=",type,":(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           },
           "french"={
             url<-paste("http://lifemap-fr.univ-lyon1.fr/solr/taxo/select?q=",type,":(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           }
           #new map can be added here
    )
    # do the request from Solr
    data_sub<-fromJSON(url)
    wrongs <- map_and_data(data_sub,info, i, wrongs)
    if (data_sub[["response"]][["numFound"]] != 0)
      coordinates<-rbind(coordinates,data_sub$response$docs[,c("taxid","lon","lat", "sci_name","zoom","nbdesc")])
    i<-i+100
  }
  if ((length(wrongs) != 0) & (input)){
    message("some taxids couldn't be found, you can find them in the file \"unfound.txt\" of your working directory")
    once <- unique(wrongs)
    file.create("unfound.txt")
    write(once, "unfound.txt") # create the file in which unfound taxids will be written
  }
  for (j in 1:ncol(coordinates)) coordinates[,j]<-unlist(coordinates[,j])
  class(coordinates$taxid)<-"character"
  return(coordinates)
}
