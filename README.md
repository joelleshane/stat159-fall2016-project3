# Statistics 159 Project 3
Authors: Abby Vogel, Bryan Alcorn, Joelle Shane, Todd Vogel

## Project Structure:

```
	code/
		functions/
		scripts/
		tests/
	data/
	documentation/
	images/
	report/
	shiny/
	slides/
	
```

The directory `code/` contains scripts for running the bulk of the statistical analysis, functions used, and tests

The directory `data/` contains the data set used for this project and the test and training data sets made for data analysis.

The directory `images/` contains image output from the scripts. These are stored in *.pdf* format.

The directory `report/` contains the .Rnw file that compiles the report in both .pdf and .html formats.

The directory `shiny/` contains 

The directory `slides/` contains the .Rmd file that produces an html file including a presentation that summarized the methods, data, and results of the project.

The directory `documentation/` contains documentation from teh college scorecard website that contains more in depth information about the data

## Instructions for Reproducing this project:

Clone: `git remote add origin https://github.com/joelleshane/stat159-fall2016-project3.git`

After cloning and downloading the contents of this github repository, run `make all` from the root directory of the project to reproduce the report. The Makefile will download the dataset, clean the data, run scripts that perform data analysis, and generate a report, shiny app, and slides with the results.\

NOTE: run `make all` in the terminal wherever it was pulled from git

##### The Process of the Makefile

1. Get the data, all of it in case the user wants to run more, this could take a long time
2. Clean the data
3. Exploratory data analysis
4. Running models
5. Running tests on our functions used in the models
6. Creating an isoslides presentation, just open the html file in the slides folder to view this or run the phony target `make open_slides`
7. Creates the report for viewing our findings and our wirteup about the findings
8. Creates the sessions to view the versions used in creating this project
9. Runs the shiny app, this will be the last thing that is run and the terminal wil display an http website to enter into a browser


##### Using the shiny

Open a web browser and enter in the website URL. This points to a local location on your machine since the command is run through the terminal and the app hosted on the local machine. To exit out in the terminal, run `Control + C`

* the way the script is set up, it wil automatically laungh it in the browser, but the location will not close until the user exits the application from the terminal

##### To get data:

run `make data`to pull add data from the college scorecard. This is useful if you want to run our project on different years. Simple change the data used in make seperation to try the analysis on different years. This will not completely work since the data vaies year to year, but other variables could be used in place. 

## Make commands for phony targets:

`all` : runs all make targets, run this from stratch

`data` : downloads the data set and saves it as () in the data folder.

`tests` : runs test of the functions

`eda` : runs the script responsible for the exploratory data analysis

`report` : generates report.pdf and report.html

`slides` : produces slides.html

`session` : creates session_info.txt containing all version information and package information

`clean` : deletes the report.pdf and report.html files

`shiny` : creates the app to run in a web browser

`documentation` : pulls the documentation from college scorecard

`dataclean` : cleans the data and produces the test and training data sets on the 2006 data after filling the NA values with the median

`regression` : this calls the `pca` and `modelling` phony target which runs the models and produces .RData files and txt files containing the results from the models

`hypothesis` : runs hypothesis testing on the full 2006 data and outputs the results

`open_slides` : opens the isoslides


## Licenses

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.