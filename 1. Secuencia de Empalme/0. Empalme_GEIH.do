********************************************************************************************
* Insitucion:   	Banco Mundial 
* Autor: 			Cristian Camilo Sanin Camargo 						  
* Version:			1.0
* Descripción:		Empalme GEIH MC2018
*********************************************************************************************

	* Parametros iniciales 
	clear all
	set more off
	cls 
	
	* Variables de trabajo

		* Directorios de trabajo	
		global path "F:\OneDrive - Ministerio del Trabajo\3. Proyectos\8. GEIH_M2018"
		
		
		* Variables de trabajo
		global f_i 2022							// Año de Trabajo (inicial)
		global f_f 2022							// Año de trabajo (final)
		
		global mes_ref 	Enero
		global mes_tra 	Febrero Marzo Abril Mayo Junio // Julio Agosto Septiembre Octubre Noviembre Diciembre
		global mes 		$mes_ref $mes_tra
	
		* Secuencia de trabajo 
		
		forvalues año = $f_i / $f_f {
			
			cd "$path/`año'/"
			shell rmdir "1. GEIH_Mes" /s /q
			mkdir "1. GEIH_Mes"
			
		}
		
		* 1. Arreglos de Nombres 
				
		forvalues año = $f_i / $f_f {
			

			foreach mes in $mes {
		
					cd "$path/`año'/`mes'/"
					
					use "Características generales, seguridad social en salud y educación.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					use "Datos del hogar y la vivienda.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "Fuerza de trabajo.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "Migración.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "No ocupados.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "Ocupados.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "Otras formas de trabajo.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "Otros ingresos e impuestos.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear
					
					*----------------------------
					
					use "Tipo de investigación.dta" , replace
					rename *, lower
					
					tostring mes , replace
					replace mes = "`mes'"
					
					compress
					save, replace
					clear	
										
									
			}
			
		}	
		

		
		* Pegado de las base de datos para consolidad una mensual 
		
		forvalues año = $f_i / $f_f {
	
			foreach mes in $mes {
		
				cd "$path/`año'/`mes'/"
					
					use "Características generales, seguridad social en salud y educación.dta", clear
					
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "Fuerza de trabajo.dta", nogen
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "No ocupados.dta",nogen
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "Ocupados.dta",nogen
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "Otras formas de trabajo.dta",nogen
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "Otros ingresos e impuestos.dta",nogen
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "Tipo de investigación.dta",nogen
					merge 1:1 directorio secuencia_p hogar orden periodo mes using "Migración.dta",nogen
					
					merge m:1 directorio secuencia_p hogar periodo mes using "Datos del hogar y la vivienda.dta",nogen
					
				save "$path/`año'/1. GEIH_Mes/GEIH18_`año'_`mes'.dta" , replace	
					
			}
			
		}
			
		
		* Unificar todos los meses en un solo año 
		
		forvalues año = $f_i / $f_f {
			
			cd "$path/`año'/1. GEIH_Mes/"
			
				use "GEIH18_`año'_$mes_ref.dta", clear 
				
				foreach db of global mes_tra {
					
					append using "GEIH18_`año'_`db'.dta" , force
					
				}
					
				save "GEIH_`año'.dta" , replace
				
			}
			
			
* -- Finalizacion del Proceso -- *
clear all 
window stopbox note "Proceso finalizado con exito! Los archivos fueron creados en la " ///
"La carpeta: - $path -" "Autor: Cristian Camilo Sanin"