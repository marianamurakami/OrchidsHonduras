library(viridis)
library(car)
library(raster)
library(vegan)
library(colorRamps)
library(ggsci)
library(colortools)
library(tmaptools)
library(rcolorutils)
##### Precisa carregar o dataset de planta
setwd("E:/Orchids_honduras/Inputs/")

DF <-  read.csv("orchid_database_habitat.csv", header = TRUE, stringsAsFactors = T)



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
res<-prcomp(all, center=TRUE, scale =TRUE)
# 'res' is now the object with the PCA with the climate for the entire country.

table1<-round(res$rotation[,1:2], digits=2)


getwd()
# setwd("D:/Chelsa/Matheus/Outputs/")
# write.table(table1, "table_PCA.csv")

#We now extract the bioclimatic variables associated with those records: select coordinates collumns (long primeiro, lat depois)

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

#Now we calculate species means: select columns with the climatic variables
orchidsMeans<-aggregate(x=orchids[,2:26], by=list(orchids$sp), FUN="mean")

#projecting individual records onto the PC axes
orchidsClimInd<-predict(res, orchids)[,1:2]

#We then use the species means and project them into the climatic space of Honduras

orchidsClim<-predict(res, orchidsMeans)[,1:2]

group <- character()

for(i in 1:dim(orchidsMeans)[1]) group[i]<-strsplit(orchidsMeans[i,1], "_")[[1]][1]
print(group)


##############Testing for differences in variance####

orchidsClim<-as.data.frame(orchidsClim)

dat<-data.frame(
  PC1=orchidsClim$PC1,
  PC2=orchidsClim$PC2,
  signPC1=sign(orchidsClim$PC1),
  signPC2=sign(orchidsClim$PC2),
  group=group)

y<-c(var(subset(dat, signPC1== 1, select="PC2")),
     var(subset(dat, signPC1==-1, select="PC2")))
y<-round(y, digits=2)
names(y)<-c("PC2.PC1plus", "PC2.PC1minus")
y
leveneTest(PC2~as.factor(signPC1), data=dat)


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


y<-c(var(subset(dat, signPC2== 1, select="PC1")),
     var(subset(dat, signPC2==-1, select="PC1"))
)
y<-round(y, digits=2)
names(y)<-c("PC1.PC2plus", "PC1.PC2minus")
leveneTest(PC1~as.factor(signPC2), data=dat)
##Variance for the entire climatic space.
var(res$x[,1][res$x[,2]>0])
var(res$x[,1][res$x[,2]<0])


#######################
a1<-leveneTest(PC1~as.factor(group), data=dat)
a2<-leveneTest(PC1~as.factor(group), data=dat[dat$signPC2== 1,])
a3<-leveneTest(PC1~as.factor(group), data=dat[dat$signPC2==-1,])
a4<-leveneTest(PC2~as.factor(group), data=dat)
a5<-leveneTest(PC2~as.factor(group), data=dat[dat$signPC1== 1,])
a6<-leveneTest(PC2~as.factor(group), data=dat[dat$signPC1==-1,])


table2<-data.frame(
  Variable=c("PC1", "PC1 (PC2+)", "PC1 (PC2-)", "PC2", "PC2 (PC1+)", "PC2 (PC1-)"),
  Epiphytes=round(c(var(subset(dat, group=="Epiphyte", select=c("PC1"))),
                       var(subset(dat, signPC2== 1 & group=="Epiphyte", select=c("PC1"))),
                       var(subset(dat, signPC2==-1 & group=="Epiphyte", select=c("PC1"))),
                       var(subset(dat, group=="Epiphyte", select=c("PC2"))),
                       var(subset(dat, signPC1== 1 & group=="Epiphyte", select=c("PC2"))),
                       var(subset(dat, signPC1==-1 & group=="Epiphyte", select=c("PC2")))
  ), digits=2),
  Terrestrial=round(c(var(subset(dat, group=="Terrestrial", select=c("PC1"))),
               var(subset(dat, signPC2== 1 & group=="Terrestrial", select=c("PC1"))),
               var(subset(dat, signPC2==-1 & group=="Terrestrial", select=c("PC1"))),
               var(subset(dat, group=="Terrestrial", select=c("PC2"))),
               var(subset(dat, signPC1== 1 & group=="Terrestrial", select=c("PC2"))),
               var(subset(dat, signPC1==-1 & group=="Terrestrial", select=c("PC2")))
  ), digits=2),
  F=round(c(a1$`F value`[1], a2$`F value`[1], a3$`F value`[1], a4$`F value`[1], a5$`F value`[1], a6$`F value`[1]), digits=2),
  P=c(a1$`Pr(>F)`[1], a2$`Pr(>F)`[1], a3$`Pr(>F)`[1], a4$`Pr(>F)`[1], a5$`Pr(>F)`[1], a6$`Pr(>F)`[1])
)

setwd("E:/Orchids_honduras/Outputs/")
write.table(table2, "orchids_variance.txt")
write.csv(table2, "orchids_variance.csv", row.names = F)
