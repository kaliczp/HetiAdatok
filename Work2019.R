## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("bin")

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
## ttfilenames <- ls(patt="^h1[1-9abc]")

## Missing????
## 2019-04-05 – 2019-04-12
## 2019-05-14 – 2019-05-16

## First piece of time-series
hom <- get(ttfilenames[1])
## Shift to zero
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom <- c(hom, ttakt)
}

## Átnézni, mert az idők csúszkálhatnak!!!
ttime <- index(hom)
ttime[diff(ttime) < 30]; which(diff(ttime) < 30)
ttime[diff(ttime) > 30]; which(diff(ttime) > 30)

data.frame(dat=sort(c(ttime[diff(ttime) < 30],ttime[diff(ttime) > 30])))

## Leállások, hiányok
ttime[11736:11737] # Csak 1; "2019-09-06 08:30:00 UTC – 2019-09-06 09:30:00 UTC"
ttime[14240:14241] # Csak 1; "2019-10-28 13:00:00 UTC – 2019-10-28 14:00:00 UTC"

## Ha kell nagyobb lyukat pótolni:
## ttimeplusz <- c(ttimeplusz, seq(as.POSIXct('2019-05-14 11:30:00'),as.POSIXct('2019-05-16 16:00:00'), by="30 mins"))
ttimeplusz <- c(as.POSIXct(c("2019-09-06 09:00:00","2019-10-28 13:30:00")))
hom.kieg <- xts(as.numeric(rep(NA, length(ttimeplusz))), ttimeplusz)

hom <- c(hom, hom.kieg)

## Teljes
write.zoo(hom['2019-01-01/'],"h1full.csv",sep=";",dec=",")

## Átlag
write.zoo(apply.daily(hom[,1],mean),"napihom2019.csv",sep=";",dec=",")

######################################################################
## Kiss Marci
######################################################################
akt <- coredata(apply.daily(hom['2019-12-01/'],max))
