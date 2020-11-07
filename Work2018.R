## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2018/bin")
## Remove dupe
ttfiles <- ttfiles[-11]

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2018/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
## 2018-06-05 08:30:00 22.16
## 2018-06-05 08:30:00 22.23
h1605 <- h1605[-238]
## 2018-11-30 11:00:00 -2.72
## 2018-11-30 11:00:00 -2.04
h1b30 <- h1b30[-337]
## 2018-12-26 16:30:00 -0.02
## 2018-12-26 16:30:00 -0.48
h1c26 <- h1c26[-349]

ttfilenames <- ls(patt="^h1[1-9abc]")

## First piece of time-series
hom2018 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2018 <- c(hom2018, ttakt)
}

## Átnézni, mert az idők csúszkálnak!!!

## Teljes
write.zoo(hom2018['2018-01-01/'],"h1full2018.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom2018[,1],mean),"napihom2018.csv",sep=";",dec=",")
write.zoo(round(apply.weekly(hom2018[,1],mean),2),"napihom2018.csv",sep=";",dec=",")

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
