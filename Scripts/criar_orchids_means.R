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
fs <- list.files(path="E:/Orchids_honduras/Inputs/Climate_data/rcp85/2040_2069//", pattern = ".tif", full.names = TRUE)

dat<-list()

for(i in 1:25) dat[[i]]<-raster(fs[i])

#Reformatting data for PCA.
all <- data.frame(
  dtr_ann = matrix(dat[[1]], ncol = 1),
  dtr_djf = matrix(dat[[2]], ncol = 1),
  dtr_jja = matrix(dat[[3]], ncol = 1),
  dtr_mam = matrix(dat[[4]], ncol = 1),
  dtr_son = matrix(dat[[5]], ncol = 1),
  prec_ann = matrix(dat[[6]], ncol = 1),
  prec_djf = matrix(dat[[7]], ncol = 1),
  prec_jja = matrix(dat[[8]], ncol = 1),
  prec_mam = matrix(dat[[9]], ncol = 1),
  prec_son = matrix(dat[[10]], ncol = 1),
  tmax_ann = matrix(dat[[11]], ncol = 1),
  tmax_djf = matrix(dat[[12]], ncol = 1),
  tmax_jja = matrix(dat[[13]], ncol = 1),
  tmax_mam = matrix(dat[[14]], ncol = 1),
  tmax_son = matrix(dat[[15]], ncol = 1),
  tmean_ann = matrix(dat[[16]], ncol = 1),
  tmean_djf = matrix(dat[[17]], ncol = 1),
  tmean_jja = matrix(dat[[18]], ncol = 1),
  tmean_mam = matrix(dat[[19]], ncol = 1),
  tmean_son = matrix(dat[[20]], ncol = 1),
  tmin_ann = matrix(dat[[21]], ncol = 1),
  tmin_djf = matrix(dat[[22]], ncol = 1),
  tmin_jja = matrix(dat[[23]], ncol = 1),
  tmin_mam = matrix(dat[[24]], ncol = 1),
  tmin_son = matrix(dat[[25]], ncol = 1)
)

all<-na.omit(all)
res<-prcomp(all, center=TRUE, scale =TRUE)

#We now extract the bioclimatic variables associated with those records: select coordinates collumns (long first, lat after)

orchids <- data.frame(
  dtr_ann = raster::extract(dat[[1]], na.omit(occ[,5:4])),
  dtr_djf = raster::extract(dat[[2]], na.omit(occ[,5:4])),
  dtr_jja = raster::extract(dat[[3]], na.omit(occ[,5:4])),
  dtr_mam = raster::extract(dat[[4]], na.omit(occ[,5:4])),
  dtr_son = raster::extract(dat[[5]], na.omit(occ[,5:4])),
  prec_ann = raster::extract(dat[[6]], na.omit(occ[,5:4])),
  prec_djf = raster::extract(dat[[7]], na.omit(occ[,5:4])),
  prec_jja = raster::extract(dat[[8]], na.omit(occ[,5:4])),
  prec_mam = raster::extract(dat[[9]], na.omit(occ[,5:4])),
  prec_son = raster::extract(dat[[10]], na.omit(occ[,5:4])),
  tmax_ann = raster::extract(dat[[11]], na.omit(occ[,5:4])),
  tmax_djf = raster::extract(dat[[12]], na.omit(occ[,5:4])),
  tmax_jja = raster::extract(dat[[13]], na.omit(occ[,5:4])),
  tmax_mam = raster::extract(dat[[14]], na.omit(occ[,5:4])),
  tmax_son = raster::extract(dat[[15]], na.omit(occ[,5:4])),
  tmean_ann = raster::extract(dat[[16]], na.omit(occ[,5:4])),
  tmean_djf = raster::extract(dat[[17]], na.omit(occ[,5:4])),
  tmean_jja = raster::extract(dat[[18]], na.omit(occ[,5:4])),
  tmean_mam = raster::extract(dat[[19]], na.omit(occ[,5:4])),
  tmean_son = raster::extract(dat[[20]], na.omit(occ[,5:4])),
  tmin_ann = raster::extract(dat[[21]], na.omit(occ[,5:4])),
  tmin_djf = raster::extract(dat[[22]], na.omit(occ[,5:4])),
  tmin_jja = raster::extract(dat[[23]], na.omit(occ[,5:4])),
  tmin_mam = raster::extract(dat[[24]], na.omit(occ[,5:4])),
  tmin_son = raster::extract(dat[[25]], na.omit(occ[,5:4]))
)



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
orchidsMeans<-aggregate(x=orchids[,2:26], by=list(orchids$sp), FUN="mean")

#projecting individual records onto the PC axes
orchidsClimInd<-predict(res, orchids)[,1:2]

#We then use the species means and project them into the climatic space of the Atlantic Forest

orchidsClim<-predict(res, orchidsMeans)[,1:2]

group <- character()

for(i in 1:dim(orchidsMeans)[1]) group[i]<-strsplit(orchidsMeans[i,1], "_")[[1]][1]
print(group)

setwd("E:/Orchids_honduras/Outputs/Envelope/")
# write.table(orchidsMeans, "orchidsMeans.txt")
write.csv(orchidsMeans, "orchidsMeans_585_2070.csv", row.names = F)
