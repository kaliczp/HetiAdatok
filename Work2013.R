## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2013/bin")
### A binárisokban úgy tűnik 522 felül lett írva 722-vel!
## Május 22-én júliusra lett átírva a naptár, így a régi
## adatkivevő laptop néhány hónapot sietett. Csak a Dataqua
## meteo állomás adatait érinti. 701-én lett visszaírva.
## 729 és c17 dupla! 
ttfiles <- ttfiles[-c(25,31,52)]

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2013/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
ttfilenames <- ls(patt="^h1[1-9abc]")

## Date correction
for(tti in c(522, 603, 610, 617)) {
    ttaktfile <- paste0("h1", tti)
    ttnewindex <- index(get(ttaktfile))-61*24*60*60
    ttcore <- coredata(get(ttaktfile))
    assign(ttaktfile, xts(ttcore, ttnewindex))
}

## First piece of time-series
hom2013 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2013 <- c(hom2013, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2013['2013-01-01/'],"h1full2013.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2013[,1],mean),"napihom2013.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2013[,1],mean),2),"napihom2013.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
