library(leaflet)
library(plyr)
library(data.table)
library(stringr)
library(mapview)
library(png)
options(digits=9)

df=read.csv2("streetArtDataJan.csv",stringsAsFactors =F,header = T)
df$Longitude=as.numeric(df$Longitude)
df$Latitude=as.numeric(df$Latitude)
df$newPath=paste0("http://i38.photobucket.com/albums/e146/PeerCHristensen/", #need to upgrade account
                  df$newFilename)
df$localPath = paste0("/Users/peerchristensen/Desktop/streetArtJan/streetArtDataJan/",
                      list.files("streetArtDataJan"))
# appears to have incorrect coordinates
#might be latitude 37.72341 should be 37.92341?
df=df[df$Title!="The Greek health system",] 

#setnames(df, old=c("Language..English..Greek..French..German.",
#                   "Text.in.English..if.not.text.blank.",
#                   "Pictorial..verbopictorial",
#                   "Name.of.the.creator"), new=c("Language","Text","Type","Creator"))

img="https://upload.wikimedia.org/wikipedia/commons/8/81/Graffiti_London.jpg"

m <- leaflet() %>%
  addTiles() %>% # Add default OpenStreetMap map tiles
  addAwesomeMarkers(lng=df$Longitude, 
                  lat=df$Latitude, 
                    popup=paste(popupImage(img, src = "remote"),"<br>",
                                "Title: ",paste("<a href=",img,">",df$Title,"</a>"),"<br>",
                                "Creator: ",df$Name_of_the_creator,"<br>",
                                "Type: ",df$Pictorial_verbopictorial,"<br>",
                                "Text: ",paste("'",df$Text,"'")),
                    clusterOptions = markerClusterOptions(),
                    label = df$Title) %>%
  addMiniMap()
m  # Print the map


