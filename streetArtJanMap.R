#STREET ART MAP ATHENS - JANUARY 2018

### load libraries
library(leaflet)
library(mapview)

### load data
df=read.csv2("streetArtUpdate1.csv",stringsAsFactors =F,header = T)

### change coordinates to numeric values
df$Longitude=as.numeric(df$Longitude)
df$Latitude=as.numeric(df$Latitude)

### create local and remote paths for loading images
df$remotePath=paste0("http://dev.humlab.lu.se/tmp/img/", 
                  df$Filename)

#df$localPath = paste0("/Users/peerchristensen/Desktop/streetArtJan/streetArtDataJan/",
#                      list.files("streetArtDataJan"))

### remove erroneous data
#we remove one data point due to erroneous coordinates. Should they be latitude 37.72341 should be 37.92341?
df=df[df$Title!="The Greek health system",] 

#sample image
#img="http://dev.humlab.lu.se/tmp/img/IMG00002_2013.jpg"

### create map
athensMap <- leaflet() %>%
  # Add a base layer
  addTiles('https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png') %>%
  # add markers
  addAwesomeMarkers(lng=df$Longitude, lat=df$Latitude,
      # add popup with images and variables as text
      popup=paste(popupImage(df$remotePath, src = c("remote")),"<br>",
                                "Title: ",paste("<a href=",df$remotePath,">",df$Title,"</a>"),"<br>",
                                "Creator: ",df$Name_of_the_creator,"<br>",
                                "Type: ",df$Pictorial_verbopictorial,"<br>",
                                "Text: ",paste("'",df$Text,"'")),
      # organise points as clusters
      clusterOptions = markerClusterOptions(),
      label = df$Title) %>%
      # include minimap
      addMiniMap()

# show map
athensMap



### unused code from earlier

#library(plyr)
#library(data.table)
#library(stringr)
#library(png)

#setnames(df, old=c("Language..English..Greek..French..German.",
#                   "Text.in.English..if.not.text.blank.",
#                   "Pictorial..verbopictorial",
#                   "Name.of.the.creator"), new=c("Language","Text","Type","Creator"))


