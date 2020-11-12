.First <- function(){Sys.setenv(TZ='UTC')}
ttfile <- dir("Csapi")

for(tti in 1:8) {
    ttaktfile <- ttfile[tti]
    ttakt <- read.csv2(paste0("Csapi/",ttaktfile), enc="latin1", na=c("NA","-"))
    ttaktname <- sub(".csv", "", ttaktfile)
    ttDatejav <- gsub("\\.", "-", ttakt$Date)
    ttPOSIXdattim <- as.POSIXct(paste(ttDatejav, ttakt$Time))
    assign(ttaktname, xts(ttakt$ÚjH.mm., ttPOSIXdattim))
}

for(tti in 9:length(ttfile)) {
    ttaktfile <- ttfile[tti]
    ttakt <- read.table(paste0("Csapi/",ttaktfile), na="-", dec=",", sep = "\t", head = TRUE)
    ttaktname <- sub(".csv", "", ttaktfile)
    ttDatejav <- gsub("\\.", "-", ttakt$Date)
    ttPOSIXdattim <- as.POSIXct(paste(ttDatejav, ttakt$Time))
    assign(ttaktname, xts(ttakt$ÚjH.mm, ttPOSIXdattim))
}

plot(csap2010, type="h")
