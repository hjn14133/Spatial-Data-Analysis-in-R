# Bivariate Plots in R
# Simple scatter plots, symbols plots and plots in ggplot package

# Set the working directory and Load the data set
Census.Data <- read.csv("practical_data.csv")

# create a simple scatter plot - plot(x, y), plotting symbols (pch)
plot(Census.Data$Unemployed, Census.Data$Qualification,
     xlab = '% in full time employment',
     ylab = '% with a Qualification',
     pch = 19)

# create a symbols plot - create a proportional symbols plot
# Adding a third variable as the size dependent variable
symbols(Census.Data$Unemployed, Census.Data$Qualification,
        circles = Census.Data$White_British,
        xlab = '% in full time employment',
        ylab = '% with a Qualification',
        fg = 'white', bg = 'purple', inches = 0.2)

# Adding a regression line, set the color to red using abline() function
# line type (lty) and line width (lwd)
abline(lm(Census.Data$Qualification~ Census.Data$Unemployed), col = 'red')

# load "ggplot2" library
library('ggplot2')

# simple scatter plots using ggplots
p <- ggplot(Census.Data, aes(Unemployed, Qualification))
p + geom_point()

# bubble plots using ggplots
p <- ggplot(Census.Data, aes(Unemployed, Qualification))
p + geom_point(aes(colour = White_British, size = Low_Occupancy))