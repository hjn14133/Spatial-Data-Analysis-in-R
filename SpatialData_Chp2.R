# Data Exploration in R: R is case sensitive

# Load the data set
Census.Data <- read.csv("practical_data.csv")

# print the data within the console
print(Census.Data)

# Descriptive Statistics - $ sign
mean(Census.Data$Unemployed)
median(Census.Data$Unemployed)
range(Census.Data$Unemployed)

# summary function - mean, median, 25th and 75th quartiles, min, max
summary(Census.Data)

# Univariate plots - the distribution of a particular variable
# Histograms, Boxplots (summary), violin plots
# Create a Histogram
hist(Census.Data$Unemployed, breaks = 20, col = 'blue',
     main = '% in full-time employment', xlab = 'Percentage')

# Create boxplots (box and whisker plots) to compare four main variables
boxplot(Census.Data[, 2:5])

# load vioplot package to create violin plots for 4 variables in 3 shades of blue
library(vioplot)
vioplot(Census.Data$Unemployed, Census.Data$Qualification, 
        Census.Data$White_British, Census.Data$Low_Occupancy,
        ylim=c(0, 100), 
        col = 'dodgerblue', rectCol = 'dodgerblue3', colMed = 'dodgerblue4',
        names = c("Unemployed", "Qualification", "White British", "Occupancy")
        )