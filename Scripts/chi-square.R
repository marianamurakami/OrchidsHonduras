setwd('E:/Orchids_honduras/Inputs//')

df <- read.csv('means_displacement_status.csv')

df$Extinction <- ifelse(df$RCP2.6.Displaced == 1 | df$RCP8.5.Displaced == 1, "Yes", "No")
df$Extinction <- as.factor(df$Extinction)
df$HABITAT <- as.factor(df$HABITAT)

table(df$HABITAT)

# create a contingency table of extinction by habitat
ext_ct <- table(df$Extinct, df$HABITAT)

# perform chi-squared test
chi_test <- chisq.test(ext_ct)

# display the results
chi_test

