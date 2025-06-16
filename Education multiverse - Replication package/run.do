**********************
* OVERVIEW
*   This script generates tables and figures for the paper:
*   "How Robust are Country Rankings in Educational Mobility?" (by Ely Stromberg & Per Engzell)
*   All raw data are stored in /data
*   All tables and figures are outputted to /out
*
* SOFTWARE REQUIREMENTS
*   Analyses run on Windows using Stata version 16 and R-4.2.2
*
* TO PERFORM A CLEAN RUN, DELETE THE FOLLOWING FOLDER:
*   /out
**********************

* User must uncomment the following line ("global ...") and set the filepath equal to the folder containing this run.do file 
global MyProject "YOUR WORKING DIRECTORY HERE"
local ProjectDir "$MyProject"

* Confirm that the globals for the project root directory have been defined
cap assert !mi("`ProjectDir'")
if _rc {
	noi di as error "Error: need to define the global in run.do"
	error 9
}

* Initialize log
clear
set more off
cap mkdir "`ProjectDir'/code/logs"
cap log close
local datetime : di %tcCCYY.NN.DD!-HH.MM.SS `=clock("$S_DATE $S_TIME", "DMYhms")'
local logfile "`ProjectDir'/code/logs/`datetime'.txt"
log using "`logfile'", text

* Configure Stata's library environment and record system parameters
*run "`ProjectDir'/code/programs/_config.do"

* R packages can be installed manually (see README) or installed automatically by uncommenting the following line
* if "$DisableR"!="1" rscript using "$MyProject/code/programs/_install_R_packages.R"

* Stata and R version control
version 15


* Create directories for output files
cap mkdir "`ProjectDir'/out"


* Run project analysis
do "`ProjectDir'/code/1_ESS_data_prep.do"
do "`ProjectDir'/code/2A_Continuous_models.do"
do "`ProjectDir'/code/2B_Correlation_models.do"
do "`ProjectDir'/code/2C_Categorical_models.do"
do "`ProjectDir'/code/2D_Positional_models.do"
do "`ProjectDir'/code/2E_Unidiff_models.do"
do "`ProjectDir'/code/3_Desctab.do"
do "`ProjectDir'/code/5_Rank_stability"

* End log
di "End date and time: $S_DATE $S_TIME"
log close

** EOF