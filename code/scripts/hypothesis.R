### Hypothesis Testing

#### This files contains code to run hypothesis tests to see if different levels of funding have a significant impact on the quality of education.

### Reading in the data

data_2006 <- read.csv("../../data/data_2006.csv")
scaled <- read.csv("../../data/scaled_data_2006.csv")
test <- read.csv("../../data/test_data.csv")
train <- read.csv("../../data/training_data.csv")

### Breaking the data into groups dependent on how much federal funding the school/students enrolled at the school received
#### Independent Variable :
#### Percent of undergraduates recieving federal financial aid

lo <- data_2006$INC_PCT_LO
m1 <- data_2006$INC_PCT_M1
m2 <- data_2006$INC_PCT_M2
h1 <- data_2006$INC_PCT_H1
pct_fin <- lo + m1 + m2 + h1

#### Visualizing data to get a better idea of how to split it into groups

data_2006 <- cbind(data_2006, pct_fin)

png("../../images/percent_aided_students_hist.png")
hist(data_2006$pct_fin, breaks = 30, main = "Histogram of Financial Aid", xlab = "Percent of Students")
dev.off()

mysum <- summary(pct_fin)

save(mysum, file = "../../data/financial_aid_percentage.RData")

#### Splitting the data by percentage of federal financial aid recieved by students


low <- subset(data_2006, pct_fin >= 0.6 & pct_fin < 0.91)
low_mid <- subset(data_2006, pct_fin >= 0.91 & pct_fin < 0.96)
mid_high <- subset(data_2006, pct_fin >= 0.96 & pct_fin < 0.984)
high <- subset(data_2006, pct_fin >= 0.984 & pct_fin < 1)

#### Response Variable:
#### Unemployment Rate - Number of students not working and not enrolled 6 years after entry (COUNT_NWNE_P6 - row 1894 / COUNT_WNE_P6 - row 1895)

#### Getting rid of response variables that are non-numeric values and finding response variable


source("../functions/unemployment.R")

unemp_low <- unemployment_six_years(low)
low_mean <- mean(unemp_low)

unemp_low_mid <- unemployment_six_years(low_mid)
low_mid_mean <- mean(unemp_low_mid)

unemp_mid_high <- unemployment_six_years(mid_high)
mid_high_mean <- mean(unemp_mid_high)

unemp_high <- unemployment_six_years(high)
high_mean <- mean(unemp_high)

png("../../images/unemployment.png")
barplot(c(low_mean, low_mid_mean, mid_high_mean, high_mean), col = c("#DB71C3", "#49A8BE", "#C8A9D1", "#D11D56"), main = "Unemployment Rate by Aid Percentage", xlab = "Percentage of Students who Recieved Financial Aid", ylab = "Unemployment Rate Six Years after Entry", names.arg = c("Low", "Low-Middle", "Middle-High", "High"), cex.names = 0.6)
dev.off()


### Null hypothesis says all funding groups should have the same preformance 
 
### W(u) = (-.5, -.5, 0, .5, .5)
### 1/2(u1 + u2) = 1/2(u4 + u5)

### Response variable will be unemployment rate, making estimate of effect of funding on unemployment rate

estimate <- (.5*low_mean + .5*low_mid_mean) - (.5*mid_high_mean + .5*high_mean)


#### standard error = wi^2 * sum(var(mean of yi))
#### --> sigma^2 * sum(wi^2 / ni)

#### wi = -.5 if i = 1 or 2
#### wi = .5 if i = 3, 4

### Finding standard error of estimate


x <- c(unemp_low, unemp_low_mid, unemp_mid_high, unemp_high)
varx <- (var(x)) * (((.5^2)/length(unemp_low)) + 
                    ((.5^2)/length(unemp_low_mid)) +
                     ((.5^2)/length(unemp_mid_high)) +
                     ((.5^2)/length(unemp_high))
                     )

### Constructing confidence interval:

sink("../../data/CI_hyptest_1.txt")
noquote(paste("high end :", estimate + (1.96 * sqrt(varx)), sep = " "))
noquote(paste("low end :", estimate - (1.96*sqrt(varx)), sep = " "))
sink()