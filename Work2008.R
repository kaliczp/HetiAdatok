## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2008/bin")
ttfiles <- ttfiles[-26]

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2008/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

ttfilenames <- ls(patt="^h1[1-9abc]")

## Teszt
ttveg <- start(get(ttfilenames[1]))
for(ttfil in 1:length(ttfilenames)) {
    ttelej <- start(get(ttfilenames[ttfil]))
    print(ttelej - ttveg)
    print(ttelej)
    cat(ttfilenames[ttfil],"\n")
    ttveg <- end(get(ttfilenames[ttfil]))
    print(ttveg)
}

## Some duplicated
## Órás csúszkálások egész évben!!!
## Ez lehetett az év, amikor véletlen átálltunk, majd direkt.
## A laptop átállhatott! Utána korrigáltunk.
index(h1407) <- index(h1407) - 60*60

## Újabb véletlen átállítás hosszabban.
index(h1505) <- index(h1505) - 60*60
index(h1513) <- index(h1513) - 60*60
index(h1519) <- index(h1519) - 60*60
index(h1526) <- index(h1526) - 60*60

## 701 – a29
for(tti in 26:43) {
    print(ttfilenames[tti])
    ttmod <- get(ttfilenames[tti])
    index(ttmod) <- index(ttmod) - 60*60
    assign(ttfilenames[tti], ttmod)
}

h1c08 <- h1c08[-436]
## A fenti helyett c12-t eltoljam??

## c1-nél a télit is eltoltam. Jegyzőkönyvvel összenézni.
## Mi volt nyári és téli???

## First piece of time-series
hom2008 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2008 <- c(hom2008, ttakt)
}

ttdiff <- diff(index(hom2008))
which(ttdiff < 30)
which(ttdiff > 30)
index(hom2008)[c(4927, 7614)]
## Hiányzik
## 2008-03-31 11:00:00
## 2008-03-31 11:30:00
hom2008['2008-03-31 10:00/2008-03-31 12:00']
## 2008-05-25 10:00:00
hom2008['2008-05-25 09:30/2008-05-25 11:00']

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
