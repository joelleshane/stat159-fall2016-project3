training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]

library("glmnet")
library("lars")

response <- training_data$LN_MEDIAN_HH_INC
response <- as.matrix(response)
predictors <- training_data[,-which(names(training_data) == "LN_MEDIAN_HH_INC")]
predictors <- as.matrix(predictors)

grid <- 10^seq(10, -2, length = 100)

set.seed(1)
lm.lasso <- cv.glmnet(predictors, response, lambda = grid, alpha = 1, intercept = FALSE, standardize = FALSE)
bestmodel_lasso <- coef(lm.lasso, lm.lasso$lambda.min)

lasso_model <- lm.lasso
save(bestmodel_lasso,lasso_model, file = "../../data/lasso_model.RData")

png("../../images/CV_errors_lasso.png")
plot(lm.lasso, main = "CV Errors Lasso")
dev.off()

test_data <- read.csv("../../data/test_data.csv")
test_data <- test_data[,-1]
test_predictors <- test_data[,-which(names(training_data) == "LN_MEDIAN_HH_INC")]
test_predictors <- as.matrix(test_predictors)
test_response <- test_data$LN_MEDIAN_HH_INC

predicted_response <- predict(lm.lasso, newx=test_predictors, s = "lambda.min", type = "response")
predicted_response <- as.vector(predicted_response)

source("../functions/mse_function.R")
lasso_mse <- MSE(predicted_response, test_response)


save(lasso_mse, file = "../../data/MSE_lasso.RData")


scaled_data_2006 <- read.csv("../../data/scaled_data_2006.csv")
scaled_data_2006 <- scaled_data_2006[,-1]
total_response <- scaled_data_2006$LN_MEDIAN_HH_INC
total_response <- as.matrix(total_response)
total_predictors <- scaled_data_2006[,-which(names(training_data) == "LN_MEDIAN_HH_INC")]
total_predictors <- as.matrix(total_predictors)


full.lasso <- glmnet(total_predictors, total_response, lambda = lm.lasso$lambda.min, alpha = 1, intercept = FALSE, standardize = FALSE)
full_coefficients <- coef(full.lasso)

save(full_coefficients, file = "../../data/full_coefficients_lasso.RData")


sink("../../data/lasso_model.txt")
print("model coefficients")
bestmodel_lasso
print("prediction mse")
lasso_mse
print("full model coefficients")
full_coefficients
sink()
