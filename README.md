# Marklifemap is a tool to visualizing your own data on a lifemap. 

**Marklifemap** allows you to visualize your own dataset on a lifemap version that you can choose, accessible from http://lifemap.univ-lyon1.fr/.

**Marklifemap** is written in R language.

## Installation
**Marklifemap** is not yet on CRAN. To install the development version:    


1. Install the release version of devtools from CRAN with `install.packages("devtools")`.    
2. Launch R and type:
```R
library(devtools)
install_github("cassandreheritier/marklifemap")
```
3. Once installed the package can be loaded using:
```R
library("marklifemap")
```

## Usage
1. Create your dataframe of dataset, with a first vector of taxids and vectors after of datasets to visualize.
```R
data<-data.frame(yourdataset)
```
2. Run marklifemap with your dataset (possible options are described below).
```R
marklifemap(data, map='ncbi', minimap=TRUE)
```
>#### Options
>The marklifemap() function is called as follows by default: 
>```R
>marklifemap(data, map='standard', minimap=FALSE, ascendant=FALSE, descendant=FALSE, popup="none", form="none", cluster="none")
>```
>Possible options are:    
>```map```: You can choose the map among 'standard', 'ncbi', 'virus' and 'french' version.  
>```minimap```: If minimap is TRUE, another map is opened in the window, to view where you are in the tree.  
>```ascendant```: If ascendant is TRUE, all of ascendants of the taxids are shown on the lifemap.  
>```descendant```: If descendant is TRUE, all of descendants of the taxids are shown on the lifemap.  
>```popup```: You can choose the type of popup you want to view among 'dataframe' (your data are directly shown), 'sci_info' (to view informations from the Solr database about your taxids) and 'none'.  
>```form```: You can choose the form of markers among 'dataframe' (markers will be proportionals to your data numbers), 'nbdesc' (with informations from Solr) and 'none'.   
>```cluster```: You can choose the type of cluster among 'sum' and 'none'.   
>```output```: You can choose to display the search result of the request from Solr, taping 'file' to create a file in your working directory, 'merge_file' to do the same but adding your dataset, 'console' to display in the console directly and 'merge_console' with your dataset again.  
>```filename```: If 'file' in 'output' option was given, you can choose the filename.  
3. See your lifemap with markers
A window appears with your lifemap, enjoy !

## Initialization  
To understand the functions under marklifemap with a dataset.
```R
taxids<-c(2,9443,2087) # example of taxids to target : Primates, Bacteria and Anaeroplasma abactoclasticum
popups<-c('First taxid','Second taxid','Third taxid') # example of popups that you want to visualize on each taxon (with order)
sizes<-c(300,20,109) # example of sizes you want for each marker / taxon
data<-data.frame(list(taxids, popups, sizes)) # example of a set of data : taxids in first vector, popups in second vector, and sizes of markers in third vector

solr_request(taxids) # function that calls database Solr, you can find names, coordinates and number of descendants of each taxon
newmap() # create a standard map
newmap(map='virus') # with virusmap
marklifemap(data, map='ncbi', popup='dataframe', form='dataframe') # an example of lifemap with markers
```

## Example  
```R
marklifemap(data, map='ncbi', popup='dataframe', form='dataframe', cluster='sum', output='file') # with a set of data initialized as before
```
---
### References
Damien DE VIENNE
Package 'leaflet'

---
>For comments, suggestions and bug reports, please open an issue on this github repository.


