scaled_data_2006 <- read.csv("../../data/scaled_data_2006.csv")


set.seed(1)
training_data <- scaled_data_2006[sample(nrow(scaled_data_2006), round(.75 * nrow(scaled_data_2006))),]
sort(training_data$X)
training_data <- training_data[,-1]

write.csv(training_data, file = "../../data/training_data.csv")

set.seed(1)
test_data <- scaled_data_2006[-sample(nrow(scaled_data_2006), round(.75 * nrow(scaled_data_2006))),]
test_data <- test_data[,-1]

write.csv(test_data, file = "../../data/test_data.csv")