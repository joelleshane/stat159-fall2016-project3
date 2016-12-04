library("glmnet")
library("lars")
library("MASS")

training_data <- read.csv(file = "../../data/training_data.csv")
training_data <- training_data[,-1]

#formatting response and predictors 
response <- training_data$UNEMP_RATE #Log of median income
response <- as.matrix(response)
predictors <- training_data[,-which(names(training_data) == "UNEMP_RATE")]  #everythning but median income
predictors <- as.matrix(predictors)


grid <- 10^seq(10, -2, length = 100)
set.seed(100)
ridge_model <- cv.glmnet(x = predictors, y = response, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)
ridge_coef <- coef(ridge_model, ridge_model$lambda.min)

#saving coefficients of the model
save(ridge_coef, ridge_model, file = "../../data/ridge_model.RData")



#Adding Histograms to Images
png('../../images/CV_Errors_Ridge.png')
plot(ridge_model, main = "CV Errors Ridge")
dev.off()


test_set <- read.csv(file = "../../data/test_data.csv")
response = test_set$UNEMP_RATE
test_set <- test_set[,-1]
test_set <- test_set[,-which(names(training_data) == "UNEMP_RATE")] 
test_predictors = as.matrix(test_set)

test_ridge <- predict(ridge_model, newx = test_predictors, s = "lambda.min", type="response")
save(test_ridge,file =  "../../data/testing_ridge.RData")

source("../functions/mse_function.R")
MSE_ridge = MSE(test_ridge, response)

save(MSE_ridge, file = "../../data/MSE_ridge.RData" )

full_data <- read.csv(file = "../../data/scaled_data_2006.csv")
full_data <- full_data[,-1]

response <- full_data$UNEMP_RATE #median income
response <- as.matrix(response)
predictors <- full_data[,-which(names(training_data) == "UNEMP_RATE")]  #everythning but median income
predictors <- as.matrix(predictors)

#rerunning model on the full data set
full_ridge = glmnet(x = predictors, y = response, intercept = FALSE, standardize = FALSE, lambda = ridge_model$lambda.min, alpha = 0)

#getting coefficients and saving
full_ridge_coef <- coef(full_ridge)
save(full_ridge_coef, file = "../../data/full_coeffecients_ridge.RData")  

#saving data from this model to a txt file
sink(file = "../../data/ridge_model.txt")
print("Coefficients for the Ridge Model")
ridge_coef
print("MSE for the Ridge Model")
MSE_ridge
print("Coefficients for the model run on the full data set")
full_ridge_coef
sink()



########## Short Ridge ########## 


training_short_data <- read.csv(file = "../../data/training_short_data.csv")
training_short_data <- training_short_data[,-1]

#formatting response and predictors 
response_short <- training_short_data$UNEMP_RATE #Log of median income
response_short <- as.matrix(response_short)
predictors_short <- training_short_data[,-which(names(training_short_data) == "UNEMP_RATE")]  #everythning but median income
predictors_short <- as.matrix(predictors_short)


grid <- 10^seq(10, -2, length = 100)
set.seed(100)
ridge_short_model <- cv.glmnet(x = predictors_short, y = response_short, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)
ridge_short_coef <- coef(ridge_short_model, ridge_short_model$lambda.min)

#saving coefficients of the model
save(ridge_short_coef, ridge_short_model, file = "../../data/ridge_short_model.RData")



#Adding Histograms to Images
png('../../images/CV_Errors_short_Ridge.png')
plot(ridge_short_model, main = "CV Errors Ridge")
dev.off()


test_short_data <- read.csv(file = "../../data/test_short_data.csv")
response_short = test_short_data$UNEMP_RATE
test_short_data <- test_short_data[,-1]
test_short_data <- test_short_data[,-which(names(training_short_data) == "UNEMP_RATE")] 
test_short_predictors = as.matrix(test_short_data)

test_short_ridge <- predict(ridge_short_model, newx = test_short_predictors, s = "lambda.min", type="response")
save(test_short_ridge,file =  "../../data/testing_short_ridge.RData")

source("../functions/mse_function.R")
MSE_short_ridge = MSE(test_short_ridge, response_short)

save(MSE_short_ridge, file = "../../data/MSE_short_ridge.RData" )

full_short_data <- read.csv(file = "../../data/scaled_short_data_2006.csv")
full_short_data <- full_short_data[,-1]

response_short <- full_short_data$UNEMP_RATE #median income
response_short <- as.matrix(response_short)
predictors_short <- full_short_data[,-which(names(full_short_data) == "UNEMP_RATE")]  #everythning but median income
predictors_short <- as.matrix(predictors_short)

#rerunning model on the full data set
full_short_ridge = glmnet(x = predictors_short, y = response_short, intercept = FALSE, standardize = FALSE, lambda = ridge_short_model$lambda.min, alpha = 0)

#getting coefficients and saving
full_short_ridge_coef <- coef(full_short_ridge)
save(full_short_ridge_coef, file = "../../data/full_short_coeffecients_ridge.RData")  

#saving data from this model to a txt file
sink(file = "../../data/ridge_short_model.txt")
print("Coefficients for the Ridge Model")
ridge_short_coef
print("MSE for the Ridge Model")
MSE_short_ridge
print("Coefficients for the model run on the full data set")
full_short_ridge_coef
sink()

