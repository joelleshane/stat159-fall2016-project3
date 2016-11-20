source("../functions/mse_function.R")
load("../../data/testing_ridge.RData")
require("hydroGOF")
require(testthat)

test_that( "MSE Test", {
  
  test_set <- read.csv(file = "../../data/test_data.csv")
  response = test_set$Balance
  length(response)
  length(test_ridge)
  func_answer = MSE(test_ridge, response)
  package_asnwer = mse(as.vector(test_ridge), response)
  expect_that(func_answer, equals(package_asnwer, tolerance = .1))
})





