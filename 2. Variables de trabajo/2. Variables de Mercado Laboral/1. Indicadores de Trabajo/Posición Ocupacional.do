********************************************************************************************
* Insitucion:   	Banco Mundial - Grupo de Empleo 
* Autor: 			Cristian Camilo Sanin Camargo 						  
* Version:			1.0
* Descripción:		Empalme GEIH MC2018
*********************************************************************************************

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

**
* Nota: TF = Trabajador familiar