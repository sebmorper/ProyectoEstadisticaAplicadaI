####  Transformacion de los Datos. 

##### I. Extraccion de los Datos. 
#####  
Primero, se llevo a cabo la extraccion de los datos desde la pagina de la Secretaria de Salud:  
  http://www.epidemiologia.salud.gob.mx/anuario/html/anuarios.html  
Fueron descargados 99 archivos PDF que contienen la informacion de los casos de diabetes reportados para hombres, mujeres y a nivel general para los anios 2003 a 2013, dependiendo de la categoria seleccionada: Grupo de Edad, Tipo de Fuente y Mes.  

##### II. Cambio de Formato (PDF a CSV).  
#####  
Para poder hacer uso de los datos extraidos, el formato de los archivos debe ser de texto plano, es decir, .txt o .csv. Para hacer el cambio de formato de PDF a CSV utilizo el programa TABULA (http://www.tabula.tecnology).  
De los archivos PDF fueron transformados 99 archivos CSV, a cada archivo le fue asignado un nombre especificando el genero y el anio de los datos contenidos y despues guardados en carpetas dependiendo de la categoria de los datos(Tipo de Fuente, Grupo de Edad o Mes).  
ej.  
"PROYECTO/DATOS/BRUTOS/CSV/MES/G-2009" Se refiere al reporte general de 2009 por mes.  
"PROYECTO/DATOS/BRUTOS/CSV/FUENTE/M-2003"  se refiere al reporte de mujeres en 2003 por tipo de fuente.  

Esto con el fin de homologar los nombres y generar una secuencia para leer, procesar y compilar los datos mediante codigo R.  

##### III. Limpieza y Compilacion de Datos.  
#####  
Mediante codigo R se realiza la lectura, limpieza y compilacion de los datos para, finalmente, generar tres nuevos archivos con la informacion lista para realizar los respectivos analisis.  

La lectura consiste en cargar los 33 archivos csv de cada una de las categorias para hombres, mujeres y general durante el periodo 2003 a 2013.  

La limpieza de los datos consiste en la homologacion de titulos, orden de las columnas, simplificar los nombres de las variables categoricas, como por ejemplo:  
  "San Luis Potos??" en "San Luis Potosi".  
Tambien se quitan los espacios entre el numero de casos para que la variable pueda ser tomada en cuenta como numerica, ejemplo:  
  "2 45" a 245.  

La compilacion de los datos es simplemente integrar los 33 archivos de cada categoria en una sola tabla.  

Para mayor informacion al respecto se puede revisar el codigo en los siguientes archivos:    
  PROYECTO/CODIGO/PRELIMINAR/Limpieza.R  
PROYECTO/CODIGO/PRELIMINAR/Limpieza.RData  