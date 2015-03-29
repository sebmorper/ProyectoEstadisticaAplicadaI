#Directorios
BRUTOS <- c ("C:\\Users\\sebastian.morales\\Desktop\\PROYECTO\\DATOS\\BRUTOS")
PROCESADOS <- c("C:\\Users\\sebastian.morales\\Desktop\\PROYECTO\\DATOS\\PROCESADOS")

#Paquetes
library(reshape2)
library(ggplot2)
library(plyr)
library(tidyr)

#Importar Datos
setwd(BRUTOS)
fuente <- read.csv("Fuente.csv", sep = ",", as.is = TRUE)
mes <- read.csv("Mes.csv", sep = ",", as.is = TRUE)
edad <- read.csv("Edad.csv", sep = ",", as.is = TRUE)

#Estructura de Datos
head(fuente)
str(fuente)

head(mes)
str(mes)

head(edad)

#Transformacion
fuenteLimpia <- subset(fuente, Estado != "TOTAL GLOBAL ")
mesLimpia <- subset(mes, Estado != "TOTAL GLOBAL ")
mesLimpia <- subset(mesLimpia, Estado != "T OTAL GLOBAL ")
edadLimpia <- subset(edad, Estado != "TOTAL GLOBAL ")
edadLimpia <- subset(edadLimpia, Estado != "T OTAL GLOBAL ")
fuenteLimpia <- fuenteLimpia[,1:12]
edadLimpia <- edadLimpia[, c(1:13, 15, 16)]
Estado <- c("Aguscalientes", "Baja California", "Baja California Sur",
            "Campeche", "Coahuila", "Colima", "Chiapas", "Chihuahua", 
            "Distrito Federal", "Durango", "Guanajuato", "Guerrero",
            "Hidalgo", "Jalisco", "Mexico", "Michoacan", "Morelos",
            "Nayarit", "Nuevo Leon", "Oaxaca", "Puebla", "Queretaro",
            "Quintana Roo", "San Luis Potosi", "Sinaloa", "Sonora",
            "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatan",
            "Zacatecas")
fuenteLimpia$Estado <- rep(Estado, 33)
mesLimpia$Estado <- rep(Estado, 33)
edadLimpia$Estado <- rep(Estado, 33)
names(edadLimpia) <- c("Estado", "0", "1_4", "5_9", "10_14", "15_19",
                       "20_24", "25_44", "45_49", "50_59", "60_64",
                       "65+", "Ign", "Fecha", "Genero")
fuenteLimpiaM <- melt(fuenteLimpia, id = c("Estado", "Genero", "Fecha"))
mesLimpiaM <- melt(mesLimpia, id = c("Estado", "Genero", "Fecha"))
edadLimpiaM <- melt(edadLimpia, id = c("Estado", "Genero", "Fecha"))
names(fuenteLimpiaM) <- c("Estado", "Genero", "Fecha", "Fuente", "Casos")
names(mesLimpiaM) <- c("Estado", "Genero", "Fecha", "Mes", "Casos")
names(edadLimpiaM) <- c("Estado", "Genero", "Fecha", "Edad", "Casos")

#NAs
fuenteLimpiaM$Casos <- gsub(" ", "", fuenteLimpiaM$Casos)
mesLimpiaM$Casos <- gsub(" ", "", mesLimpiaM$Casos)
edadLimpiaM$Casos <- gsub(" ", "", edadLimpiaM$Casos)
fuenteLimpiaM$Casos <- as.numeric(fuenteLimpiaM$Casos)
mesLimpiaM$Casos <- as.numeric(mesLimpiaM$Casos)
edadLimpiaM$Casos <- as.numeric(edadLimpiaM$Casos)
fuenteLimpiaM <- fuenteLimpiaM[!is.na(fuenteLimpiaM$Casos),]
mesLimpiaM <- mesLimpiaM[!is.na(mesLimpiaM$Casos),]
edadLimpiaM <- edadLimpiaM[!is.na(edadLimpiaM$Casos),]

###EN EL ARCIVO ORIGINAL EL DATO DEL MES DE DIC 2013 EN COAHUILA ES 626
###EL ARCHIVO CSV TENEMOS 66 POR LO QUE HAREMOS UN CAMBIO
mesLimpiaM[12293,5] <- 626

#Exportar Datos
setwd(PROCESADOS)
write.csv(fuenteLimpiaM, file = "Fuente.csv")
write.csv(mesLimpiaM, file = "Mes.csv")
write.csv(edadLimpiaM, file = "Edad.csv")

#Calidad de los Datos
fuente <- read.csv("Fuente.csv", sep = ",", as.is = TRUE)
mes <- read.csv("Mes.csv", sep = ",", as.is = TRUE)
edad <- read.csv("Edad.csv", sep = ",", as.is = TRUE)


###Numero Estados medidos por Genero y fuente al Año
table(fuente$Genero, fuente$Fuente, fuente$Fecha)

###Numero de Estados medidos por Genero al Año 
table(mes$Genero, mes$Mes, mes$Fecha)

###
table(edad$Genero, edad$Edad, edad$Fecha)

###Numero de casos por Genero al Año  
for(i in 2003:2013) {
  General[i-2002] <- sum(subset(fuente, Fecha == i & Genero == "General")$Casos)
  Masculino[i-2002] <- sum(subset(fuente, Fecha == i & Genero == "Masculino")$Casos)
  Femenino[i-2002] <- sum(subset(fuente, Fecha == i & Genero == "Femenino")$Casos)
  Fecha[i-2002] <- i
  Total <- Masculino + Femenino
  Diferencia <- Total - General
  TablaFuenteFecha <- data.frame(Fecha, General, Masculino, Femenino, Total, Diferencia)
}
TablaFuenteFecha
###REVISAR ARCHIVO PDF General 2009 Fuente!!!!

i <- 2003
General <- NULL
Masculino <- NULL
Femenino <- NULL
Fecha <- NULL
while(i <= 2013) {
    General[i-2002] <- sum(subset(fuente, Fecha == i & Genero == "General")$Casos)
    Masculino[i-2002] <- sum(subset(fuente, Fecha == i & Genero =="Masculino")$Casos)
    Femenino[i-2002] <- sum(subset(fuente, Fecha == i & Genero == "Femenino")$Casos)
    Fecha[i-2002] <- i
    Total <- Masculino + Femenino
    Diferencia <- Total - General
    TablaFuenteFecha <- data.frame(Fecha, General, Masculino, Femenino, Total, Diferencia)
    i <- i+1
}

i <- 2003
while(i <= 2013) {
    General[i-2002] <- sum(subset(mes, Fecha == i & Genero == "General")$Casos)
    Masculino[i-2002] <- sum(subset(mes, Fecha == i & Genero =="Masculino")$Casos)
    Femenino[i-2002] <- sum(subset(mes, Fecha == i & Genero == "Femenino")$Casos)
    Fecha[i-2002] <- i
    Total <- Masculino + Femenino
    Diferencia <- Total - General
    TablaMesFecha <- data.frame(Fecha, General, Masculino, Femenino, Total, Diferencia)
    i <- i+1
}

i <- 2003
while(i <= 2013) {
    General[i-2002] <- sum(subset(edad, Fecha == i & Genero == "General")$Casos)
    Masculino[i-2002] <- sum(subset(edad, Fecha == i & Genero =="Masculino")$Casos)
    Femenino[i-2002] <- sum(subset(edad, Fecha == i & Genero == "Femenino")$Casos)
    Fecha[i-2002] <- i
    Total <- Masculino + Femenino
    Diferencia <- Total - General
    TablaEdadFecha <- data.frame(Fecha, General, Masculino, Femenino, Total, Diferencia)
    i <- i+1
}


###Numero de casos por G??nero al a??o
for(i in 2003:2013) {
  General[i - 2002] <- sum(subset(mes, (Fecha == i & Genero =="General"))$Casos))
  Masculino[i - 2002] <- sum(subset(mes, (Fecha == i & Genero == "Masculino"))$Casos))
  Femenino[i - 2002] <- sum(subset(mes, (Fecha == i & Genero == "Femenino"))$Casos))
  Fecha[i - 2002] <- i
  Total <- Masculino + Femenino
  Diferencia <- Total - General
  TablaMesFecha <- data.frame(Fecha, General, Masculino, Femenino, Total, Diferencia)
}
TablaMesFecha


#Analisis Exploratorio

## GENERAL
####Se ha registrado una mayor cantidad de diabetes tipo II en mujeres (2003-2013)
TablaGeneral <- TablaEdadFecha[,1:4]
CasosTotales <- sum(TablaGeneral$General)
CasosTotalesMasculino <- sum(TablaGeneral$Masculino)
CasosTotalesFemenino <- sum(TablaGeneral$Femenino)
TablaCasosTotales <- data.frame(CasosTotalesMasculino, CasosTotalesFemenino, CasosTotales)
names(TablaCasosTotales) <- c("Masculino", "Femenino", "Total")
TablaCasosTotales

CasosTotalesFemeninoPorcentaje <- (CasosTotalesFemenino / CasosTotales) * 100
CasosTotalesMasculinoPorcentaje <- (CasosTotalesMasculino / CasosTotales) * 100
TablaCasosPorcentaje <- data.frame(CasosTotalesMasculinoPorcentaje, CasosTotalesFemeninoPorcentaje)
names(TablaCasosPorcentaje) <- c("Masculino", "Femenino")
TablaCasosPorcentaje
###CAMBIAR A GGPLOT2
barplot(c(TablaCasosPorcentaje$Masculino, TablaCasosPorcentaje$Femenino),
        xlab = c("Masculino    Femenino"))


##Tendencias Anuales
#####ASIGNAR UNA TABLA GENERAL POR A??O
maxCasosAnual <- subset(TablaGeneral, TablaGeneral$General == max(TablaGeneral$General))$Fecha
maxCasosAnualMasc <- subset(TablaGeneral, TablaGeneral$Masculino == max(TablaGeneral$Masculino))$Fecha
maxCasosAnualFem <- subset(TablaGeneral, TablaGeneral$Femenino == max(TablaGeneral$Femenino))$Fecha
minCasosAnual <- subset(TablaGeneral, TablaGeneral$General == min(TablaGeneral$General))$Fecha
minCasosAnualMasc <- subset(TablaGeneral, TablaGeneral$Masculino == min(TablaGeneral$Masculino))$Fecha
minCasosAnualFem <- subset(TablaGeneral, TablaGeneral$Femenino == min(TablaGeneral$Femenino))$Fecha
Masculino <- c(minCasosAnualMasc, maxCasosAnualMasc)
Femenino <- c(minCasosAnualFem, maxCasosAnualFem)
General <- c(minCasosAnual, maxCasosAnual)

TablaMinMax <- data.frame(Masculino, Femenino, General)
row.names(TablaMinMax) <- c("min", "max")
TablaMinMax

promedioAnual <- mean(TablaGeneral$General)
promedioAnualMasc <- mean(TablaGeneral$Masculino)
promedioAnualFem <- mean(TablaGeneral$Femenino)
TablaPromedioAnual <- data.frame(promedioAnual, promedioAnualFem, promedioAnualMasc)
names(TablaPromedioAnual) <- c("General", "Femenino", "Masculino")
TablaPromedioAnual
###CAMBIAR A GGPLOT2
plot(General ~ Fecha , data = TablaMesFecha, type = "l", ylim = c(100000, 450000))
lines(TablaMesFecha$Fecha, TablaMesFecha$Masculino, col = "blue")
lines(TablaMesFecha$Fecha, TablaMesFecha$Femenino, col = "red")

###Estado
i  <- 1
General <- NULL
Masculino <- NULL
Femenino <- NULL
while(i <= 32) {
    General[i] <- sum(subset(mes, Estado[i] == mes$Estado & Genero == "General")$Casos)
    Masculino[i] <- sum(subset(mes, Estado[i] == mes$Estado & Genero == "Masculino")$Casos)
    Femenino[i] <- sum(subset(mes, Estado[i] == mes$Estado & Genero == "Femenino")$Casos)
    i <- i+1
}
TablaGeneralEstados <- data.frame(Estado, General, Masculino, Femenino)
maxEstado <- as.character(subset(TablaGeneralEstados, TablaGeneralEstados$General == max(TablaGeneralEstados$General))$Estado)
minEstado <- as.character(subset(TablaGeneralEstados, TablaGeneralEstados$General == min(TablaGeneralEstados$General))$Estado)
maxEstadoMasc <- as.character(subset(TablaGeneralEstados, TablaGeneralEstados$Masculino == max(TablaGeneralEstados$Masculino))$Estado)
minEstadoMasc <- as.character(subset(TablaGeneralEstados, TablaGeneralEstados$Masculino == min(TablaGeneralEstados$Masculino))$Estado)
maxEstadoFem <- as.character(subset(TablaGeneralEstados, TablaGeneralEstados$Femenino == max(TablaGeneralEstados$Femenino))$Estado)
minEstadoFem <- as.character(subset(TablaGeneralEstados, TablaGeneralEstados$Femenino == min(TablaGeneralEstados$Femenino))$Estado)
Masculino <- c(minEstadoMasc, maxEstadoMasc)
Femenino <- c(minEstadoFem, maxEstadoFem)
General <- c(minEstado, maxEstado)
TablaMinMaxEstados <- data.frame(Masculino, Femenino, General)
row.names(TablaMinMaxEstados) <- c("min", "max")

i  <- 1
General <- NULL
Masculino <- NULL
Femenino <- NULL
while(i <= 32) {
    General[i] <- sum(subset(mes, Estado[i] == mes$Estado & Genero == "General")$Casos) * 100 / CasosTotales
    i <- i+1
}
TablaEstadosPorcentaje <- data.frame(Estado, General)
TablaEstadosPorcentaje <- TablaEstadosPorcentaje[order(-TablaEstadosPorcentaje$General),]


### Por Fuente

