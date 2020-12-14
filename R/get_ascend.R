#' get_ascend
#'
#' Get a vector of taxids from maximum 1000 of the ascendant from each taxid in input
#'
#' @param taxids a vector of taxids
#'
#' @return DATA a vector of taxids
#'
#' @import jsonlite
#'
#' @export
#'
#' @examples get_ascend(2)
#'
get_ascend<-function(taxids) {
  taxids<-as.character(taxids)
  DATA<-NULL
  i<-1
  while(i<=length(taxids)) { #for each taxid in vector by group of 100
    cat(".")
    taxids_sub<-taxids[i:(i+99)]
    taxids_sub<-taxids_sub[!is.na(taxids_sub)] #remove NA values
    taxids_sub<-paste(taxids_sub, collapse="%20")
    url<-paste("http://lifemap-ncbi.univ-lyon1.fr/solr/addi/select?q=taxid:(",taxids_sub,")&wt=json&rows=1000",sep="", collapse="") #get all taxids of ascendant groups in database
    data_sub<-fromJSON(url)
    if (data_sub$response$numFound!=0) { #if query succeeded
      for (j in data_sub$response$docs[,"ascend"]) { #ascend is the taxid of ascendant groups
        DATA<-append(DATA,j) #add each taxid to the list of results
      }
    }
    i<-i+100
  }
  return(DATA)
}
