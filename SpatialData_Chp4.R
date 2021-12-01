# Finding Relationships in R
# Run a Pearson's correlation test - linear relationship
# Run a Spearman's rank correlation test - non-linear relationship - large-scale ordinal variables
# Run a linear regression model

# Set the working directory and Load the data set
Census.Data <- read.csv("practical_data.csv")

# Bivariate Correlations

# Run a Pearson's correlation - coefficient (r)
cor(Census.Data$Unemployed, Census.Data$Qualification)

# Run a Pearson's correlation - coefficient (r) and significnace statistics
cor.test(Census.Data$Unemployed, Census.Data$Qualification)

# Run a Spearman's correlation
cor.test(Census.Data$Unemployed, Census.Data$Qualification,
         method = 'spearman')

# Create correlation matrix
data1 <- Census.Data[, 2:5]
round(cor(data1), 2)

# Create a heatmap of this correlation matrix
library(ggplot2)
library(reshape2)

qplot(x = Var1, y = Var2, data = melt(cor(data1, use = 'p')),
      fill=value, geom = 'tile') + scale_fill_gradient2(limits = c(-1, 1))

# Regression Analysis
model_1 <- lm(Census.Data$Qualification ~ Census.Data$Unemployed)
plot(Census.Data$Unemployed, Census.Data$Qualification, 
     xlab = '% Unemployed', 
     ylab = '% With a Qualification') + abline(model_1)
# summary() function to check the basic results from running the model
# intercept and slope: y = b0 + b1x + error
# R2 - this model can explain how much variance in Y
summary(model_1)

# Inference with regression - assume that the residuals are normally distributed
# confidence intervals for the estimated coefficients (intercept and slope)
confint(model_1, level = 0.95)

# Multiple regression - checking the relevance of competing explanations
# Run a model with two independent variables
model_2 <- lm(Census.Data$Qualification ~ Census.Data$Unemployed + 
                Census.Data$White_British)

# View the model summary
summary(model_2)

# Run a model with two independent variables - Best model in this case
model_3 <- lm(Census.Data$Qualification ~ Census.Data$Unemployed + 
                Census.Data$Low_Occupancy)

# View the model summary - R squared value: 0.58
summary(model_3)

# Run a model with two independent variables
model_4 <- lm(Census.Data$Qualification ~ Census.Data$White_British + 
                Census.Data$Low_Occupancy)

# View the model summary
summary(model_4)

# Run a model with three independent variables
model_5 <- lm(Census.Data$Qualification ~ Census.Data$White_British + 
                Census.Data$Low_Occupancy + Census.Data$Unemployed)

# View the model summary
summary(model_5)
