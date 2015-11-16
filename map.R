require("rgdal")
require("maptools")
require("ggplot2")
require("plyr")
require("rgeos")
require("sp")

#set working directory
setwd("C:/Users/")

data <- read.csv("pubs/data.csv")
map <- readShapeSpatial("counties/Distribution/Areas.shp")
towns <- read.csv("towns/towndata.csv")
names <- data.frame(data$name)

map <- fortify(map, region = "name")
ggplot() + 
  geom_map(data = data, aes(map_id = name, fill = percent), map = map) + 
  #geom_point(data=towns, aes(x=towns$Latitude, y=towns$Longitude, color="#FFFF00", fill="#FFFF00", size=1.3) +
  ggtitle("Pub Density by Postal Area") +
  scale_fill_gradient2(low = "black", mid = "grey", midpoint = .01, high = "white", limits = c(0, .02)) +
  expand_limits(x = map$long, y = map$lat) +
  theme(panel.background = element_rect(fill="#000000")) +
  theme(axis.title = element_blank()) +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(plot.title = element_text(family="Trebuchet MS", size=10, face="bold", hjust=0, color="#777777")) +
  coord_equal()

areas@data$name <- rownames(areas@data)
areas.df <- fortify(areas)
areas.df <- join(areas.df, df, by="name")
areas.df <- merge(areas.df, data)

ggplot(data, aes(x=long,y=lat,group=group)) +
  geom_polygon(data=areas,aes(x=long,y=lat,group=group),fill="#000000",colour= "#FFFFFF", lwd=0.05) +
  theme(panel.background = element_rect(fill="#FFFFFF")) +
  theme(axis.title = element_blank()) +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(plot.title = element_text(family="Trebuchet MS", size=38, face="bold", hjust=0, color="#777777")) +
  coord_equal()