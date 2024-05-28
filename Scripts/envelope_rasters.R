setwd("E:/Orchids_honduras/Inputs/Altitude/")


######### Present #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean <- rast("E:/Orchids_honduras/Inputs/Altitude/tmean_ann.tif")
plot(tmean)
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean <- tmean >= min_value & tmean <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean <- mask(masked_tmean, tmean)
x11()
plot(envelope_raster_tmean)

# Set cells with value 0 to NA
envelope_raster_tmean[envelope_raster_tmean == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean.tif")

######## prec ##########
setwd("E:/Orchids_honduras/Inputs/Altitude/")

# Load the terra package
library(terra)

# Import the raster file
prec <- rast("E:/Orchids_honduras/Inputs/Altitude/prec_ann.tif")
plot(prec)
# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec <- prec >= min_value & prec <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec <- mask(masked_prec, prec)
x11()
plot(envelope_raster_prec)

# Set cells with value 0 to NA
envelope_raster_prec[envelope_raster_prec == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec.tif")



######## tmin ##########

setwd("E:/Orchids_honduras/Inputs/Altitude/")

# Load the terra package
library(terra)

# Import the raster file
tmin <- rast("E:/Orchids_honduras/Inputs/Altitude/tmin_ann.tif")
plot(tmin)
# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin <- tmin >= min_value & tmin <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin <- mask(masked_tmin, tmin)
x11()
plot(envelope_raster_tmin)


# Set cells with value 0 to NA
envelope_raster_tmin[envelope_raster_tmin == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin.tif")


######## tmax ##########

setwd("E:/Orchids_honduras/Inputs/Altitude/")

# Load the terra package
library(terra)

# Import the raster file
tmax <- rast("E:/Orchids_honduras/Inputs/Altitude/tmax_ann.tif")
plot(tmax)
# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax <- tmax >= min_value & tmax <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax <- mask(masked_tmax, tmax)
x11()
plot(envelope_raster_tmax)

# Set cells with value 0 to NA
envelope_raster_tmax[envelope_raster_tmax == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax.tif")


######## dtr ##########

setwd("E:/Orchids_honduras/Inputs/Altitude/")

# Load the terra package
library(terra)

# Import the raster file
dtr <- rast("E:/Orchids_honduras/Inputs/Altitude/dtr_ann.tif")
plot(dtr)
# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr <- dtr >= min_value & dtr <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr <- mask(masked_dtr, dtr)
x11()
plot(envelope_raster_dtr)


# Set cells with value 0 to NA
envelope_raster_dtr[envelope_raster_dtr == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr.tif")



######### Future 85 / 2050 #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2020_2049/tmean_ann.tif")
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean_future <- tmean_future >= min_value & tmean_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean_future <- mask(masked_tmean_future, tmean_future)

# Set cells with value 0 to NA
envelope_raster_tmean_future[envelope_raster_tmean_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean_585_2050.tif")



# Load the terra package
library(terra)

######## prec ##########
# Import the raster file
prec_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2020_2049/prec_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec_future <- prec_future >= min_value & prec_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec_future <- mask(masked_prec_future, prec_future)

# Set cells with value 0 to NA
envelope_raster_prec_future[envelope_raster_prec_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec_585_2050.tif")



# Load the terra package
library(terra)

######## tmin ##########
# Import the raster file
tmin_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2020_2049/tmin_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin_future <- tmin_future >= min_value & tmin_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin_future <- mask(masked_tmin_future, tmin_future)

# Set cells with value 0 to NA
envelope_raster_tmin_future[envelope_raster_tmin_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin_585_2050.tif")



# Load the terra package
library(terra)

######## tmax ##########
# Import the raster file
tmax_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2020_2049/tmax_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax_future <- tmax_future >= min_value & tmax_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax_future <- mask(masked_tmax_future, tmax_future)

# Set cells with value 0 to NA
envelope_raster_tmax_future[envelope_raster_tmax_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax_585_2050.tif")



# Load the terra package
library(terra)

######## dtr ##########
# Import the raster file
dtr_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2020_2049/dtr_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr_future <- dtr_future >= min_value & dtr_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr_future <- mask(masked_dtr_future, dtr_future)

# Set cells with value 0 to NA
envelope_raster_dtr_future[envelope_raster_dtr_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr_585_2050.tif")


######### Future 85 / 2070 #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2040_2069/tmean_ann.tif")
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean_future <- tmean_future >= min_value & tmean_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean_future <- mask(masked_tmean_future, tmean_future)

# Set cells with value 0 to NA
envelope_raster_tmean_future[envelope_raster_tmean_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean_585_2070.tif")



# Load the terra package
library(terra)

######## prec ##########
# Import the raster file
prec_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2040_2069/prec_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec_future <- prec_future >= min_value & prec_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec_future <- mask(masked_prec_future, prec_future)

# Set cells with value 0 to NA
envelope_raster_prec_future[envelope_raster_prec_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec_585_2070.tif")



# Load the terra package
library(terra)

######## tmin ##########
# Import the raster file
tmin_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2040_2069/tmin_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin_future <- tmin_future >= min_value & tmin_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin_future <- mask(masked_tmin_future, tmin_future)

# Set cells with value 0 to NA
envelope_raster_tmin_future[envelope_raster_tmin_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin_585_2070.tif")



# Load the terra package
library(terra)

######## tmax ##########
# Import the raster file
tmax_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2040_2069/tmax_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax_future <- tmax_future >= min_value & tmax_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax_future <- mask(masked_tmax_future, tmax_future)

# Set cells with value 0 to NA
envelope_raster_tmax_future[envelope_raster_tmax_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax_585_2070.tif")



# Load the terra package
library(terra)

######## dtr ##########
# Import the raster file
dtr_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2040_2069/dtr_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr_future <- dtr_future >= min_value & dtr_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr_future <- mask(masked_dtr_future, dtr_future)

# Set cells with value 0 to NA
envelope_raster_dtr_future[envelope_raster_dtr_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr_585_2070.tif")



######### Future 85 / 2100 #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2070_2099/tmean_ann.tif")
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean_future <- tmean_future >= min_value & tmean_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean_future <- mask(masked_tmean_future, tmean_future)

# Set cells with value 0 to NA
envelope_raster_tmean_future[envelope_raster_tmean_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean_585_2100.tif")



# Load the terra package
library(terra)

######## prec ##########
# Import the raster file
prec_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2070_2099/prec_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec_future <- prec_future >= min_value & prec_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec_future <- mask(masked_prec_future, prec_future)

# Set cells with value 0 to NA
envelope_raster_prec_future[envelope_raster_prec_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec_585_2100.tif")



# Load the terra package
library(terra)

######## tmin ##########
# Import the raster file
tmin_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2070_2099/tmin_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin_future <- tmin_future >= min_value & tmin_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin_future <- mask(masked_tmin_future, tmin_future)

# Set cells with value 0 to NA
envelope_raster_tmin_future[envelope_raster_tmin_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin_585_2100.tif")



# Load the terra package
library(terra)

######## tmax ##########
# Import the raster file
tmax_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2070_2099/tmax_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax_future <- tmax_future >= min_value & tmax_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax_future <- mask(masked_tmax_future, tmax_future)

# Set cells with value 0 to NA
envelope_raster_tmax_future[envelope_raster_tmax_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax_585_2100.tif")



# Load the terra package
library(terra)

######## dtr ##########
# Import the raster file
dtr_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp85/2070_2099/dtr_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr_future <- dtr_future >= min_value & dtr_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr_future <- mask(masked_dtr_future, dtr_future)

# Set cells with value 0 to NA
envelope_raster_dtr_future[envelope_raster_dtr_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr_585_2100.tif")



######### Future 26 / 2100 #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2070_2099/tmean_ann.tif")
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean_future <- tmean_future >= min_value & tmean_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean_future <- mask(masked_tmean_future, tmean_future)

# Set cells with value 0 to NA
envelope_raster_tmean_future[envelope_raster_tmean_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean_126_2100.tif")



# Load the terra package
library(terra)

######## prec ##########
# Import the raster file
prec_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2070_2099/prec_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec_future <- prec_future >= min_value & prec_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec_future <- mask(masked_prec_future, prec_future)

# Set cells with value 0 to NA
envelope_raster_prec_future[envelope_raster_prec_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec_126_2100.tif")



# Load the terra package
library(terra)

######## tmin ##########
# Import the raster file
tmin_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2070_2099/tmin_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin_future <- tmin_future >= min_value & tmin_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin_future <- mask(masked_tmin_future, tmin_future)

# Set cells with value 0 to NA
envelope_raster_tmin_future[envelope_raster_tmin_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin_126_2100.tif")



# Load the terra package
library(terra)

######## tmax ##########
# Import the raster file
tmax_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2070_2099/tmax_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax_future <- tmax_future >= min_value & tmax_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax_future <- mask(masked_tmax_future, tmax_future)

# Set cells with value 0 to NA
envelope_raster_tmax_future[envelope_raster_tmax_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax_126_2100.tif")



# Load the terra package
library(terra)

######## dtr ##########
# Import the raster file
dtr_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2070_2099/dtr_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr_future <- dtr_future >= min_value & dtr_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr_future <- mask(masked_dtr_future, dtr_future)

# Set cells with value 0 to NA
envelope_raster_dtr_future[envelope_raster_dtr_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr_126_2100.tif")



######### Future 26 / 2050 #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2020_2049/tmean_ann.tif")
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean_future <- tmean_future >= min_value & tmean_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean_future <- mask(masked_tmean_future, tmean_future)

# Set cells with value 0 to NA
envelope_raster_tmean_future[envelope_raster_tmean_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean_126_2050.tif")



# Load the terra package
library(terra)

######## prec ##########
# Import the raster file
prec_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2020_2049/prec_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec_future <- prec_future >= min_value & prec_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec_future <- mask(masked_prec_future, prec_future)

# Set cells with value 0 to NA
envelope_raster_prec_future[envelope_raster_prec_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec_126_2050.tif")



# Load the terra package
library(terra)

######## tmin ##########
# Import the raster file
tmin_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2020_2049/tmin_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin_future <- tmin_future >= min_value & tmin_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin_future <- mask(masked_tmin_future, tmin_future)

# Set cells with value 0 to NA
envelope_raster_tmin_future[envelope_raster_tmin_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin_126_2050.tif")



# Load the terra package
library(terra)

######## tmax ##########
# Import the raster file
tmax_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2020_2049/tmax_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax_future <- tmax_future >= min_value & tmax_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax_future <- mask(masked_tmax_future, tmax_future)

# Set cells with value 0 to NA
envelope_raster_tmax_future[envelope_raster_tmax_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax_126_2050.tif")



# Load the terra package
library(terra)

######## dtr ##########
# Import the raster file
dtr_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2020_2049/dtr_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr_future <- dtr_future >= min_value & dtr_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr_future <- mask(masked_dtr_future, dtr_future)

# Set cells with value 0 to NA
envelope_raster_dtr_future[envelope_raster_dtr_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr_126_2050.tif")



######### Future 26 / 2070 #############

# Load the terra package
library(terra)

######## tmean ##########
# Import the raster file
tmean_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2040_2069/tmean_ann.tif")
# Set the minimum and maximum values to filter the raster
min_value <- 203.12
max_value <- 244.76


# Create a logical mask for values within the specified range
masked_tmean_future <- tmean_future >= min_value & tmean_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmean_future <- mask(masked_tmean_future, tmean_future)

# Set cells with value 0 to NA
envelope_raster_tmean_future[envelope_raster_tmean_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmean_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmean_126_2070.tif")



# Load the terra package
library(terra)

######## prec ##########
# Import the raster file
prec_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2040_2069/prec_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 1227.45
max_value <- 1982.36


# Create a logical mask for values within the specified range
masked_prec_future <- prec_future >= min_value & prec_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_prec_future <- mask(masked_prec_future, prec_future)

# Set cells with value 0 to NA
envelope_raster_prec_future[envelope_raster_prec_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_prec_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_prec_126_2070.tif")



# Load the terra package
library(terra)

######## tmin ##########
# Import the raster file
tmin_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2040_2069/tmin_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 149.05
max_value <- 190.5


# Create a logical mask for values within the specified range
masked_tmin_future <- tmin_future >= min_value & tmin_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmin_future <- mask(masked_tmin_future, tmin_future)

# Set cells with value 0 to NA
envelope_raster_tmin_future[envelope_raster_tmin_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmin_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmin_126_2070.tif")



# Load the terra package
library(terra)

######## tmax ##########
# Import the raster file
tmax_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2040_2069/tmax_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 255.48
max_value <- 300.65


# Create a logical mask for values within the specified range
masked_tmax_future <- tmax_future >= min_value & tmax_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_tmax_future <- mask(masked_tmax_future, tmax_future)

# Set cells with value 0 to NA
envelope_raster_tmax_future[envelope_raster_tmax_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_tmax_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_tmax_126_2070.tif")



# Load the terra package
library(terra)

######## dtr ##########
# Import the raster file
dtr_future <- rast("E:/Orchids_honduras/Inputs/Climate_data/rcp26/2040_2069/dtr_ann.tif")

# Set the minimum and maximum values to filter the raster
min_value <- 96.34
max_value <- 120.32


# Create a logical mask for values within the specified range
masked_dtr_future <- dtr_future >= min_value & dtr_future <= max_value


# Apply the mask to the raster to create a new raster with filtered values
envelope_raster_dtr_future <- mask(masked_dtr_future, dtr_future)

# Set cells with value 0 to NA
envelope_raster_dtr_future[envelope_raster_dtr_future == 0] <- NA

# Save the new raster as a file
writeRaster(envelope_raster_dtr_future, "E:/Orchids_honduras/Outputs/Envelope/Rasters/envelope_raster_dtr_126_2070.tif")

