scaled_data_2006 <- read.csv("../../data/scaled_data_2006.csv")

scaled_short_data_2006 <- read.csv("../../data/scaled_short_data_2006.csv")

set.seed(1)
training_data <- scaled_data_2006[sample(nrow(scaled_data_2006), round(.75 * nrow(scaled_data_2006))),]
training_data <- training_data[,-1]

write.csv(training_data, file = "../../data/training_data.csv")

set.seed(1)
training_short_data <- scaled_short_data_2006[sample(nrow(scaled_short_data_2006), round(.75 * nrow(scaled_short_data_2006))),]
training_short_data <- training_short_data[,-1]

write.csv(training_short_data, file = "../../data/training_short_data.csv")

set.seed(1)
test_data <- scaled_data_2006[-sample(nrow(scaled_data_2006), round(.75 * nrow(scaled_data_2006))),]
test_data <- test_data[,-1]

write.csv(test_data, file = "../../data/test_data.csv")

set.seed(1)
test_short_data <- scaled_short_data_2006[-sample(nrow(scaled_short_data_2006), round(.75 * nrow(scaled_short_data_2006))),]
test_short_data <- test_short_data[,-1]

write.csv(test_short_data, file = "../../data/test_short_data.csv")
