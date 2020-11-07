## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2010/bin")
## márc29--ápr 9-ig nem ment az adatgyűjtő angolház festés miatt.
## Hibás fájlok 19:"h1604.waq" 21:"h1609.waq" 22:"h1618.waq"
ttfiles <- ttfiles[-c(19, 21, 22)]

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2010/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
ttfilenames <- ls(patt="^h1[1-9abc]")

## First piece of time-series
hom2010 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2010 <- c(hom2010, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2010['2010-01-01/'],"h1full2010.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2010[,1],mean),"napihom2010.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2010[,1],mean),2),"napihom2010.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
