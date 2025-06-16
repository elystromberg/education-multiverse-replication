*global par unidiff // reg corr odds posit unidiff

clear


local ProjectDir "$MyProject"
cd "`ProjectDir'"
global DATA "$MyProject"


foreach par in reg corr odds pos unidiff {
    global par `par'
    
    use "data/models_${par}.dta", clear
    
    kountry cntry, from(iso2c)
    drop cntry
    ren NAMES_STD cntry
    
    collapse (median) Median=m1 (mean) Mean=m1 (min) Min=m1 (max) Max=m1 (iqr) IQR=m1, by(cntry)
    gen Range = Max - Min
    sort Median
    
    count 
    local j = r(N) + 1
    set obs `j'
    replace cntry = "\hline Mean" in `j'

    foreach var of varlist _all {
        cap sum `var'
        cap replace `var' = r(mean) in `j'
        
        tostring `var', force replace format(%9.3f)
    }
    
    replace Range = Range + "\\" 
    replace c =  "\\ \hline " + c in 1
    ren cntry Country
    export delimited "out/tab_${par}.tex", delimiter("&") replace
}