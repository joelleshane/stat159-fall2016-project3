# Purpose of this file: Find the variables we want to use as predictors for post graduation income
# This helps with dimension reduction and reducing the risk of multicollinearity

require(pls)
set.seed (1000)

# We will begin our analysis on 2015 data 

full_2015 <- read.csv("../../data/MERGED2014_15_PP.csv")
training_data <- read.csv("../../data/training_data.csv")
post_earning <- read.csv("../../data/post_earning.csv")

#I will run PCA on a couple different potential predictors to test out different parameters and find the predictor I want to use
#The predictor will be part of the dataset unemprate

#unemployment rate
pcr_model <- pcr(UNEMP_RATE~., data = training_data, scale = TRUE, validation = "CV")

summary(pcr_model)
validationplot(pcr_model)
predplot(pcr_model)
coefplot(pcr_model)


#now testing our model on the test-data


test_data <- read.csv("../../data/test_data.csv")

#need to figure out how many components, look at validation plot
pcr_pred <- predict(pcr_model, test_data, ncomp = 90)

#error, test accuracy
mse_pca <- mean((pcr_pred - test_data["UNEMP_RATE"])^2)




#LN_MEDIAN_HH_INC - Log of the median household income

#Other data we considered trying to model
#MN_EARN_WNE_P10 - Mean earnings of students working and not enrolled 10 years after entry
#GT_25K_P7 Share of students earning over $25,000/year (threshold earnings) 7 years after entry
#GT_25K_P6 Share of students earning over $25,000/year (threshold earnings) 6 years after entry
#MN_EARN_WNE_INC3_P10 Mean earnings of students working and not enrolled 10 years after entry in the highest income tercile $75,001+
