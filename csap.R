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
