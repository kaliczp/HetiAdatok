## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2017/bin")

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2017/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated

ttfilenames <- ls(patt="^h1[1-9abc]")

## First piece of time-series
hom2017 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2017 <- c(hom2017, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2017['2017-01-01/'],"h1full2017.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2017[,1],mean),"napihom2017.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2017[,1],mean),2),"napihom2017.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
