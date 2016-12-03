#######################
# EDA
#######################

#stat 159 final project (Group: The Lefties + 1)

#data_2006_full <- read.csv("~/Desktop/data/MERGED2005_06_pp.csv")
#read in data
data_2006_full <- read.csv("../../data/MERGED2005_06_pp.csv")

for (i in 1:ncol(data_2006_full)) {
  if (is.factor(data_2006_full[,i]) == TRUE) {
    data_2006_full[,i] <- as.numeric(levels(data_2006_full[,i]))[data_2006_full[,i]]
  }
}


#####################
# Plots
#####################

png(file="../../images/histogram_unemp.png")
hist(data_2006_full$UNEMP_RATE, main ="Unemployment Rates (2006)", xlab ="Unemployment Rate", breaks=20)
dev.off()

png(file="../../images/histogram_avgfacsal.png")
hist(data_2006_full$AVGFACSAL, main = "Average Faculty Salary (2006)", xlab="Salary in US Dollars", breaks=25)
dev.off()


png(file="../../images/histogram_highdeg.png")
hist(data_2006_full$HIGHDEG, main = "Highest Degree Awarded (2006)", xlab="ff")
dev.off()


png(file="../../images/histogram_inexpfte.png")
hist(data_2006_full$INEXPFTE, main = "Instructional expenditures per full-time equivalent student (2006)", xlab="US Dollars", breaks=25)
dev.off()


png(file="../../images/histogram_tuitionfee_in.png")
hist(data_2006_full$TUITIONFEE_IN, main = "In-State Tuition and Fees (2006)", xlab="US Dollars", breaks=25)
dev.off()

png(file="../../images/histogram_c150_4.png")
hist(data_2006_full$C150_4, main = "Completion Rate For First-Time, Full-Time Students (2006)", xlab="Four Year Institutions", breaks=20)
dev.off()

png(file="../../images/histogram_c150_l4.png")
hist(data_2006_full$C150_L4, main = "Completion Rate For First-Time, Full-Time Students (2006)", xlab="Less than Four Year Institutions", breaks=20)
dev.off()

png(file="../../images/histogram_ret_ft4.png")
hist(data_2006_full$RET_FT4, main = "First-time, full-time students retention rate (2006)", xlab="Four Year Institutions", breaks=20)
dev.off()


png(file="../../images/histogram_pell_comp_orig_yr2_rt.png")
hist(data_2006_full$PELL_COMP_ORIG_YR2_RT, main = "% of Students who Receive a Pell Grant(2006)", xlab="Completed within 2 Years", breaks=20)
dev.off()

png(file="../../images/histogram_pell_comp_orig_yr3_rt.png")
hist(data_2006_full$PELL_COMP_ORIG_YR3_RT, main = "% of Students who Receive a Pell Grant(2006)", xlab="Completed within 3 Years", breaks=20)
dev.off()

png(file="../../images/histogram_pell_comp_orig_yr4_rt.png")
hist(data_2006_full$PELL_COMP_ORIG_YR4_RT, main = "% of Students who Receive a Pell Grant(2006)", xlab="Completed within 4 Years", breaks=20)
dev.off()

png(file="../../images/histogram_cdr2.png")
hist(data_2006_full$CDR2, main = "Two-year Cohort Default Rate(2006)", xlab="Rate", breaks=25)
dev.off()



#####################
# Summary Statistics
#####################


sink("../../data/eda-output-summarystats.txt")

print("Summary Statistics of Unemployment Rate")
summary(data_2006_full$UNEMP_RATE)
sd(data_2006_full$UNEMP_RATE)

print("Summary Statistics of Average Faculty Salary")
summary(data_2006_full$AVGFACSAL)
sd(data_2006_full$AVGFACSAL)

print("Summary Statistics of Highest Degree Awarded")
summary(data_2006_full$HIGHDEG)
sd(data_2006_full$HIGHDEG)


print("Summary Statistics of Instructional expenditures per full-time equivalent student")
summary(data_2006_full$INEXPFTE)
sd(data_2006_full$INEXPFTE)


print("Summary Statistics of In-State Tuition and Fees")
summary(data_2006_full$TUITIONFEE_IN)
sd(data_2006_full$TUITIONFEE_IN)


print("Summary Statistics of Completion Rate For First-Time, Full-Time Students at four year institutions")
summary(data_2006_full$C150_4)
sd(data_2006_full$C150_4)

print("Summary Statistics of Completion Rate For First-Time, Full-Time Students at less than 4 year institutions")
summary(data_2006_full$C150_L4)
sd(data_2006_full$C150_L4)


print("Summary Statistics of First-time, full-time students retention rate")
summary(data_2006_full$RET_FT4)
sd(data_2006_full$RET_FT4)

print("Summary Statistics of % of Students who Receive a Pell Grant and Completed within 2 Years")
summary(data_2006_full$PELL_COMP_ORIG_YR2_RT)
sd(data_2006_full$PELL_COMP_ORIG_YR2_RT)

print("Summary Statistics of % of Students who Receive a Pell Grant and Completed within 3 Years")
summary(data_2006_full$PELL_COMP_ORIG_YR3_RT)
sd(data_2006_full$PELL_COMP_ORIG_YR3_RT)

print("Summary Statistics of % of Students who Receive a Pell Grant and Completed within 4 Years")
summary(data_2006_full$PELL_COMP_ORIG_YR4_RT)
sd(data_2006_full$PELL_COMP_ORIG_YR4_RT)


print("Summary Statistics of Two-Year Cohort Default Rate")
summary(data_2006_full$CDR2)
sd(data_2006_full$CDR2)

sink()

########################
# Matrix of Correlation
########################

#this  doen't work lol

quant_vars <- data.frame(data_2006_full$UNEMP_RATE, data_2006_full$AVGFACSAL, data_2006_full$INEXPFTE, data_2006_full$TUITIONFEE_IN, data_2006_full$C150_4, data_2006_full$RET_FT4,  data_2006_full$PELL_COMP_ORIG_YR2_RT, data_2006_full$PELL_COMP_ORIG_YR3_RT, data_2006_full$PELL_COMP_ORIG_YR4_RT, data_2006_full$CDR2)
matofcor <- cor(quant_vars)


sink("../../data/eda-output-matofcorr.txt")
matofcor
sink()


########################
# Scatterplot Matrix
########################

png(file="../../images/scatterplot-matrix.png")
pairs(quant_vars, pch=".", main="Scatterplot Matrix")
dev.off()


########################
# ANOVA
########################


anova_2006 <- aov(UNEMP_RATE~AVGFACSAL+INEXPFTE+TUITIONFEE_IN+C150_4+RET_FT4+PELL_COMP_ORIG_YR2_RT+PELL_COMP_ORIG_YR3_RT+PELL_COMP_ORIG_YR4_RT+CDR2, data=data_2006_full)

sum_anova <- summary(anova_2006)

sink("../../data/eda-output-anova.txt")
sum_anova
sink()

