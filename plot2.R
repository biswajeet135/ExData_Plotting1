########################################################
## FILE: PLOT 2
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

## Plot 2
plot(finaldata$Global_active_power~finaldata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()