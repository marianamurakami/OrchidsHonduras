########### Present ###########


setwd("E:/Orchids_honduras/Outputs/")
bioclim_var <- read.csv("orchidsMeans.csv")

# Rename the column
colnames(bioclim_var)[colnames(bioclim_var) == "Group.1"] <- "SPECIES"

# Load the tidyverse package
library(tidyverse)

# Split the SPECIES column
bioclim_var <- bioclim_var %>%
  separate(SPECIES, into = c("Habit", "Genus", "Epithet"), sep = "_", remove = T)


# Join Genus and Epithet columns
bioclim_var <- bioclim_var %>%
  unite(SPECIES, Genus, Epithet, sep = " ")



setwd("E:/Orchids_honduras/Inputs/")
displaced <- read.csv("displaced_orchids.csv")
displaced <- displaced[,c(3:7)]


# SPECIES column is character type

library(dplyr)

# Summarize the data based on unique SPECIES values
summary_data <- displaced %>%
  group_by(SPECIES) %>%
  summarize(Present = max(Present),
            RCP2.6.Displaced = max(RCP2.6.Displaced),
            RCP8.5.Displaced = max(RCP8.5.Displaced),
            Displaced_ssp = max(Displaced_ssp))


###### criar coluna com status e preencher o displaced de acordo com a tabela e não dosplaced se não estiver nela

# Create a vector of species present in the "displaced" table
present_species <- displaced$SPECIES

# Fill the "bioclim_var$Displaced_spp" column with "Yes" if species is present, else NA
bioclim_var$Displaced_spp <- ifelse(bioclim_var$SPECIES %in% present_species, "Yes", "No")

## Reorder the columns so annual means come first
bioclim_var <- select(bioclim_var, Habit, SPECIES, Displaced_spp, prec_ann, tmean_ann, tmin_ann, tmax_ann, dtr_ann)


# Round columns 3 to 8 to two decimal places
bioclim_var[, 4:8] <- round(bioclim_var[, 4:8], 2)


setwd("E:/Orchids_honduras/Outputs/")
write.csv(bioclim_var, "mean_bioclim_var.csv", row.names = F)


### DISPLACED SPP
displaced <- subset(bioclim_var, bioclim_var$Displaced_spp=="Yes")

# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values_displaced <- apply(displaced[, 4:8], 2, mean)
sd_values_displaced <- apply(displaced[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
displaced_data <- data.frame(Column = names(mean_values_displaced),
  Mean = mean_values_displaced,
  SD = sd_values_displaced)


# Create the new columns "Minimal_range" and "Maximum_range"
displaced_data$Minimal_range <- displaced_data$Mean - displaced_data$SD
displaced_data$Maximum_range <- displaced_data$Mean + displaced_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
displaced_data[, columns_to_round] <- round(displaced_data[, columns_to_round], 2)




### non_displaced SPP
non_displaced <- subset(bioclim_var, bioclim_var$Displaced_spp=="No")

# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values_non_displaced <- apply(non_displaced[, 4:8], 2, mean)
sd_values_non_displaced <- apply(non_displaced[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
non_displaced_data <- data.frame(Column = names(mean_values_non_displaced),
                                 Mean = mean_values_non_displaced,
                                 SD = sd_values_non_displaced)


# Create the new columns "Minimal_range" and "Maximum_range"
non_displaced_data$Minimal_range <- non_displaced_data$Mean - non_displaced_data$SD
non_displaced_data$Maximum_range <- non_displaced_data$Mean + non_displaced_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
non_displaced_data[, columns_to_round] <- round(non_displaced_data[, columns_to_round], 2)







### ALL SPP
# Calculate the mean and standard deviation for columns 3 to 7
mean_values <- apply(bioclim_var[, 4:8], 2, mean)
sd_values <- apply(bioclim_var[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
bioclim_var_data <- data.frame(Column = names(mean_values),
                               Mean = mean_values,
                               SD = sd_values)


# Create the new columns "Minimal_range" and "Maximum_range"
bioclim_var_data$Minimal_range <- bioclim_var_data$Mean - bioclim_var_data$SD
bioclim_var_data$Maximum_range <- bioclim_var_data$Mean + bioclim_var_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
bioclim_var_data[, columns_to_round] <- round(bioclim_var_data[, columns_to_round], 2)

setwd("E:/Orchids_honduras/Outputs/")
write.csv(bioclim_var_data, "bioclima_var_data.csv", row.names = F)









########### Future 85 2100 ###########


setwd("E:/Orchids_honduras/Outputs/Envelope/")
bioclim_var <- read.csv("orchidsMeans.csv")

# Rename the column
colnames(bioclim_var)[colnames(bioclim_var) == "Group.1"] <- "SPECIES"
bioclim_var <- bioclim_var[,-1]

# Load the tidyverse package
library(tidyverse)

# Split the SPECIES column
bioclim_var <- bioclim_var %>%
  separate(SPECIES, into = c("Habit", "Genus", "Epithet"), sep = "_", remove = T)


# Join Genus and Epithet columns
bioclim_var <- bioclim_var %>%
  unite(SPECIES, Genus, Epithet, sep = " ")



setwd("E:/Orchids_honduras/Inputs/")
displaced <- read.csv("displaced_orchids.csv")
displaced <- displaced[,c(3:7)]


# SPECIES column is character type

library(dplyr)

# Summarize the data based on unique SPECIES values
summary_data <- displaced %>%
  group_by(SPECIES) %>%
  summarize(Present = max(Present),
            RCP2.6.Displaced = max(RCP2.6.Displaced),
            RCP8.5.Displaced = max(RCP8.5.Displaced),
            Displaced_ssp = max(Displaced_ssp))


###### criar coluna com status e preencher o displaced de acordo com a tabela e não dosplaced se não estiver nela

# Create a vector of species present in the "displaced" table
present_species <- displaced$SPECIES

# Fill the "bioclim_var$Displaced_spp" column with "Yes" if species is present, else NA
bioclim_var$Displaced_spp <- ifelse(bioclim_var$SPECIES %in% present_species, "Yes", "No")

## Reorder the columns so annual means come first
bioclim_var <- select(bioclim_var, Habit, SPECIES, Displaced_spp, prec_ann, tmean_ann, tmin_ann, tmax_ann, dtr_ann)


# Round columns 3 to 8 to two decimal places
bioclim_var[, 4:8] <- round(bioclim_var[, 4:8], 2)


setwd("E:/Orchids_honduras/Outputs/Envelope/")
write.csv(bioclim_var, "mean_bioclim_var_future.csv", row.names = F)


### DISPLACED SPP
displaced <- subset(bioclim_var, bioclim_var$Displaced_spp=="Yes")

# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values_displaced <- apply(displaced[, 4:8], 2, mean)
sd_values_displaced <- apply(displaced[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
displaced_data <- data.frame(Column = names(mean_values_displaced),
                             Mean = mean_values_displaced,
                             SD = sd_values_displaced)


# Create the new columns "Minimal_range" and "Maximum_range"
displaced_data$Minimal_range <- displaced_data$Mean - displaced_data$SD
displaced_data$Maximum_range <- displaced_data$Mean + displaced_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
displaced_data[, columns_to_round] <- round(displaced_data[, columns_to_round], 2)




### non_displaced SPP
non_displaced <- subset(bioclim_var, bioclim_var$Displaced_spp=="No")

# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values_non_displaced <- apply(non_displaced[, 4:8], 2, mean)
sd_values_non_displaced <- apply(non_displaced[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
non_displaced_data <- data.frame(Column = names(mean_values_non_displaced),
                                 Mean = mean_values_non_displaced,
                                 SD = sd_values_non_displaced)


# Create the new columns "Minimal_range" and "Maximum_range"
non_displaced_data$Minimal_range <- non_displaced_data$Mean - non_displaced_data$SD
non_displaced_data$Maximum_range <- non_displaced_data$Mean + non_displaced_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
non_displaced_data[, columns_to_round] <- round(non_displaced_data[, columns_to_round], 2)


### ALL SPP
# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values <- apply(bioclim_var[, 4:8], 2, mean)
sd_values <- apply(bioclim_var[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
bioclim_var_data <- data.frame(Column = names(mean_values),
                               Mean = mean_values,
                               SD = sd_values)


# Create the new columns "Minimal_range" and "Maximum_range"
bioclim_var_data$Minimal_range <- bioclim_var_data$Mean - bioclim_var_data$SD
bioclim_var_data$Maximum_range <- bioclim_var_data$Mean + bioclim_var_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
bioclim_var_data[, columns_to_round] <- round(bioclim_var_data[, columns_to_round], 2)

setwd("E:/Orchids_honduras/Outputs/Envelope/")
write.csv(bioclim_var_data, "bioclima_var_data_future.csv", row.names = F)



########### Future 26 2100 ###########


setwd("E:/Orchids_honduras/Outputs/Envelope/")
bioclim_var <- read.csv("orchidsMeans_26_2100.csv")

# Rename the column
colnames(bioclim_var)[colnames(bioclim_var) == "Group.1"] <- "SPECIES"


# Load the tidyverse package
library(tidyverse)

# Split the SPECIES column
bioclim_var <- bioclim_var %>%
  separate(SPECIES, into = c("Habit", "Genus", "Epithet"), sep = "_", remove = T)


# Join Genus and Epithet columns
bioclim_var <- bioclim_var %>%
  unite(SPECIES, Genus, Epithet, sep = " ")



setwd("E:/Orchids_honduras/Inputs/")
displaced <- read.csv("displaced_orchids.csv")
displaced <- displaced[,c(3:7)]


# SPECIES column is character type

library(dplyr)

# Summarize the data based on unique SPECIES values
summary_data <- displaced %>%
  group_by(SPECIES) %>%
  summarize(Present = max(Present),
            RCP2.6.Displaced = max(RCP2.6.Displaced),
            RCP8.5.Displaced = max(RCP8.5.Displaced),
            Displaced_ssp = max(Displaced_ssp))


###### criar coluna com status e preencher o displaced de acordo com a tabela e não dosplaced se não estiver nela

# Create a vector of species present in the "displaced" table
present_species <- displaced$SPECIES

# Fill the "bioclim_var$Displaced_spp" column with "Yes" if species is present, else NA
bioclim_var$Displaced_spp <- ifelse(bioclim_var$SPECIES %in% present_species, "Yes", "No")

## Reorder the columns so annual means come first
bioclim_var <- select(bioclim_var, Habit, SPECIES, Displaced_spp, prec_ann, tmean_ann, tmin_ann, tmax_ann, dtr_ann)


# Round columns 3 to 8 to two decimal places
bioclim_var[, 4:8] <- round(bioclim_var[, 4:8], 2)


setwd("E:/Orchids_honduras/Outputs/Envelope/")
write.csv(bioclim_var, "mean_bioclim_var_future_126.csv", row.names = F)


### DISPLACED SPP
displaced <- subset(bioclim_var, bioclim_var$Displaced_spp=="Yes")

# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values_displaced <- apply(displaced[, 4:8], 2, mean)
sd_values_displaced <- apply(displaced[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
displaced_data <- data.frame(Column = names(mean_values_displaced),
                             Mean = mean_values_displaced,
                             SD = sd_values_displaced)


# Create the new columns "Minimal_range" and "Maximum_range"
displaced_data$Minimal_range <- displaced_data$Mean - displaced_data$SD
displaced_data$Maximum_range <- displaced_data$Mean + displaced_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
displaced_data[, columns_to_round] <- round(displaced_data[, columns_to_round], 2)




### non_displaced SPP
non_displaced <- subset(bioclim_var, bioclim_var$Displaced_spp=="No")

# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values_non_displaced <- apply(non_displaced[, 4:8], 2, mean)
sd_values_non_displaced <- apply(non_displaced[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
non_displaced_data <- data.frame(Column = names(mean_values_non_displaced),
                                 Mean = mean_values_non_displaced,
                                 SD = sd_values_non_displaced)


# Create the new columns "Minimal_range" and "Maximum_range"
non_displaced_data$Minimal_range <- non_displaced_data$Mean - non_displaced_data$SD
non_displaced_data$Maximum_range <- non_displaced_data$Mean + non_displaced_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
non_displaced_data[, columns_to_round] <- round(non_displaced_data[, columns_to_round], 2)


### ALL SPP
# Assuming your table is named 'bioclim_var'

# Calculate the mean and standard deviation for columns 3 to 7
mean_values <- apply(bioclim_var[, 4:8], 2, mean)
sd_values <- apply(bioclim_var[, 4:8], 2, sd)

# Create a new data frame or tibble for mean and standard deviation values
bioclim_var_data <- data.frame(Column = names(mean_values),
                               Mean = mean_values,
                               SD = sd_values)


# Create the new columns "Minimal_range" and "Maximum_range"
bioclim_var_data$Minimal_range <- bioclim_var_data$Mean - bioclim_var_data$SD
bioclim_var_data$Maximum_range <- bioclim_var_data$Mean + bioclim_var_data$SD

# Specify the columns to round (columns 2 to 5)
columns_to_round <- 2:5

# Round the specified columns to two decimal places
bioclim_var_data[, columns_to_round] <- round(bioclim_var_data[, columns_to_round], 2)

setwd("E:/Orchids_honduras/Outputs/Envelope/")
write.csv(bioclim_var_data, "bioclima_var_data_future_126.csv", row.names = F)