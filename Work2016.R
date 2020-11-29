## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2016/bin")

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2016/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
## 2016-03-08 10:30:00 4.34
## 2016-03-08 10:30:00 4.63
h1308 <- h1308[-334]

ttfilenames <- ls(patt="^h1[1-9abcA]")

## First piece of time-series
hom2016 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2016 <- c(hom2016, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2016['2016-01-01/'],"h1full2016.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2016[,1],mean),"napihom2016.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2016[,1],mean),2),"napihom2016.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
