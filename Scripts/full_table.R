library(dplyr)

setwd('E:/Orchids_honduras/Inputs/')

orchids <- read.csv('orchid_database_habitat_pontos_filtrados.csv')
displacement <- read.csv('means_displacement_status.csv')

## extract ONLY honduras Orchidaceae epiphyte spp
full_table <- dplyr::left_join(displacement, orchids, by = "SPECIES")

names(full_table)

full_table <- full_table[,-c(10,11,20)]


# Renaming columns
colnames(full_table)[1] <- "HABITAT"
colnames(full_table)[2] <- "GENUS"

write.csv(full_table, 'full_table.csv', row.names = F)
