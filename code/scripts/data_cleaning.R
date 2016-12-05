#Beginning data cleaning

data_2006 <- read.csv("../../data/MERGED2005_06_PP.csv")

for (i in 1:ncol(data_2006)) {
  if (is.factor(data_2006[,i]) == TRUE) {
    data_2006[,i] <- as.numeric(levels(data_2006[,i]))[data_2006[,i]]
  }
}

data_short_2006 <- data_2006[,c("UNEMP_RATE", "INEXPFTE", "TUITIONFEE_IN", "AVGFACSAL", "C150_4", "C150_L4", "RET_FT4", "PELL_COMP_ORIG_YR2_RT", "PELL_COMP_ORIG_YR3_RT", "PELL_COMP_ORIG_YR4_RT", "CDR2")]

write.csv(data_short_2006, file = "../../data/data_short_2006.csv")


##### remove columns with less than 50% of data missing

data_2006 <- data_2006[, colSums(is.na(data_2006)) <= .5 * nrow(data_2006)]

data_2006 <- data_2006[,c(-1,-2,-3)]

write.csv(data_2006, file = "../../data/data_2006.csv")

##### scaling and mean centering data

scaled_data_2006 <- scale(data_2006, center = TRUE, scale = TRUE)
scaled_data_2006 <- cbind( data_2006[, c(1,2)], scaled_data_2006[,c(-1,-2)])

for(i in 1:ncol(scaled_data_2006)){
  scaled_data_2006[is.na(scaled_data_2006[,i]), i] <- median(scaled_data_2006[,i], na.rm = TRUE)
}

scaled_data_2006 <- scaled_data_2006[, colSums(is.na(scaled_data_2006)) <= .5 * nrow(scaled_data_2006)]

write.csv(scaled_data_2006, file = "../../data/scaled_data_2006.csv")

##### scaling and mean centering short data

scaled_short_data_2006 <- scale(data_short_2006, center = TRUE, scale = TRUE)
scaled_short_data_2006 <- cbind( data_short_2006[, c(1,2)], scaled_short_data_2006[,c(-1,-2)])

for(i in 1:ncol(scaled_short_data_2006)){
  scaled_short_data_2006[is.na(scaled_short_data_2006[,i]), i] <- median(scaled_short_data_2006[,i], na.rm = TRUE)
}

scaled_short_data_2006 <- scaled_short_data_2006[, colSums(is.na(scaled_short_data_2006)) <= .5 * nrow(scaled_short_data_2006)]

write.csv(scaled_short_data_2006, file = "../../data/scaled_short_data_2006.csv")
