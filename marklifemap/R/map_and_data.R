#' Map and data
#'
#' If there are taxids which do not exist in the chosen map, prints the unfound
#' taxids.
#'
#' @param data_sub a dataframe resulting from a JSON query
#' @param taxids a vector of numeric corresponding to taxids
#' @param i a numeric tracking the position of the taxids
#' @param wrongs a vector of unfound taxids
#'
#' @return a vector of uncorresponding taxid
#'
#' @export
#'
#'@examples library(jsonlite)
#'@examples map_and_data(fromJSON("http://lifemap-ncbi.univ-lyon1.fr/solr/taxo/select?q=taxid:(2%209443%202087)&wt=json&rows=1000"), c(2,9443,2087), 1, c(2,9443))
#'
map_and_data <- function(data_sub, taxids, i, wrongs){
  if (length(taxids) - i >= 100){
    # if the list of taxid is longer than 100 and there are more than 100 taxids left
    if (data_sub[["response"]][["numFound"]] != 100){
      # if there are invalid taxids in the url, print them
      for (k in i:(i+99)){
        if ((taxids[k] %in% data_sub[["response"]][["docs"]][1][["taxid"]]) == FALSE)
         wrongs <- append(wrongs, taxids[k]) # print(taxids[k])
      }
    }
  }
  else if (i >= 101){
    # if the list of taxid is longer than 100 and there are less than 100 taxids left
    if (data_sub[["response"]][["numFound"]] != (length(taxids) - (i-1))) {
      for (m in i:(length(taxids))){
        if ((taxids[m] %in% data_sub[["response"]][["docs"]][1][["taxid"]]) == FALSE)
          wrongs <- append(wrongs, taxids[m]) # print(taxids[m])
      }
    }
  }
  else{
    # if the list of taxid is shorter than 100
    if (data_sub[["response"]][["numFound"]] != length(taxids)){
      for (k in (1:(length(taxids)))){
        if ((taxids[k] %in% data_sub[["response"]][["docs"]][1][["taxid"]]) == FALSE)
          wrongs <- append(wrongs, taxids[k]) # print(taxids[k])
      }
    }
  }
  return(wrongs)
}
