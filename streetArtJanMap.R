#STREET ART MAP ATHENS - JANUARY 2018

### load libraries
library(leaflet)
#library(plyr)
#library(data.table)
#library(stringr)
library(mapview)
#library(png)

### load data
df=read.csv2("streetArtDataJan.csv",stringsAsFactors =F,header = T)

### change coordinates to numeric values
df$Longitude=as.numeric(df$Longitude)
df$Latitude=as.numeric(df$Latitude)

### create local and remote paths for loading images
df$remotePath=paste0("http://i38.photobucket.com/albums/e146/PeerCHristensen/", 
                  df$newFilename)

df$localPath = paste0("/Users/peerchristensen/Desktop/streetArtJan/streetArtDataJan/",
                      list.files("streetArtDataJan"))

### remove erroneous data
#we remove one data point due to erroneous coordinates. Should they be latitude 37.72341 should be 37.92341?
df=df[df$Title!="The Greek health system",] 

#sample image
img="https://upload.wikimedia.org/wikipedia/commons/8/81/Graffiti_London.jpg"

### create map
athensMap <- leaflet() %>%
  # Add a base layer
  addTiles('https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png') %>%
  # add markers
  addAwesomeMarkers(lng=df$Longitude, lat=df$Latitude,
      # add popup with images and variables as text
      popup=paste(popupImage(img, src = c("remote")),"<br>",
                                "Title: ",paste("<a href=",img,">",df$Title,"</a>"),"<br>",
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

#setnames(df, old=c("Language..English..Greek..French..German.",
#                   "Text.in.English..if.not.text.blank.",
#                   "Pictorial..verbopictorial",
#                   "Name.of.the.creator"), new=c("Language","Text","Type","Creator"))


