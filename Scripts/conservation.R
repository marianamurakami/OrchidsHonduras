library(ConR)
library(dplyr)


?IUCN.eval

setwd('E:/Orchids_honduras/Inputs/')

df <- read.csv('full_table.csv')

## create frequency column
df <- df %>%
  group_by(SPECIES) %>%
  mutate(freq = n()) %>%
  ungroup()

## excluding spp with less than 3 records
orchids_3 <- subset(df, freq > 2)

## select Lat, Long, and species
orchids_3 <- orchids_3[,c(15,16,3)]

MyData <- orchids_3

str(MyData)

conservation_orchids <- IUCN.eval(MyData)

setwd('E:/Orchids_honduras/Outputs/')
# write.csv(conservation_orchids, "conservation.csv", row.names = F)

conservation_3recs <- na.omit(conservation_orchids)

str(conservation_3recs)


### WITH ALL RECORDS
# [1] "Number of species per category"
# 
# CR       EN LC or NT       VU 
# 194      217       84       82 
# [1] "Ratio of species per category"
# 
# CR       EN LC or NT       VU 
# 33.6     37.6     14.6     14.2 



##  WITH 3 OR MORE RECORDS
# [1] "Number of species per category"
# 
# CR       EN LC or NT       VU 
# 16      169       84       82 
# [1] "Ratio of species per category"
# 
# CR       EN LC or NT       VU 
# 4.6     48.1     23.9     23.4 











# Create a summary of counts for each unique factor - AOO
category_AOO <- conservation_3recs %>%
  group_by(Category_AOO) %>%
  summarise(count = n())

# Print the summary
print(category_AOO)


# Create a summary of counts for each unique factor - EOO
category_EOO <- conservation_3recs %>%
  group_by(Category_EOO) %>%
  summarise(count = n())

# Print the summary
print(category_EOO)





# Extent of Occurrence (EOO):
#   
#   EOO refers to the geographic area encompassing all known or estimated locations where a particular species can be found.
# It represents the entire range or distribution of a species, including all the locations where the species is known to exist, even if those locations are sparsely scattered.
# EOO is usually defined by drawing the minimum convex polygon around all known occurrences or suitable habitats of the species.
# EOO provides a broader view of the species' distribution and is used to assess the overall size of the area it occupies.




# Area of Occupancy (AOO):
# AOO, on the other hand, focuses on the actual areas within the species' EOO where it is currently known to be present.
# It is a measure of the occupied habitat or the specific locations where the species has been observed or is known to exist.
# AOO is typically represented as a series of grid cells or polygons within the EOO.
# AOO provides a more detailed assessment of the species' distribution, as it considers only the parts of the range where the species is currently found.


# In summary, EOO provides a broader perspective on the overall range of a species, while AOO zooms in on the specific areas within that range where the species is currently present. Both EOO and AOO are important factors in assessing a species' conservation status, as they help conservationists and researchers understand the extent of a species' distribution and the degree of threat it may face due to habitat loss, fragmentation, or other factors. Conservation efforts often consider both EOO and AOO when evaluating the risk of extinction and planning conservation strategies for a species.