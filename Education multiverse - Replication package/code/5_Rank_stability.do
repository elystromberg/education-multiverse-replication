clear 


local ProjectDir "$MyProject"
cd "`ProjectDir'"
global DATA "$MyProject"


********************************************
* Stability plots for global rankings 
********************************************

* Set theme
ssc install SCHEME_TUFTE
set scheme tufte

* Select outcome variable: rank (rank) or coefficient (m1)
global outcome rank // m1
* Select estimation: linear (regress) or ordered (ologit)
global est regress // ologit - need to change global rsq e(r2) to e(r2_p)
global rsq e(r2)

* Load data and do some cleaning
clear 


local ProjectDir "$MyProject"
cd "`ProjectDir'"
global DATA "$MyProject"


local val = 0
foreach para in reg corr odds unidiff pos {
	local ++val
	append using "data/models_`para'.dta"
	cap gen para = .
	replace para = `val' if missing(para)
	
}

drop m5 // Parental educational variable: only relevant for log odds
label variable para "Parameter"
label variable m3 "Education variable"
label variable m4 "Which parent?"
label variable m6 "Age restriction"
label variable m7 "Foreign born incl?"
label variable m8 "Gender"

* Now run the models and collect estimates
gen lab = ""
gen r2 = .

local k = 1
qui $est $outcome i.m9
replace lab = "Baseline" in `k'
replace r2 = ${rsq} in `k'

* Contribution is lower for all other model ingredients
foreach var of varlist para m3-m8 { 
	local ++k
	local lab: variable label `var'
	replace lab = "`lab'" in `k'

	qui $est $outcome i.m9##i.`var'
	replace r2 = ${rsq} in `k'
	}

	
* Clean up and plot the estimates
keep lab r2
keep if !missing(r2)

gen tmp = r2 if lab !="Baseline"
sort tmp
drop tmp

gen id = _n
recode id 7=8
labmask id, val(lab)
format r2 %9.2f

sum r2 in 7
local line = r(mean)
tw scatter id r2, mlab(r2) mlabpos(12) mlabsize(medsmall) ytit("") xtit("Rank stability") ///
	ylab(1 2 3 4 5 6 8, grid val angle(0)) yscale(range(1 8.5)) xlab(0(.25)1) ///
	xline(`line', lp(dash) lc(gs12)) aspect(1) ysize(3) xsize(4.3) scale(*1.2) ///
	text(6 -.45 "Split by:") plotr(lc(white))
	
graph export "out/stability.pdf", replace

********************************************
* Correlation of rankings across parameters
********************************************

clear 


local ProjectDir "$MyProject"
cd "`ProjectDir'"
global DATA "$MyProject"


local val = 0
foreach para in reg corr odds unidiff pos {
	local ++val
	append using "data/models_`para'.dta"
	cap gen para = .
	replace para = `val' if missing(para)
	
}

drop m1 m2 m10 idmodnr std
reshape wide rank, i(m3-m9) j(para)

corr rank*
factor rank*


********************************************
* Stability plots for individual parameters 
********************************************


foreach para in corr reg odds unidiff pos {
	clear
    global para `para'
    
    use "data/models_${para}.dta"

    drop m5 // Parental educational variable: only relevant for log odds

    label variable m3 "Education variable"
    label variable m4 "Which parent?"
    label variable m6 "Age restriction"
    label variable m7 "Foreign born incl?"
    label variable m8 "Gender"

    * Now run the models and collect estimates
    gen lab = ""
    gen r2 = .

    local k = 1
    qui $est $outcome i.m9
    replace lab = "Baseline" in `k'
    replace r2 = ${rsq} in `k'

    foreach var of varlist m3-m8 { 
        local ++k
        local lab: variable label `var'
        replace lab = "`lab'" in `k'

        qui $est $outcome i.m9##i.`var'
        replace r2 = ${rsq} in `k'
    }

    * Clean up and plot the estimates
    keep lab r2
    keep if !missing(r2)

    gen tmp = r2 if lab !="Baseline"
    sort tmp
    drop tmp

    gen id = _n
    recode id 6=7
    labmask id, val(lab)
    format r2 %9.2f

    sum r2 in 6
    local line = r(mean)
    tw scatter id r2, mlab(r2) mlabpos(12) mlabsize(medsmall) ytit("") xtit("Rank stability") ///
        ylab(1 2 3 4 5 7, grid val angle(0)) yscale(range(1 7.5)) xlab(0(.25)1) ///
        xline(`line', lp(dash) lc(gs12)) aspect(1) ysize(3) xsize(4.3) scale(*1.5) ///
        text(6 -.6 "Split by:") plotr(lc(white))
    
    graph export "out/stability_${para}.pdf", replace
}

