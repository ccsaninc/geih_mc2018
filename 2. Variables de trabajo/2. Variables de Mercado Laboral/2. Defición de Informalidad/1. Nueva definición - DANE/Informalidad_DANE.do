********************************************************************************************
* Insitucion:   	Banco Mundial - Grupo de Empleo 
* Autor: 		    Cristian Camilo Sanin Camargo 						  
* Version:		    1.0
* Descripción:		Definicion de informalidad - DANE MC2018 - Nueva 
*********************************************************************************************

*** Informalidad Laboral - Construcción de la nueva medición de informalidad ***
*** Nota: Ver presentación del DANE para ver metodologia propuesta ****

    clear
    cd " "  // Documentar la ruta de trabajo
    dir

use GEIH2022.dta , clear // data

gen anios=(per-1)
gen oficio_c8_2d=substr(oficio_c8,1,2)
destring oficio_c8_2d, replace

gen formal =.

replace formal=0 if p6430==3
replace formal=0 if p6430==6 & formal==.
replace formal=1 if inlist(rama2d_r4,"84","99") & formal==.
replace formal=0 if p6430==8 & formal==.

*********************
*	ASALARIADOS		*
*********************
replace formal=1 if p6430==2 & formal==.
replace formal=1 if inlist(p6430,1,7) & p3045s1==1 & formal==.  /*Tiene CC*/
replace formal=1 if inlist(p6430,1,7) & (inlist(p3045s1,2,9) & p3046==1) & formal==. /* No registra cc, SI contabilidad*/
replace formal=0 if inlist(p6430,1,7) & (inlist(p3045s1,2,9) & p3046==2) & formal==. /* NO registra cc, NO contabilidad*/
replace formal=1 if (inlist(p6430,1,7) & (inlist(p3045s1,2,9) & p3046==9) & p3069>=4) & formal==. /* NO registra cc, NO contabilidad, +5 */
replace formal=0 if (inlist(p6430,1,7) & (inlist(p3045s1,2,9) & p3046==9) & p3069<=3) & formal==. /* NO registra cc, NO contabilidad, -5 */


*********************
*	INDEPENDIENTES	*
*********************
*****************
* SIN NEGOCIO	*
*****************
replace formal=1 if (inlist(p6430,4,5) & p6765!=7 & p3065==1) & formal==. /*No tiene negocio, Si CC */
replace formal=1 if (inlist(p6430,4,5) & p6765!=7 & inlist(p3065,2,9) & p3066==1) & formal==. /*No negocio,No o N/S CC, SI contabilidad */
replace formal=0 if (inlist(p6430,4,5) & p6765!=7 & inlist(p3065,2,9) & p3066==2) & formal==. /*No negocio,No o N/S CC, No contabilidad */
replace formal=1 if (p6430==5 		  & p6765!=7 & inlist(p3065,2,9) & p3066==9 & p3069>=4) & formal==. /*No neg,No o N/S CC, N/S contab,Empre >5 */
replace formal=0 if (p6430==5         & p6765!=7 & inlist(p3065,2,9) & p3066==9 & p3069<=3) & formal==. /*No neg,No o N/S CC, N/S contab,Empre <=5 */
replace formal=1 if (p6430==4 		  & p6765!=7 & inlist(p3065,2,9) & p3066==9 & (oficio_c8_2d>=0 & oficio_c8_2d<=20)) & formal==. /*No neg,No o N/S CC, N/S contab*/
replace formal=0 if (p6430==4 		  & p6765!=7 & inlist(p3065,2,9) & p3066==9 & (oficio_c8_2d>=21)) & formal==. /*No neg,No o N/S CC, N/S contab

*********************************************
*	CON NEGOCIO; CON REGISTRO MERCANTIL		*
********************************************/

replace formal=1 if (inlist(p6430,4,5) & p6765==7 & p3067==1 & p3067s1==1 & p3067s2>=anios) & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==1 & p3067s1==1 & p3067s2<anios) & formal==.
replace formal=1 if (inlist(p6430,4,5) & p6765==7 & p3067==1 & p3067s1==2 & p6775==1) & formal==.
replace formal=1 if (inlist(p6430,4,5) & p6765==7 & p3067==1 & p3067s1==2 & p6775==3 & (oficio_c8_2d >=0 & oficio_c8_2d<=20)) & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==1 & p3067s1==2 & p6775==3 & (oficio_c8_2d >=21)) & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==1 & p3067s1==2 & p6775==2) & formal==.
replace formal=1 if (p6430==4 & p6765==7 & p3067==1 & p3067s1==2 & p6775==9 & (oficio_c8_2d>=0 & oficio_c8_2d<=20)) & formal==.
replace formal=0 if (p6430==4 & p6765==7 & p3067==1 & p3067s1==2 & p6775==9 & (oficio_c8_2d>=21)) & formal==.
replace formal=1 if (p6430==5 & p6765==7 & p3067==1 & p3067s1==2 & p6775==9 & p3069>= 4) & formal==.
replace formal=0 if (p6430==5 & p6765==7 & p3067==1 & p3067s1==2 & p6775==9 & p3069<=3) & formal==.

******************************
*	SIN REGISTRO MERCANTIL	 *
******************************
replace formal=1 if (inlist(p6430,4,5) & p6765==7 & p3067==2 & p6775==1 & p3068==1)  & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==2 & p6775==1 & p3068==2) & formal==.
replace formal=1 if (inlist(p6430,4,5) & p6765==7 & p3067==2 & p6775==3 & (oficio_c8_2d>=0 & oficio_c8_2d<=20)) & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==2 & p6775==3 & (oficio_c8_2d>=21)) & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==2 & p6775==1 & p3068==9) & formal==.
replace formal=0 if (inlist(p6430,4,5) & p6765==7 & p3067==2 & p6775==2) & formal==.
replace formal=1 if (p6430==5 & p6765==7 & p3067==2 & p6775==9 & p3069>=4) & formal==.
replace formal=0 if (p6430==5 & p6765==7 & p3067==2 & p6775==9 & p3069<=3) & formal==.
replace formal=1 if (p6430==4 & p6765==7 & p3067==2 & p6775==9 & (oficio_c8_2d>=0 & oficio_c8_2d<=20)) & formal==. 
replace formal=0 if (p6430==4 & p6765==7 & p3067==2 & p6775==9 & (oficio_c8_2d>=21)) & formal==.

*****************************
*	OCUPACIÃ"N INFORMAL		*	
*****************************

*************
*	SALUD	*
*************
gen salud=.
replace salud=1 if ((inlist(p6430,1,2,3,7) & inlist(p6100,1,2) & inlist(p6110,1,2,4))) & salud==. /*Contr, espec*/ /*empre, parte y parte, le descuentan de pensi*/
replace salud=1 if ( inlist(p6430,1,2,3,7) & p6100==9 & p6450==2) & salud==. /*no sabe regimen*//*contrato escrito*/
replace salud=1 if ( inlist(p6430,1,2,3,7) & p6110==9 & p6450==2) & salud==. /*no sabe quien paga*//*contrato escrito*/
replace salud=0 if   inlist(p6430,1,2,3,7) & salud==.

*****************
*	PENSION	*
*****************
gen pension=.
replace pension=1 if (inlist(p6430,1,2,3,7) & p6920==3) & pension==.
replace pension=1 if (inlist(p6430,1,2,3,7) & p6920==1 & inlist(p6930,1,2,3) & inlist(p6940,1,3)) & pension==. /*Privado, colpen, Reg esp*/ /*paga una parte, la empresa*/
replace pension=0 if  inlist(p6430,1,2,3,7) & pension==.

*****************************
*	OCUPACIÃ"N INFORMAL		*
*****************************
gen ei=.
replace ei=0 if inlist(p6430,6,8) & ei==.
replace ei=formal if inlist(p6430,4,5) & ei==.
replace ei=1 if inlist(p6430,1,2,3,7) & (salud==1 & pension==1) & ei==.
replace ei=0 if inlist(p6430,1,2,3,7) & ei==.

*- Tab de verificación de di file -*

tab ei if oci==1 & inlist(mes,5,6,7) [iw=fex_c18 /3],m
