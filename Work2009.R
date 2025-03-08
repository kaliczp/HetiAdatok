## waqImport a ~/Kutatás/binHidegviz/waqImport.R  ill. binHidegviz
Sys.setenv(TZ='UTC')

ttfiles <- dir("2009/bin")

ttfiles <- ttfiles[-40]

## Import binary files
for(ttname in ttfiles) {
    ttshortname <- sub("\\.waq","",ttname)
    assign(ttshortname, waqImport(paste0("2009/bin/",ttname), freq.in.sec = 1800, trunc.unit = "hour", Correction = 100)-41.1)
    print(start(get(ttshortname)));print(end(get(ttshortname)))
}

## Some duplicated
## 2009-04-27 10:30:00 14.97
## 2009-04-27 10:30:00 15.96
h1427 <- h1427[-336]

## Elcsúszott??
## 2009-07-06 13:30:00 22.44
## 2009-07-06 15:00:00 21.83
## Mérés h1713 Kivételénél 10:47-et mutatott az óra nyári idő? Ellenőr!
## 2009-07-13 11:30:00 19.25
## 2009-07-13 11:00:00 22.26
index(h1713) <- index(h1713) - 60*60

## h1120 Rossz évszám
## 2080-01-02 14:00:00
## 2080-01-06 13:30:00
index(h1120) <- index(h1120) - 25918*24*60*60

ttfilenames <- ls(patt="^h1[1-9abc]")

## First piece of time-series
hom2009 <- get(ttfilenames[1])
## All files
for(tti in 2:length(ttfilenames)) {
    ## Next piece of time-series
    ttakt <- get(ttfilenames[tti])
    ## Contecanate with  actual
    hom2009 <- c(hom2009, ttakt)
}

ttdiff <- diff(index(hom2009))
which(ttdiff < 30)
which(ttdiff > 30)
index(hom2009)[c(6519, 7524)]
## Hiányzik
## 2009-05-04 11:00:00
hom2009['2009-05-04 10:00/2009-05-04 11:30']
## 2009-05-25 10:00:00
hom2009['2009-05-25 09:30/2009-05-25 11:00']

## Takarítás
rm(list = ttfilenames)
rm(list = ls(patt = "^tt"))
