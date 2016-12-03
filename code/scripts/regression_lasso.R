#Beggining Lasso Regression

library("glmnet")
library("lars")

training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]

#Getting response and predictors
response <- training_data$UNEMP_RATE
response <- as.matrix(response)
predictors <- training_data[,-which(names(training_data) == "UNEMP_RATE")]
predictors <- as.matrix(predictors)

grid <- 10^seq(10, -2, length = 100)

set.seed(1)
lasso_model <- cv.glmnet(predictors, response, lambda = grid, alpha = 1, intercept = FALSE, standardize = FALSE)
lasso_coef <- coef(lasso_model, lasso_model$lambda.min)

save(lasso_coef,lasso_model, file = "../../data/lasso_model.RData")

png("../../images/CV_errors_lasso.png")
plot(lasso_model, main = "CV Errors Lasso")
dev.off()

test_data <- read.csv("../../data/test_data.csv")
test_data <- test_data[,-1]
test_predictors <- test_data[,-which(names(training_data) == "UNEMP_RATE")]
test_predictors <- as.matrix(test_predictors)
test_response <- test_data$UNEMP_RATE

predicted_response <- predict(lasso_model, newx=test_predictors, s = "lambda.min", type = "response")
predicted_response <- as.vector(predicted_response)

source("../functions/mse_function.R")
MSE_lasso <- MSE(predicted_response, test_response)
save(MSE_lasso, file = "../../data/MSE_lasso.RData")


scaled_data_2006 <- read.csv("../../data/scaled_data_2006.csv")
scaled_data_2006 <- scaled_data_2006[,-1]
total_response <- scaled_data_2006$UNEMP_RATE
total_response <- as.matrix(total_response)
total_predictors <- scaled_data_2006[,-which(names(training_data) == "UNEMP_RATE")]
total_predictors <- as.matrix(total_predictors)


full_lasso <- glmnet(total_predictors, total_response, lambda = lasso_model$lambda.min, alpha = 1, intercept = FALSE, standardize = FALSE)
full_coefficients <- coef(full_lasso)

save(full_coefficients, file = "../../data/full_coefficients_lasso.RData")


sink("../../data/lasso_model.txt")
print("model coefficients")
lasso_coef
print("prediction mse")
MSE_lasso
print("full model coefficients")
full_coefficients
sink()


########## Short Version ########## 


training_short_data <- read.csv("../../data/training_short_data.csv")
training_short_data <- training_short_data[,-1]

#Getting response and predictors
response_short <- training_short_data$UNEMP_RATE
response_short <- as.matrix(response)
predictors_short <- training_short_data[,-which(names(training_short_data) == "UNEMP_RATE")]
predictors_short <- as.matrix(predictors_short)

grid <- 10^seq(10, -2, length = 100)

set.seed(1)
lasso_short_model <- cv.glmnet(predictors_short, response_short, lambda = grid, alpha = 1, intercept = FALSE, standardize = FALSE)
lasso_short_coef <- coef(lasso_short_model, lasso_short_model$lambda.min)

save(lasso_short_coef,lasso_short_model, file = "../../data/lasso_short_model.RData")

png("../../images/CV_errors_lasso.png")
plot(lasso_short_model, main = "CV Short Errors Lasso")
dev.off()

test_short_data <- read.csv("../../data/test_short_data.csv")
test_short_data <- test_short_data[,-1]
test_short_predictors <- test_short_data[,-which(names(training_short_data) == "UNEMP_RATE")]
test_short_predictors <- as.matrix(test_short_predictors)
test_short_response <- test_short_data$UNEMP_RATE

predicted_short_response <- predict(lasso_short_model, newx=test_short_predictors, s = "lambda.min", type = "response")
predicted_short_response <- as.vector(predicted_short_response)

source("../functions/mse_function.R")
MSE_short_lasso <- MSE(predicted_short_response, test_short_response)


save(MSE_short_lasso, file = "../../data/MSE_short_lasso.RData")


scaled_short_data_2006 <- read.csv("../../data/scaled_short_data_2006.csv")
scaled_short_data_2006 <- scaled_short_data_2006[,-1]
total_short_response <- scaled_short_data_2006$UNEMP_RATE
total_short_response <- as.matrix(total_short_response)
total_short_predictors <- scaled_short_data_2006[,-which(names(training_short_data) == "UNEMP_RATE")]
total_short_predictors <- as.matrix(total_short_predictors)


full_short_lasso <- glmnet(total_short_predictors, total_short_response, lambda = lasso_short_model$lambda.min, alpha = 1, intercept = FALSE, standardize = FALSE)
full_short_coefficients <- coef(full_lasso)

save(full_short_coefficients, file = "../../data/full_short_coefficients_lasso.RData")


sink("../../data/lasso_short_model.txt")
print("model coefficients")
lasso_short_coef
print("prediction mse")
MSE_short_lasso
print("full model coefficients")
full_short_coefficients
sink()
