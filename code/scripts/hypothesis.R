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


### Null hypothesis says all funding groups should have the same preformance 
 
### W(u) = (-.5, -.5, 0, .5, .5)
### 1/2(u1 + u2) = 1/2(u4 + u5)

### Response variable will be unemployment rate, making estimate of effect of funding on unemployment rate

estimate <- (.5*mean(low$) + .5*mean(low_mid$)) - (.5*mean(mid_high$) + .5*mean(high$))


standard error = wi^2 * sum(var(mean of yi))
 --> sigma^2 * sum(wi^2 / ni)

wi = -1 if i = 1
wi = 1/3 if i = 3, 4 or 5

### Finding standard error of estimate


x <- c(low$score, low_mid$score, mid_high$score, high$score)
varx <- (var(x)) * (((.5^2)/length(low$) + 
                    ((.5^2)/length(low_mid$)) +
                     ((.5^2)/length(mid_high$)) +
                     ((.5^2)/length(high$))
                     )



estimate - 0 / sqrt(varx) -- > 
estimate/sqrt(varx)

#### two-tailed t-test at 5% significance level with 39 degrees of freedom

length(c(low$, low_mid$, mid_high$, high$)) - 4 --> ~2.33


### Constructing confidence interval:

estimate + (2.33 * sqrt(varx))
estimate - (2.33*sqrt(varx))

plot