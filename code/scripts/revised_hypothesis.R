#### This file contains a revised hypothesis test that controls for some potentially confounding factors in the first hypothesis test

### Reading in the data

data_2006 <- read.csv("../../data/data_2006.csv")
load("../../data/data_by_finaid.RData")

#### Visualizing data to get a better idea of how to split it into groups

data_2006$AVGFACSAL <- as.numeric(as.character(data_2006$AVGFACSAL))
data_2006 <- subset(data_2006, data_2006$AVGFACSAL != TRUE)

png("../../images/fac_sal_hist.png")
hist(as.numeric(data_2006$AVGFACSAL), breaks = 50, main = "Histogram of Faculty Salary", xlab = "Monthly Faculty Salary")
dev.off()

a <- summary(data_2006$AVGFACSAL)
save(a, file = "../../data/faculty_salaries.RData")

### Grouping by average faculty salary

mid <- rbind(low_mid, mid_high)

LFLS <- subset(low, low$AVGFACSAL < 4500)
MFLS <- subset(mid, mid$AVGFACSAL < 4500)
HFLS <- subset(high, high$AVGFACSAL < 4500)

LFMS <- subset(low, low$AVGFACSAL >= 4500 & low$AVGFACSAL < 6000)
MFMS <- subset(mid, mid$AVGFACSAL >= 4500 & mid$AVGFACSAL < 6000)
HFMS <- subset(high, high$AVGFACSAL >= 4500 & high$AVGFACSAL < 6000)

LFHS <- subset(low, low$AVGFACSAL >= 6000)
MFHS <- subset(mid, mid$AVGFACSAL >= 6000)
HFHS <- subset(high, high$AVGFACSAL >= 6000)

#### Response Variable:
#### Unemployment Rate - Number of students not working and not enrolled 6 years after entry (COUNT_NWNE_P6 - row 1894 / COUNT_WNE_P6 - row 1895)

#### Getting rid of response variables that are non-numeric values and finding response variable


source("../functions/unemployment.R")

#Within Low Faculty Salary -- comparing different funding levels and unemployment rates

unemp_LFLS <- unemployment_six_years(LFLS)
LFLS_mean <- mean(unemp_LFLS)

unemp_MFLS <- unemployment_six_years(MFLS)
MFLS_mean <- mean(unemp_MFLS)

unemp_HFLS <- unemployment_six_years(HFLS)
HFLS_mean <- mean(unemp_HFLS)

#Within Medium Faculty Salary -- comparing different funding levels and unemployment rates

unemp_LFMS <- unemployment_six_years(LFMS)
LFMS_mean <- mean(unemp_LFMS)

unemp_MFMS <- unemployment_six_years(MFMS)
MFMS_mean <- mean(unemp_MFMS)

unemp_HFMS <- unemployment_six_years(HFMS)
HFMS_mean <- mean(unemp_HFMS)

#Within High Faculty Salary -- comparing different funding levels and unemployment rates

unemp_LFHS <- unemployment_six_years(LFHS)
LFHS_mean <- mean(unemp_LFHS)

unemp_MFHS <- unemployment_six_years(MFHS)
MFHS_mean <- mean(unemp_MFHS)

unemp_HFHS <- unemployment_six_years(HFHS)
HFHS_mean <- mean(unemp_HFHS)

LS <- c(LFLS_mean, MFLS_mean, HFLS_mean)
MS <- c(LFMS_mean, MFMS_mean, HFMS_mean)
HS <- c(LFHS_mean, MFHS_mean, HFHS_mean)
counts <- matrix(c(LS, MS, HS), nrow = 3, ncol = 3)

png("../../images/funding.png")
barplot(height = counts, col = c("darkblue", "red", "purple"), beside = TRUE, main = "Bar Plot of Unemployment Rate", names.arg = c("Low", "Medium", "High"), xlab = "Average Faculty Salary", ylab = "Unemployment Rate", ylim = c(0, 0.18))
legend("topright", legend = c("Low Funding", "Medium Funding", "High Funding"), fill = c("darkblue", "red", "purple"), cex = 0.5)
dev.off()


### Response variable will be unemployment rate, making estimate of effect of funding on unemployment rate
### 1/2(u1 + u2) = u3

estimate_LS <- (.5*LFLS_mean + .5*MFLS_mean) - HFLS_mean

estimate_MS <- (.5*LFMS_mean  + .5*MFMS_mean) - HFMS_mean

estimate_HS <- (.5*LFHS_mean + .5*MFHS_mean) - HFHS_mean


#### standard error = wi^2 * sum(var(mean of yi))
#### --> sigma^2 * sum(wi^2 / ni)

#### wi = -.5 if i = 1 or 2
#### wi = 1 if i = 3

### Finding standard error of estimate


x_LS <- c(unemp_LFLS, unemp_MFLS, unemp_HFLS)
                     
varx_LS <- var(x_LS) * (((.5^2)/length(unemp_LFLS)) +
                      ((.5^2)/length(unemp_MFLS)) +
                          (1/length(unemp_HFLS)))
                     
x_MS <- c(unemp_LFMS, unemp_MFMS, unemp_HFMS)
varx_MS <- var(x_MS) * (((.5^2)/length(unemp_LFMS)) + 
                    ((.5^2)/length(unemp_MFMS)) +
                     (1/length(unemp_HFMS)))
                     
x_HS <- c(unemp_LFHS, unemp_MFHS, unemp_HFHS)
varx_HS <- (var(x_HS)) * (((.5^2)/length(unemp_LFHS)) + 
                    ((.5^2)/length(unemp_MFHS)) +
                     (1/length(unemp_HFHS)))
                     
save(estimate_LS, estimate_MS, estimate_HS, varx_LS, varx_MS, varx_HS, file = "../../data/rev_hyp_results.RData")

### Constructing confidence interval:

sink("../../data/CI_hyptest_revised.txt")
paste("Low Faculty Salary Estimate of Funding Effect")
noquote(paste("high end :", estimate_LS + (1.96 * sqrt(varx_LS)), sep = " "))
noquote(paste("low end :", estimate_LS - (1.96*sqrt(varx_LS)), sep = " "))
paste("Medium Faculty Salary Estimate of Funding Effect")
noquote(paste("high end :", estimate_MS + (1.96 * sqrt(varx_MS)), sep = " "))
noquote(paste("low end :", estimate_MS - (1.96*sqrt(varx_MS)), sep = " "))
paste("High Faculty Salary Estimate of Funding Effect")
noquote(paste("high end :", estimate_HS + (1.96 * sqrt(varx_HS)), sep = " "))
noquote(paste("low end :", estimate_HS - (1.96*sqrt(varx_HS)), sep = " "))
sink()