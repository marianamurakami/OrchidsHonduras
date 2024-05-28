library(viridis)
library(car)
library(raster)
library(vegan)
library(colorRamps)
library(ggsci)
# library(colortools)
library(tmaptools)
# library(rcolorutils)
##### Precisa carregar o dataset de planta
setwd("E:/Orchids_honduras/Inputs/")

occ <- read.csv("orchid_database_habitat.csv", header = TRUE, stringsAsFactors = T)
unique(occ$SPECIES)

## Selecting the relevant columns
occ <- occ[,c(1:3,9,10,12)]

#Reading rasters.
fs <- list.files(path="E:/Orchids_honduras/Inputs/Altitude/", pattern = ".tif", full.names = TRUE)

dat<-list()

for(i in 1:1) dat[[i]]<-raster(fs[i])

#Reformatting data for PCA.
all<-data.frame(
  altitude=matrix(dat[[1]], ncol=1))


#We now extract the bioclimatic variables associated with those records: select coordinates collumns (long first, lat after)

orchids<-data.frame(altitude=raster::extract(dat[[1]], na.omit(occ[,5:4])))


#This is a trick to get species level means, but keeping both the scientific names and functional group: select family (or group columns), genus and epithet columns
sp<-character()
for(i in 1:dim(orchids)[1]){
  sp[i]<-paste(occ[i,6], occ[i,2], occ[i,3], sep="_")
}

orchids<-cbind(sp, orchids)
orchids<-na.omit(orchids) 

#removing duplicated records
orchids<-unique(orchids)

#Now we calculate species means: select columns with the climatic variables
altitudeMeans<-aggregate(x=orchids[,2], by=list(orchids$sp), FUN="mean")


setwd('E:/Orchids_honduras/Outputs/')
orchidsMeans <- read.csv('orchidsMeans.csv')


full_table <- dplyr::left_join(altitudeMeans, orchidsMeans, by = "Group.1")


colnames(full_table)[1] <- "SPECIES"
colnames(full_table)[2] <- "Altitude"

library(tidyr)

full_table <- tidyr::separate(full_table, SPECIES, into = c("HABITAT", "GENUS", "EPITHET"), sep = "_")


full_table <- tidyr::unite(full_table, SPECIES, GENUS, EPITHET, sep = " ")


## displacement status
setwd('E:/Orchids_honduras/Inputs/')
displacement <- read.csv('means_displacement_status.csv')
displacement <- displacement[,c(3,7:9)]

full_table <- dplyr::left_join(displacement, full_table, by = "SPECIES")

## rounding values
# Assuming your data frame is named "df"
columns_to_round <- names(full_table)[-c(1:5)]  # Exclude columns 3 and 4 from rounding (PCA values)

full_table[, columns_to_round] <- lapply(full_table[, columns_to_round], function(x) round(x, 2))


names(full_table)

## selecting the annual range for the climate variabes
full_table <- full_table[,c(1:7,12,17,22,27)]

setwd('E:/Orchids_honduras/Outputs/')
# write.csv(full_table, "environmental_means.csv", row.names = F)

full_table_displaced <- subset(full_table, full_table$Displaced_ssp == "Yes")


full_table_displaced_epiphyte <- subset(full_table_displaced, full_table_displaced$HABITAT=="Epiphyte")

full_table_displaced_terrestrial <- subset(full_table_displaced, full_table_displaced$HABITAT=="Terrestrial")


##### Displaced Epiphytes
str(full_table_displaced_epiphyte)

# Select numeric columns
numeric_cols_epiphytes <- sapply(full_table_displaced_epiphyte, is.numeric)

# Calculate mean and standard deviation for numeric columns
mean_values_epiphytes <- sapply(full_table_displaced_epiphyte[, numeric_cols_epiphytes], mean)
sd_values_epiphytes <- sapply(full_table_displaced_epiphyte[, numeric_cols_epiphytes], sd)

# Create a data frame with mean and standard deviation
result_table_epiphytes <- data.frame(Mean = mean_values_epiphytes, SD = sd_values_epiphytes)

result_table_epiphytes <- result_table_epiphytes[-c(1,2),]

sd(full_table_displaced_epiphyte$tmin_ann)


##### Displaced terrestrials
str(full_table_displaced_terrestrial)

# Select numeric columns
numeric_cols_terrestrials <- sapply(full_table_displaced_terrestrial, is.numeric)

# Calculate mean and standard deviation for numeric columns
mean_values_terrestrials <- sapply(full_table_displaced_terrestrial[, numeric_cols_terrestrials], mean)
sd_values_terrestrials <- sapply(full_table_displaced_terrestrial[, numeric_cols_terrestrials], sd)

# Create a data frame with mean and standard deviation
result_table_terrestrials <- data.frame(Mean = mean_values_terrestrials, SD = sd_values_terrestrials)

result_table_terrestrials <- result_table_terrestrials[-c(1,2),]

sd(full_table_displaced_terrestrial$tmin_ann)

## rename the columns so I can join epiphytes and terrestril tables
colnames(result_table_epiphytes)[1] <- "Epi_mean"
colnames(result_table_epiphytes)[2] <- "Epi_SD"

colnames(result_table_terrestrials)[1] <- "Terrestri_mean"
colnames(result_table_terrestrials)[2] <- "Terrestri_SD"

final_table <- cbind(result_table_epiphytes, result_table_terrestrials)
final_table <- round(final_table, 2)

final_table

transposed_table <- t(final_table)

### BOTH displaced
# Select numeric columns
numeric_cols <- sapply(full_table_displaced, is.numeric)

# Calculate mean and standard deviation for numeric columns
mean_values <- sapply(full_table_displaced[, numeric_cols], mean)
sd_values <- sapply(full_table_displaced[, numeric_cols], sd)

# Create a data frame with mean and standard deviation
result_table <- data.frame(Mean = mean_values, SD = sd_values)

result_table <- result_table[-c(1,2),]

sd(full_table_displaced$tmin_ann)

## rename the columns so I can join epiphytes and terrestril tables
colnames(result_table)[1] <- "All_mean"
colnames(result_table)[2] <- "All_SD"


final_table <- cbind(result_table_epiphytes, result_table_terrestrials)
final_table <- cbind(result_table, final_table)
final_table <- round(final_table, 2)

final_table

transposed_table <- t(final_table)



write.csv(transposed_table, "environmental_mean_sd_displaced_spp.csv", row.names = T)




#### non-displaced
full_table_non_displaced <- subset(full_table, full_table$Displaced_ssp == "No")


full_table_non_displaced_epiphyte <- subset(full_table_non_displaced, full_table_non_displaced$HABITAT=="Epiphyte")

full_table_non_displaced_terrestrial <- subset(full_table_non_displaced, full_table_non_displaced$HABITAT=="Terrestrial")


##### non_displaced Epiphytes
str(full_table_non_displaced_epiphyte)

# Select numeric columns
numeric_cols_epiphytes <- sapply(full_table_non_displaced_epiphyte, is.numeric)

# Calculate mean and standard deviation for numeric columns
mean_values_epiphytes <- sapply(full_table_non_displaced_epiphyte[, numeric_cols_epiphytes], mean)
sd_values_epiphytes <- sapply(full_table_non_displaced_epiphyte[, numeric_cols_epiphytes], sd)

# Create a data frame with mean and standard deviation
result_table_epiphytes <- data.frame(Mean = mean_values_epiphytes, SD = sd_values_epiphytes)

result_table_epiphytes <- result_table_epiphytes[-c(1,2),]

sd(full_table_non_displaced_epiphyte$tmin_ann)


##### non_displaced terrestrials
str(full_table_non_displaced_terrestrial)

# Select numeric columns
numeric_cols_terrestrials <- sapply(full_table_non_displaced_terrestrial, is.numeric)

# Calculate mean and standard deviation for numeric columns
mean_values_terrestrials <- sapply(full_table_non_displaced_terrestrial[, numeric_cols_terrestrials], mean)
sd_values_terrestrials <- sapply(full_table_non_displaced_terrestrial[, numeric_cols_terrestrials], sd)

# Create a data frame with mean and standard deviation
result_table_terrestrials <- data.frame(Mean = mean_values_terrestrials, SD = sd_values_terrestrials)

result_table_terrestrials <- result_table_terrestrials[-c(1,2),]

sd(full_table_non_displaced_terrestrial$tmin_ann)

## rename the columns so I can join epiphytes and terrestril tables
colnames(result_table_epiphytes)[1] <- "Epi_mean"
colnames(result_table_epiphytes)[2] <- "Epi_SD"

colnames(result_table_terrestrials)[1] <- "Terrestri_mean"
colnames(result_table_terrestrials)[2] <- "Terrestri_SD"

final_table <- cbind(result_table_epiphytes, result_table_terrestrials)
final_table <- round(final_table, 2)

final_table

transposed_table <- t(final_table)


### both non_displaced
# Select numeric columns
numeric_cols <- sapply(full_table_non_displaced, is.numeric)

# Calculate mean and standard deviation for numeric columns
mean_values <- sapply(full_table_non_displaced[, numeric_cols], mean)
sd_values <- sapply(full_table_non_displaced[, numeric_cols], sd)

# Create a data frame with mean and standard deviation
result_table <- data.frame(Mean = mean_values, SD = sd_values)

result_table <- result_table[-c(1,2),]

sd(full_table_non_displaced$tmin_ann)

## rename the columns so I can join epiphytes and terrestril tables
colnames(result_table)[1] <- "All_mean"
colnames(result_table)[2] <- "All_SD"


final_table <- cbind(result_table_epiphytes, result_table_terrestrials)
final_table <- cbind(result_table, final_table)
final_table <- round(final_table, 2)

final_table

transposed_table <- t(final_table)



write.csv(transposed_table, "environmental_mean_sd_non_displaced_spp.csv", row.names = T)


