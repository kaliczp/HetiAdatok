## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2015/bin")

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2015/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
ttfilenames <- ls(patt="^h1[1-9abc]")

## Dupla sor
## 2015-04-07 10:30:00 5.29
## 2015-04-07 10:30:00 5.97
h1407 <- h1407[-243]

## First piece of time-series
hom2015 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2015 <- c(hom2015, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2015['2015-01-01/'],"h1full2015.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2015[,1],mean),"napihom2015.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2015[,1],mean),2),"napihom2015.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
