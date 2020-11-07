## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2014/bin")
## június 10 -- június 16?

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2014/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
ttfilenames <- ls(patt="^h1[1-9abc]")

## First piece of time-series
hom2014 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2014 <- c(hom2014, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2014['2014-01-01/'],"h1full2014.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2014[,1],mean),"napihom2014.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2014[,1],mean),2),"napihom2014.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
