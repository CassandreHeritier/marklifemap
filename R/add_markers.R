#' Add markers
#'
#' Add markers to a lifemap using \code{leaflet}. Options \code{popup}, \code{form} and \code{cluster} allow to change graphic representation.
#'
#' @param marks dataframe of markers to view on the lifemap given by the user ; NULL by default
#' @param lifemap a map widget created from \code{leaflet()}, moddified by \code{add_markers()}
#' @param radius a numeric for the size of markers if form use a circle
#' @param popup a character string used for the name of the popup option when clicking markers ; "none" by default
#' @param form  a character string used for the name of the shape option of the marker ; "none" by default
#' @param cluster a character string used for the name of the cluster options of markers; "none" by default
#'
#' @return mark_lifemap the lifemap with markers
#'
#' @import leaflet
#' @import curl
#'
#' @export
#'
#' @examples library(jsonlite)
#' @examples add_markers(lifemap=newmap(solr_request(2, "taxid", "ncbi")))
#'
add_markers <- function(marks=NULL, lifemap, radius=10, popup="none",form="none",cluster="none"){
  switch(popup, # choice of popup
         "dataframe"={ # if user wants to use his own dataframe
           for (i in marks){
             elm<-as.vector(t(i))
             if (is.character(elm)){ # the last vector of characters is used as popups
               popup=elm
             }
           }
         },
         "sci_info"={ # if the user wants data from database Solr
           popup=~paste(sep="<br/>",sci_name,taxid,nbdesc) # scientific name, taxid and number of descendants are used as popups
         },
         # new popups can be added here, as a new switch case
         "none"={ # if popup is none, there is no popup
           popup=NULL
         }
  )
  switch(cluster, # choice of cluster
         "sum"={ # if sum of groups is chosen
           clusterOptions=markerClusterOptions() # cluster will display the number of groups clustered
         },
         #new cluster options can be added here, as a new switch case
         "none"={ # if cluster is none, there is no cluster
           clusterOptions=NULL
         }
  )
  switch(form, # choice of icon form
         "dataframe"={ # if user wants to use his own dataframe for the size of markers
           for (i in marks){
             elm<-as.vector(t(i))
             if (is.numeric(elm)){ # the last vector of numeric is used as radius
               radius<-elm/10
             }
           }
           # creation of circle for each group, with previous options
           mark_lifemap<-addCircleMarkers(lifemap, lng=~lon, lat=~lat, radius=radius, color='red', stroke=TRUE, fillOpacity=0.5, popup=popup, label=~sci_name,clusterOptions=clusterOptions)
         },
         "nbdesc"={ # if user wants to use number of descendants as radius
           mark_lifemap<-addCircleMarkers(lifemap, lng=~lon, lat=~lat, radius=(~nbdesc+1), color="blue", stroke=TRUE, popup=popup, label=~sci_name,clusterOptions=clusterOptions)
         },
         # new markers form can be added here, as a new switch case
         "none"={ # if form is none, simple arrow is used
           mark_lifemap<-addMarkers(lifemap, lng=~lon, lat=~lat, popup=popup,label=~sci_name,clusterOptions=clusterOptions)
         }
  )

  return(mark_lifemap)
}

