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
fs <- list.files(path="E:/Orchids_honduras/Inputs/Climate_data/Present/", pattern = ".tif", full.names = TRUE)

dat<-list()

for(i in 1:85) dat[[i]]<-raster(fs[i])

#Reformatting data for PCA.
all<-data.frame(
  dtr_ann=matrix(dat[[13]], ncol=1),
  dtr_djf=matrix(dat[[14]], ncol=1),
  dtr_jja=matrix(dat[[15]], ncol=1),
  dtr_mam=matrix(dat[[16]], ncol=1),
  dtr_son=matrix(dat[[17]], ncol=1),
  prec_ann=matrix(dat[[30]], ncol=1),
  prec_djf=matrix(dat[[31]], ncol=1),
  prec_jja=matrix(dat[[32]], ncol=1),
  prec_mam=matrix(dat[[33]], ncol=1),
  prec_son=matrix(dat[[34]], ncol=1),
  tmax_ann=matrix(dat[[47]], ncol=1),
  tmax_djf=matrix(dat[[48]], ncol=1),
  tmax_jja=matrix(dat[[49]], ncol=1),
  tmax_mam=matrix(dat[[50]], ncol=1),
  tmax_son=matrix(dat[[51]], ncol=1),
  tmean_ann=matrix(dat[[64]], ncol=1),
  tmean_djf=matrix(dat[[65]], ncol=1),
  tmean_jja=matrix(dat[[66]], ncol=1),
  tmean_mam=matrix(dat[[67]], ncol=1),
  tmean_son=matrix(dat[[68]], ncol=1),
  tmin_ann=matrix(dat[[81]], ncol=1),
  tmin_djf=matrix(dat[[82]], ncol=1),
  tmin_jja=matrix(dat[[83]], ncol=1),
  tmin_mam=matrix(dat[[84]], ncol=1),
  tmin_son=matrix(dat[[85]], ncol=1)
)

x11()
all<-na.omit(all)
res<-prcomp(all, center=TRUE, scale =TRUE)
screeplot(res, bstick=TRUE)  # we should retain the first two PCs
summary(res)
# 'res' is now the object with the PCA with the climate for the entire country.

table1<-round(res$rotation[,1:2], digits=2)
table1
setwd('E:/Orchids_honduras/Outputs/')
getwd()
# write.table(table1, "table_PCA.csv")



#We now extract the bioclimatic variables associated with those records: select coordinates collumns (long first, lat after)

orchids<-data.frame(dtr_ann=extract(dat[[13]], na.omit(occ[,5:4])),
                      dtr_djf=extract(dat[[14]], na.omit(occ[,5:4])),
                      dtr_jja=extract(dat[[15]], na.omit(occ[,5:4])),
                      dtr_mam=extract(dat[[16]], na.omit(occ[,5:4])),
                      dtr_son=extract(dat[[17]], na.omit(occ[,5:4])),
                      prec_ann=extract(dat[[30]], na.omit(occ[,5:4])),
                      prec_djf=extract(dat[[31]], na.omit(occ[,5:4])),
                      prec_jja=extract(dat[[32]], na.omit(occ[,5:4])),
                      prec_mam=extract(dat[[33]], na.omit(occ[,5:4])),
                      prec_son=extract(dat[[34]], na.omit(occ[,5:4])),
                      tmax_ann=extract(dat[[47]], na.omit(occ[,5:4])),
                      tmax_djf=extract(dat[[48]], na.omit(occ[,5:4])),
                      tmax_jja=extract(dat[[49]], na.omit(occ[,5:4])),
                      tmax_mam=extract(dat[[50]], na.omit(occ[,5:4])),
                      tmax_son=extract(dat[[51]], na.omit(occ[,5:4])),
                      tmean_ann=extract(dat[[64]], na.omit(occ[,5:4])),
                      tmean_djf=extract(dat[[65]], na.omit(occ[,5:4])),
                      tmean_jja=extract(dat[[66]], na.omit(occ[,5:4])),
                      tmean_mam=extract(dat[[67]], na.omit(occ[,5:4])),
                      tmean_son=extract(dat[[68]], na.omit(occ[,5:4])),
                      tmin_ann=extract(dat[[81]], na.omit(occ[,5:4])),
                      tmin_djf=extract(dat[[82]], na.omit(occ[,5:4])),
                      tmin_jja=extract(dat[[83]], na.omit(occ[,5:4])),
                      tmin_mam=extract(dat[[84]], na.omit(occ[,5:4])),
                      tmin_son=extract(dat[[85]], na.omit(occ[,5:4])))


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

getwd()
# write.table(orchidsMeans, "orchidsMeans.txt")
# write.csv(orchidsMeans, "orchidsMeans.csv")
# write.table(orchidsClim, "orchidsClim.txt")
# write.csv(orchidsClim, "orchidsClim.csv")


########### FIGURE 1 ######

#All species
setwd('E:/Orchids_honduras/Outputs/')
# pdf("Figures_MA/Figure_1.pdf", width=8, height=11)

### Plotar as epífitas no espaço climático
layout(matrix(1:1, ncol=1))
par(mar=c(5,5,5,5))
cols<-viridis::plasma(4)
# palette_explorer()

plot(res$x[,1:2], xlab="PC1", ylab="PC2", col=gray.colors(1, alpha=0.05), cex.lab = 2, cex.axis = 1.75)

points(orchidsClimInd[,2]~orchidsClimInd[,1], col="black") #all records


# Habitat
points(orchidsClim[which(group=="Terrestrial"),2]~orchidsClim[which(group=="Terrestrial"),1], col=cols[4], pch=16)

points(orchidsClim[which(group=="Epiphyte"),2]~orchidsClim[which(group=="Epiphyte"),1], col=cols[2], pch=16)


legend("bottomleft", pch=16, legend = c("Epiphyte species", "Terrestrial species"), col=cols[c(4,2)], bty="n", cex = 1.5)




##############Testing for differences in variance####

orchidsClim<-as.data.frame(orchidsClim)

dat<-data.frame(PC1=orchidsClim$PC1,PC2=orchidsClim$PC2,signPC1=sign(orchidsClim$PC1), signPC2=sign(orchidsClim$PC2),group=group)
View(dat)

y<-c(var(subset(dat, signPC1== 1, select="PC2")),
     var(subset(dat, signPC1==-1, select="PC2")))
y<-round(y, digits=2)
names(y)<-c("PC2.PC1plus", "PC2.PC1minus")
y
leveneTest(PC2~as.factor(signPC1), data=dat) #comparando PC1 positivo com PC1 negativo


##Variance for the entire climatic space.
var(res$x[,2][res$x[,1]>0])
var(res$x[,2][res$x[,1]<0])


y<-c(var(subset(dat, signPC2== 1, select="PC1")),
     var(subset(dat, signPC2==-1, select="PC1")))
y<-round(y, digits=2)
names(y)<-c("PC1.PC2plus", "PC1.PC2minus")
y
leveneTest(PC1~as.factor(signPC2), data=dat)
##Variance for the entire climatic space.
var(res$x[,1][res$x[,2]>0])
var(res$x[,1][res$x[,2]<0])



################ FIGURE 2 ########

fs <- list.files(path="E:/Orchids_honduras/Inputs/Climate_data/Present/", pattern = ".tif", full.names = TRUE)
dat<-list()
for(i in 1:85) dat[[i]]<-raster(fs[i])

dat
## Reformating data for PCA
all<-data.frame(
  dtr_ann=matrix(dat[[13]], ncol=1),
  dtr_djf=matrix(dat[[14]], ncol=1),
  dtr_jja=matrix(dat[[15]], ncol=1),
  dtr_mam=matrix(dat[[16]], ncol=1),
  dtr_son=matrix(dat[[17]], ncol=1),
  prec_ann=matrix(dat[[30]], ncol=1),
  prec_djf=matrix(dat[[31]], ncol=1),
  prec_jja=matrix(dat[[32]], ncol=1),
  prec_mam=matrix(dat[[33]], ncol=1),
  prec_son=matrix(dat[[34]], ncol=1),
  tmax_ann=matrix(dat[[47]], ncol=1),
  tmax_djf=matrix(dat[[48]], ncol=1),
  tmax_jja=matrix(dat[[49]], ncol=1),
  tmax_mam=matrix(dat[[50]], ncol=1),
  tmax_son=matrix(dat[[51]], ncol=1),
  tmean_ann=matrix(dat[[64]], ncol=1),
  tmean_djf=matrix(dat[[65]], ncol=1),
  tmean_jja=matrix(dat[[66]], ncol=1),
  tmean_mam=matrix(dat[[67]], ncol=1),
  tmean_son=matrix(dat[[68]], ncol=1),
  tmin_ann=matrix(dat[[81]], ncol=1),
  tmin_djf=matrix(dat[[82]], ncol=1),
  tmin_jja=matrix(dat[[83]], ncol=1),
  tmin_mam=matrix(dat[[84]], ncol=1),
  tmin_son=matrix(dat[[85]], ncol=1)
)


all<-na.omit(all)
pca<-prcomp(all, center=TRUE, scale =TRUE)

#This function takes a set of coordinates, extracts the corresponding bioclimatic variables and projects them based on the pca above.
extractClim<-function(loc){
  climLoc<-data.frame(
    Group.1=seq(1:dim(loc)[1]),
    dtr_ann=extract(dat[[13]], loc),
    dtr_djf=extract(dat[[14]], loc),
    dtr_jja=extract(dat[[15]], loc),
    dtr_mam=extract(dat[[16]], loc),
    dtr_son=extract(dat[[17]], loc),
    prec_ann=extract(dat[[30]], loc),
    prec_djf=extract(dat[[31]], loc),
    prec_jja=extract(dat[[32]], loc),
    prec_mam=extract(dat[[33]], loc),
    prec_son=extract(dat[[34]], loc),
    tmax_ann=extract(dat[[47]], loc),
    tmax_djf=extract(dat[[48]], loc),
    tmax_jja=extract(dat[[49]], loc),
    tmax_mam=extract(dat[[50]], loc),
    tmax_son=extract(dat[[51]], loc),
    tmean_ann=extract(dat[[64]], loc),
    tmean_djf=extract(dat[[65]], loc),
    tmean_jja=extract(dat[[66]], loc),
    tmean_mam=extract(dat[[67]], loc),
    tmean_son=extract(dat[[68]], loc),
    tmin_ann=extract(dat[[81]], loc),
    tmin_djf=extract(dat[[82]], loc),
    tmin_jja=extract(dat[[83]], loc),
    tmin_mam=extract(dat[[84]], loc),
    tmin_son=extract(dat[[85]], loc))
  
  x<-predict(pca, climLoc)
  xx<-list()
  xx[[1]]<-x[,1]
  xx[[2]]<-x[,2]
  xx
}


dat[[1]] ##to check coordinates and dimensions for lenth.out
lats<-seq(12.98333, 16.51667, length.out=424) #424
lons<-seq(-89.35833, -83.025, length.out=760) #760

t0<-Sys.time()
mapPC1<-mapPC2<-matrix(ncol=length(lats), nrow=length(lons))
for(i in 1:length(lons)){
  print(i)
  loc<-data.frame(lons[i], lats)
  yy<-extractClim(loc)
  mapPC1[i,]<-yy[[1]]
  mapPC2[i,]<-yy[[2]]
}


########## SAVE WORKSPACE #########

# pdf("../figures/Figure_2a.pdf", width=7.5, height=11)
x11()
layout(matrix(1:1,ncol=1))

image(mapPC1, useRaster=TRUE, axes=FALSE, col=viridis::plasma(100), main="PC1")

# Convert the matrix to a raster object
r <- raster(mapPC1)

# Write the raster to a file
setwd("E:/Orchids_honduras/Outputs/")
writeRaster(r, 'mapPC1.tiff')


legend_image <- as.raster(matrix(viridis::plasma(20)[20:1], ncol=1))
plot(c(0,2),c(0,1),type = 'n', axes = F,xlab = '', ylab = '', main = 'scores')
yy<-range(na.omit(mapPC1[mapPC1>-10000]))
text(x=1.5, y = seq(0,1,l=5), labels = round(seq(yy[1],yy[2],l=5),1), cex=0.75)
rasterImage(legend_image, 0, 0, 1,1)


image(mapPC2, useRaster=TRUE, axes=FALSE, col=viridis::plasma(100), main="PC2")

# Convert the matrix to a raster object
r <- raster(mapPC2)

# Write the raster to a file
setwd("E:/Orchids_honduras/Outputs/")
writeRaster(r, 'mapPC2.tiff')

legend_image <- as.raster(matrix(viridis::plasma(20)[20:1], ncol=1))
plot(c(0,2),c(0,1),type = 'n', axes = F,xlab = '', ylab = '', main = 'scores')
yy<-range(na.omit(mapPC2[mapPC2>-10000]))
text(x=1.5, y = seq(0,1,l=5), labels = round(seq(yy[1],yy[2],l=5),1), cex=0.75)
rasterImage(legend_image, 0, 0, 1,1)



############ FIGURE 3 #############
library(raster)
library(maptools)
library(rgdal)
library(viridis)
library(readxl)

################################################################
#Reading rasters.
fs <- list.files(path="E:/Orchids_honduras/Inputs/Climate_data/Present/", pattern = ".tif", full.names = TRUE)

dat<-list()

for(i in 1:85) dat[[i]]<-raster(fs[i])

#Reformatting data for PCA.
all<-data.frame(
  dtr_ann=matrix(dat[[13]], ncol=1),
  dtr_djf=matrix(dat[[14]], ncol=1),
  dtr_jja=matrix(dat[[15]], ncol=1),
  dtr_mam=matrix(dat[[16]], ncol=1),
  dtr_son=matrix(dat[[17]], ncol=1),
  prec_ann=matrix(dat[[30]], ncol=1),
  prec_djf=matrix(dat[[31]], ncol=1),
  prec_jja=matrix(dat[[32]], ncol=1),
  prec_mam=matrix(dat[[33]], ncol=1),
  prec_son=matrix(dat[[34]], ncol=1),
  tmax_ann=matrix(dat[[47]], ncol=1),
  tmax_djf=matrix(dat[[48]], ncol=1),
  tmax_jja=matrix(dat[[49]], ncol=1),
  tmax_mam=matrix(dat[[50]], ncol=1),
  tmax_son=matrix(dat[[51]], ncol=1),
  tmean_ann=matrix(dat[[64]], ncol=1),
  tmean_djf=matrix(dat[[65]], ncol=1),
  tmean_jja=matrix(dat[[66]], ncol=1),
  tmean_mam=matrix(dat[[67]], ncol=1),
  tmean_son=matrix(dat[[68]], ncol=1),
  tmin_ann=matrix(dat[[81]], ncol=1),
  tmin_djf=matrix(dat[[82]], ncol=1),
  tmin_jja=matrix(dat[[83]], ncol=1),
  tmin_mam=matrix(dat[[84]], ncol=1),
  tmin_son=matrix(dat[[85]], ncol=1)
)

all<-na.omit(all)
pca<-prcomp(all, center=TRUE, scale =TRUE)
res<-prcomp(all, center=TRUE, scale =TRUE)
screeplot(res, bstick=TRUE)  # we should retain the first two PCs
summary(res)
# 'res' is now the object with the PCA with the climate for the entire country.

table1<-round(res$rotation[,1:2], digits=2)
table1


####repeating original species mean
setwd("E:/Orchids_honduras/Inputs/")

occ <- read.csv("orchid_database_habitat.csv")
## Selecting the relevant columns
occ <- occ[,c(1:3,9,10,12)]


#We now extract the bioclimatic variables associated with those records.
orchids<-data.frame(dtr_ann=extract(dat[[13]], na.omit(occ[,5:4])),
                    dtr_djf=extract(dat[[14]], na.omit(occ[,5:4])),
                    dtr_jja=extract(dat[[15]], na.omit(occ[,5:4])),
                    dtr_mam=extract(dat[[16]], na.omit(occ[,5:4])),
                    dtr_son=extract(dat[[17]], na.omit(occ[,5:4])),
                    prec_ann=extract(dat[[30]], na.omit(occ[,5:4])),
                    prec_djf=extract(dat[[31]], na.omit(occ[,5:4])),
                    prec_jja=extract(dat[[32]], na.omit(occ[,5:4])),
                    prec_mam=extract(dat[[33]], na.omit(occ[,5:4])),
                    prec_son=extract(dat[[34]], na.omit(occ[,5:4])),
                    tmax_ann=extract(dat[[47]], na.omit(occ[,5:4])),
                    tmax_djf=extract(dat[[48]], na.omit(occ[,5:4])),
                    tmax_jja=extract(dat[[49]], na.omit(occ[,5:4])),
                    tmax_mam=extract(dat[[50]], na.omit(occ[,5:4])),
                    tmax_son=extract(dat[[51]], na.omit(occ[,5:4])),
                    tmean_ann=extract(dat[[64]], na.omit(occ[,5:4])),
                    tmean_djf=extract(dat[[65]], na.omit(occ[,5:4])),
                    tmean_jja=extract(dat[[66]], na.omit(occ[,5:4])),
                    tmean_mam=extract(dat[[67]], na.omit(occ[,5:4])),
                    tmean_son=extract(dat[[68]], na.omit(occ[,5:4])),
                    tmin_ann=extract(dat[[81]], na.omit(occ[,5:4])),
                    tmin_djf=extract(dat[[82]], na.omit(occ[,5:4])),
                    tmin_jja=extract(dat[[83]], na.omit(occ[,5:4])),
                    tmin_mam=extract(dat[[84]], na.omit(occ[,5:4])),
                    tmin_son=extract(dat[[85]], na.omit(occ[,5:4])))

#This is a trick to get species level means, but keeping both the scientific names and functional group: select family (or group columns), genus and epithet columns.
sp<-character()
for(i in 1:dim(orchids)[1]){
  sp[i]<-paste(occ[i,6], occ[i,2], occ[i,3], sep="_")
}


orchids<-cbind(sp, orchids)
orchids<-na.omit(orchids) 

#removing duplicated records
orchids<-unique(orchids)

## Creating species list to bind orchids_tableS3 (tabela com presença e ausencia de cada spp nos diferentes cenários)
orchids_sp<-data.frame(unique(orchids$sp))
#Now we calculate species means
orchidsMeans<-aggregate(x=orchids[,2:26], by=list(orchids$sp), FUN="mean")

#projecting individual records onto the PC axes
orchidsClimInd<-predict(res, orchids)[,1:2]

#We then use the species means and project them into the climatic space of the Atlantic Forest

orchidsClim<-predict(res, orchidsMeans)[,1:2]


###########################################################
futurePCA<-function(path){
  fs <- list.files(path=path, pattern = "tif$", full.names = TRUE)
  dat<-list()
  for(i in 1:25) dat[[i]]<-raster(fs[i])
  all<-data.frame(
    dtr_ann=matrix(dat[[1]], ncol=1),
    dtr_djf=matrix(dat[[2]], ncol=1),
    dtr_jja=matrix(dat[[3]], ncol=1),
    dtr_mam=matrix(dat[[4]], ncol=1),
    dtr_son=matrix(dat[[5]], ncol=1),
    prec_ann=matrix(dat[[6]], ncol=1),
    prec_djf=matrix(dat[[7]], ncol=1),
    prec_jja=matrix(dat[[8]], ncol=1),
    prec_mam=matrix(dat[[9]], ncol=1),
    prec_son=matrix(dat[[10]], ncol=1),
    tmax_ann=matrix(dat[[11]], ncol=1),
    tmax_djf=matrix(dat[[12]], ncol=1),
    tmax_jja=matrix(dat[[13]], ncol=1),
    tmax_mam=matrix(dat[[14]], ncol=1),
    tmax_son=matrix(dat[[15]], ncol=1),
    tmean_ann=matrix(dat[[16]], ncol=1),
    tmean_djf=matrix(dat[[17]], ncol=1),
    tmean_jja=matrix(dat[[18]], ncol=1),
    tmean_mam=matrix(dat[[19]], ncol=1),
    tmean_son=matrix(dat[[20]], ncol=1),
    tmin_ann=matrix(dat[[21]], ncol=1),
    tmin_djf=matrix(dat[[22]], ncol=1),
    tmin_jja=matrix(dat[[23]], ncol=1),
    tmin_mam=matrix(dat[[24]], ncol=1),
    tmin_son=matrix(dat[[25]], ncol=1)
  )
  all<-na.omit(all)
  xx<-predict(res, all)[,1:2]
  xx
}

setwd('E:/Orchids_honduras/Inputs/Climate_data/rcp26/')
ssp126_2049<-futurePCA("2020_2049")
ssp126_2069<-futurePCA("2040_2069")
ssp126_2099<-futurePCA("2070_2099")

setwd('E:/Orchids_honduras/Inputs/Climate_data/rcp45/')
ssp485_2049<-futurePCA("2020_2049")
ssp485_2069<-futurePCA("2040_2069")
ssp485_2099<-futurePCA("2070_2099")

setwd('E:/Orchids_honduras/Inputs/Climate_data/rcp85/')
ssp585_2049<-futurePCA("2020_2049")
ssp585_2069<-futurePCA("2040_2069")
ssp585_2099<-futurePCA("2070_2099")


x11()
# pdf("../figures/Figure_3.pdf", width=6, height=11)
layout(matrix(1:3, ncol=3))
cols<-mako(4, alpha = 0.1)
plot(res$x[,1:2], xlab="PC1", ylab="PC2", col=cols[1], ylim=c(-15, 10), xlim=c(-10, 15), pch=16, main="RCP2.6")
points(ssp126_2049[,2]~ssp126_2049[,1], col=cols[2], pch=16)
points(ssp126_2069[,2]~ssp126_2049[,1], col=cols[3], pch=16)
points(ssp126_2099[,2]~ssp126_2049[,1], col=cols[4], pch=16)
points(orchidsClim[,2]~orchidsClim[,1], col="brown2")
legend("bottomleft", pch=16, 
       legend = c("Present", "2020-2049", "2040-2069","2070-2099"), col=mako(4), bty="n")


plot(res$x[,1:2], xlab="PC1", ylab="PC2", col=cols[1], ylim=c(-15, 10), xlim=c(-10, 15), pch=16, main="RCP8.5")
points(ssp585_2049[,2]~ssp585_2049[,1], col=cols[2], pch=16)
points(ssp585_2069[,2]~ssp585_2049[,1], col=cols[3], pch=16)
points(ssp585_2099[,2]~ssp585_2049[,1], col=cols[4], pch=16)
points(orchidsClim[,2]~orchidsClim[,1], col="brown2")
legend("bottomleft", pch=16, 
       legend = c("Present", "2020-2049", "2040-2069","2070-2099"), col=mako(4), bty="n")

library(concaveman)
library(sf)
library(viridis)
setwd("E:/Orchids_honduras/Outputs/")
# write.table(orchidsClim, "orchidsClim.txt")
# write.table(ssp126_2049, "ssp126_2049.txt")
# write.table(ssp126_2069, "ssp126_2069.txt")
# write.table(ssp126_2099, "ssp126_2099.txt")
# 
# write.table(ssp585_2049, "ssp585_2049.txt")
# write.table(ssp585_2069, "ssp585_2069.txt")
# write.table(ssp585_2099, "ssp585_2099.txt")


orchidsPoints<-read.table("orchidsClim.txt")
ssp126_2049<-read.table("ssp126_2049.txt")
ssp126_2069<-read.table("ssp126_2069.txt")
ssp126_2099<-read.table("ssp126_2099.txt")

ssp585_2049<-read.table("ssp585_2049.txt")
ssp585_2069<-read.table("ssp585_2069.txt")
ssp585_2099<-read.table("ssp585_2099.txt")



###### CRS ######
##### mudei o crs pro mesmo que usei pra converter o shapefile de floresta atlantica
orchidsPol <- sf::st_as_sf(orchidsPoints, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp126_2049Pol <- sf::st_as_sf(ssp126_2049, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp126_2069Pol <- sf::st_as_sf(ssp126_2069, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp126_2099Pol <- sf::st_as_sf(ssp126_2099, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")

ssp585_2049Pol <- sf::st_as_sf(ssp585_2049, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp585_2069Pol <- sf::st_as_sf(ssp585_2069, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp585_2099Pol <- sf::st_as_sf(ssp585_2099, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")



cols<-turbo(6)
plot(orchidsPoints, ylim=c(-15, 10), xlim=c(-14, 15), col="brown2")
plot(concaveman(ssp126_2049Pol), border=cols[1], add=TRUE)
plot(concaveman(ssp126_2069Pol), border=cols[2], add=TRUE)
plot(concaveman(ssp126_2099Pol), border=cols[3], add=TRUE)

plot(concaveman(ssp585_2049Pol), border=cols[4], add=TRUE)
plot(concaveman(ssp585_2069Pol), border=cols[5], add=TRUE)
plot(concaveman(ssp585_2099Pol), border=cols[6], add=TRUE)



legend("bottomleft", pch=16, 
       legend = c("RCP2.6 2020-2049", "RCP2.6 2040-2069","RCP2.6 2070-2099",
                  "RCP8.5 2020-2049", "RCP8.5 2040-2069","RCP8.5 2070-2099"), col=cols[1:6], bty="n")
# dev.off()


####################### fig 4 ##############

library(concaveman)
library(sf)
library(viridis)
library(sp)
library(rgdal)
library(rgeos)
library(prevR)
library(dplyr)
library(tidyr)

setwd("E:/Orchids_honduras/Outputs/")
orchidsPoints<-read.table("orchidsClim.txt")
present<-as.data.frame(res$x[,1:2])
ssp126_2049<-read.table("ssp126_2049.txt")
ssp126_2069<-read.table("ssp126_2069.txt")
ssp126_2099<-read.table("ssp126_2099.txt")

ssp585_2049<-read.table("ssp585_2049.txt")
ssp585_2069<-read.table("ssp585_2069.txt")
ssp585_2099<-read.table("ssp585_2099.txt")


presentPol  <- sf::st_as_sf(present,  coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp126_2049Pol <- sf::st_as_sf(ssp126_2049, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp126_2069Pol <- sf::st_as_sf(ssp126_2069, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp126_2099Pol <- sf::st_as_sf(ssp126_2099, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")

ssp585_2049Pol <- sf::st_as_sf(ssp585_2049, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp585_2069Pol <- sf::st_as_sf(ssp585_2069, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")
ssp585_2099Pol <- sf::st_as_sf(ssp585_2099, coords = c("PC1", "PC2"), crs = 4326, agr = "constant")


getwd()
#There's probably a more elegant way to do this
unlink("orchids_shp1.shp")
st_write(concaveman(presentPol), "orchids_shp1.shp"); SpresentPol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")

st_write(concaveman(ssp126_2049Pol), "orchids_shp1.shp"); Sssp126_2049Pol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")

st_write(concaveman(ssp126_2069Pol), "orchids_shp1.shp"); Sssp126_2069Pol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")

st_write(concaveman(ssp126_2099Pol), "orchids_shp1.shp"); Sssp126_2099Pol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")



st_write(concaveman(ssp585_2049Pol), "orchids_shp1.shp"); Sssp585_2049Pol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")

st_write(concaveman(ssp585_2069Pol), "orchids_shp1.shp"); Sssp585_2069Pol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")

st_write(concaveman(ssp585_2099Pol), "orchids_shp1.shp"); Sssp585_2099Pol<-rgdal::readOGR("orchids_shp1.shp"); unlink("orchids_shp1.shp")



table3<-rbind(
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], SpresentPol)),
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp126_2049Pol)),
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp126_2069Pol)),
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp126_2099Pol)),
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp585_2049Pol)),
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp585_2069Pol)),
  table(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp585_2099Pol))
)

areas<-c(area(SpresentPol), 
         area(Sssp126_2049Pol), 
         area(Sssp126_2069Pol),
         area(Sssp126_2099Pol),
         area(Sssp585_2069Pol), 
         area(Sssp585_2099Pol))

areas<-areas*100/area(SpresentPol)
lost<-c(raster::area(raster::intersect(SpresentPol,SpresentPol)),
        raster::area(raster::intersect(SpresentPol,Sssp126_2049Pol)),
        raster::area(raster::intersect(SpresentPol,Sssp126_2069Pol)),
        raster::area(raster::intersect(SpresentPol,Sssp126_2099Pol)),
        raster::area(raster::intersect(SpresentPol,Sssp585_2049Pol)),
        raster::area(raster::intersect(SpresentPol,Sssp585_2069Pol)),
        raster::area(raster::intersect(SpresentPol,Sssp585_2099Pol))
)
getwd()
lost<-lost*100/area(SpresentPol)

##### nao sei se essa tabela tá certa: outside ta com todas as spp do dataset (869)
table3<-cbind(table3, round(areas, digits=1), round(lost, digits=1))

colnames(table3)<-c("Outside", "Within", "Total area", "Overlap")
rownames(table3)<-c("present", "ssp126_2049", "ssp126_2069", "ssp126_2099", "ssp585_2049", "ssp585_2069","ssp585_2099")
getwd()
# write.table(table3, "orchids_lost_area.csv", row.names = T)

present=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], SpresentPol))
ssp126_2049=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp126_2049Pol))
ssp126_2069=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp126_2069Pol))
ssp126_2099=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp126_2099Pol))

ssp585_2049=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp585_2049Pol))
ssp585_2069=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp585_2069Pol))
ssp585_2099=as.numeric(point.in.SpatialPolygons(orchidsPoints[,1], orchidsPoints[,2], Sssp585_2099Pol))


tableS1<-cbind(rownames(orchidsPoints), present, ssp126_2049, ssp126_2069, ssp126_2099)

tableS2<-cbind(rownames(orchidsPoints), present, ssp585_2049, ssp585_2069, ssp585_2099)

tableS3 <- dplyr::bind_cols(orchids_sp, tableS1)
tableS3 <- dplyr::bind_cols(tableS3, tableS2)
tableS3 <- tableS3[,-c(2,7,8)]

colnames(tableS3)<-c("SPECIES", "Present", "RCP2.6_2049", "RCP2.6_2069", "RCP2.6_2099", "RCP8.5_2049", "RCP8.5_2069", "RCP8.5_2099")


tableS3 <- tableS3 %>%
  separate(SPECIES, into = c("HABITAT", "GENUS", "EPITHET"), sep = "_", remove = T)


tableS3 <- tableS3 %>% 
  unite("SPECIES", GENUS:EPITHET, remove = FALSE, sep = " ")

tableS3 <- tableS3[,-4]

tableS3 <- tableS3 %>%
  dplyr::select('HABITAT', 'GENUS', 'SPECIES', 'Present', 'RCP2.6_2049', 'RCP2.6_2069', 'RCP2.6_2099','RCP8.5_2049', 'RCP8.5_2069', 'RCP8.5_2099')

## juntar os valores de PC1 e PC2 às linhas das epécies
tableS3_PC <- bind_cols(tableS3, orchidsPoints)

# write.csv(tableS1, "orchids_tableS1-226.csv", quote=FALSE, row.names=FALSE)
# write.csv(tableS2, "orchids_tableS2-585.csv", quote=FALSE, row.names=FALSE)
# write.csv(tableS3_PC, "orchids_lost_species.csv", quote=FALSE, row.names=FALSE)
getwd()

x11()
layout(matrix(1:6, ncol=2))
library(RColorBrewer)
cores <- brewer.pal(3, "Greens")

par(mar=c(1,1,1,1))
plot(SpresentPol, xlim=c(-12,15), ylim=c(-16, 11), main="a RCP2.6 - 2049", cex.main = 1.5)
plot(Sssp126_2049Pol, col=cores[2], add=TRUE)
plot(raster::intersect(SpresentPol,Sssp126_2049Pol), col=cores[3], add=TRUE)

plot(SpresentPol, xlim=c(-12,15), ylim=c(-16, 11), main="c RCP2.6 - 2099", cex.main = 1.5)
plot(Sssp126_2099Pol, col=cores[2], add=TRUE)
plot(raster::intersect(SpresentPol,Sssp126_2099Pol), col=cores[3], add=TRUE)

plot(SpresentPol, xlim=c(-12,15), ylim=c(-16, 11), main="e RCP8.5 - 2049", cex.main = 1.5)
plot(Sssp585_2049Pol, col=cores[2], add=TRUE)
plot(raster::intersect(SpresentPol,Sssp585_2049Pol), col=cores[3], add=TRUE)

plot(SpresentPol, xlim=c(-12,15), ylim=c(-16, 11), main="b RCP2.6 - 2069", cex.main = 1.5)
plot(Sssp126_2069Pol, col=cores[2], add=TRUE)
plot(raster::intersect(SpresentPol,Sssp126_2069Pol), col=cores[3], add=TRUE)

plot(SpresentPol, xlim=c(-12,15), ylim=c(-16, 11), main="d RCP8.5 - 2069", cex.main = 1.5)
plot(Sssp585_2069Pol, col=cores[2], add=TRUE)
plot(raster::intersect(SpresentPol,Sssp585_2069Pol), col=cores[3], add=TRUE)

plot(SpresentPol, xlim=c(-12,15), ylim=c(-16, 11), main="f RCP8.5 - 2099", cex.main = 1.5)
plot(Sssp585_2099Pol, col=cores[2], add=TRUE)
plot(raster::intersect(SpresentPol,Sssp585_2099Pol), col=cores[3], add=TRUE)


# dev.off()
