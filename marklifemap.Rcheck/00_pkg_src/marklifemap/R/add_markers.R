#' Add markers
#'
#' Add of markers on the lifemap, with various options for form, cluster and popup
#'
#' @param marks data.frame of marks to view on the lifemap, given by the user;
#' NULL by default
#' @param lifemap the map generated
#' @param radius the size of markers
#' @param popup if user wants popups ; "none" by default
#' @param form if user wants special form ; "none" by default
#' @param cluster if user wants cluster ; "none" by default
#'
#' @return mark_lifemap
#'
#' @import leaflet
#'
#' @export
#'
#' @examples add_markers(marks, newmap(solr_request(2, "ncbi"), "ncbi"))
#'
add_markers <- function(marks=NULL, lifemap, radius=10, popup="none",form="none",cluster="none"){
  switch(popup, #choice of popup
         "dataframe"={ #if user want to use their own dataframe
           for (i in marks){
             elm<-as.vector(t(i))
             if (is.character(elm)){ #column of characters will be used as popups
               popup=elm
             }
           }
         },
         "sci_info"={ #if the user want data from database
           popup=~paste(sep="<br/>",sci_name,taxid,nbdesc) #scientific name, tax id and number of descriptions are used as popup
         },
         #new popups can be added here, as a new switch case
         "none"={ #if none chosen, then no popup
           popup=NULL
         }
  )
  switch(cluster, #choice of cluster
         "sum"={ #if sum of groups choosen
           clusterOptions=markerClusterOptions() #cluster wil display the number of groups clustered
         },
         "none"={ #if none chosen, then no cluster
           clusterOptions=NULL
         }
  )
  switch(form, #choice of icon form
         "dataframe"={ #if user want to use their own dataframe
           for (i in marks){
             elm<-as.vector(t(i))
             if (is.numeric(elm)){ #numerics column are used as radius
               radius<-elm/10
             }
           }
           #creation of circle for each group, with previous options
           mark_lifemap<-addCircleMarkers(lifemap, lng=~lon, lat=~lat, radius=radius, color='red', stroke=TRUE, fillOpacity=0.5, popup=popup, label=~sci_name,clusterOptions=clusterOptions)
         },
         "nbdesc"={ #if user want to use number of descriptions as radius
           mark_lifemap<-addCircleMarkers(lifemap, lng=~lon, lat=~lat, radius=(~nbdesc+1), color="blue", stroke=TRUE, popup=popup, label=~sci_name,clusterOptions=clusterOptions)
         },
         #new markers form can be added here, as a new switch case
         "none"={ #if none chosen, simple arrow are used
           mark_lifemap<-addMarkers(lifemap, lng=~lon, lat=~lat, popup=popup,label=~sci_name,clusterOptions=clusterOptions)
         }
  )

  return(mark_lifemap)
}

