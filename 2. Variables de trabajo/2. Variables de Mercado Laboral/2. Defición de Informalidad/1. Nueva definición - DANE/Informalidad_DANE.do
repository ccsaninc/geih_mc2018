********************************************************************************************
* Insitucion:   	Banco Mundial - Grupo de Empleo 
* Autor: 			Cristian Camilo Sanin Camargo 						  
* Version:			1.0
* Descripción:		Empalme GEIH MC2018
*********************************************************************************************

*** Informalidad Laboral - Construcción de la nueva medición de informalidad ***
*** Nota: Ver presentación del DANE para ver metodologia propuesta ****

    global añot = 2022   // Documentar el año de analisis

* Identificacion de la posicion ocupacional

        gen poc_ocu = .
		replace poc_ocu = 1 if p6430==1 
		replace poc_ocu = 2 if p6430==2
		replace poc_ocu = 3 if p6430==3
		replace poc_ocu = 4 if p6430==4
		replace poc_ocu = 5 if p6430==5
		replace poc_ocu = 6 if p6430==6
		replace poc_ocu = 7 if p6430==7
		replace poc_ocu = 8 if p6430==8
        replace poc_ocu = 8 if p6430==9
		
		label var poc_ocu "Posicion ocupacional"
		label define poc_ocu 1 "Asalariado privado" 2 "Empleados de Gobierno" 3 "Empleado Domestico" 4 "Trabajadores cuenta propia" 5 "Patron" 6 "TF: Trabajador sin remuneracion" 7 "Trabajador sin remuneracion" 8 "Jornalero" 9 "Otro"
		label values poc_ocu poc_ocu 

* Tamaño de la empresa

        recode p3069 (1/3 = 1 ) (4/10 = 0) , gen (tam5_empresa)
        
        label var tam5_empresa "tamaño de la empresa"
		label define tam5_empresa 1 "Hasta 5 personas" 0 "Mayor a 5 personas"
		label values tam5_empresa tam5_empresa

* Año de renovación del registro mercantil

    gen mer_año = 1 if p3067s2 = $añot - 1 
    replace mer_año = 2 if p3067s2 < $añot - 1

    label var mer_año  "Renovar registro mercantil"
	label define mer_año  1 "t-1" 0 "Menor a t-1"
	label values mer_año  mer_año 

* Grupo de Pofesionales

    gen oficio_c8_2 = substr(oficio_c8,1,2)
    destring oficio_c8_2 , replace

    gen oficio_f = 1 if oficio_c8_2 >= 0 & oficio_c8_2 <=14
    replace oficio_f = 0 if oficio_c8_2 >= 21

*- Directorio de variables 

/*
    p6430 - En este trabajo … es?
    p3045 - La empresa, negocio o institución en la que ….. trabaja ¿está registrada o tiene:
    p3045s1 - Opción de camara de comercio
    p3046 - La empresa o negocio en la que …… trabaja tiene una oficina de contabilidad o cuenta con los servicios de un contador?
    p3069 - ¿Cuántas personas en total tiene la empresa, negocio, industria, oficina, firma, finca o sitio donde ... trabaja?
    p6765 - En la semana pasada, ¿cuál de las siguientes formas de trabajo realizó:
    p3067s1 - ¿... ha renovado ese registro?
    p3067s2 - ¿Cuál fue el último año en el que renovó este registro?
    p6775 - ¿El negocio o actividad de ... lleva contabilidad (realiza anualmente balance general y estado de perdidas y ganancias), o libro de registro diario de operaciones?

    *- Variable de Oficio -*

    oficio_c8 - Oficio de los Ocupados
    
    */


*- Generacion de la variable de informalidad

    gen informalidad_DANE = .
    label var informalidad_DANE "Nueva definición DANE MC2018"
    label define informalidad 0 "Formal" 1 "Informal"

*- Ocupados: Asalariados (primera diapositiva)

    * Formal
    replace informalidad_DANE = 0 if poc_ocu ==  2
    replace informalidad_DANE = 0 if (poc_ocu == 1 | poc_ocu == 7) & p3045s1 == 1 
    replace informalidad_DANE = 0 if (poc_ocu == 1 | poc_ocu == 7) & p3045s1 == 2 & p3046 == 1 
    replace informalidad_DANE = 0 if (poc_ocu == 1 | poc_ocu == 7) & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 9 & tam5_empresa == 0

    * Informal
    replace informalidad_DANE = 1 if (poc_ocu == 1 | poc_ocu == 7) & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 2 
    replace informalidad_DANE = 1 if (poc_ocu == 1 | poc_ocu == 7) & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 9 & tam5_empresa == 1

*- Independientes sin negocio: Independientes (Segunda diapositiva)

    * Formal
    replace informalidad_DANE = 0 if (poc_ocu == 4 | poc_ocu == 5) & p6765 != 7 & p3045s1 == 1 
    replace informalidad_DANE = 0 if (poc_ocu == 4 | poc_ocu == 5) & p6765 != 7 & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 1 
    replace informalidad_DANE = 0 if (poc_ocu == 4 | poc_ocu == 5) & p6765 != 7 & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 9 & tam5_empresa == 0

    * Informal    
    replace informalidad_DANE = 1 if (poc_ocu == 4 | poc_ocu == 5) & p6765 != 7 & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 2 
    replace informalidad_DANE = 1 if (poc_ocu == 4 | poc_ocu == 5) & p6765 != 7 & (p3045s1 == 2 | p3045s1 == 9) & p3046 == 2 & tam5_empresa == 1

*- Independientes con negocio: Independientes (Tercera diapositiva)

    * Formal
    replace informalidad_DANE = 0 if (poc_ocu == 4 | poc_ocu == 5) & p6765 == 7 & p3045s1 == 1 & p3067s1 == 1 & mer_año == 1 
    replace informalidad_DANE = 0 if (poc_ocu == 4 | poc_ocu == 5) & p6765 == 7 & p3045s1 == 1 & p3067s1 == 2 & p6775 == 1 

    * Informal    
    replace informalidad_DANE = 1 if (poc_ocu == 4 | poc_ocu == 5) & p6765 == 7 & p3045s1 == 1 & p3067s1 == 1 & mer_año == 0 
    replace informalidad_DANE = 1 if (poc_ocu == 4 | poc_ocu == 5) & p6765 == 7 & p3045s1 == 1 & p3067s1 == 2 & p6775 == 2 
    
    replace informalidad_DANE = 1 if (poc_ocu == 4 | poc_ocu == 5) & p6765 == 7 & p3045s1 == 1 & p3067s1 == 2 & p6775 == 3 






