########################################################
## FILE: PLOT 4
########################################################

##GETTING DATA

fileurl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipname <- "household_power_consumption.zip"
if(!file.exists(zipname)) {
  download.file(fileurl,zipname,mode = "wb")
}

filename <- "household_power_consumption.txt"
if(!file.exists(filename)) {
  unzip(zipname)
}

data <- read.table(filename, header = TRUE, sep = ";", na.strings="?", 
                   check.names=F, stringsAsFactors=F)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
head(data)
str(data)

##SUBSETTING DATA

finaldata <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
str(finaldata)

datetime <- paste(as.Date(finaldata$Date), finaldata$Time)
finaldata$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(finaldata, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()