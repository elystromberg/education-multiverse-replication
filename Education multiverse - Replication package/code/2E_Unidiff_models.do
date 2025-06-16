*==============================================================================*
* Multiverse of continuous models calculating rank correlation coefficients 
*==============================================================================*

*** Project:				How Robust are Country Rankings in Educational Mobility?
*** Author:					Ely Strömberg & Per Engzell
*** Created: 				25-07-2023

*------------------------------------------------------*
* Set work directory
*------------------------------------------------------*

clear all


local ProjectDir "$MyProject"
cd "`ProjectDir'/data"
global DATA "$MyProject"

*------------------------------------------------------*
* Load data
*------------------------------------------------------*

use 						"ESS_1-10_rdy.dta", clear
keep edulvl3 edulvl3f edulvl3m edulvl3pd ///
eisced3 eisced3f eisced3m eisced3pd ///
age2465 age2535 age2565 age2569 age2570 age2574 age25pl age2746 ///
age2747 age2855 age2933 age30pl brncntr cntry gndr
 
compress
save 						"ESS_1-10_udiff.dta", replace
use 						"ESS_1-10_udiff.dta"

* Sample selection and numeric country variable 
gen tmp = 0
foreach c in "BE" "CH" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "HU" "IE" "NL" "NO" "PL" "SE" "SI" {
	replace tmp=1 if cntry=="`c'"
}

keep if tmp
drop tmp

encode cntry, gen(country)

*******************************************************************************
* Setting up and running the multiverse analysis
********************************************************************************

matrix m = .,.,.,.,.,.,.,.,.,.

local rrr 0

* Setting respondent educational variables
scalar aa = 0
	foreach c_educ in edulvl3 eisced3 { 
		scalar aa = aa + 1

* Setting dominance, the choice here should define the varlist in the next loop
scalar bb = 0
	foreach par_meas in "edulvl3pd eisced3pd" "edulvl3f eisced3f" "edulvl3m eisced3m" {  
		scalar bb = bb + 1
		
* Setting parental variables, the varlist should depend on previous loop
scalar cc = 0 
	foreach p_educ in `par_meas' { 
		scalar cc = cc + 1

* Setting age restriction
scalar dd = 0
	foreach c_age in age2465 age2535 age2565 age2569 age2570 age2574 age25pl age2746 age2747 age2855 age2933 age30pl { 
		scalar dd = dd + 1

* Setting exclusion/inclusion of foreign born respondents
scalar ee = 0
	foreach brnfrg in "" "& brncntr == 1" { 
		scalar ee = ee + 1

* Setting respondent gender
scalar ff = 0
	foreach gender in "1" "2"  { 
		scalar ff = ff + 1 

* Run unidiff model with country as layer
capture udiff `c_educ' `p_educ' i.country if !missing(`c_age') `brnfrg' & gndr== `gender'

local ++rrr
display `rrr'
if _rc!=0 {
	matrix m = m \ ., ., aa, bb, cc, dd, ee, ff, ., .
}

else if _rc==1 {
		continue, break
}

else {

mat b = e(b)'
mat b = b[1..16,1]

* Loop over countries
scalar gg = 0
	foreach country in "BE" "CH" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "HU" "IE" "NL" "NO" "PL" "SE" "SI" { 
		scalar gg = gg + 1
		count if cntry == "`country'" & !missing(`c_age') `brnfrg' & gndr== `gender'
		scalar nn = r(N)

		if "`country'" == "BE" {
				matrix jj = ., aa, bb, cc, dd, ee, ff, gg, nn
				}
		else {
				matrix jj = jj \ ., aa, bb, cc, dd, ee, ff, gg, nn
				}

}

matrix kk = b, jj
matrix m = m \ kk

}

}
}
}
}
}
}

* Move matrix to data
clear 
svmat m
drop in 1
save						"models_unidiff.dta", replace
use							"models_unidiff.dta", clear

*------------------------------------------------------*
* Label data 
*------------------------------------------------------*

label data "This file contains multiverse results for unidiff models"

label variable m1 "Coefficient estimate"
label variable m2 "Standard error"
label variable m3 "Respondent educational variable"
label variable m4 "Parental source of educational variable"
label variable m5 "Parental educational variable"
label variable m6 "Age restriction"
label variable m7 "Exclusion/inclusion of foreign born respondents"
label variable m8 "Gender"
label variable m9 "Country"
label variable m10 "Number of observations (N) per country"

label define var3 1 "ISCED 3 categories"
label values m3 var3

label define var4 1 "Dominant" 2 "Father" 3 "Mother"
label values m4 var4

label define var5 1 "Parental theoretical education" // CORRECT? 
label values m5 var5

label define var6 1 "24-65" 2 "25-35" 3 "25-65" 4 "25-69" 5 "25-70" ///
6 "25-74" 7 "25+" 8 "27-46" 9 "27-47" 10 "28-55" 11 "29-33" 12 "30+"
label values m6 var6

label define var7 1 "Included" 2 "Excluded"
label values m7 var7

label define var8 1 "Men" 2 "Women"
label values m8 var8

label define var9 1 "BE" 2 "CH" 3 "DE" 4 "DK" 5 "EE" 6 "ES" 7 "FI" ///
8 "FR" 9 "UK" 10 "HU" 11 "IE" 12 "NL" 13 "NO" 14 "PL" 15 "SE" 16 "SI"
label values m9 var9

save						"models_unidiff_raw.dta", replace
use							"models_unidiff_raw.dta", clear

*------------------------------------------------------*
* Rank models
*------------------------------------------------------*

* Create idmodno as an model-id
egen idmodno = concat(m3 m4 m5 m6 m7 m8), punct(,)
encode idmodno, generate(idmodnr)
label drop idmodnr

* Standardized coefficient estimates
*egen std = std(m1), by(idmodnr)

gen std = .
levelsof idmodnr, local(l)
 foreach k of local l {
 egen tmp = std(m1) if idmodnr==`k'
 replace std = tmp if !missing(tmp)
 drop tmp
 }

* Generate country variable
gen cntry=""
local i =1
foreach c in "BE" "CH" "DE" "DK" "EE" "ES" "FI" "FR" "UK" "HU" "IE" "NL" "NO" "PL" "SE" "SI" {
	replace cntry = "`c'" if m9==`i'
	local ++i
}

* Remove models where one country has less than 500 observations
gen rem = 0
replace rem = 1 if missing(m1) | m10<500
egen nbad = total(rem==1), by(idmodnr)
drop if nbad

* Create variable rank for each model
bysort idmodno: egen rank = rank(m1)

drop idmodno rem nbad

save							"models_unidiff.dta", replace
