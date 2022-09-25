********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 			Cristian Camilo Sanin Camargo 						  
* Version:			1.0
* Descripción:		Empalme GEIH MC2018
*********************************************************************************************

    gen nu_mes = .

    replace nu_mes = 1 if mes == "Enero"
    replace nu_mes = 2 if mes == "Febrero"
    replace nu_mes = 3 if mes == "Marzo"
    replace nu_mes = 4 if mes == "Abril"
    replace nu_mes = 5 if mes == "Mayo"
    replace nu_mes = 6 if mes == "Junio"
    replace nu_mes = 7 if mes == "Julio"
    replace nu_mes = 8 if mes == "Agosto"
    replace nu_mes = 9 if mes == "Septiembre"
    replace nu_mes = 10 if mes == "Octubre"
    replace nu_mes = 11 if mes == "Noviembre"
    replace nu_mes = 12 if mes == "Diciembre" 

    label var nu_mes "Numero de Mes"

    
    
    table area nu_mes p6920 [iw=fex_c18]

    tab nu_mes p6920 [iw=fex_c18]
