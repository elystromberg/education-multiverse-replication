*==============================================================================*
* ESS DATA PREPARATION
*==============================================================================*

*** Project:				How Robust are Country Rankings in Educational Mobility?
*** Author:					Ely Strömberg & Per Engzell
*** Created: 				26-01-2022

*------------------------------------------------------*
* Set work directory
*------------------------------------------------------*

clear all





local ProjectDir "$MyProject"
cd "`ProjectDir'/data"
global DATA "$MyProject"

*------------------------------------------------------*
* Install packages
*------------------------------------------------------*
*ssc install gtools
*gtools, upgrade

	
*------------------------------------------------------*
* ESS round 1-9 data
*------------------------------------------------------*

// Append ESS waves 1-10 (2002-2018)
use 						"$DATA/data/source/ESS1e06_6.stata/ESS1e06_6.dta", clear
append using				"$DATA/data/source/ESS2e03_6.stata/ESS2e03_6.dta"
append using				"$DATA/data/source/ESS3e03_7.stata/ESS3e03_7.dta"
append using				"$DATA/data/source/ESS4e04_5.stata/ESS4e04_5.dta"
append using				"$DATA/data/source/ESS5e03_4.stata/ESS5e03_4.dta"
append using				"$DATA/data/source/ESS6e02_4.stata/ESS6e02_4.dta"
append using				"$DATA/data/source/ESS7e02_2.stata/ESS7e02_2.dta"
append using				"$DATA/data/source/ESS8e02_2.stata/ESS8e02_2.dta"
append using				"$DATA/data/source/ESS9e03_1.stata/ESS9e03_1.dta"
append using				"$DATA/data/source/ESS10/ESS10.dta", force
append using				"$DATA/data/source/ESS10SC/ESS10SC.dta", force


// Keep selection of variables
keep						name essround edition cntry idno brncntr ///
							gndr agea yrbrn ///
							eduyrs edulvla edulvlb edulvlfa edulvlma ///
							edulvlfb edulvlmb eisced eiscedf eiscedm


save						"$DATA/ESS_1-10_raw.dta", replace
use 						"$DATA/ESS_1-10_raw.dta", clear


*------------------------------------------------------*
* Recoding of variables
*------------------------------------------------------*							
// This section recodes the ESS variables in different ways to create a multitude
// of analytical choices
						

* Children's education
gen c_ed_30 = .
replace 					c_ed_30 = eduyrs if eduyrs <= 30

gen c_ed_25 = .
replace 					c_ed_25 = eduyrs if eduyrs <= 25



* Age
gen age2465 = .
replace 					age2465 = agea if (agea >= 24 & agea <= 65)

gen age2535 = .
replace 					age2535 = agea if (agea >= 25 & agea <= 35)

gen age2565 = .
replace 					age2565 = agea if agea >= 25 & agea <= 65

gen age2569 = .
replace 					age2569 = agea if agea >= 25 & agea <= 69

gen age2570 = .
replace 					age2570 = agea if agea >= 25 & agea <= 70

gen age2574 = .
replace 					age2574 = agea if agea >= 25 & agea <= 74

gen age25pl = .
replace 					age25pl = agea if agea >= 25 

gen age2746 = .
replace 					age2746 = agea if agea >= 27 & agea <= 46

gen age2747 = .
replace 					age2747 = agea if agea >= 27 & agea <= 47

gen age2855 = .
replace 					age2855 = agea if agea >= 28 & agea <= 55

gen age2933 = .
replace 					age2933 = agea if agea >= 29 & agea <= 33

gen age30pl = .
replace 					age30pl = agea if agea >= 30 



*******************************************************************************
* running other do-files
*******************************************************************************
save 						"$DATA/data/ESS_prep.dta", replace
use 						"$DATA/data/ESS_prep.dta", clear

do 							"$DATA/code/1.1_recode-edulvl-to-tyrsa.do"




*==============================================================================*
* Recode EISCED to categorical variables
* 
*==============================================================================*

**** Respondent

* Tertiary Y/N 
gen							eiscedter =.
label variable 				eiscedter "Whether completed tertiary education (EISCED V1-V2)"
label define				eiscedter 0 "no" 1 "yes"
label values 				eiscedter eiscedter	
replace 					eiscedter = 0 if inlist(eisced,1,2,3,4,5) 
replace						eiscedter = 1 if inlist(eisced,6,7)

* Secondary Y/N 
gen							eiscedsec =.
label variable 				eiscedsec "Whether completed secondary education (EISCED II-IV)"
label define				eiscedsec 0 "no" 1 "yes"
label values 				eiscedsec eiscedsec
replace 					eiscedsec = 0 if inlist(eisced,1) 
replace						eiscedsec = 1 if inlist(eisced,2,3,4,5)

* Categorical Y/N 
gen							eisced3 =.
label variable 				eisced3 "Educational level primary secondary tertiary (EISCED)"
label define				eisced3 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				eisced3 eisced3
replace 					eisced3 = 0 if inlist(eisced,1) 
replace						eisced3 = 1 if inlist(eisced,2,3,4,5)
replace						eisced3 = 2 if inlist(eisced,6,7)

**** Father

gen							eiscedterf =.
label variable 				eiscedterf "Whether father completed tertiary education (EISCED V1-V2)"
label define				eiscedterf 0 "no" 1 "yes"
label values 				eiscedterf eiscedterf	
replace 					eiscedterf = 0 if inlist(eiscedf,1,2,3,4,5) 
replace						eiscedterf = 1 if inlist(eiscedf,6,7)

* Secondary Y/N 
gen							eiscedsecf =.
label variable 				eiscedsecf "Whether father completed secondary education (EISCED II-IV)"
label define				eiscedsecf 0 "no" 1 "yes"
label values 				eiscedsecf eiscedsecf
replace 					eiscedsecf = 0 if inlist(eiscedf,1) 
replace						eiscedsecf = 1 if inlist(eiscedf,2,3,4,5)

* Categorical Y/N 
gen							eisced3f =.
label variable 				eisced3f "Educational level father primary secondary tertiary (EISCED)"
label define				eisced3f 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				eisced3f eisced3f
replace 					eisced3f = 0 if inlist(eiscedf,1) 
replace						eisced3f = 1 if inlist(eiscedf,2,3,4,5)
replace						eisced3f = 2 if inlist(eiscedf,6,7)

**** Mother

gen							eiscedterm =.
label variable 				eiscedterm "Whether mother completed tertiary education (EISCED V1-V2)"
label define				eiscedterm 0 "no" 1 "yes"
label values 				eiscedterm eiscedterm	
replace 					eiscedterm = 0 if inlist(eiscedm,1,2,3,4,5) 
replace						eiscedterm = 1 if inlist(eiscedm,6,7)

* Secondary Y/N 
gen							eiscedsecm =.
label variable 				eiscedsecm "Whether mother completed secondary education (EISCED II-IV)"
label define				eiscedsecm 0 "no" 1 "yes"
label values 				eiscedsecm eiscedsecm
replace 					eiscedsecm = 0 if inlist(eiscedm,1) 
replace						eiscedsecm = 1 if inlist(eiscedm,2,3,4,5)

* Categorical Y/N 
gen							eisced3m =.
label variable 				eisced3m "Educational level mother primary secondary tertiary (EISCED)"
label define				eisced3m 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				eisced3m eisced3m
replace 					eisced3m = 0 if inlist(eiscedm,1) 
replace						eisced3m = 1 if inlist(eiscedm,2,3,4,5)
replace						eisced3m = 2 if inlist(eiscedm,6,7)

* Parental 
* Dominant

* Dominant parental education
gen							eisced3pd =.
label variable 				eisced3pd "Highest parental education (EISCED)"
label define				eisced3pd 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				eisced3pd eisced3pd

replace eisced3pd = eisced3f if missing(eisced3m)
replace eisced3pd = eisced3m if missing(eisced3f)
replace eisced3pd = eisced3f if eisced3f>=eisced3m & !missing(eisced3f)
replace eisced3pd = eisced3m if eisced3m>=eisced3f & !missing(eisced3m)

* Any parent with tertiary education
gen							eiscedterpd =.
label variable 				eiscedterpd "Whether any parent completed tertiary education (EISCED V1-V2)"
label define				eiscedterpd 0 "no" 1 "yes"
label values 				eiscedterpd eiscedterpd

replace eiscedterpd = 0 if inlist(eisced3pd, 0, 1)
replace eiscedterpd = 1 if inlist(eisced3pd, 2)

* Any parent with secondary education
gen							eiscedsecpd =.
label variable 				eiscedsecpd "Whether any parent completed secondary education (EISCED II-IV)"
label define				eiscedsecpd 0 "no" 1 "yes"
label values 				eiscedsecpd eiscedsecpd

replace eiscedsecpd = 0 if inlist(eisced3pd, 0)
replace eiscedsecpd = 1 if inlist(eisced3pd, 1)







*==============================================================================*
* Recode edulvl to categorical variables
* 
*==============================================================================*

*------------------------------------------------------*
* Respondents' highest education
*------------------------------------------------------*

* Categorical variables ******************************************************************
* Highest level of education 3 categories
gen							edulvl3 =.
label variable 				edulvl3 "Highest level of education 3 categories (eduvlvl)"
label define				edulvl3 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				edulvl3 edulvl3


// 2002-2008: edulvla 	
replace 					edulvl3 = 0 if inlist(edulvla,1) & essround < 5
replace						edulvl3 = 1 if inlist(edulvla,2,3,4) & essround < 5
replace						edulvl3 = 2 if inlist(edulvla,5) & essround < 5

// 2010-2018: edulvlb
replace 					edulvl3 = 0 if inlist(edulvlb,113, 129) & essround > 4
replace						edulvl3 = 1 if inlist(edulvlb,212,213,221,222,223,229, ///
311,312,313,321,322,323,412,413,421,422,423) & essround > 4
replace						edulvl3 = 2 if inlist(edulvlb,510,520,610,620,710,720,800) & essround > 4




// Coding ISCED97 and ISCED11 into dummy variables representing Primary, 
// Secondary, and Tertiary education for respondents

* Secondary Y/N 
gen							edulvlsec =.
label variable 				edulvlsec "Whether completed secondary education (ISCED 2-4)"
label define				edulvlsec 0 "no" 1 "yes"
label values 				edulvlsec edulvlsec


// 2002-2008: edulvla 	
replace 					edulvlsec = 0 if inlist(edulvla,1,5,6) & essround < 5
replace						edulvlsec = 1 if inlist(edulvla,2,3,4) & essround < 5


// 2010-2018: edulvlb
replace 					edulvlsec = 0 if edulvlb < 5555 & essround > 4
replace						edulvlsec = 1 if inlist(edulvlb,212,213,221,222,223,229, ///
311,312,313,321,322,323,412,413,421,422,423) & essround > 4

* Tertiary Y/N 
gen							edulvlter =.
label variable 				edulvlter "Whether completed tertiary education (ISCED 5-6)"
label define				edulvlter 0 "no" 1 "yes"
label values 				edulvlter edulvlter


// 2002-2008: edulvla 	
replace 					edulvlter = 0 if inlist(edulvla,1,2,3,4) & essround < 5
replace						edulvlter = 1 if edulvla == 5 & essround < 5


// 2010-2018: edulvlb
replace 					edulvlter = 0 if edulvlb < 5555 & essround > 4
replace						edulvlter = 1 if inlist(edulvlb,510,520,610,620,710,720,800) & essround > 4



*------------------------------------------------------*
* Parents' education
*------------------------------------------------------*
* Categorical variables ******************************************************************
* Father's highest level of education 3 categories 
gen							edulvl3f =.
label variable 				edulvl3f "Father's highest level of education 3 categories (eduvlvl)"
label define				edulvl3f 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				edulvl3f edulvl3f


// 2002-2008: edulvla 	
replace 					edulvl3f = 0 if inlist(edulvlfa,1) & essround < 5
replace						edulvl3f = 1 if inlist(edulvlfa,2,3,4) & essround < 5
replace						edulvl3f = 2 if inlist(edulvlfa,5) & essround < 5

// 2010-2018: edulvlb
replace 					edulvl3f = 0 if inlist(edulvlfb,113, 129) & essround > 4
replace						edulvl3f = 1 if inlist(edulvlfb,212,213,221,222,223,229, ///
311,312,313,321,322,323,412,413,421,422,423) & essround > 4
replace						edulvl3f = 2 if inlist(edulvlfb,510,520,610,620,710,720,800) & essround > 4


* Father's tertiary attainment Y/N 
gen							edulvlterf =.
label variable 				edulvlterf "Whether father completed tertiary education (ISCED 5-6)"
label define				edulvlterf 0 "no" 1 "yes"
label values 				edulvlterf edulvlterf

replace						edulvlterf = 0 if inlist(edulvl3f,0,1)
replace						edulvlterf = 1 if inlist(edulvl3f,2)

* Mother's highest level of education 3 categories 
gen							edulvl3m =.
label variable 				edulvl3m "Mother's highest level of education 3 categories (eduvlvl)"
label define				edulvl3m 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				edulvl3m edulvl3m



// 2002-2008: edulvla 	
replace 					edulvl3m = 0 if inlist(edulvlma,1) & essround < 5
replace						edulvl3m = 1 if inlist(edulvlma,2,3,4) & essround < 5
replace						edulvl3m = 2 if inlist(edulvlma,5) & essround < 5

// 2010-2018: edulvlb
replace 					edulvl3m = 0 if inlist(edulvlmb,113, 129) & essround > 4
replace						edulvl3m = 1 if inlist(edulvlmb,212,213,221,222,223,229, ///
311,312,313,321,322,323,412,413,421,422,423) & essround > 4
replace						edulvl3m = 2 if inlist(edulvlmb,510,520,610,620,710,720,800) & essround > 4

* Mother's tertiary attainment Y/N 
gen							edulvlterm =.
label variable 				edulvlterm "Whether mother completed tertiary education (ISCED 5-6)"
label define				edulvlterm 0 "no" 1 "yes"
label values 				edulvlterm edulvlterm

replace						edulvlterm = 0 if inlist(edulvl3m,0,1)
replace						edulvlterm = 1 if inlist(edulvl3m,2)

* Dominant parental level of education 3 categories 
gen							edulvl3pd =.
label variable 				edulvl3pd "Highest level of education of any parent 3 categories (eduvlvl)"
label define				edulvl3pd 0 "Primary education" 1 "Secondary education" 2 "Tertiary education"
label values 				edulvl3pd edulvl3pd


replace 					edulvl3pd = edulvl3f if missing(edulvl3m)
replace 					edulvl3pd = edulvl3m if missing(edulvl3f)
replace 					edulvl3pd = edulvl3f if edulvl3f>=edulvl3m & !missing(edulvl3f)
replace 					edulvl3pd = edulvl3m if edulvl3m>=edulvl3f & !missing(edulvl3m)

* Dominant parental tertiary attainment Y/N 
gen							edulvlterpd =.
label variable 				edulvlterpd "Whether any parent completed tertiary education (ISCED 5-6)"
label define				edulvlterpd 0 "no" 1 "yes"
label values 				edulvlterpd edulvlterpd

replace						edulvlterpd = 0 if inlist(edulvl3pd,0,1)
replace						edulvlterpd = 1 if inlist(edulvl3pd,2)

*==============================================================================*
* Recode to Standardized Educational attainment
*==============================================================================*

* Variables: c_eduyrs in c_ed_30 c_ed_25 yrisced eduyrs11a eduyrsh yriscedd eduyrs11pda eduyrshpd yrisceda eduyrs11pda eduyrshpa yriscedf eduyrs11fa eduyrshf yriscedm eduyrs11ma eduyrshm

egen cntrygndr=group(cntry gndr)

foreach var in c_ed_30 c_ed_25 tyrsa tyrspda tyrspaa tyrsfa tyrsma  {

	// bysort cntrygndr: egen "z`var'" = std(`var')

	gen z`var' = .
	levelsof cntrygndr, local(l)
	foreach k of local l {
	egen tmp = std(`var') if cntrygndr==`k'
	replace z`var' = tmp if !missing(tmp)
	drop tmp
	}

}



*==============================================================================*
* Recode to Relative Educational attainment gquantiles
*==============================================================================*

* Recode educational attainment to relative measure using gquantiles
* make sure to have gtools installed

* respondent 
gquantiles qgeduyrs25 = c_ed_25, xtile nq(100) by(cntry)
gquantiles qgeduyrs30 = c_ed_30, xtile nq(100) by(cntry)
gquantiles qgtyrsa = tyrsa, xtile nq(100) by(cntry)
* parent

gquantiles qgtyrsfa = tyrsfa, xtile nq(100) by(cntry)
gquantiles qgtyrsma = tyrsma, xtile nq(100) by(cntry)
gquantiles qgtyrspda = tyrspda, xtile nq(100) by(cntry)
gquantiles qgtyrspaa = tyrspaa, xtile nq(100) by(cntry)




*==============================================================================*
* Save ready dataset
*==============================================================================*

//save data ready for modeling
save						"$DATA/data/ESS_1-10_rdy.dta", replace
use							"$DATA/data/ESS_1-10_rdy.dta", clear



