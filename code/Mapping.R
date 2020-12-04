install.packages("maps")
library(maps)
install.packages("mapdata", dependencies = TRUE)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

usa <- map_data("usa")
states <- map_data("state")

ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)


imwest <- subset(states, region %in% c("california", "oregon", "washington", "idaho", "arizona", "nevada", "utah"))

ggplot(data = imwest) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "white", color = "black") + 
  coord_fixed(1.3)+
  ylab("Latitude")+
  xlab("Longitude")
