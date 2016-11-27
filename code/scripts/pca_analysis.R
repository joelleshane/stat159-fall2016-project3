# Purpose of this file: Find the variables we want to use as predictors for post graduation income
# This helps with dimension reduction and reducing the risk of multicollinearity

require(pls)
set.seed (1000)

# We will begin our analysis on 2015 data 

full_2015 <- read.csv("../../data/MERGED2014_15_PP.csv")
training_data <- read.csv("../../data/training_data.csv")
post_earning <- read.csv("../../data/post_earning.csv")

#I will run PCA on a couple different potential predictors to test out different parameters and find the predictor I want to use
#The predictor will be part of the dataset unemprate

#unemployment rate
pcr_model <- pcr(UNEMP_RATE~., data = full_2015, scale = TRUE, validation = "CV")

summary(pcr_model)
validationplot(pcr_model)
predplot(pcr_model)
coefplot(pcr_model)

# Mean earnings of students working and not enrolled 10 years after entry in the highest income tercile $75,001+ (MN_EARN_WNE_INC3_P10)
# MN_EARN_WNE_INC3_P10


#GT_25K_P6 Share of students earning over $25,000/year (threshold earnings) 6 years after entry

#GT_25K_P7 Share of students earning over $25,000/year (threshold earnings) 7 years after entry


#LN_MEDIAN_HH_INC - Log of the median household income

#MN_EARN_WNE_P10 - Mean earnings of students working and not enrolled 10 years after entry


####### NOTES ########

df1 = data.frame(CustomerId=c(1:10),
                 Hobby = c(rep("sing", 4), rep("pingpong", 3), rep("hiking", 3)),
                 Product=c(rep("Toaster",3),rep("Phone", 2), rep("Radio",3), rep("Stereo", 2)))

df2 = data.frame(CustomerId=c(2,4,6, 8, 10),State=c(rep("Alabama",2),rep("Ohio",1),   rep("Cal", 2)),
                 like=c("sing", 'hiking', "pingpong", 'hiking', "sing"))

df3 = merge(df1, df2, by.x=c("CustomerId", "Hobby"), by.y=c("CustomerId", "like"))
