* p524a1 = Ingreso total del mes anterior
* p208a = Edad
* p207 = Sexo

* ssc install estout
* cd ""

use "enaho01a_2020_500.dta", clear

* Borra las otras variables
keep conglome fac estrato ubigeo p524a1 p208a p207

* Dropeo las que no tienen información
drop if p524a1==.


svyset conglome [pw=fac], strata(estrato)

egen ubigeogroup = group(ubigeo)


su ubigeogroup, meanonly

 forvalues i = 1/`r(max)' {
    svy: regress p524a1 p208a p207 if ubigeogroup == `i'
	estimates store perf`i'
	esttab perf`i' using C:\Users\Sofia\Downloads\DATATON\Stata\csvs\est`i'.csv, b(3)
	estimates clear
}

save ubigeogroup.dta
