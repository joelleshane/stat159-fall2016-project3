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

