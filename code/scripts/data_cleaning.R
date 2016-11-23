setwd("/Users/toddvogel/Documents/Senior Year/Stat 159/stat159-fall2016-project3/code/scripts")

data_2015 <- read.csv("../../data/MERGED2014_15_PP.csv")

for (i in 1:ncol(data_2015)) {
  if (is.factor(data_2015[,i]) == TRUE) {
    data_2015[,i] <- as.numeric(levels(data_2015[,i]))[data_2015[,i]]
  }
}

##### remove columns with greater than 50% of data missing

data_2015 <- data_2015[, colSums(is.na(data_2015)) <= .5 * nrow(data_2015)]

##### scaling and mean centering data

scaled_data_2015 <- scale(data_2015, center = TRUE, scale = TRUE)
scaled_data_2015 <- cbind( data_2015[, c(1,2)], scaled_data_2015[,c(-1,-2)])

for(i in 1:ncol(scaled_data_2015)){
  scaled_data_2015[is.na(scaled_data_2015[,i]), i] <- median(scaled_data_2015[,i], na.rm = TRUE)
}

write.csv(scaled_data_2015, file = "../../data/scaled_data_2015.csv")
