#Phony targets
.PHONY: all
.PHONY: tests
.PHONY: eda
.PHONY: ols
.PHONY: ridge
.PHONY: lasso
.PHONY: pcr
.PHONY: plsr
.PHONY: regressions
.PHONY: report
.PHONY: slides
.PHONY: session
.PHONY: clean
.PHONY: data
.PHONY: analysis
.PHONY: documentation

#make a data phony
all:
	make data
	make eda
	make regressions
	make tests
	make slides
	make report
	make session

#all regression models
regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr
	make analysis
	
	
#session info
session:
	bash session.sh
	cd code/scripts; Rscript session-info.R
	
	
#getting all data files
data: data/dataset.zip data/scorecard.csv data/recent.csv data/new_NSLDS.csv data/post_earning.csv
	
data/dataset.zip:
	curl -o data/dataset.zip "https://ed-public-download.apps.cloud.gov/downloads/CollegeScorecard_Raw_Data.zip"
	unzip data/dataset.zip -d ./data
	unzip data/Crosswalks_20160908.zip
	
data/scorecard.csv:
	curl -o data/scorecard.csv "https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Scorecard-Elements.csv"
	
data/recent.csv:
	curl -o data/recent.csv "https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-All-Data-Elements.csv"
	
data/new_NSLDS.csv:
	curl -o data/new_NSLDS.csv "https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-NSLDS-Elements.csv"
	
data/post_earning.csv:
	curl -o data/post_earning.csv "https://ed-public-download.apps.cloud.gov/downloads/Most-Recent-Cohorts-Treasury-Elements.csv"
	
	
	


documentation:
	curl -o documentation/introduction.pdf https://collegescorecard.ed.gov/assets/BetterInformationForBetterCollegeChoiceAndInstitutionalPerformance.pdf
	curl -o documentation/federal_info.pdf https://collegescorecard.ed.gov/assets/UsingFederalDataToMeasureAndImprovePerformance.pdf
	curl -o documentation/data_dict.csv https://collegescorecard.ed.gov/assets/CollegeScorecardDataDictionary-10-26-2016.xlsx
	curl -o documentation/data_report.pdf https://collegescorecard.ed.gov/assets/FullDataDocumentation.pdf



#remove any data that you end up not using to save time for new people, don't want to download everything
#need to download data file “MERGED2005_06_PP.csv” (data_cleaning.R)
