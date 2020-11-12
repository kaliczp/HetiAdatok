ttallhomnam <- ls(patt="hom2")

hom <- hom2010
ttallhomnam <- paste0("hom20", 11:20)
for(ttobj in ttallhomnam) {
    ttaktind <- index(hom)
    ttaktend <- ttaktind[length(ttaktind)]
    ttaktstart <- ttaktend + 30*60
    hom <- c(hom, get(ttobj)[paste(ttaktstart,"/")])
}

plot(apply.weekly(hom,mean))
hom.dummy <- xts(rep(10,568), seq(as.POSIXct("2009-12-27")+23.5*60*60,as.POSIXct("2020-11-10")+1, by="weeks"))
hom.full <- c(hom, hom.dummy['2010-06-07/2010-06-20'])
hom.heti <- round(apply.weekly(hom.full,function(x){mean(x, na.rm=TRUE)}),2)

plot(hom.heti, main="Hőmérséklet")

write.zoo(hom.heti,"hetihom.csv",sep=";",dec=",")

hom.min <- round(apply.weekly(hom.full,function(x){min(x, na.rm=TRUE)}),2)
hom.max <- round(apply.weekly(hom.full,function(x){max(x, na.rm=TRUE)}),2)
hom.all <- cbind(hom.min, hom.heti, hom.max)
write.zoo(hom.all,"hetihom.csv",sep=";",dec=",")
