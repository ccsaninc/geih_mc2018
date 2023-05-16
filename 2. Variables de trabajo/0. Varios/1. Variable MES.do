********************************************************************************************
* Insitucion:   	Ministerio del Trabajo
* Autor: 			Cristian Camilo Sanin Camargo 						  
* Version:			1.0
* Descripción:		Empalme GEIH MC2018
*********************************************************************************************

    gen n_mes = .

    replace n_mes = 1 if mes == "Enero"
    replace n_mes = 2 if mes == "Febrero"
    replace n_mes = 3 if mes == "Marzo"
    replace n_mes = 4 if mes == "Abril"
    replace n_mes = 5 if mes == "Mayo"
    replace n_mes = 6 if mes == "Junio"
    replace n_mes = 7 if mes == "Julio"
    replace n_mes = 8 if mes == "Agosto"
    replace n_mes = 9 if mes == "Septiembre"
    replace n_mes = 10 if mes == "Octubre"
    replace n_mes = 11 if mes == "Noviembre"
    replace n_mes = 12 if mes == "Diciembre" 

    label var n_mes "Numero de Mes"