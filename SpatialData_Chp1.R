# Spatial Data Analysis in R

# Set the working directory
setwd("C:/JianingHe/Learning Materials/Spatial Data Analysis in R/Camden")

# Load data from csv files
Ethnicity <-read.csv("tables/KS201EW_oa11.csv")
Rooms <- read.csv("tables/KS403EW_oa11.csv")
Qualifications <- read.csv("tables/KS501EW_oa11.csv")
Employment <- read.csv("tables/KS601EW_oa11.csv")

# Viewing the top 1000 cases of a data frame
View(Employment)

# Viewing column names of a data frame
names(Employment)

# Selecting specific columns with required data 
Employment <- Employment[, c(1, 20)]
Rooms <- Rooms[, c(1, 13)]
Ethnicity <- Ethnicity[, c(1, 21)]
Qualifications <- Qualifications[, c(1, 20)]

# Changing both column names
names(Ethnicity) <- c("OA", "White_British")
names(Rooms) <- c("OA", "Low_Occupancy")
names(Employment) <- c("OA", "Unemployed")
names(Qualifications) <- c("OA", "Qualification")

# Joining data - Merge two data sets each time by "OA" to create a new data object
merged_data_1 <- merge(Ethnicity, Rooms, by="OA")
merged_data_2 <- merge(merged_data_1, Employment, by="OA")
Census.Data <- merge(merged_data_2, Qualifications, by="OA")

# Removing the "merged_data" objects those are not needed
rm(merged_data_1, merged_data_2)

# Exporting data to a csv file name "practical_data"
write.csv(Census.Data, "practical_data.csv", row.names = F)