#' Solr request
#'
#' @param taxids a vector of taxids
#' @param map a character string for a lifemap, "standard" by default
#'
#' @return coordinates
#'
#' @import jsonlite
#'
#' @export
#'
#' @examples solr_request(c(2,9443,2087), map='ncbi')
solr_request<-function(taxids, map='standard') {
  taxids<-as.character(taxids)
  coordinates<-NULL
  i<-1
  while(i<=length(taxids)) {
    cat(".")
    taxids_sub<-taxids[i:(i+99)]
    taxids_sub<-taxids_sub[!is.na(taxids_sub)]
    taxids_sub<-paste(taxids_sub, collapse="%20")
    switch(map,
           "ncbi"={
             url<-paste("http://lifemap-ncbi.univ-lyon1.fr/solr/taxo/select?q=taxid:(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           },
           "standard"={
             url<-paste("http://lifemap.univ-lyon1.fr/solr/taxo/select?q=taxid:(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           },
           "virus"={
             url<-paste("http://virusmap.univ-lyon1.fr/solr/taxo/select?q=taxid:(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           },
           "french"={
             url<-paste("http://lifemap-fr.univ-lyon1.fr/solr/taxo/select?q=taxid:(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="")
           }
    )
    data_sub<-fromJSON(url)
    map_and_data(data_sub,taxids, i)
    coordinates<-rbind(coordinates,data_sub$response$docs[,c("taxid","lon","lat", "sci_name","zoom","nbdesc")])
    i<-i+100
  }
  for (j in 1:ncol(coordinates)) coordinates[,j]<-unlist(coordinates[,j])
  class(coordinates$taxid)<-"character"
  return(coordinates)
}
