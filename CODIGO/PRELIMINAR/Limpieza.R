##---------DIRECTORIO-------------------------------------

directorio <- c("/Users/carmorsa/Desktop/PROYECTO")
setwd(directorio)


##-------------------------- PAQUETES ----------------------------
library(reshape2)
library(plyr)
library(tidyr)


##------------------------ IMPORTAR DATOS ------------------------

### FUENTE
setwd("./DATOS/BRUTOS/CSV/FUENTE")

for(i in 2003:2013) {
    mujeres = paste("M", i, sep = "-")
    assign(mujeres, read.csv(paste(mujeres, ".csv", sep="")))
    hombres = paste("H", i, sep = "-")
    assign(hombres, read.csv(paste(hombres, ".csv", sep = "")))
    general = paste("G", i, sep = "-")
    assign(general, read.csv(paste(general, ".csv", sep = "")))
}

`G-2008` <- `G-2008`[1:33,]
`G-2010` <- `G-2010`[4:36,c(1:7,9:12)]
`G-2011` <- `G-2011`[3:35,]
`G-2012` <- `G-2012`[2:34,]
`H-2010` <- `H-2010`[3:35,]
`H-2011` <- `H-2011`[3:35,]
`H-2012` <- `H-2012`[,c(1:6, 8:12)]
`M-2010` <- `M-2010`[2:34,]
`M-2011` <- `M-2011`[3:35,]

`G-2003`$id <- c("G-2003")
`G-2004`$id <- c("G-2004")
`G-2005`$id <- c("G-2005")
`G-2006`$id <- c("G-2006")
`G-2007`$id <- c("G-2007")
`G-2008`$id <- c("G-2008")
`G-2009`$id <- c("G-2009")
`G-2010`$id <- c("G-2010")
`G-2011`$id <- c("G-2011")
`G-2012`$id <- c("G-2012")
`G-2013`$id <- c("G-2013")
`M-2003`$id <- c("M-2003")
`M-2004`$id <- c("M-2004")
`M-2005`$id <- c("M-2005")
`M-2006`$id <- c("M-2006")
`M-2007`$id <- c("M-2007")
`M-2008`$id <- c("M-2008")
`M-2009`$id <- c("M-2009")
`M-2010`$id <- c("M-2010")
`M-2011`$id <- c("M-2011")
`M-2012`$id <- c("M-2012")
`M-2013`$id <- c("M-2013")
`H-2003`$id <- c("H-2003")
`H-2004`$id <- c("H-2004")
`H-2005`$id <- c("H-2005")
`H-2006`$id <- c("H-2006")
`H-2007`$id <- c("H-2007")
`H-2008`$id <- c("H-2008")
`H-2009`$id <- c("H-2009")
`H-2010`$id <- c("H-2010")
`H-2011`$id <- c("H-2011")
`H-2012`$id <- c("H-2012")
`H-2013`$id <- c("H-2013")

nombresFuente <- c("estado", "salud", "imss.ord", "issste",
                   "imss.op", "dif", "pemex", "sedena",
                   "semar", "otras", "total", "id")

names(`G-2003`) <- nombresFuente
names(`G-2004`) <- nombresFuente
names(`G-2005`) <- nombresFuente
names(`G-2006`) <- nombresFuente
names(`G-2007`) <- nombresFuente
names(`G-2008`) <- nombresFuente
names(`G-2009`) <- nombresFuente
names(`G-2010`) <- nombresFuente
names(`G-2011`) <- nombresFuente
names(`G-2012`) <- nombresFuente
names(`G-2013`) <- nombresFuente

names(`M-2003`) <- nombresFuente
names(`M-2004`) <- nombresFuente
names(`M-2005`) <- nombresFuente
names(`M-2006`) <- nombresFuente
names(`M-2007`) <- nombresFuente
names(`M-2008`) <- nombresFuente
names(`M-2009`) <- nombresFuente
names(`M-2010`) <- nombresFuente
names(`M-2011`) <- nombresFuente
names(`M-2012`) <- nombresFuente
names(`M-2013`) <- nombresFuente

names(`H-2003`) <- nombresFuente
names(`H-2004`) <- nombresFuente
names(`H-2005`) <- nombresFuente
names(`H-2006`) <- nombresFuente
names(`H-2007`) <- nombresFuente
names(`H-2008`) <- nombresFuente
names(`H-2009`) <- nombresFuente
names(`H-2010`) <- nombresFuente
names(`H-2011`) <- nombresFuente
names(`H-2012`) <- nombresFuente
names(`H-2013`) <- nombresFuente

fuente <- rbind(`G-2003`, `G-2004`, `G-2005`, `G-2006`, `G-2007`,
                `G-2008`, `G-2009`, `G-2010`, `G-2011`, `G-2012`,
                `G-2013`, `M-2003`, `M-2004`, `M-2005`, `M-2006`,
                `M-2007`, `M-2008`, `M-2009`, `M-2010`, `M-2011`,
                `M-2012`, `M-2013`, `H-2003`, `H-2004`, `H-2005`,
                `H-2006`, `H-2007`, `H-2008`, `H-2009`, `H-2010`, 
                `H-2011`, `H-2012`, `H-2013`)

fuente <- separate(fuente, "id", into = c("genero", "fecha"), sep = "-")

fuente$genero <- gsub("G", "General", fuente$genero)
fuente$genero <- gsub("H", "Hombres", fuente$genero)
fuente$genero <- gsub("M", "Mujeres", fuente$genero)

fuenteLimpia <- fuente[, c(1:10,12,13)]
fuenteLimpia <- subset(fuenteLimpia, estado != "TOTAL GLOBAL ")
fuenteLimpia <- subset(fuenteLimpia, estado != "OTAL GLOBAL ")

Estado <- c("Aguscalientes", "Baja California", "Baja California Sur",
            "Campeche", "Coahuila", "Colima", "Chiapas", "Chihuahua", 
            "Distrito Federal", "Durango", "Guanajuato", "Guerrero",
            "Hidalgo", "Jalisco", "Mexico", "Michoacan", "Morelos",
            "Nayarit", "Nuevo Leon", "Oaxaca", "Puebla", "Queretaro",
            "Quintana Roo", "San Luis Potosi", "Sinaloa", "Sonora",
            "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatan",
            "Zacatecas")
fuenteLimpia$estado <- rep(Estado, 33)

fuenteLimpiaM <- melt(fuenteLimpia, id = c("estado", "genero", "fecha"))
names(fuenteLimpiaM) <- c("estado", "genero", "fecha", "fuente", "casos")


### MES
setwd(directorio)
setwd("./DATOS/BRUTOS/CSV/MES")

for(i in 2003:2013) {
    mujeres = paste("M", i, sep = "-")
    assign(mujeres, read.csv(paste(mujeres, ".csv", sep="")))
    hombres = paste("H", i, sep = "-")
    assign(hombres, read.csv(paste(hombres, ".csv", sep = "")))
    general = paste("G", i, sep = "-")
    assign(general, read.csv(paste(general, ".csv", sep = "")))
}

`G-2003` <- `G-2003`[, c(1, 4:15)]
`G-2004` <- `G-2004`[, c(1, 4:15)]
`G-2005` <- `G-2005`[, c(1, 4:15)]
`G-2006` <- `G-2006`[, c(1, 4:15)]
`G-2007` <- `G-2007`[, c(1, 4:15)]
`G-2008` <- `G-2008`[, c(1, 4:15)]
`G-2009` <- `G-2009`[, c(1, 3:14)]
`G-2010` <- `G-2010`[, c(1, 3:14)]
`G-2011` <- `G-2011`[, c(1, 3:14)]
`G-2012` <- `G-2012`[, c(1, 3:14)]
`G-2013` <- `G-2013`[, c(1, 3:14)]

`H-2003` <- `H-2003`[, c(1, 4:15)]
`H-2004` <- `H-2004`[, c(1, 4:15)]
`H-2005` <- `H-2005`[, c(1, 4:15)]
`H-2006` <- `H-2006`[, c(1, 4:15)]
`H-2007` <- `H-2007`[, c(1, 4:15)]
`H-2008` <- `H-2008`[, c(1, 4:15)]
`H-2009` <- `H-2009`[, c(1, 3:14)]
`H-2010` <- `H-2010`[, c(1, 3:14)]
`H-2011` <- `H-2011`[, c(1, 3:14)]
`H-2012` <- `H-2012`[2:34, c(1, 3:14)]
`H-2013` <- `H-2013`[, c(1, 3:14)]

`M-2003` <- `M-2003`[, c(1, 4:15)]
`M-2004` <- `M-2004`[, c(1, 4:15)]
`M-2005` <- `M-2005`[, c(1, 4:15)]
`M-2006` <- `M-2006`[, c(1, 4:15)]
`M-2007` <- `M-2007`[, c(1, 4:15)]
`M-2008` <- `M-2008`[, c(1, 4:15)]
`M-2009` <- `M-2009`[, c(1, 3:14)]
`M-2010` <- `M-2010`[, c(1, 3:14)]
`M-2011` <- `M-2011`[2:34, c(1, 3:14)]
`M-2012` <- `M-2012`[2:34, c(1, 3:14)]
`M-2013` <- `M-2013`[, c(1, 3:14)]

nombresMes <- c("estado", "ene", "feb", "mar", "abr",
                "may", "jun", "jul", "ago", "sep",
                "oct", "nov", "dic")
names(`G-2003`) <- nombresMes
names(`G-2004`) <- nombresMes
names(`G-2005`) <- nombresMes
names(`G-2006`) <- nombresMes
names(`G-2007`) <- nombresMes
names(`G-2008`) <- nombresMes
names(`G-2009`) <- nombresMes
names(`G-2010`) <- nombresMes
names(`G-2011`) <- nombresMes
names(`G-2012`) <- nombresMes
names(`G-2013`) <- nombresMes

names(`H-2003`) <- nombresMes
names(`H-2004`) <- nombresMes
names(`H-2005`) <- nombresMes
names(`H-2006`) <- nombresMes
names(`H-2007`) <- nombresMes
names(`H-2008`) <- nombresMes
names(`H-2009`) <- nombresMes
names(`H-2010`) <- nombresMes
names(`H-2011`) <- nombresMes
names(`H-2012`) <- nombresMes
names(`H-2013`) <- nombresMes

names(`M-2003`) <- nombresMes
names(`M-2004`) <- nombresMes
names(`M-2005`) <- nombresMes
names(`M-2006`) <- nombresMes
names(`M-2007`) <- nombresMes
names(`M-2008`) <- nombresMes
names(`M-2009`) <- nombresMes
names(`M-2010`) <- nombresMes
names(`M-2011`) <- nombresMes
names(`M-2012`) <- nombresMes
names(`M-2013`) <- nombresMes

`G-2003`$id <- c("G-2003")
`G-2004`$id <- c("G-2004")
`G-2005`$id <- c("G-2005")
`G-2006`$id <- c("G-2006")
`G-2007`$id <- c("G-2007")
`G-2008`$id <- c("G-2008")
`G-2009`$id <- c("G-2009")
`G-2010`$id <- c("G-2010")
`G-2011`$id <- c("G-2011")
`G-2012`$id <- c("G-2012")
`G-2013`$id <- c("G-2013")

`H-2003`$id <- c("H-2003")
`H-2004`$id <- c("H-2004")
`H-2005`$id <- c("H-2005")
`H-2006`$id <- c("H-2006")
`H-2007`$id <- c("H-2007")
`H-2008`$id <- c("H-2008")
`H-2009`$id <- c("H-2009")
`H-2010`$id <- c("H-2010")
`H-2011`$id <- c("H-2011")
`H-2012`$id <- c("H-2012")
`H-2013`$id <- c("H-2013")

`M-2003`$id <- c("M-2003")
`M-2004`$id <- c("M-2004")
`M-2005`$id <- c("M-2005")
`M-2006`$id <- c("M-2006")
`M-2007`$id <- c("M-2007")
`M-2008`$id <- c("M-2008")
`M-2009`$id <- c("M-2009")
`M-2010`$id <- c("M-2010")
`M-2011`$id <- c("M-2011")
`M-2012`$id <- c("M-2012")
`M-2013`$id <- c("M-2013")

mes <- rbind(`G-2003`, `G-2004`, `G-2005`, `G-2006`, `G-2007`,
             `G-2008`, `G-2009`, `G-2010`, `G-2011`, `G-2012`,
             `G-2013`, `H-2003`, `H-2004`, `H-2005`, `H-2006`,
             `H-2007`, `H-2008`, `H-2009`, `H-2010`, `H-2011`,
             `H-2012`, `H-2013`, `M-2003`, `M-2004`, `M-2005`,
             `M-2006`, `M-2007`, `M-2008`, `M-2009`, `M-2010`,
             `M-2011`, `M-2012`, `M-2013`)

mes <- separate(mes, "id", into = c("genero", "fecha"), sep = "-")

mes$genero <- gsub("G", "General", mes$genero)
mes$genero <- gsub("H", "Hombres", mes$genero)
mes$genero <- gsub("M", "Mujeres", mes$genero)

mesLimpia <- subset(mes, estado != "TOTAL GLOBAL ")
mesLimpia <- subset(mesLimpia, estado != "T OTAL GLOBAL ")

mesLimpia$estado <- rep(Estado, 33)

mesLimpiaM <- melt(mesLimpia, id = c("estado", "genero", "fecha"))
names(mesLimpiaM) <- c("estado", "genero", "fecha", "mes", "casos")


## EDAD
setwd(directorio)
setwd("./DATOS/BRUTOS/CSV/EDAD")

for(i in 2003:2013) {
  mujeres = paste("M", i, sep = "-")
  assign(mujeres, read.csv(paste(mujeres, ".csv", sep="")))
  hombres = paste("H", i, sep = "-")
  assign(hombres, read.csv(paste(hombres, ".csv", sep = "")))
  general = paste("G", i, sep = "-")
  assign(general, read.csv(paste(general, ".csv", sep = "")))
}

`G-2011` <- `G-2011`[2:34,]
`H-2011` <- `H-2011`[2:34,]
`H-2012` <- `H-2012`[2:34,]
`M-2010` <- `M-2010`[, c(1,3:15)]
`M-2011` <- `M-2011`[2:34,]

nombresEdad <- c("estado","<1", "1a4", "5a9", "10a14", "15a19",
                 "20a24","25a44", "45a49", "50a59", "60a64",
                 "65+", "ign", "total")

names(`G-2003`) <- nombresEdad
names(`G-2004`) <- nombresEdad
names(`G-2005`) <- nombresEdad
names(`G-2006`) <- nombresEdad
names(`G-2007`) <- nombresEdad
names(`G-2008`) <- nombresEdad
names(`G-2009`) <- nombresEdad
names(`G-2010`) <- nombresEdad
names(`G-2011`) <- nombresEdad
names(`G-2012`) <- nombresEdad
names(`G-2013`) <- nombresEdad

names(`H-2003`) <- nombresEdad
names(`H-2004`) <- nombresEdad
names(`H-2005`) <- nombresEdad
names(`H-2006`) <- nombresEdad
names(`H-2007`) <- nombresEdad
names(`H-2008`) <- nombresEdad
names(`H-2009`) <- nombresEdad
names(`H-2010`) <- nombresEdad
names(`H-2011`) <- nombresEdad
names(`H-2012`) <- nombresEdad
names(`H-2013`) <- nombresEdad

names(`M-2003`) <- nombresEdad
names(`M-2004`) <- nombresEdad
names(`M-2005`) <- nombresEdad
names(`M-2006`) <- nombresEdad
names(`M-2007`) <- nombresEdad
names(`M-2008`) <- nombresEdad
names(`M-2009`) <- nombresEdad
names(`M-2010`) <- nombresEdad
names(`M-2011`) <- nombresEdad
names(`M-2012`) <- nombresEdad
names(`M-2013`) <- nombresEdad

`G-2003`$id <- c("G-2003")
`G-2004`$id <- c("G-2004")
`G-2005`$id <- c("G-2005")
`G-2006`$id <- c("G-2006")
`G-2007`$id <- c("G-2007")
`G-2008`$id <- c("G-2008")
`G-2009`$id <- c("G-2009")
`G-2010`$id <- c("G-2010")
`G-2011`$id <- c("G-2011")
`G-2012`$id <- c("G-2012")
`G-2013`$id <- c("G-2013")

`H-2003`$id <- c("H-2003")
`H-2004`$id <- c("H-2004")
`H-2005`$id <- c("H-2005")
`H-2006`$id <- c("H-2006")
`H-2007`$id <- c("H-2007")
`H-2008`$id <- c("H-2008")
`H-2009`$id <- c("H-2009")
`H-2010`$id <- c("H-2010")
`H-2011`$id <- c("H-2011")
`H-2012`$id <- c("H-2012")
`H-2013`$id <- c("H-2013")

`M-2003`$id <- c("M-2003")
`M-2004`$id <- c("M-2004")
`M-2005`$id <- c("M-2005")
`M-2006`$id <- c("M-2006")
`M-2007`$id <- c("M-2007")
`M-2008`$id <- c("M-2008")
`M-2009`$id <- c("M-2009")
`M-2010`$id <- c("M-2010")
`M-2011`$id <- c("M-2011")
`M-2012`$id <- c("M-2012")
`M-2013`$id <- c("M-2013")

edad <- rbind(`G-2003`, `G-2004`, `G-2005`, `G-2006`, `G-2007`,
              `G-2008`, `G-2009`, `G-2010`, `G-2011`, `G-2012`,
              `G-2013`, `H-2003`, `H-2004`, `H-2005`, `H-2006`,
              `H-2007`, `H-2008`, `H-2009`, `H-2010`, `H-2011`,
              `H-2012`, `H-2013`, `M-2003`, `M-2004`, `M-2005`,
              `M-2006`, `M-2007`, `M-2008`, `M-2009`, `M-2010`,
              `M-2011`, `M-2012`, `M-2013`)

edad <- separate(edad, "id", into = c("genero", "fecha"), sep = "-")

edad$genero <- gsub("G", "General", edad$genero)
edad$genero <- gsub("H", "Hombres", edad$genero)
edad$genero <- gsub("M", "Mujeres", edad$genero)

edadLimpia <- edad[,c(1:13,15,16)]
edadLimpia <- subset(edadLimpia, estado != "TOTAL GLOBAL ")
edadLimpia <- subset(edadLimpia, estado != "T OTAL GLOBAL ")
edadLimpia$estado <- rep(Estado, 33)

edadLimpiaM <- melt(edadLimpia, id = c("estado", "genero", "fecha"))
names(edadLimpiaM) <- c("estado", "genero", "fecha", "edad", "casos")


## -------------------- LIMPIEZA DE DATOS ----------------------

fuenteLimpiaM$casos <- gsub(" ", "", fuenteLimpiaM$casos) 
edadLimpiaM$casos <- gsub(" ", "", edadLimpiaM$casos)
mesLimpiaM$casos <- gsub(" ", "", mesLimpiaM$casos)

fuenteLimpiaM$casos <- as.numeric(fuenteLimpiaM$casos)
edadLimpiaM$casos <- as.numeric(edadLimpiaM$casos)
mesLimpiaM$casos  <- as.numeric(mesLimpiaM$casos)

###En la base original de genero por mes, el dato real es 626
mesLimpiaM[11941, 5] <- 626

fuenteLimpiaM <- fuenteLimpiaM[!is.na(fuenteLimpiaM$casos),]
mesLimpiaM <- mesLimpiaM[!is.na(mesLimpiaM$casos),]
edadLimpiaM <- edadLimpiaM[!is.na(edadLimpiaM$casos),]

## ---------------------- FECHAS ------------------------------

fuenteLimpiaM$fecha2 <- c("01/01/")
fuenteLimpiaM$fecha3 <- unite(fuenteLimpiaM, fecha2, fecha)

## --------------------- EXPORTAR DATOS ------------------------
setwd(directorio)
setwd("./DATOS/PROCESADOS")

write.csv(fuenteLimpiaM, file = "Fuente.csv")
write.csv(edadLimpiaM, file = "Edad.csv")
write.csv(mesLimpiaM, file = "Mes.csv")