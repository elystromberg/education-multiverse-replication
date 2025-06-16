*******************************************************
* Recode edulvla and edulvlb to ISCED using presentation by Schneider
* https://csdiworkshop.org/wp-content/uploads/2013/CSDI2013_SilkeSchneider.pdf
* Recode ISCED to years using National mapping from ISCED11 & 97
* available at http://uis.unesco.org/en/isced-mappings
*******************************************************



// tyrspda and tyrsaa switches names
// missing if one parent missing, should just take existing parent 
// should be fixed


* Final variables:
* tyrsa - theoretical years of education
* tyrsfa - theoretical years of education - father
* tyrsma - theoretical years of education - mother
* tyrspda - theoretical years of education - parental dominant
* tyrspaa - theoretical years of education - parental average


// Edulvla rounds 1-4


gen eduyrs97a=.
gen eduyrs97fa=.
gen eduyrs97ma=.
replace eduyrs97a=edulvla
replace eduyrs97fa=edulvlfa
replace eduyrs97ma=edulvlma


recode eduyrs97a else=. if inlist(cntry, "AL", "AT", "ME", "PT", "RS", "UA", "XK")
recode eduyrs97fa else=. if inlist(cntry, "AL", "AT", "ME", "PT", "RS", "UA", "XK")
recode eduyrs97ma else=. if inlist(cntry, "AL", "AT", "ME", "PT", "RS", "UA", "XK")

********************************************************************************
* Respondent hypothetical years of education, averaged over ISCED11 level
*
********************************************************************************

* Austria ISCED 97	
recode eduyrs97a 1=3.25 2=8.34 3=11.33 4=13.13 5=15.88 else=. if cntry=="AT"
*Belgium
recode eduyrs97a 1=6.5 2=8.333333333 3=11.4 4=13.42857143 5=15.45833333 else=. if cntry=="BE"
* Bulgaria
recode eduyrs97a 1=4 2=6.83 3=11.00 4=14.00 5=17.25 else=. if cntry=="BG"
* Croatia	
recode eduyrs97a 1=4 2=5.67 3=10.92 5=16.84 else=. if cntry=="HR"
* Cyprus	
recode eduyrs97a 1=7.5 2=10.00 3=12.42 4=14.00 5=17.13 else=. if cntry=="CY"
* Czechia	
recode eduyrs97a 1=5.50 2=9.85 3=12.40 4=13.88 5=16.78 else=. if cntry=="CZ"
* Denmark	
recode eduyrs97a 1=4.00 2=10.50 3=12.63 4=14.00 5=17.00 else=. if cntry=="DK"
* Estonia	
recode eduyrs97a 1=6.00 2=8.6 3=11.65 4=14.38 5=17.30 else=. if cntry=="EE"
* Finland	
recode eduyrs97a 1=6 2=9 3=12 4=13.50 5=17.53 else=. if cntry=="FI"
* France	
recode eduyrs97a 1=5 2=9 3=12.04166667 4=13 5=16.28947368 else=. if cntry=="FR"
* Germany	
recode eduyrs97a 1=4.00 2=10.89 3=12.43 4=15.83 5=17.17 else=. if cntry=="DE"
* Greece	
recode eduyrs97a 1=6 2=9.50 3=12.33 4=13.75 5=17.97 else=. if cntry=="GR"
* Hungary	
recode eduyrs97a 1=4 2=9.785714286 3=11.61111111 4=14.5 5=16.47368421 else=. if cntry=="HU"
* Iceland	
recode eduyrs97a 1=7 2=10.90 3=13.25 4=14.82 5=18.375 else=. if cntry=="IS"
* Ireland	
recode eduyrs97a 1=8 2=11.1 3=14 4=15.45833333 5=18.00 else=. if cntry=="IE"
* Israel	
recode eduyrs97a 1=7.00 2=9.00 3=12.00 4=13.00 5=16.19 else=. if cntry=="IL"
* Italy	
recode eduyrs97a 1=5 2=8.00 3=12.31 4=14.00 5=18.67 else=. if cntry=="IT"
* Latvia	
recode eduyrs97a 1=6.00 2=9.13 3=12.43 4=13.63 5=16.56 else=. if cntry=="LV"
* Lithuania	
recode eduyrs97a 1=7 2=11.3 3=12.25 4=13.50 5=18.18 else=. if cntry=="LT"
* Luxembourg	
recode eduyrs97a 1=5.75 2=8.61 3=12.84 4=15.00 5=20.50 else=. if cntry=="LU"
* Netherlands	
recode eduyrs97a 1=6.00 2=10.50 3=12.60 4=14.00 5=16.66666667 else=. if cntry=="NL"
* Norway	
recode eduyrs97a 1=7.00 2=10.00 3=13.13 4=15.25 5=18.73 else=. if cntry=="NO"
* Poland	
recode eduyrs97a 1=7.5 2=9.5 3=12.38 4=14.05 5=17.38 else=. if cntry=="PL"
* Romania	
recode eduyrs97a 1.00=5.00 2.00=8.25 3.00=11.08 4.00=14.00 5.00=18.50 else=. if cntry=="RO"
* Russia	
recode eduyrs97a 1=4.00 2=9.00 3=10.75 4=12.00 5=17.29 else=. if cntry=="RU"
* Slovakia	
recode eduyrs97a 1=5.20 2=9.79 3=12.72 4=15.00 5=17.00 else=. if cntry=="SK"
* Slovenia	
recode eduyrs97a 1.00=6.00 2.00=9.00 3.00=12.70 4.00=13.50 5.00=18.52 else=. if cntry=="SI"
* Spain	
recode eduyrs97a 1.00=6.00 2.00=10.00 3.00=11.79 4.00=12.75 5.00=17.15 else=. if cntry=="ES"
* Switzerland	
recode eduyrs97a 1=6.00 2=9.33 3=11.86 4=14.30 5=16.81 else=. if cntry=="CH"
* Sweden	
recode eduyrs97a 1.00=6.00 2.00=9.38 3.00=11.56 4.00=13.50 5.00=16.32 else=. if cntry=="SE"
* Turkey	
recode eduyrs97a 1.00=4.00 2.00=8.00 3.00=12.14 5.00=18.00 else=. if cntry=="TR"
* United Kingdom	
recode eduyrs97a 1.00=8.75 2.00=9.50 3.00=12.65 5.00=16.65 else=. if cntry=="GB"

********************************************************************************
* Father's hypothetical years of education. averaged over ISCED11 level
*
********************************************************************************

* Austria ISCED 97	
recode eduyrs97fa 1=3.25 2=8.333333333 3=11.33 4=13.13 5=15.88 else=. if cntry=="AT"
*Belgium
recode eduyrs97fa 1=6.5 2=8.333333333 3=11.4 4=13.42857143 5=15.45833333 else=. if cntry=="BE"
* Bulgaria
recode eduyrs97fa 1=4 2=6.83 3=11.00 4=14.00 5=17.25 else=. if cntry=="BG"
* Croatia	
recode eduyrs97fa 1=4 2=5.67 3=10.92 5=16.84 else=. if cntry=="HR"
* Cyprus	
recode eduyrs97fa 1=7.5 2=10.00 3=12.42 4=14.00 5=17.13 else=. if cntry=="CY"
* Czechia	
recode eduyrs97fa 1=5.50 2=9.85 3=12.40 4=13.88 5=16.78 else=. if cntry=="CZ"
* Denmark	
recode eduyrs97fa 1=4.00 2=10.50 3=12.63 4=14.00 5=17.00 else=. if cntry=="DK"
* Estonia	
recode eduyrs97fa 1=6.00 2=8.6 3=11.65 4=14.38 5=17.30 else=. if cntry=="EE"
* Finland	
recode eduyrs97fa 1=6 2=9 3=12 4=13.50 5=17.53 else=. if cntry=="FI"
* France	
recode eduyrs97fa 1=5 2=9 3=12.04166667 4=13 5=16.28947368 else=. if cntry=="FR"
* Germany	
recode eduyrs97fa 1=4.00 2=10.89 3=12.43 4=15.83 5=17.17 else=. if cntry=="DE"
* Greece	
recode eduyrs97fa 1=6 2=9.50 3=12.33 4=13.75 5=17.97 else=. if cntry=="GR"
* Hungary	
recode eduyrs97fa 1=4 2=9.785714286 3=11.61111111 4=14.5 5=16.47368421 else=. if cntry=="HU"
* Iceland	
recode eduyrs97fa 1=7 2=10.90 3=13.25 4=14.82 5=18.375 else=. if cntry=="IS"
* Ireland	
recode eduyrs97fa 1=8 2=11.1 3=14 4=15.45833333 5=18.00 else=. if cntry=="IE"
* Israel	
recode eduyrs97fa 1=7.00 2=9.00 3=12.00 4=13.00 5=16.19 else=. if cntry=="IL"
* Italy	
recode eduyrs97fa 1=5 2=8.00 3=12.31 4=14.00 5=18.67 else=. if cntry=="IT"
* Latvia	
recode eduyrs97fa 1=6.00 2=9.13 3=12.43 4=13.63 5=16.56 else=. if cntry=="LV"
* Lithuania	
recode eduyrs97fa 1=7 2=11.3 3=12.25 4=13.50 5=18.18 else=. if cntry=="LT"
* Luxembourg	
recode eduyrs97fa 1=5.75 2=8.61 3=12.84 4=15.00 5=20.50 else=. if cntry=="LU"
* Netherlands	
recode eduyrs97fa 1=6.00 2=10.50 3=12.60 4=14.00 5=16.66666667 else=. if cntry=="NL"
* Norway	
recode eduyrs97fa 1=7.00 2=10.00 3=13.13 4=15.25 5=18.73 else=. if cntry=="NO"
* Poland	
recode eduyrs97fa 1=7.5 2=9.5 3=12.38 4=14.05 5=17.38 else=. if cntry=="PL"
* Romania	
recode eduyrs97fa 1.00=5.00 2.00=8.25 3.00=11.08 4.00=14.00 5.00=18.50 else=. if cntry=="RO"
* Russia	
recode eduyrs97fa 1=4.00 2=9.00 3=10.75 4=12.00 5=17.29 else=. if cntry=="RU"
* Slovakia	
recode eduyrs97fa 1=5.20 2=9.79 3=12.72 4=15.00 5=17.00 else=. if cntry=="SK"
* Slovenia	
recode eduyrs97fa 1.00=6.00 2.00=9.00 3.00=12.70 4.00=13.50 5.00=18.52 else=. if cntry=="SI"
* Spain	
recode eduyrs97fa 1.00=6.00 2.00=10.00 3.00=11.79 4.00=12.75 5.00=17.15 else=. if cntry=="ES"
* Switzerland	
recode eduyrs97fa 1=6.00 2=9.33 3=11.86 4=14.30 5=16.81 else=. if cntry=="CH"
* Sweden	
recode eduyrs97fa 1.00=6.00 2.00=9.38 3.00=11.56 4.00=13.50 5.00=16.32 else=. if cntry=="SE"
* Turkey	
recode eduyrs97fa 1.00=4.00 2.00=8.00 3.00=12.14 5.00=18.00 else=. if cntry=="TR"
* United Kingdom	
recode eduyrs97fa 1.00=8.75 2.00=9.50 3.00=12.65 5.00=16.65 else=. if cntry=="GB"


********************************************************************************
* Mother's hypothetical years of education. averaged over ISCED11 level
*
********************************************************************************

* Austria ISCED 97	
recode eduyrs97ma 1=3.25 2=8.333333333 3=11.33 4=13.13 5=15.88 else=. if cntry=="AT"
*Belgium
recode eduyrs97ma 1=6.5 2=8.333333333 3=11.4 4=13.42857143 5=15.45833333 else=. if cntry=="BE"
* Bulgaria
recode eduyrs97ma 1=4 2=6.83 3=11.00 4=14.00 5=17.25 else=. if cntry=="BG"
* Croatia	
recode eduyrs97ma 1=4 2=5.67 3=10.92 5=16.84 else=. if cntry=="HR"
* Cyprus	
recode eduyrs97ma 1=7.5 2=10.00 3=12.42 4=14.00 5=17.13 else=. if cntry=="CY"
* Czechia	
recode eduyrs97ma 1=5.50 2=9.85 3=12.40 4=13.88 5=16.78 else=. if cntry=="CZ"
* Denmark	
recode eduyrs97ma 1=4.00 2=10.50 3=12.63 4=14.00 5=17.00 else=. if cntry=="DK"
* Estonia	
recode eduyrs97ma 1=6.00 2=8.6 3=11.65 4=14.38 5=17.30 else=. if cntry=="EE"
* Finland	
recode eduyrs97ma 1=6 2=9 3=12 4=13.50 5=17.53 else=. if cntry=="FI"
* France	
recode eduyrs97ma 1=5 2=9 3=12.04166667 4=13 5=16.28947368 else=. if cntry=="FR"
* Germany	
recode eduyrs97ma 1=4.00 2=10.89 3=12.43 4=15.83 5=17.17 else=. if cntry=="DE"
* Greece	
recode eduyrs97ma 1=6 2=9.50 3=12.33 4=13.75 5=17.97 else=. if cntry=="GR"
* Hungary	
recode eduyrs97ma 1=4 2=9.785714286 3=11.61111111 4=14.5 5=16.47368421 else=. if cntry=="HU"
* Iceland	
recode eduyrs97ma 1=7 2=10.90 3=13.25 4=14.82 5=18.375 else=. if cntry=="IS"
* Ireland	
recode eduyrs97ma 1=8 2=11.1 3=14 4=15.45833333 5=18.00 else=. if cntry=="IE"
* Israel	
recode eduyrs97ma 1=7.00 2=9.00 3=12.00 4=13.00 5=16.19 else=. if cntry=="IL"
* Italy	
recode eduyrs97ma 1=5 2=8.00 3=12.31 4=14.00 5=18.67 else=. if cntry=="IT"
* Latvia	
recode eduyrs97ma 1=6.00 2=9.13 3=12.43 4=13.63 5=16.56 else=. if cntry=="LV"
* Lithuania	
recode eduyrs97ma 1=7 2=11.3 3=12.25 4=13.50 5=18.18 else=. if cntry=="LT"
* Luxembourg	
recode eduyrs97ma 1=5.75 2=8.61 3=12.84 4=15.00 5=20.50 else=. if cntry=="LU"
* Netherlands	
recode eduyrs97ma 1=6.00 2=10.50 3=12.60 4=14.00 5=16.66666667 else=. if cntry=="NL"
* Norway	
recode eduyrs97ma 1=7.00 2=10.00 3=13.13 4=15.25 5=18.73 else=. if cntry=="NO"
* Poland	
recode eduyrs97ma 1=7.5 2=9.5 3=12.38 4=14.05 5=17.38 else=. if cntry=="PL"
* Romania	
recode eduyrs97ma 1.00=5.00 2.00=8.25 3.00=11.08 4.00=14.00 5.00=18.50 else=. if cntry=="RO"
* Russia	
recode eduyrs97ma 1=4.00 2=9.00 3=10.75 4=12.00 5=17.29 else=. if cntry=="RU"
* Slovakia	
recode eduyrs97ma 1=5.20 2=9.79 3=12.72 4=15.00 5=17.00 else=. if cntry=="SK"
* Slovenia	
recode eduyrs97ma 1.00=6.00 2.00=9.00 3.00=12.70 4.00=13.50 5.00=18.52 else=. if cntry=="SI"
* Spain	
recode eduyrs97ma 1.00=6.00 2.00=10.00 3.00=11.79 4.00=12.75 5.00=17.15 else=. if cntry=="ES"
* Switzerland	
recode eduyrs97ma 1=6.00 2=9.33 3=11.86 4=14.30 5=16.81 else=. if cntry=="CH"
* Sweden	
recode eduyrs97ma 1.00=6.00 2.00=9.38 3.00=11.56 4.00=13.50 5.00=16.32 else=. if cntry=="SE"
* Turkey	
recode eduyrs97ma 1.00=4.00 2.00=8.00 3.00=12.14 5.00=18.00 else=. if cntry=="TR"
* United Kingdom	
recode eduyrs97ma 1.00=8.75 2.00=9.50 3.00=12.65 5.00=16.65 else=. if cntry=="GB"




********************************************************************************
* Parental average and dominant hypothetical years of education
* averaged over ISCED11 level
********************************************************************************

gen eduyrs97pda=.
replace eduyrs97pda = eduyrs97fa if missing(eduyrs97ma)
replace eduyrs97pda = eduyrs97ma if missing(eduyrs97fa)
replace eduyrs97pda = eduyrs97fa if eduyrs97fa>=eduyrs97ma & !missing(eduyrs97fa)
replace eduyrs97pda = eduyrs97ma if eduyrs97ma>=eduyrs97fa & !missing(eduyrs97ma)

gen eduyrs97paa=((eduyrs97fa+eduyrs97ma)/2)
replace eduyrs97paa = eduyrs97fa if missing(eduyrs97ma) & !missing(eduyrs97fa)
replace eduyrs97paa = eduyrs97ma if missing(eduyrs97fa) & !missing(eduyrs97ma)


********************************************************************************
********** EDULVLB Round 5+
**********
********************************************************************************

* missing AL AT ME PT RS UA XK   


gen eduyrs11a=.
gen eduyrs11fa=.
gen eduyrs11ma=.
gen isced11=.
gen isced11f=.
gen isced11m=.
replace isced11=edulvlb
replace isced11f=edulvlfb
replace isced11m=edulvlmb

* edulvlb to ISCED11
recode isced11 0=0 113=100 129=100 212=244 213=244 221=253 222=254 223=254 229=254 311=343 312=344 ///
313=344 321=353 322=354 323=354 412=444 413=444 421=453 422=454 423=454 510=510 520=520 ///
610=660 620=660 710=760 720=760 800=800 else=.

recode isced11f 0=0 113=100 129=100 212=244 213=244 221=253 222=254 223=254 229=254 311=343 312=344 ///
313=344 321=353 322=354 323=354 412=444 413=444 421=453 422=454 423=454 510=510 520=520 ///
610=660 620=660 710=760 720=760 800=800 else=.

recode isced11m 0=0 113=100 129=100 212=244 213=244 221=253 222=254 223=254 229=254 311=343 312=344 ///
313=344 321=353 322=354 323=354 412=444 413=444 421=453 422=454 423=454 510=510 520=520 ///
610=660 620=660 710=760 720=760 800=800 else=.

replace eduyrs11a=isced11
replace eduyrs11fa=isced11f
replace eduyrs11ma=isced11m

recode eduyrs11a else=. if inlist(cntry, "AL", "AT", "ME", "PT", "RS", "UA", "XK")
recode eduyrs11fa else=. if inlist(cntry, "AL", "AT", "ME", "PT", "RS", "UA", "XK")
recode eduyrs11ma else=. if inlist(cntry, "AL", "AT", "ME", "PT", "RS", "UA", "XK")

********************************************************************************
* Respondent hypothetical years of education, averaged over ISCED11 level
*
********************************************************************************

*Belgium
recode eduyrs11a 100=6.5 244=8 254=9.0 344=12.0 354=12.0 453=14.0 660=15.5 760=17.33 800=20.5 else=. if cntry=="BE"
* Bulgaria
recode eduyrs11a 0=0 100=4.25 244=8.0 254=9.0 344=12.0 354=12.0 453=14.0 ///
660=15.5 760=17.33 800=20.5 else=. if cntry=="BG"
* Croatia	
recode eduyrs11a 0=0 100=4.00 244=5.5 253=. 254=8.7 343=. 344=12.0 353=11.3 354=12.4 444=. 453=. 454=. 510=. 520=14.25 660=15.5 760=17.25 800=20.5 else=. if cntry=="HR"
* Cyprus	
recode eduyrs11a 0=0 100=7.5 244=10.0 253=. 254=. 343=. 344=12.5 353=. 354=12.3 444=. 453=. 454=14.0 510=. 520=14.5 660=16.3 760=17.42 800=20.5 else=. if cntry=="CY"
* Czechia	
recode eduyrs11a 0=0 100=5.5 244=9.8 253=11.5 254=. 343=. 344=13.0 353=12.3 354=13.0 444=14.0 453=13.5 454=14.0 510=. 520=14.33333333 660=15.3 760=18.50 800=21 else=. if cntry=="CZ"
* Denmark	
recode eduyrs11a 0=0 100=7 244=10.7 253=. 254=. 343=. 344=13.3 353=14.0 354=14.0 444=. 453=. 454=14.0 510=. 520=15.66666667 660=15.8 760=18.00 800=20.5 else=. if cntry=="DK"
* Estonia	
recode eduyrs11a 0=0 100=7.75 244=9.0 253=. 254=11.1 343=. 344=12.0 353=. 354=12.5 444=. 453=. 454=13.9 510=. 520=. 660=15.5 760=17.25 800=21 else=. if cntry=="EE"
* Finland	
recode eduyrs11a 0=0 100=6 244=9.0 253=. 254=. 343=. 344=12.0 353=. 354=12.2 444=. 453=. 454=13.5 510=. 520=14.5 660=15.4 760=18.88 800=21.5 else=. if cntry=="FI"
* France	
recode eduyrs11a 0=0 100=5 244=9.0 253=. 254=. 343=. 344=12.0 353=12.1 354=12.5 444=13.0 453=13.0 454=. 510=. 520=14.16666667 660=15.3 760=17.25 800=20 else=. if cntry=="FR"
* Germany	
recode eduyrs11a 0=0 100=4 244=10.8 253=. 254=11.0 343=. 344=12.8 353=12.0 354=13.3 444=15.0 453=15.5 454=16.0 510=. 520=14.5 660=16.6 760=19.08 800=20 else=. if cntry=="DE"
* Greece	
recode eduyrs11a 0=0 100=4 244=8.8 253=. 254=11.0 343=. 344=12.5 353=12.0 354=12.0 444=. 453=13.7 454=. 510=. 520=. 660=16.2 760=18.08 800=22 else=. if cntry=="GR"
* Hungary	
recode eduyrs11a 0=0 100=4 244=8.9 253=10.7 254=. 343=. 344=12.0 353=11.1 354=12.0 444=. 453=. 454=. 510=. 520=14.5 660=15.8 760=17.63 800=20 else=. if cntry=="HU"
* Iceland	
recode eduyrs11a 0=0 100=7 244=11.0 253=. 254=11.1 343=12.8 344=14.3 353=13.1 354=14.0 444=14.75 453=14.4 454=. 510=. 520=16.125 660=18.2 760=19.50 800=22.5 else=. if cntry=="IS"
* Ireland	
recode eduyrs11a 0=0 100=8 244=11.1 253=. 254=. 343=13.5 344=13.5 353=14.5 354=. 444=15.5 453=15.6 454=15 510=15.5 520=15.5 660=17.0 760=18.25 800=24.25 else=. if cntry=="IE"
* Israel	
recode eduyrs11a 0=0 100=7 244=9.00 253=. 254=. 343=12.0 344=12.0 353=12.0 354=12.0 444=13 453=. 454=13 510=. 520=13.6 660=15.8 760=17.64 800=22 else=. if cntry=="IL"
* Italy	
recode eduyrs11a 0=0 100=5 244=8.00 253=. 254=. 343=. 344=12.8 353=11.2 354=12.8 444=. 453=14.0 454=. 510=. 520=15.5 660=16.6 760=19.25 800=21 else=. if cntry=="IT"
* Latvia	
recode eduyrs11a 0=0 100=6 244=9.00 253=. 254=10.83 343=. 344=12.5 353=. 354=13.5 444=. 453=13.6 454=13.5 510=. 520=14.5 660=15.9 760=17.00 800=20.5 else=. if cntry=="LV"
* Lithuania	
recode eduyrs11a 0=0 100=4 244=11.00 253=. 254=12.00 343=. 344=12.0 353=. 354=13.0 444=. 453=. 454=13.5 510=. 520=. 660=16.3 760=19.17 800=21 else=. if cntry=="LT"
* Luxembourg	
recode eduyrs11a 0=0 100=6 244=8.81 253=. 254=. 343=. 344=12.9 353=11.9 354=13.1 444=. 453=15 454=. 510=16 520=17 660=18.3 760=21.18 800=23 else=. if cntry=="LU"
* Netherlands	
recode eduyrs11a 0=0 100=6 244=10.33333333 253=10 254=11 343=. 344=12 353=12.75 354=13.5 444=. 453=. 454=14 510=. 520=16 660=15 760=16.5 800=21 else=. if cntry=="NL"
* Norway	
recode eduyrs11a 0=0 100=7 244=10 253=. 254=. 343=11.5 344=13.5 353=16 354=. 444=. 453=. 454=15 510=15.5 520=. 660=16.7 760=18.8 800=22 else=. if cntry=="NO"
* Poland	
recode eduyrs11a 0=0 100=7.5 244=9 253=. 254=. 343=. 344=12 353=12.14285714 354=12.66666667 444=. 453=14.05 454=. 510=15.4 520=. 660=15.75 760=18.08333333 800=21.5 else=. if cntry=="PL"
* Romania	
recode eduyrs11a 0=0 100=5 244=8.166666667 253=. 254=. 343=. 344=12.5 353=. 354=12.5 444=. 453=14 454=. 510=. 520=. 660=15 760=17.66666667 800=21.5 else=. if cntry=="RO"
* Russia	
recode eduyrs11a 0=0 100=4 244=9 253=. 254=. 343=. 344=11 353=10 354=13 444=. 453=. 454=12 510=14 520=. 660=15 760=17 800=20.5 else=. if cntry=="RU"
* Slovakia	
recode eduyrs11a 0=0 100=5.2 244=9.25 253=11.75 254=. 343=. 344=13 353=12 354=13 444=. 453=. 454=14.5 510=15.5 520=. 660=16 760=18.5 800=21 else=. if cntry=="SK"
* Slovenia	
recode eduyrs11a 0=0 100=6 244=9 253=. 254=. 343=. 344=13.375 353=12 354=13.58333333 444=. 453=. 454=. 510=. 520=15.25 660=16.5 760=18.125 800=21.25 else=. if cntry=="SI"
* Spain	
recode eduyrs11a 0=0 100=6.00 244=10.25 253=. 254=9.83 343=. 344=12 353=11.66666667 354=12 444=. 453=12.75 454=. 510=. 520=14.33 660=16.25 760=18.63 800=21.50 else=. if cntry=="ES"
* Switzerland	
recode eduyrs11a 0=0 100=6 244=9.33 253=. 254=10.00 343=11 344=12.41666667 353=12 354=12 444=14.50 453=. 454=14.50 510=. 520=13.50 660=16.38 760=17.67 800=21 else=. if cntry=="CH"
* Sweden	
recode eduyrs11a 0=0 100=6 244=9.38 253=. 254=10.50 343=13 344=12 353=13 354=. 444=13 453=12.50 454=13 510=. 520=14 660=15.08 760=16.72 800=21 else=. if cntry=="SE"
* Turkey	
recode eduyrs11a 0=0 100=4 244=8.00 253=. 254=. 343=. 344=12.25 353=12 354=12.125 444=. 453=. 454=. 510=. 520=14 660=16 760=17.6 800=22 else=. if cntry=="TR"
* United Kingdom	
recode eduyrs11a 0=0 100=8.75 244=9.50 253=. 254=11.5 343=12 344=12.5 353=. 354=14.66666667 444=. 453=. 454=15.25 510=. 520=16.125 660=16 760=17.25 800=21 else=. if cntry=="GB"

********************************************************************************
* Father's hypothetical years of education, averaged over ISCED11 level
*
********************************************************************************

*Belgium
recode eduyrs11fa 100=6.5 244=8 254=9.0 344=12.0 354=12.0 453=14.0 660=15.5 760=17.33 800=20.5 else=. if cntry=="BE"
* Bulgaria
recode eduyrs11fa 0=0 100=4.25 244=8.0 254=9.0 344=12.0 354=12.0 453=14.0 ///
660=15.5 760=17.33 800=20.5 else=. if cntry=="BG"
* Croatia	
recode eduyrs11fa 0=0 100=4.00 244=5.5 253=. 254=8.7 343=. 344=12.0 353=11.3 354=12.4 444=. 453=. 454=. 510=. 520=14.25 660=15.5 760=17.25 800=20.5 else=. if cntry=="HR"
* Cyprus	
recode eduyrs11fa 0=0 100=7.5 244=10.0 253=. 254=. 343=. 344=12.5 353=. 354=12.3 444=. 453=. 454=14.0 510=. 520=14.5 660=16.3 760=17.42 800=20.5 else=. if cntry=="CY"
* Czechia	
recode eduyrs11fa 0=0 100=5.5 244=9.8 253=11.5 254=. 343=. 344=13.0 353=12.3 354=13.0 444=14.0 453=13.5 454=14.0 510=. 520=14.33333333 660=15.3 760=18.50 800=21 else=. if cntry=="CZ"
* Denmark	
recode eduyrs11fa 0=0 100=7 244=10.7 253=. 254=. 343=. 344=13.3 353=14.0 354=14.0 444=. 453=. 454=14.0 510=. 520=15.66666667 660=15.8 760=18.00 800=20.5 else=. if cntry=="DK"
* Estonia	
recode eduyrs11fa 0=0 100=7.75 244=9.0 253=. 254=11.1 343=. 344=12.0 353=. 354=12.5 444=. 453=. 454=13.9 510=. 520=. 660=15.5 760=17.25 800=21 else=. if cntry=="EE"
* Finland	
recode eduyrs11fa 0=0 100=6 244=9.0 253=. 254=. 343=. 344=12.0 353=. 354=12.2 444=. 453=. 454=13.5 510=. 520=14.5 660=15.4 760=18.88 800=21.5 else=. if cntry=="FI"
* France	
recode eduyrs11fa 0=0 100=5 244=9.0 253=. 254=. 343=. 344=12.0 353=12.1 354=12.5 444=13.0 453=13.0 454=. 510=. 520=14.16666667 660=15.3 760=17.25 800=20 else=. if cntry=="FR"
* Germany	
recode eduyrs11fa 0=0 100=4 244=10.8 253=. 254=11.0 343=. 344=12.8 353=12.0 354=13.3 444=15.0 453=15.5 454=16.0 510=. 520=14.5 660=16.6 760=19.08 800=20 else=. if cntry=="DE"
* Greece	
recode eduyrs11fa 0=0 100=4 244=8.8 253=. 254=11.0 343=. 344=12.5 353=12.0 354=12.0 444=. 453=13.7 454=. 510=. 520=. 660=16.2 760=18.08 800=22 else=. if cntry=="GR"
* Hungary	
recode eduyrs11fa 0=0 100=4 244=8.9 253=10.7 254=. 343=. 344=12.0 353=11.1 354=12.0 444=. 453=. 454=. 510=. 520=14.5 660=15.8 760=17.63 800=20 else=. if cntry=="HU"
* Iceland	
recode eduyrs11fa 0=0 100=7 244=11.0 253=. 254=11.1 343=12.8 344=14.3 353=13.1 354=14.0 444=14.75 453=14.4 454=. 510=. 520=16.125 660=18.2 760=19.50 800=22.5 else=. if cntry=="IS"
* Ireland	
recode eduyrs11fa 0=0 100=8 244=11.1 253=. 254=. 343=13.5 344=13.5 353=14.5 354=. 444=15.5 453=15.6 454=15 510=15.5 520=15.5 660=17.0 760=18.25 800=24.25 else=. if cntry=="IE"
* Israel	
recode eduyrs11fa 0=0 100=7 244=9.00 253=. 254=. 343=12.0 344=12.0 353=12.0 354=12.0 444=13 453=. 454=13 510=. 520=13.6 660=15.8 760=17.64 800=22 else=. if cntry=="IL"
* Italy	
recode eduyrs11fa 0=0 100=5 244=8.00 253=. 254=. 343=. 344=12.8 353=11.2 354=12.8 444=. 453=14.0 454=. 510=. 520=15.5 660=16.6 760=19.25 800=21 else=. if cntry=="IT"
* Latvia	
recode eduyrs11fa 0=0 100=6 244=9.00 253=. 254=10.83 343=. 344=12.5 353=. 354=13.5 444=. 453=13.6 454=13.5 510=. 520=14.5 660=15.9 760=17.00 800=20.5 else=. if cntry=="LV"
* Lithuania	
recode eduyrs11fa 0=0 100=4 244=11.00 253=. 254=12.00 343=. 344=12.0 353=. 354=13.0 444=. 453=. 454=13.5 510=. 520=. 660=16.3 760=19.17 800=21 else=. if cntry=="LT"
* Luxembourg	
recode eduyrs11fa 0=0 100=6 244=8.81 253=. 254=. 343=. 344=12.9 353=11.9 354=13.1 444=. 453=15 454=. 510=16 520=17 660=18.3 760=21.18 800=23 else=. if cntry=="LU"
* Netherlands	
recode eduyrs11fa 0=0 100=6 244=10.33333333 253=10 254=11 343=. 344=12 353=12.75 354=13.5 444=. 453=. 454=14 510=. 520=16 660=15 760=16.5 800=21 else=. if cntry=="NL"
* Norway	
recode eduyrs11fa 0=0 100=7 244=10 253=. 254=. 343=11.5 344=13.5 353=16 354=. 444=. 453=. 454=15 510=15.5 520=. 660=16.7 760=18.8 800=22 else=. if cntry=="NO"
* Poland	
recode eduyrs11fa 0=0 100=7.5 244=9 253=. 254=. 343=. 344=12 353=12.14285714 354=12.66666667 444=. 453=14.05 454=. 510=15.4 520=. 660=15.75 760=18.08333333 800=21.5 else=. if cntry=="PL"
* Romania	
recode eduyrs11fa 0=0 100=5 244=8.166666667 253=. 254=. 343=. 344=12.5 353=. 354=12.5 444=. 453=14 454=. 510=. 520=. 660=15 760=17.66666667 800=21.5 else=. if cntry=="RO"
* Russia	
recode eduyrs11fa 0=0 100=4 244=9 253=. 254=. 343=. 344=11 353=10 354=13 444=. 453=. 454=12 510=14 520=. 660=15 760=17 800=20.5 else=. if cntry=="RU"
* Slovakia	
recode eduyrs11fa 0=0 100=5.2 244=9.25 253=11.75 254=. 343=. 344=13 353=12 354=13 444=. 453=. 454=14.5 510=15.5 520=. 660=16 760=18.5 800=21 else=. if cntry=="SK"
* Slovenia	
recode eduyrs11fa 0=0 100=6 244=9 253=. 254=. 343=. 344=13.375 353=12 354=13.58333333 444=. 453=. 454=. 510=. 520=15.25 660=16.5 760=18.125 800=21.25 else=. if cntry=="SI"
* Spain	
recode eduyrs11fa 0=0 100=6.00 244=10.25 253=. 254=9.83 343=. 344=12 353=11.66666667 354=12 444=. 453=12.75 454=. 510=. 520=14.33 660=16.25 760=18.63 800=21.50 else=. if cntry=="ES"
* Switzerland	
recode eduyrs11fa 0=0 100=6 244=9.33 253=. 254=10.00 343=11 344=12.41666667 353=12 354=12 444=14.50 453=. 454=14.50 510=. 520=13.50 660=16.38 760=17.67 800=21 else=. if cntry=="CH"
* Sweden	
recode eduyrs11fa 0=0 100=6 244=9.38 253=. 254=10.50 343=13 344=12 353=13 354=. 444=13 453=12.50 454=13 510=. 520=14 660=15.08 760=16.72 800=21 else=. if cntry=="SE"
* Turkey	
recode eduyrs11fa 0=0 100=4 244=8.00 253=. 254=. 343=. 344=12.25 353=12 354=12.125 444=. 453=. 454=. 510=. 520=14 660=16 760=17.6 800=22 else=. if cntry=="TR"
* United Kingdom	
recode eduyrs11fa 0=0 100=8.75 244=9.50 253=. 254=11.5 343=12 344=12.5 353=. 354=14.66666667 444=. 453=. 454=15.25 510=. 520=16.125 660=16 760=17.25 800=21 else=. if cntry=="GB"


********************************************************************************
* Mothers hypothetical years of education, averaged over ISCED11 level
*
********************************************************************************

*Belgium
recode eduyrs11ma 100=6.5 244=8 254=9.0 344=12.0 354=12.0 453=14.0 660=15.5 760=17.33 800=20.5 else=. if cntry=="BE"
* Bulgaria
recode eduyrs11ma 0=0 100=4.25 244=8.0 254=9.0 344=12.0 354=12.0 453=14.0 ///
660=15.5 760=17.33 800=20.5 else=. if cntry=="BG"
* Croatia	
recode eduyrs11ma 0=0 100=4.00 244=5.5 253=. 254=8.7 343=. 344=12.0 353=11.3 354=12.4 444=. 453=. 454=. 510=. 520=14.25 660=15.5 760=17.25 800=20.5 else=. if cntry=="HR"
* Cyprus	
recode eduyrs11ma 0=0 100=7.5 244=10.0 253=. 254=. 343=. 344=12.5 353=. 354=12.3 444=. 453=. 454=14.0 510=. 520=14.5 660=16.3 760=17.42 800=20.5 else=. if cntry=="CY"
* Czechia	
recode eduyrs11ma 0=0 100=5.5 244=9.8 253=11.5 254=. 343=. 344=13.0 353=12.3 354=13.0 444=14.0 453=13.5 454=14.0 510=. 520=14.33333333 660=15.3 760=18.50 800=21 else=. if cntry=="CZ"
* Denmark	
recode eduyrs11ma 0=0 100=7 244=10.7 253=. 254=. 343=. 344=13.3 353=14.0 354=14.0 444=. 453=. 454=14.0 510=. 520=15.66666667 660=15.8 760=18.00 800=20.5 else=. if cntry=="DK"
* Estonia	
recode eduyrs11ma 0=0 100=7.75 244=9.0 253=. 254=11.1 343=. 344=12.0 353=. 354=12.5 444=. 453=. 454=13.9 510=. 520=. 660=15.5 760=17.25 800=21 else=. if cntry=="EE"
* Finland	
recode eduyrs11ma 0=0 100=6 244=9.0 253=. 254=. 343=. 344=12.0 353=. 354=12.2 444=. 453=. 454=13.5 510=. 520=14.5 660=15.4 760=18.88 800=21.5 else=. if cntry=="FI"
* France	
recode eduyrs11ma 0=0 100=5 244=9.0 253=. 254=. 343=. 344=12.0 353=12.1 354=12.5 444=13.0 453=13.0 454=. 510=. 520=14.16666667 660=15.3 760=17.25 800=20 else=. if cntry=="FR"
* Germany	
recode eduyrs11ma 0=0 100=4 244=10.8 253=. 254=11.0 343=. 344=12.8 353=12.0 354=13.3 444=15.0 453=15.5 454=16.0 510=. 520=14.5 660=16.6 760=19.08 800=20 else=. if cntry=="DE"
* Greece	
recode eduyrs11ma 0=0 100=4 244=8.8 253=. 254=11.0 343=. 344=12.5 353=12.0 354=12.0 444=. 453=13.7 454=. 510=. 520=. 660=16.2 760=18.08 800=22 else=. if cntry=="GR"
* Hungary	
recode eduyrs11ma 0=0 100=4 244=8.9 253=10.7 254=. 343=. 344=12.0 353=11.1 354=12.0 444=. 453=. 454=. 510=. 520=14.5 660=15.8 760=17.63 800=20 else=. if cntry=="HU"
* Iceland	
recode eduyrs11ma 0=0 100=7 244=11.0 253=. 254=11.1 343=12.8 344=14.3 353=13.1 354=14.0 444=14.75 453=14.4 454=. 510=. 520=16.125 660=18.2 760=19.50 800=22.5 else=. if cntry=="IS"
* Ireland	
recode eduyrs11ma 0=0 100=8 244=11.1 253=. 254=. 343=13.5 344=13.5 353=14.5 354=. 444=15.5 453=15.6 454=15 510=15.5 520=15.5 660=17.0 760=18.25 800=24.25 else=. if cntry=="IE"
* Israel	
recode eduyrs11ma 0=0 100=7 244=9.00 253=. 254=. 343=12.0 344=12.0 353=12.0 354=12.0 444=13 453=. 454=13 510=. 520=13.6 660=15.8 760=17.64 800=22 else=. if cntry=="IL"
* Italy	
recode eduyrs11ma 0=0 100=5 244=8.00 253=. 254=. 343=. 344=12.8 353=11.2 354=12.8 444=. 453=14.0 454=. 510=. 520=15.5 660=16.6 760=19.25 800=21 else=. if cntry=="IT"
* Latvia	
recode eduyrs11ma 0=0 100=6 244=9.00 253=. 254=10.83 343=. 344=12.5 353=. 354=13.5 444=. 453=13.6 454=13.5 510=. 520=14.5 660=15.9 760=17.00 800=20.5 else=. if cntry=="LV"
* Lithuania	
recode eduyrs11ma 0=0 100=4 244=11.00 253=. 254=12.00 343=. 344=12.0 353=. 354=13.0 444=. 453=. 454=13.5 510=. 520=. 660=16.3 760=19.17 800=21 else=. if cntry=="LT"
* Luxembourg	
recode eduyrs11ma 0=0 100=6 244=8.81 253=. 254=. 343=. 344=12.9 353=11.9 354=13.1 444=. 453=15 454=. 510=16 520=17 660=18.3 760=21.18 800=23 else=. if cntry=="LU"
* Netherlands	
recode eduyrs11ma 0=0 100=6 244=10.33333333 253=10 254=11 343=. 344=12 353=12.75 354=13.5 444=. 453=. 454=14 510=. 520=16 660=15 760=16.5 800=21 else=. if cntry=="NL"
* Norway	
recode eduyrs11ma 0=0 100=7 244=10 253=. 254=. 343=11.5 344=13.5 353=16 354=. 444=. 453=. 454=15 510=15.5 520=. 660=16.7 760=18.8 800=22 else=. if cntry=="NO"
* Poland	
recode eduyrs11ma 0=0 100=7.5 244=9 253=. 254=. 343=. 344=12 353=12.14285714 354=12.66666667 444=. 453=14.05 454=. 510=15.4 520=. 660=15.75 760=18.08333333 800=21.5 else=. if cntry=="PL"
* Romania	
recode eduyrs11ma 0=0 100=5 244=8.166666667 253=. 254=. 343=. 344=12.5 353=. 354=12.5 444=. 453=14 454=. 510=. 520=. 660=15 760=17.66666667 800=21.5 else=. if cntry=="RO"
* Russia	
recode eduyrs11ma 0=0 100=4 244=9 253=. 254=. 343=. 344=11 353=10 354=13 444=. 453=. 454=12 510=14 520=. 660=15 760=17 800=20.5 else=. if cntry=="RU"
* Slovakia	
recode eduyrs11ma 0=0 100=5.2 244=9.25 253=11.75 254=. 343=. 344=13 353=12 354=13 444=. 453=. 454=14.5 510=15.5 520=. 660=16 760=18.5 800=21 else=. if cntry=="SK"
* Slovenia	
recode eduyrs11ma 0=0 100=6 244=9 253=. 254=. 343=. 344=13.375 353=12 354=13.58333333 444=. 453=. 454=. 510=. 520=15.25 660=16.5 760=18.125 800=21.25 else=. if cntry=="SI"
* Spain	
recode eduyrs11ma 0=0 100=6.00 244=10.25 253=. 254=9.83 343=. 344=12 353=11.66666667 354=12 444=. 453=12.75 454=. 510=. 520=14.33 660=16.25 760=18.63 800=21.50 else=. if cntry=="ES"
* Switzerland	
recode eduyrs11ma 0=0 100=6 244=9.33 253=. 254=10.00 343=11 344=12.41666667 353=12 354=12 444=14.50 453=. 454=14.50 510=. 520=13.50 660=16.38 760=17.67 800=21 else=. if cntry=="CH"
* Sweden	
recode eduyrs11ma 0=0 100=6 244=9.38 253=. 254=10.50 343=13 344=12 353=13 354=. 444=13 453=12.50 454=13 510=. 520=14 660=15.08 760=16.72 800=21 else=. if cntry=="SE"
* Turkey	
recode eduyrs11ma 0=0 100=4 244=8.00 253=. 254=. 343=. 344=12.25 353=12 354=12.125 444=. 453=. 454=. 510=. 520=14 660=16 760=17.6 800=22 else=. if cntry=="TR"
* United Kingdom	
recode eduyrs11ma 0=0 100=8.75 244=9.50 253=. 254=11.5 343=12 344=12.5 353=. 354=14.66666667 444=. 453=. 454=15.25 510=. 520=16.125 660=16 760=17.25 800=21 else=. if cntry=="GB"


********************************************************************************
* Parental average and dominant hypothetical years of education
* averaged over ISCED11 level
********************************************************************************

gen eduyrs11pda=.
replace eduyrs11pda = eduyrs11fa if missing(eduyrs11ma)
replace eduyrs11pda = eduyrs11ma if missing(eduyrs11fa)
replace eduyrs11pda = eduyrs11fa if eduyrs11fa>=eduyrs11ma & !missing(eduyrs11fa)
replace eduyrs11pda = eduyrs11ma if eduyrs11ma>=eduyrs11fa & !missing(eduyrs11ma)

gen eduyrs11paa=((eduyrs11fa+eduyrs11ma)/2)
replace eduyrs11paa = eduyrs11fa if missing(eduyrs97ma) & !missing(eduyrs11fa)
replace eduyrs11paa = eduyrs11ma if missing(eduyrs97fa) & !missing(eduyrs11ma)


********************************************************************************
********************************************************************************
* Combining edulvla and edulvlb, respondent, father, mother, average, dominant
* 
********************************************************************************
********************************************************************************

gen tyrsa = .
replace tyrsa = eduyrs97a if !missing(eduyrs97a)
replace tyrsa = eduyrs11a if !missing(eduyrs11a)

gen tyrsfa = .
replace tyrsfa = eduyrs97fa if !missing(eduyrs97fa)
replace tyrsfa = eduyrs11fa if !missing(eduyrs11fa)

gen tyrsma = .
replace tyrsma = eduyrs97ma if !missing(eduyrs97ma)
replace tyrsma = eduyrs11ma if !missing(eduyrs11ma)

gen tyrspda = .
replace tyrspda = eduyrs97pda if !missing(eduyrs97pda)
replace tyrspda = eduyrs11pda if !missing(eduyrs11pda)

gen tyrspaa = .
replace tyrspaa = eduyrs97paa if !missing(eduyrs97paa)
replace tyrspaa = eduyrs11paa if !missing(eduyrs11paa)

drop eduyrs97a eduyrs11a eduyrs97fa eduyrs11fa eduyrs97ma eduyrs11ma eduyrs97pda eduyrs11pda eduyrs97paa eduyrs11paa