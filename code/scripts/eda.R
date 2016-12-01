#######################
# EDA
#######################

#read in data
data_2006 <- read.csv("../../data/data_2006.csv")

#use median to replace NA values
for(i in 1:ncol(data_2006)){
  data_2006[is.na(data_2006[,i]), i] <- median(data_2006[,i], na.rm = TRUE)
}


#####################
# Plots
#####################

png(file="../../images/histogram-unemp.png")
hist(data_2006$UNEMP_RATE, main ="Unemployment Rates (2006)", xlab ="Unemployment Rate", breaks=20)
dev.off()

png(file="../../images/histogram-avgfacsal.png")
hist(data_2006$AVGFACSAL, main = "Average Faculty Salary (2006)", xlab="Salary in US Dollars", breaks=25)
dev.off()


#####################
# Summary Statistics
#####################


sink("../../data/eda-output.txt")

print("Summary Statistics of Unemployment Rate")
summary(data_2006$UNEMP_RATE)
sd(data_2006$UNEMP_RATE)

print("Summary Statistics of Average Faculty Salary")
summary(data_2006$AVGFACSAL)
sd(data_2006$AVGFACSAL)

print("Summary Statistics of Thousands of Dallars Spent on Radio Advertising")
summary(ad$Radio)

print("Summary Statistics of Thousands of Dallars Spent on Newspaper Advertising")
summary(ad$Newspaper)

print("Matrix of Correlation")
cor(data.frame(ad[2:5]))

sink()
