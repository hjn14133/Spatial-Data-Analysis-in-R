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