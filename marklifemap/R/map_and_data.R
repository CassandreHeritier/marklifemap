#' Map and data
#'
#' If there are taxids which do not exist in the chosen map, prints the unfound
#' taxids.
#'
#' @param data_sub a dataframe resultaing from a JSON query
#' @param taxids a vector of numeric correspondong to taxids
#' @param i a numeric tracking the position of the taxids
#'
#' @return TRUE
#'
#' @export
#'
#'@examples map_and_data(fromJSON("http://lifemap-ncbi.univ-lyon1.fr/solr/taxo/select?q=taxid:(2%209443%202087)&wt=json&rows=1000"), c(2,9443,2087), 1)
#'
map_and_data <- function(data_sub, taxids, i){
  if (length(taxids) - i >= 100){
    # if the list of taxid is longer than 100 and there are more than 100 taxids left
    if (data_sub[["response"]][["numFound"]] != 100){
      # if there are invalid taxids in the url, print them
      print("couldn't find following taxids:")
      for (k in i:(i+99)){
        if ((taxids[k] %in% data_sub[["response"]][["docs"]][1][["taxid"]]) == FALSE)
          print(taxids[k])
      }
    }
    else{
      # if all taxids of the url were found
      print("found all")
    }
  }
  else if (i > 100){
    # if the list of taxid is longer than 100 and there are less than 100 taxids left
    if (data_sub[["response"]][["numFound"]] != (length(taxids) - i)){
      print("couldn't find following taxids:")
      for (m in i:(length(taxids))){
       if ((taxids[m] %in% data_sub[["response"]][["docs"]][1][["taxid"]]) == FALSE)
          print(taxids[m])
      }
    }
    else
      print("found all")
  }
  else{
    # if the list of taxid is shorter than 100
    if (data_sub[["response"]][["numFound"]] != length(taxids)){
      print("couldn't find following taxids:")
      for (k in (1:(length(taxids)))){
        if ((taxids[k] %in% data_sub[["response"]][["docs"]][1][["taxid"]]) == FALSE)
          print(taxids[k])
      }
    }
    else
      print("found all")

  }
  return(TRUE)
}

