#Phony targets
.PHONY: all
.PHONY: tests
.PHONY: eda
.PHONY: pca
.PHONY: regressions
.PHONY: report
.PHONY: slides
.PHONY: session
.PHONY: clean
.PHONY: data
.PHONY: documentation
.PHONY: shiny
.PHONY: dataclean
.PHONY: hypothesis
.PHONY: open_slides

#make a data phony
all:
	make data
	make eda
	make regressions
	make tests
	make slides
	make hypothesis
	make report
	make session
	make shiny

#all regression models
regressions:
	make model
	make pca
	
#runnings the scripts
eda:
	cd code/scripts && Rscript eda_script.R
model:
	cd code/scripts && Rscript regression_lasso.R
	cd code/scripts && Rscript regression_ridge.R
pca:
	cd code/scripts && Rscript pca_analysis.R
hypothesis:
	cd code/scripts && Rscript hypothesis.R
	cd code/scripts && Rscript revised_hypothesis.R


	
#session info
session:
	bash session.sh
		
	
#getting all data files and getting training and test sets
dataset = data/dataset.zip
scorecard = data/scorecard.csv
recent = data/recent.csv
new_NSLDS = data/new_NSLDS.csv
post_earnings = data/post_earning.csv
clean_data = data/test_data.csv


#Now running Make
data: dataset scorecard recent new_NSLDS post_earnings dataclean	  
	
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
	
dataclean:
	cd code/scripts; Rscript data_cleaning.R
	cd code/scripts; Rscript data_separation.R
	
#The documentation such as the data dictionary	
documentation:
	curl -o documentation/introduction.pdf https://collegescorecard.ed.gov/assets/BetterInformationForBetterCollegeChoiceAndInstitutionalPerformance.pdf
	curl -o documentation/federal_info.pdf https://collegescorecard.ed.gov/assets/UsingFederalDataToMeasureAndImprovePerformance.pdf
	curl -o documentation/data_dict.csv https://collegescorecard.ed.gov/assets/CollegeScorecardDataDictionary-10-26-2016.xlsx
	curl -o documentation/data_report.pdf https://collegescorecard.ed.gov/assets/FullDataDocumentation.pdf
	

#creating the report - depends on running the regression
main = report.pdf
combined = report.Rmd

report: $(main)
report.pdf: $(combined)
	cd report; R -e "rmarkdown::render(\"report.Rmd\", \"all\")"
report.Rmd:
	cd report; cat sections/*.Rmd > $@

#creating the slides
slides:
	cd slides && R -e "rmarkdown::render('slides.Rmd')"

#cleaning the report
clean:
	rm report/report.*
	rm slides/slides.html
	rm session-info.txt
	
#Shiny, run this last
shiny:
	cd shiny && Rscript -e 'library(shiny);shiny::runApp("./", launch.browser=TRUE)'
	

#testing
test:
	cd code/tests; Rscript -e 'library(testthat); test_file("all_tests.R")'


######### NOTES #########
#remove any data that you end up not using to save time for new people, don't want to #download everthing 
#need to download file "MERGED2005_2006_PP.csv" for (data_cleaning.R)


######### Extra commands ##########

clean_all:
	rm -r images/*
	rm report/report.*
	rm slides/slides.html
	rm session-info.txt
	
clean_slides:
	rm slides/slides.html
	
open_slides:
	open slides/slides.html
	



