# Statistics 159 Project 3
Authors: Abby Vogel, Bryan Alcorn, Joelle Shane, Todd Vogel

## Project Structure:

```
	code/
		functions/
		scripts/
		tests/
	data/
	images/
	report/
	shiny/
	slides/
	
```

The directory `code/` contains 

The directory `data/` contains the data set used for this project and the test and training data sets made for data analysis.

The directory `images/` contains image output from the scripts. These are stored in *.pdf* format.

The directory `report/` contains the .Rnw file that compiles the report in both .pdf and .html formats.

The directory `shiny/` contains 

The directory `slides/` contains the .Rmd file that produces an html file including a presentation that summarized the methods, data, and results of the project.

## Instructions for Reproducing this project:

After cloning and downloading the contents of this github repository, run the Makefile to reproduce the report. The Makefile will download the dataset, clean the data, run scripts that perform data analysis, and generate a report, shiny app, and slides with the results.

## Make commands for phony targets:

`all` : 

`data` : downloads the data set and saves it as () in the data folder.

`tests` : runs test of the functions

`eda` : runs the script responsible for the exploratory data analysis

`report` : generates report.pdf and report.html

`slides` : produces slides.html

`session` : creates session_info.txt

`clean` : deletes the report.pdf and report.html files


## Licenses
