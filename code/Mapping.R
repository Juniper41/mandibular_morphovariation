install.packages("maps")
library(maps)
install.packages("mapdata", dependencies = TRUE)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

usa <- map_data("usa")
states <- map_data("state")
cities <- map_data("city")


ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)

#Create States Subset
imwest <- subset(states, region %in% c("california", "oregon", "washington", "idaho", "arizona", "nevada", "utah"))

#Set Study Site Coordinates: 
sites <- data.frame(ID = c("TLC","HC"),
                    y = c(-119.5, -112.1),
                    x = c(40.5, 41.1))
#plot
ggplot(data = imwest) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "white", color = "black") + 
  geom_point(data = sites, aes(x = y, y = x, group = "ID"), shape=21, fill = "red", col="red", size=5)+
  coord_fixed(1.3)+
  ylab("Latitude")+
  xlab("Longitude")




