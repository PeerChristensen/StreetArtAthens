# EXTRACTING COORDINATES FROM IMAGE FILES

#install.packages("exifr")
library(exifr)
library(dplyr)

dat <- read_exif("newImages",recursive=T)
dat <- select(dat,
               FileName,
               GPSLongitude, GPSLatitude)

write.csv2(dat, 'newExifdata.csv',sep=",",
          row.names = F)


#### Another solution using exiftool in terminal:

#exiftool -filename -gpslatitude -gpslongitude -T -n NAME_OF_DIRECTORY > out.txt
