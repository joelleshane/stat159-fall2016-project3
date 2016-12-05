source("../functions/mse_function.R")
load("../../data/testing_ridge.RData")
library(hydroGOF)
library(testthat)
library(pls)

test_that( "MSE Test", {
  
  test_set <- read.csv(file = "../../data/test_data.csv")
  response = test_set$UNEMP_RATE
  length(response)
  length(test_ridge)
  func_answer = MSE(test_ridge, response)
  package_asnwer = mse(as.vector(test_ridge), response)
  expect_that(func_answer, equals(package_asnwer, tolerance = .1))
})

source("../functions/unemployment.R")

test_that( "Unemployment Test", {
	
	COUNT_NWNE_P6 <- c(1,2,3)
	COUNT_WNE_P6 <- c(4,4,8)
	df <- data.frame(COUNT_NWNE_P6, COUNT_WNE_P6)
	total <- COUNT_NWNE_P6 + COUNT_WNE_P6
	values <- COUNT_NWNE_P6 / total
	unemp_output = unemployment_six_years(df)
	expect_that(values, equals(unemp_output, tolerance = 0.1))
})



