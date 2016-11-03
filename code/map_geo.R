# attribution for great work
#  thanks to Martijn Tennekes for tmap and examples
#  thanks to Robin Lovelace http://robinlovelace.net/2014/06/22/great-circles-in-rworldmap-ggplot2.html

library(tmap)

data(land, World)

# convert to Eckert IV projection
land_eck4 <- set_projection(land, "eck4")

# plot
tm_shape(land_eck4) +
  tm_raster("elevation", 
            breaks=c(-Inf, 250, 500, 1000, 1500, 2000, 2500, 3000, 4000, Inf),  
            palette = terrain.colors(9), 
            title="Elevation",
            legend.show = FALSE) +
  tm_shape(World) +
  tm_borders("grey20") +
  tm_grid(projection="longlat", labels.size = .5) +
  tm_text("name", size="AREA") +
  tm_compass(position = c(.65, .15), color.light = "grey90") +
  tm_credits("Eckert IV projection", position = c("RIGHT", "BOTTOM")) +
  tm_layout(inner.margins=c(.04,.03, .02, .01), 
            legend.position = c("left", "bottom"), 
            legend.frame = TRUE, 
            bg.color="lightblue", 
            legend.bg.color="lightblue", 
            earth.boundary = TRUE, 
            space.color="grey90") + 
  tm_style_classic()


library(geosphere)

pdf <- data.frame(
  place = c("Birmingham","New York","Montreal","Shanghai","Seattle","LA","Marburg"),
  lon = c(-86.83,-74.09,-73.61,121.29,-122.39,-118.34,8.75),
  lat = c(33.54,40.74,45.61,31.20,47.64,34.05,50.82)
)

spdf <- SpatialPointsDataFrame(
  pdf[,c(2,3)],
  pdf,
  proj4string=CRS("+proj=longlat +datum=WGS84")
)

tm_shape(World) +
  tm_borders() +
  tm_shape(set_projection(spdf,"eck4")) +
  tm_bubbles()

gcirs <- lapply(
  2:nrow(pdf),
  function(d){
    gcir <- gcIntermediate(pdf[1,c(2,3)],pdf[d,c(2,3)])
    SpatialPointsDataFrame(
      gcir,
      as.data.frame(gcir),
      proj4string=CRS("+proj=longlat +datum=WGS84")
    )
  }
)


tm_shape(land_eck4) +
  tm_raster("elevation", 
            breaks=c(-Inf, 250, 500, 1000, 1500, 2000, 2500, 3000, 4000, Inf),  
            palette = terrain.colors(9),
            alpha=0.6,
            title="Elevation",
            legend.show = FALSE) +
  tm_shape(World) +
  tm_borders("grey20") +
  tm_grid(projection="longlat", labels.size = .5) +
  tm_text("name", size="AREA") +
  tm_compass(position = c(.65, .15), color.light = "grey90") +
  tm_credits("Eckert IV projection", position = c("RIGHT", "BOTTOM")) +
  tm_layout(inner.margins=c(.04,.03, .02, .01), 
            legend.position = c("left", "bottom"), 
            legend.frame = TRUE, 
            bg.color="lightblue", 
            legend.bg.color="lightblue", 
            earth.boundary = TRUE, 
            space.color="grey90") + 
  tm_style_classic() +
  tm_shape(do.call(rbind,gcirs)) +
  tm_dots(col="purple", alpha=1) +
  tm_shape(spdf) +
  tm_bubbles(col="purple",size=0.2)
