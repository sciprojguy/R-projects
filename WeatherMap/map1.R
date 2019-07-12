library(sf)
library(raster)
library(spData)
library(spDataLarge)

world_asia = world[world$continent == "Asia", ] 
asia = st_union(world_asia)
plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")

plot(world["continent"], reset = FALSE)
cex = sqrt(world$pop) / 10000
world_cents = st_centroid(world, of_largest = TRUE) 
plot(st_geometry(world_cents), add = TRUE, cex = cex)

india = world[world$name_long == "India", ]
plot(st_geometry(india), expandBB = c(0, 0.2, 0.1, 1), col = "gray", lwd = 3) 
plot(world_asia[0], add = TRUE)
