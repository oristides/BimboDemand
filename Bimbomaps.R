#install.packages("ggmap")


library(ggmap)
library(stringi)

town$TownExtract<- gsub("AG.","", (gsub("[0-9][0-9][0-9][0-9]","", x = town$Town,  perl = TRUE)),perl = TRUE)
town$number<- substr(x = town$Town, start = 1, stop = 4)
town$direccion<-paste(town$TownExtract," ",town$State," ","Mexico")

bimbogeocode<-geocode(location = town$direccion) #usando el API de GOogle para geocodificar llas ciudades y con un poco mayor de precición si colocamos Agencia Bimbo.

Agenciasbimbo<-cbind(town,bimbogeocode)
Agenciasbimbo

qmap("Mexico")

??ggmap
MexicoMap <- ggmap(get_googlemap(center=as.numeric(geocode("Mexico Country")), scale=2, zoom=5), extent="normal")

pointsbimbo<-MexicoMap + geom_point(data=bimbogeocode, aes(x=lon, y=lat), col="red", alpha=0.4)

pdf(pointsbimbo,
  
  file = "AgenciasDEBimboMExico.pdf", width = 8, height = 8)

