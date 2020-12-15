#' Solr request
#'
#' Function to do a request from the database Solr to get the coordinates
#' of each taxon (taxids given).
#'
#' @param taxids a vector of taxids
#' @param type a character string for the type of data used
#' @param map a character string for a lifemap, "standard" by default
#'
#' @return coordinates of each taxid
#'
#' @import jsonlite
#'
#' @export
#'
#' @examples solr_request(c(2,9443,2087), map='ncbi')

solr_request<-function(taxids,type="taxid", map='standard') {
  taxids<-as.character(taxids) # change to characters
  coordinates<-NULL # coordinates of taxids in the lifemap
  i<-1
  while(i<=length(taxids)) {
    # url cannot be too long, so that we need to cut the taxids
    # (100 max in one chunk)
    # and make as many requests as necessary
    cat(".")
    taxids_sub<-taxids[i:(i+99)]
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
    )
    # do the request from Solr
    data_sub<-fromJSON(url)
    map_and_data(data_sub,taxids, i)
    if (data_sub[["response"]][["numFound"]] != 0)
      coordinates<-rbind(coordinates,data_sub$response$docs[,c("taxid","lon","lat", "sci_name","zoom","nbdesc")])
    i<-i+100
  }
  for (j in 1:ncol(coordinates)) coordinates[,j]<-unlist(coordinates[,j])
  class(coordinates$taxid)<-"character"
  return(coordinates)
}
