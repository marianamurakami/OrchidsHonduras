setwd("E:/Orchids_honduras//Inputs/")


#Carregando os pacotes
library(dplyr)
library(tidyr)
library(tidyverse)
library(stringr)
library(readr)
library(flora)

#################PLANTS#############

orchids <- read.csv("orchids_honduras_database.csv", encoding = 'UTF-8')

names(orchids)
a <- table(unique(orchids$Epithet))
View(a)

# Rename the columns
# Original column names
original_names <- names(orchids)


######## PREPARING THE DATASET ###########
# Rename columns to capital letters
new_names <- toupper(original_names)
names(orchids) <- new_names

# Print the updated column names
names(orchids)

# Switch columns 1 and 3 names
# Retrieve the original column names
original_names <- names(orchids)

# Swap the names of columns 1 and 3
temp <- original_names[1]
original_names[1] <- original_names[3]
original_names[3] <- temp

# Assign the updated names to the dataset
names(orchids) <- original_names

# Print the updated column names
names(orchids)


#### CLEANING THE DATASET
# Check the resulting data frame
unique(orchids$SPECIES)
unique(orchids$GENUS)
# Remove the entry 'aa' from the GENUS column
orchids <- orchids[orchids$GENUS != 'Aa', ]
unique(orchids$GENUS)

unique(orchids$EPITHET)
# Remove the entry 'X' from the EPITHET column (it is Epidendrum X doroteae, a natural hybrid)
orchids <- orchids[orchids$EPITHET != 'X', ]
unique(orchids$EPITHET)



########## CLEANING VARIATIES, SUBSPECIES ETC (NOT NEEDED FOR HONDURAS DATASET)#####
# Clean the "<a0>" pattern
orchids$EPITHET <- gsub("<a0>", "", orchids$EPITHET)

# Clean the varieties within "EPITHET" column
orchids$EPITHET <- gsub("var\\..*", "", orchids$EPITHET)

orchids$EPITHET <- gsub(" var*", "", orchids$EPITHET)

orchids$EPITHET <- gsub("subsp\\..*", "", orchids$EPITHET)

orchids$EPITHET <- gsub("subsp*", "", orchids$EPITHET)

orchids$EPITHET <- gsub("cf. ", "", orchids$EPITHET)

orchids$EPITHET <- gsub("cf ", "", orchids$EPITHET)

orchids$EPITHET <- gsub("aff. ", "", orchids$EPITHET)

orchids$EPITHET <- gsub("aff ", "", orchids$EPITHET)

orchids$EPITHET <- gsub(" x ", " ", orchids$EPITHET)

orchids$EPITHET <- gsub("x ", "", orchids$EPITHET)

unique(orchids$SPECIES)


# # Extract the first word from the "EPITHET" column (clean var., subsp. etc)
# orchids$EPITHET <- sapply(strsplit(as.character(orchids$EPITHET), " "), `[`, 1)
# unique((orchids$EPITHET))
# 
# 
# 
# unique(orchids$EPITHET)
# 
# orchids <- orchids %>%
#   mutate(SPECIES = paste(Genus, EPITHET, sep = " "))


## Classify growth form according to EpiList 1.0 (Zotz 2021) #####

## Import EpiList
epi_list <- read.csv('EpiList_Final_revised.csv')
colnames(epi_list)[2] <- 'SPECIES'


## Extracting Honduras Orchidaceae epiphytic species according to epilist
orchids_epi_names <- intersect(orchids$SPECIES, epi_list$SPECIES)

orchids_epi <- orchids[orchids$SPECIES %in% orchids_epi_names,]


## Extracting Honduras Orchidaceae epiphytic species according to Flora do Brasil list
flora_names <- unique(orchids$SPECIES)
Epif_flora <- flora::get.taxa(flora_names, habitat = T)
names(Epif_flora)
colnames(Epif_flora)[10] <- 'SPECIES'

table(Epif_flora$habitat)

Epif_flora_habitat <- subset(Epif_flora, habitat != "Hemiepífita" & habitat != "Rupícola|Terrícola" & habitat != "Terrícola" & habitat != "Rupícola" & habitat != "Saprófita")

table(Epif_flora_habitat$habitat)

intersect_nomes_flora <- intersect(orchids$SPECIES, Epif_flora_habitat$SPECIES)

orchids_flora <- orchids[orchids$SPECIES %in% intersect_nomes_flora,]


### Joining the two lists (epilist and flora do brasil) with Honduras Orchidaceae spp
list_zotz <- data.frame(unique(orchids_epi$SPECIES))
colnames(list_zotz)[1] <- 'SPECIES'

list_flora <- data.frame(unique(orchids_flora$SPECIES))
colnames(list_flora)[1] <- 'SPECIES'


both <- full_join(list_flora, list_zotz, by = "SPECIES")


## extract ONLY honduras Orchidaceae epiphyte spp
epif_flora_zotz <- left_join(both, orchids, by = "SPECIES")

epif <- epif_flora_zotz


# Filling "Habitat" column (labeling each species as either "Epiphyte" or "Terrestrial" based on whether it is found in the "epif" dataset or not.)
orchids$HABITAT <- ifelse(orchids$SPECIES %in% epif$SPECIES, "Epiphyte", "Terrestrial")


write.csv(orchids, "orchid_database_habitat.csv", row.names = F)

aa <- table(unique(orchids$SPECIES))
View(aa)
#################ORCHIDS#############

orchids$SIZE <- 0
orchids$PSEUDOBULD <- 0
orchids$LEAF_RETENTION <- 0

# Filling SIZE column:
orchids <- orchids %>%
  mutate(SIZE = case_when(
    Genus == "Acianthera" ~ "Micro",
    Genus == "Anathallis" ~ "Micro",
    Genus == "Barbosella" ~ "Micro",
    Genus == "Brassavola" ~ "Macro",
    Genus == "Campylocentrum" ~ "Micro",
    Genus == "Capanemia" ~ "Micro",
    Genus == "Centroglossa" ~ "Micro",
    Genus == "Christensonella" ~ "Micro",
    Genus == "Coryanthes" ~ "Macro",
    Genus == "Cyclopogon" ~ "Micro",
    Genus == "Dichaea" ~ "Micro",
    Genus == "Dimerandra" ~ "Macro",
    Genus == "Dryadella" ~ "Micro",
    SPECIES == "Elleanthus brasiliensis" ~ "Macro",
    SPECIES == "Elleanthus crinipis" ~ "Macro",
    SPECIES == "Elleanthus linifolius" ~ "Micro",
    Genus == "Erycina" ~ "Micro",
    Genus == "Eurystyles" ~ "Micro",
    Genus == "Isabelia" ~ "Micro",
    Genus == "Hapalorchis" ~ "Micro",
    Genus == "Ionopsis" ~ "Micro",
    Genus == "Jacquiniella" ~ "Micro",
    Genus == "Koellensteinia" ~ "Micro",
    Genus == "Lankesterella" ~ "Micro",
    Genus == "Lepanthopsis" ~ "Micro",
    Genus == "Leptotes" ~ "Micro",
    Genus == "Lockhartia" ~ "Micro",
    Genus == "Loefgrenianthus" ~ "Micro",
    Genus == "Masdevallia" ~ "Micro",
    Genus == "Myoxanthus" ~ "Micro",
    Genus == "Notylia" ~ "Micro",
    Genus == "Octomeria" ~ "Micro",
    Genus == "Oncidium" ~ "Micro",
    Genus == "Ornithocephalus" ~ "Micro",
    Genus == "Pabstiella" ~ "Micro",
    Genus == "Phymatidium" ~ "Micro",
    Genus == "Platyrhiza" ~ "Micro",
    Genus == "Platystele" ~ "Micro",
    Genus == "Polystachya" ~ "Micro",
    Genus == "Prescottia" ~ "Micro",
    Genus == "Scaphyglottis" ~ "Micro",
    Genus == "Specklinia" ~ "Micro",
    Genus == "Stelis" ~ "Micro",
    Genus == "Trichocentrum" ~ "Micro",
    Genus == "Trichosalpinx" ~ "Micro",
    Genus == "Trigonidium" ~ "Micro",
    Genus == "Warmingia" ~ "Micro",
    Genus == "Zootrophion" ~ "Micro",
    Genus == "Zygostates" ~ "Micro",

    Genus == "Aspasia" ~ "Macro",
    Genus == "Bifrenaria" ~ "Macro",
    Genus == "Brasiliorchis" ~ "Macro",
    Genus == "Catasetum" ~ "Macro",
    Genus == "Cirrhaea" ~ "Macro",
    Genus == "Comparettia" ~ "Macro",
    Genus == "Cyrtopodium" ~ "Macro",
    SPECIES == "Elleanthus brasiliensis" ~ "Macro",
    SPECIES == "Elleanthus crinipes" ~ "Macro",
    SPECIES == "Elleanthus linifolius" ~ "Micro",
    Genus == "Encyclia" ~ "Macro",
    Genus == "Epidendrum" ~ "Macro",
    Genus == "Galeandra" ~ "Macro",
    Genus == "Gomesa" ~ "Macro",
    Genus == "Gongora" ~ "Macro",
    Genus == "Grandiphyllum" ~ "Macro",
    Genus == "Grobya" ~ "Macro",
    Genus == "Heterotaxis" ~ "Macro",
    Genus == "Huntleya" ~ "Macro",
    Genus == "Laelia" ~ "Macro",
    Genus == "Maxillaria" ~ "Macro",
    Genus == "Maxillariella" ~ "Macro",
    Genus == "Miltonia" ~ "Macro",
    Genus == "Pabstia" ~ "Macro",
    Genus == "Peristeria" ~ "Macro",
    Genus == "Promenaea" ~ "Macro",
    Genus == "Prosthechea" ~ "Macro",
    Genus == "Rodriguezia" ~ "Macro",
    Genus == "Scuticaria" ~ "Macro",
    Genus == "Sobralia" ~ "Macro",
    Genus == "Stanhopea" ~ "Macro",
    Genus == "Trizeuxis" ~ "Micro",
    Genus == "Vanilla" ~ "Macro",
    Genus == "Xylobium" ~ "Macro",
    Genus == "Zygopetalum" ~ "Macro",

    SPECIES == "Bulbophyllum atropurpureum" ~ "Micro",
    SPECIES == "Bulbophyllum cantagallense" ~ "Micro",
    SPECIES == "Bulbophyllum chloroglossum" ~ "Micro",
    SPECIES == "Bulbophyllum epiphytum" ~ "Micro",
    SPECIES == "Bulbophyllum glutinosum" ~ "Micro",
    SPECIES == "Bulbophyllum granulosum" ~ "Micro",
    SPECIES == "Bulbophyllum micranthum" ~ "Micro",
    SPECIES == "Bulbophyllum micropetaliforme" ~ "Micro",
    SPECIES == "Bulbophyllum napellii" ~ "Micro",
    SPECIES == "Bulbophyllum plumosum" ~ "Micro",
    SPECIES == "Bulbophyllum regnellii" ~ "Micro",


    SPECIES == "Cattleya amethystoglossa" ~ "Macro",
    SPECIES == "Cattleya bicolor" ~ "Macro",
    SPECIES == "Cattleya crispa" ~ "Macro",
    SPECIES == "Cattleya forbesii" ~ "Macro",
    SPECIES == "Cattleya granulosa" ~ "Macro",
    SPECIES == "Cattleya guttata" ~ "Macro",
    SPECIES == "Cattleya harrisoniana" ~ "Macro",
    SPECIES == "Cattleya intermedia" ~ "Macro",
    SPECIES == "Cattleya labiata" ~ "Macro",
    SPECIES == "Cattleya loddigesii" ~ "Macro",
    SPECIES == "Cattleya perrinii" ~ "Macro",
    SPECIES == "Cattleya pumila" ~ "Macro",
    SPECIES == "Cattleya purpurata" ~ "Macro",
    SPECIES == "Cattleya schilleriana" ~ "Macro",
    SPECIES == "Cattleya tigrina" ~ "Macro",
    SPECIES == "Cattleya xanthina" ~ "Macro",

    SPECIES == "Cattleya cernua" ~ "Micro",
    SPECIES == "Cattleya coccinea" ~ "Micro",
    SPECIES == "Cattleya lundii" ~ "Micro"))

table(orchids$SIZE)
which(is.na(orchids$SIZE))


# Filling PSEUDOBULB column:
orchids <- orchids %>%
  mutate(PSEUDOBULD = case_when(
    Genus == "Acianthera" ~ "No",
    Genus == "Anathallis" ~ "No",
    Genus == "Aspasia" ~ "Yes",
    Genus == "Barbosella" ~ "No",
    Genus == "Bifrenaria" ~ "Yes",
    Genus == "Brasiliorchis" ~ "Yes",
    Genus == "Brassavola" ~ "No",
    Genus == "Bulbophyllum" ~ "Yes",
    Genus == "Campylocentrum" ~ "No",
    Genus == "Capanemia" ~ "Yes",
    Genus == "Catasetum" ~ "Yes",
    Genus == "Cattleya" ~"Yes",
    Genus == "Centroglossa" ~ "No",
    Genus == "Christensonella" ~ "Yes",
    Genus == "Cirrhaea" ~ "Yes",
    Genus == "Comparettia" ~ "Yes",
    Genus == "Coryanthes" ~ "Yes",
    Genus == "Cyclopogon" ~ "No",
    Genus == "Cyrtopodium" ~ "Yes",
    Genus == "Dichaea" ~ "No",
    Genus == "Dimerandra" ~ "No",
    Genus == "Dryadella" ~ "No",
    Genus == "Elleanthus" ~ "No",
    Genus == "Encyclia" ~ "Yes",
    Genus == "Epidendrum" ~ "No",
    Genus == "Erycina" ~ "No",
    Genus == "Eurystyles" ~ "No",
    Genus == "Galeandra" ~ "No",
    Genus == "Gomesa" ~ "Yes",
    Genus == "Gongora" ~ "Yes",
    Genus == "Grandiphyllum" ~ "Yes",
    Genus == "Grobya" ~ "Yes",
    Genus == "Hapalorchis" ~ "No",
    Genus == "Heterotaxis" ~ "Yes",
    Genus == "Huntleya" ~ "No",
    Genus == "Ionopsis" ~ "No",
    Genus == "Isabelia" ~ "Yes",
    Genus == "Jacquiniella" ~ "No",
    Genus == "Koellensteinia" ~ "No",
    Genus == "Laelia" ~ "Yes",
    Genus == "Lankesterella" ~ "No",
    Genus == "Lepanthopsis" ~ "No",
    Genus == "Leptotes" ~ "No",
    Genus == "Lockhartia" ~ "No",
    Genus == "Loefgrenianthus" ~ "No",
    Genus == "Masdevallia" ~ "No",
    Genus == "Maxillaria" ~ "Yes",
    Genus == "Maxillariella" ~ "Yes",
    Genus == "Miltonia" ~ "Yes",
    Genus == "Myoxanthus" ~ "No",
    Genus == "Notylia" ~ "No",
    Genus == "Octomeria" ~ "No",
    Genus == "Oncidium" ~ "Yes",
    Genus == "Ornithocephalus" ~ "No",
    Genus == "Pabstia" ~ "Yes",
    Genus == "Pabstiella" ~ "No",
    Genus == "Peristeria" ~ "Yes",
    Genus == "Phymatidium" ~ "No",
    Genus == "Platyrhiza" ~ "No",
    Genus == "Platystele" ~ "No",
    Genus == "Polystachya" ~ "Yes",
    Genus == "Prescottia" ~ "No",
    SPECIES == "Scaphyglottis brasiliensis" ~ "No",
    SPECIES == "Scaphyglottis emarginata" ~ "No",
    SPECIES == "Scaphyglottis fusiformis" ~ "Yes",
    SPECIES == "Scaphyglottis livida" ~ "Yes",
    SPECIES == "Scaphyglottis modesta" ~ "Yes",
    SPECIES == "Scaphyglottis reflexa" ~ "No",
    SPECIES == "Scaphyglottis sickii" ~ "Yes",
    Genus == "Promenaea" ~ "Yes",
    Genus == "Prosthechea" ~ "Yes",
    Genus == "Rodriguezia" ~ "No",
    Genus == "Scuticaria" ~ "No",
    Genus == "Sobralia" ~ "No",
    Genus == "Specklinia" ~ "No",
    Genus == "Stanhopea" ~ "Yes",
    Genus == "Stelis" ~ "No",
    Genus == "Trichocentrum" ~ "No",
    Genus == "Trichosalpinx" ~ "No",
    Genus == "Trigonidium" ~ "No",
    Genus == "Trizeuxis" ~ "No",
    Genus == "Vanilla" ~ "No",
    Genus == "Warmingia" ~ "No",
    Genus == "Xylobium" ~ "Yes",
    Genus == "Zootrophion" ~ "No",
    Genus == "Zygopetalum" ~ "Yes",
    Genus == "Zygostates" ~ "No"))

table(orchids$PSEUDOBULD)
which(is.na(orchids$PSEUDOBULD))


## Filling LEAF_RETENTION column:
orchids <- orchids %>%
  mutate(LEAF_RETENTION = case_when(
    Genus == "Acianthera" ~ "Yes",
    Genus == "Anathallis" ~ "Yes",
    Genus == "Aspasia" ~ "No",
    Genus == "Barbosella" ~ "Yes",
    Genus == "Bifrenaria" ~ "No",
    Genus == "Brasiliorchis" ~ "No",
    Genus == "Brassavola" ~ "Yes",
    Genus == "Bulbophyllum" ~ "Yes",
    SPECIES == "Campylocentrum brachycarpum" ~ "Yes",
    SPECIES == "Campylocentrum crassirhizum" ~ "Yes",
    SPECIES == "Campylocentrum densiflorum" ~ "Yes",
    SPECIES == "Campylocentrum micranthum" ~ "Yes",
    SPECIES == "Campylocentrum neglectum" ~ "Yes",
    SPECIES == "Campylocentrum ornithorrhynchum" ~ "Yes",
    SPECIES == "Campylocentrum parahybunense" ~ "Yes",
    SPECIES == "Campylocentrum pauloense" ~ "Yes",
    SPECIES == "Campylocentrum robustum" ~ "Yes",
    SPECIES == "Campylocentrum sellowii" ~ "Yes",
    SPECIES == "Campylocentrum spannagelii" ~ "Yes",
    SPECIES == "Campylocentrum grisebachii" ~ "No",
    Genus == "Capanemia" ~ "Yes",
    Genus == "Catasetum" ~ "No",
    Genus == "Cattleya" ~ "Yes",
    Genus == "Centroglossa" ~ "Yes",
    Genus == "Christensonella" ~ "Yes",
    Genus == "Cirrhaea" ~ "No",
    SPECIES == "Comparettia coccinea" ~ "Yes",
    Genus == "Coryanthes" ~ "No",
    Genus == "Cyclopogon" ~ "No",
    Genus == "Cyrtopodium" ~ "No",
    Genus == "Dichaea" ~ "No",
    Genus == "Dimerandra" ~ "No",
    Genus == "Dryadella" ~ "Yes",
    Genus == "Elleanthus" ~ "No",
    Genus == "Encyclia" ~ "No",
    Genus == "Epidendrum" ~ "Yes",
    Genus == "Erycina" ~ "No",
    Genus == "Eurystyles" ~ "No",
    Genus == "Galeandra" ~ "No",
    Genus == "Gomesa" ~ "No",
    Genus == "Gongora" ~ "No",
    Genus == "Grandiphyllum" ~ "No",
    Genus == "Grobya" ~ "No",
    Genus == "Hapalorchis" ~ "No",
    Genus == "Heterotaxis" ~ "No",
    Genus == "Huntleya" ~ "No",
    Genus == "Ionopsis" ~ "Yes",
    Genus == "Isabelia" ~ "Yes",
    Genus == "Jacquiniella" ~ "Yes",
    Genus == "Koellensteinia" ~ "No",
    Genus == "Laelia" ~ "No",
    Genus == "Lankesterella" ~ "No",
    Genus == "Lepanthopsis" ~ "Yes",
    Genus == "Leptotes" ~ "Yes",
    Genus == "Loefgrenianthus" ~ "Yes",
    Genus == "Lockhartia" ~ "Yes",
    Genus == "Masdevallia" ~ "Yes",
    Genus == "Maxillaria" ~ "No",
    Genus == "Maxillariella" ~ "No",
    Genus == "Miltonia" ~ "No",
    Genus == "Myoxanthus" ~ "Yes",
    Genus == "Notylia" ~ "No",
    Genus == "Octomeria" ~ "Yes",
    Genus == "Oncidium" ~ "No",
    Genus == "Ornithocephalus" ~ "No",
    Genus == "Pabstia" ~ "No",
    Genus == "Pabstiella" ~ "Yes",
    Genus == "Peristeria" ~ "No",
    Genus == "Phymatidium" ~ "Yes",
    Genus == "Platyrhiza" ~ "No",
    Genus == "Platystele" ~ "Yes",
    Genus == "Polystachya" ~ "No",
    Genus == "Prescottia" ~ "No",
    Genus == "Promenaea" ~ "No",
    Genus == "Prosthechea" ~ "No",
    Genus == "Rodriguezia" ~ "Yes",
    SPECIES == "Scaphyglottis brasiliensis" ~ "Yes",
    SPECIES == "Scaphyglottis emarginata" ~ "No",
    SPECIES == "Scaphyglottis fusiformis" ~ "No",
    SPECIES == "Scaphyglottis livida" ~ "No",
    SPECIES == "Scaphyglottis modesta" ~ "No",
    SPECIES == "Scaphyglottis reflexa" ~ "Yes",
    SPECIES == "Scaphyglottis sickii" ~ "No",
    Genus == "Scuticaria" ~ "Yes",
    Genus == "Sobralia" ~ "No",
    Genus == "Specklinia" ~ "Yes",
    Genus == "Stanhopea" ~ "No",
    Genus == "Stelis" ~ "Yes",
    Genus == "Trichocentrum" ~ "Yes",
    Genus == "Trichosalpinx" ~ "Yes",
    Genus == "Trigonidium" ~ "Yes",
    Genus == "Trizeuxis" ~ "No",
    Genus == "Vanilla" ~ "No",
    Genus == "Xylobium" ~ "No",
    Genus == "Warmingia" ~ "No",
    Genus == "Zootrophion" ~ "Yes",
    Genus == "Zygopetalum" ~ "No",
    Genus == "Zygostates" ~ "No"))

table(orchids$LEAF_RETENTION)
which(is.na(orchids$LEAF_RETENTION))

orchids <- orchids[,1:6]

write.table(orchids, 'orchids_clean_habitat.txt')
