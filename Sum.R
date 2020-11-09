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
hom.heti <- round(apply.weekly(hom,function(x){mean(x, na.rm=TRUE)}),2)
plot(hom.heti, main="Hőmérséklet")

write.zoo(hom.heti,"hetihom.csv",sep=";",dec=",")
