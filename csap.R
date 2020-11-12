.First <- function(){Sys.setenv(TZ='UTC')}
ttfile <- dir("Csapi")

for(tti in 1:7) {
    ttaktfile <- ttfile[tti]
    ttakt <- read.csv2(paste0("Csapi/",ttaktfile), enc="latin1", na=c("NA","-"))
    ttaktname <- sub(".csv", "", ttaktfile)
    ttDatejav <- gsub("\\.", "-", ttakt$Date)
    ttPOSIXdattim <- as.POSIXct(paste(ttDatejav, ttakt$Time))
    assign(ttaktname, xts(ttakt$ÚjH.mm., ttPOSIXdattim))
}

for(tti in 8:length(ttfile)) {
    ttaktfile <- ttfile[tti]
    ttakt <- read.table(paste0("Csapi/",ttaktfile), na="-", dec=",", sep = "\t", head = TRUE)
    ttaktname <- sub(".csv", "", ttaktfile)
    ttDatejav <- gsub("\\.", "-", ttakt$Date)
    ttPOSIXdattim <- as.POSIXct(paste(ttDatejav, ttakt$Time))
    assign(ttaktname, xts(ttakt$ÚjH.mm, ttPOSIXdattim))
}

plot(csap2010, type="h")

## 2017 javítás
sum(oldcsap2017, na.rm=T) #631.8
sum(csap2017, na.rm=T) #692.71

plot.zoo(csap2017, lwd = 2, type="h")
lines(as.zoo(oldcsap2017), lwd =2, col="red", type="h")

## Összefűzés
csap <- c(csap2010, csap2011, csap2012, csap2013, csap2014, csap2015, csap2016, csap2017, csap2018, csap2019, csap2020)

csap.full <- c(csap, xts(rep(0,568), seq(as.POSIXct("2009-12-27")+23.5*60*60,as.POSIXct("2020-11-10")+1, by="weeks")))

## Heti összeg
csapsum <- apply.weekly(csap.full,function(x)(sum(x, na.rm=TRUE)))

homcsap <- cbind(hom.all,csapsum)

write.zoo(homcsap, "hetihomcsap.csv",sep=";",dec=",")


apply.yearly(csap.full,function(x)(sum(x, na.rm=TRUE)))
