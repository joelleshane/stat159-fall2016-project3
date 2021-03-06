# Purpose of this file: Use PCA 
# This helps with dimension reduction and reducing the risk of multicollinearity


#Begin Analysis on the training data
training_data <- read.csv("../../data/training_data.csv")
training_data <- training_data[,-1]


#unemployment rate, this is our first indicator of a successful college
set.seed (1000)
pca<- prcomp(training_data, center = TRUE, scale. = FALSE)

#note that the first component contains all the variance pca this means all the variance in the data is explained in the first principal component
plot(pca, type = "l")
summary(pca)

#All the data goes to the first component, no dimensionality reduction is useful 


#for principal component regression
require(pls) 

set.seed (1000)
pcr_model <- pcr(UNEMP_RATE~., data = training_data, scale = TRUE, validation = "CV")

ncomp_pcr <- which(pcr_model$validation$PRESS == min(pcr_model$validation$PRESS)) #selects components with best model
pcr_coef <- coef(pcr_model)
save(pcr_coef,pcr_model, file = "../../data/pcr_model.RData")


predplot(pcr_model)
coefplot(pcr_model)

#Adding Histograms to Images
png('../../images/CV_Errors_pcr.png')
validationplot(pcr_model, val.type = "MSEP")
dev.off()


#Test Data
test_data <- read.csv("../../data/test_data.csv")
test_data <- test_data[,-1]


#need to figure out how many components, look at validation plot
pcr_pred <- predict(pcr_model, test_data, ncomp = 90)
response <- test_data["UNEMP_RATE"]
response <- as.matrix(response)

#error, test accuracy
source("../functions/mse_function.R")
MSE_pcr = MSE(pcr_pred, response)
save(MSE_pcr, file = "../../data/MSE_pcr.RData")


#saving  the important stuff
sink(file = "../../data/pcr_model.txt")
print("The PCR model")
pcr_coef
print("applied predictors")
pcr_pred
print("The PCR MSE")
MSE_pcr
sink()


######### SHORT VERSION ##########

#Begin Analysis on the short training data
training_short_data <- read.csv("../../data/training_short_data.csv")
training_short_data <- training_short_data[,-1]

#for principal component regression

set.seed (1000)
pcr_short_model <- pcr(UNEMP_RATE~., data = training_short_data, scale = TRUE, validation = "CV")

ncomp_short_pcr <- which(pcr_short_model$validation$PRESS == min(pcr_short_model$validation$PRESS)) #selects components with best model
pcr_short_coef <- coef(pcr_short_model)
save(pcr_short_coef, pcr_short_model, file = "../../data/pcr_short_model.RData")


predplot(pcr_short_model)
coefplot(pcr_short_model)

#Adding Histograms to Images
png('../../images/CV_Errors_pcr.png')
validationplot(pcr_short_model, val.type = "MSEP")
dev.off()


#Test Data
test_short_data <- read.csv("../../data/test_short_data.csv")
test_short_data <- test_short_data[,-1]

#need to figure out how many components, look at validation plot
pcr_short_pred <- predict(pcr_short_model, test_short_data, ncomp = length(pcr_short_coef))
response_short <- test_short_data["UNEMP_RATE"]

response_short <- as.matrix(response_short)

#error, test accuracy
source("../functions/mse_function.R")
MSE_short_pcr = MSE(pcr_short_pred, response_short)
save(MSE_short_pcr, file = "../../data/MSE_short_pcr.RData")


#saving  the important stuff
sink(file = "../../data/pcr_short_model.txt")
print("The PCR model")
pcr_short_coef
print("applied predictors")
pcr_short_pred
print("The PCR MSE")
MSE_short_pcr
sink()



