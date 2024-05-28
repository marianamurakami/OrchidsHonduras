library(terra)



########### present ##################
tmean <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/envelope_shape_tmean.gpkg")

tmin <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/envelope_shape_tmin.gpkg")

tmax <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/envelope_shape_tmax.gpkg")

prec <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/envelope_shape_prec.gpkg")

dtr <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/envelope_shape_dtr.gpkg")




# Load the sf package
library(sf)

intersection <- terra::intersect(tmean, tmax)
intersection <- terra::intersect(intersection, tmin)
intersection <- terra::intersect(intersection, prec)
intersection <- terra::intersect(intersection, dtr)

x11()
plot(intersection)

setwd("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/")

str(intersection)

# Write the shapefile
writeVector(intersection, "E:/Orchids_honduras/Outputs/Envelope/Shapefiles/intersection.shp")







########### future 26 2050##################

tmean_126_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmean_126_2050.gpkg")

tmin_126_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmin_126_2050.gpkg")

tmax_126_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmax_126_2050.gpkg")

prec_126_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/prec_126_2050.gpkg")

dtr_126_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/dtr_126_2050.gpkg")




# Load the sf package
library(sf)

intersection_126_2050 <- terra::intersect(tmean_126_2050, tmax_126_2050)
intersection_126_2050 <- terra::intersect(intersection_126_2050, tmin_126_2050)
intersection_126_2050 <- terra::intersect(intersection_126_2050, prec_126_2050)
intersection_126_2050 <- terra::intersect(intersection_126_2050, dtr_126_2050)


########### future 26 2070##################

tmean_126_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmean_126_2070.gpkg")

tmin_126_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmin_126_2070.gpkg")

tmax_126_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmax_126_2070.gpkg")

prec_126_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/prec_126_2070.gpkg")

dtr_126_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/dtr_126_2070.gpkg")




# Load the sf package
library(sf)

intersection_126_2070 <- terra::intersect(tmean_126_2070, tmax_126_2070)
intersection_126_2070 <- terra::intersect(intersection_126_2070, tmin_126_2070)
intersection_126_2070 <- terra::intersect(intersection_126_2070, prec_126_2070)
intersection_126_2070 <- terra::intersect(intersection_126_2070, dtr_126_2070)


########### future 26 2100##################

tmean_126_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmean_126_2100.gpkg")

tmin_126_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmin_126_2100.gpkg")

tmax_126_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/tmax_126_2100.gpkg")

prec_126_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/prec_126_2100.gpkg")

dtr_126_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/dtr_126_2100.gpkg")




# Load the sf package
library(sf)

intersection_126_2100 <- terra::intersect(tmean_126_2100, tmax_126_2100)
intersection_126_2100 <- terra::intersect(intersection_126_2100, tmin_126_2100)
intersection_126_2100 <- terra::intersect(intersection_126_2100, prec_126_2100)
intersection_126_2100 <- terra::intersect(intersection_126_2100, dtr_126_2100)


## intersection 126
intersection_126 <- terra::intersect(intersection_126_2050, intersection_126_2070)
intersection_126 <- terra::intersect(intersection_126, intersection_126_2100)

plot(intersection_126)

setwd("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/126/")
# Write the shapefile
writeVector(intersection_126, "E:/Orchids_honduras/Outputs/Envelope/Shapefiles/intersection_126.shp")





########### future 26 2050##################

tmean_585_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmean_585_2050.gpkg")

tmin_585_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmin_585_2050.gpkg")

tmax_585_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmax_585_2050.gpkg")

prec_585_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/prec_585_2050.gpkg")

dtr_585_2050 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/dtr_585_2050.gpkg")




# Load the sf package
library(sf)

intersection_585_2050 <- terra::intersect(tmean_585_2050, tmax_585_2050)
intersection_585_2050 <- terra::intersect(intersection_585_2050, tmin_585_2050)
intersection_585_2050 <- terra::intersect(intersection_585_2050, prec_585_2050)
intersection_585_2050 <- terra::intersect(intersection_585_2050, dtr_585_2050)


########### future 26 2070##################

tmean_585_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmean_585_2070.gpkg")

tmin_585_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmin_585_2070.gpkg")

tmax_585_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmax_585_2070.gpkg")

prec_585_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/prec_585_2070.gpkg")

dtr_585_2070 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/dtr_585_2070.gpkg")




# Load the sf package
library(sf)

intersection_585_2070 <- terra::intersect(tmean_585_2070, tmax_585_2070)
intersection_585_2070 <- terra::intersect(intersection_585_2070, tmin_585_2070)
intersection_585_2070 <- terra::intersect(intersection_585_2070, prec_585_2070)
intersection_585_2070 <- terra::intersect(intersection_585_2070, dtr_585_2070)


########### future 26 2100##################

tmean_585_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmean_585_2100.gpkg")

tmin_585_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmin_585_2100.gpkg")

tmax_585_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/tmax_585_2100.gpkg")

prec_585_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/prec_585_2100.gpkg")

dtr_585_2100 <- vect("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/dtr_585_2100.gpkg")




# Load the sf package
library(sf)

intersection_585_2100 <- terra::intersect(tmean_585_2100, tmax_585_2100)
intersection_585_2100 <- terra::intersect(intersection_585_2100, tmin_585_2100)
intersection_585_2100 <- terra::intersect(intersection_585_2100, prec_585_2100)
intersection_585_2100 <- terra::intersect(intersection_585_2100, dtr_585_2100)


## intersection 585
intersection_585 <- terra::intersect(intersection_585_2050, intersection_585_2070)
intersection_585 <- terra::intersect(intersection_585, intersection_585_2100)

plot(intersection_585)

setwd("E:/Orchids_honduras/Outputs/Envelope/Shapefiles/585/")
# Write the shapefile
writeVector(intersection_585, "E:/Orchids_honduras/Outputs/Envelope/Shapefiles/intersection_585.shp")
