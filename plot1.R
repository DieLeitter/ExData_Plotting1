########################## Data reading

if(!file.exists("./data")){
        dir.create("./data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/power.zip")
unzip("./data/power.zip", exdir = "./data")

### reading the data
# names
powerdata <- read.table("household_power_consumption.txt", sep = ";", skip = 1, col.names = powerdata_names,
                        stringsAsFactors = FALSE, na.strings = c("NA", "?",""))
powerdata_names <- apply(powerdata_names,2, as.character)

# data
powerdata <- read.table("household_power_consumption.txt", sep = ";", skip = 1, col.names = powerdata_names,
                        stringsAsFactors = FALSE, na.strings = c("NA", "?",""))
# seting date/time
DateTime <- paste(powerdata$Date, powerdata$Time)
powerdata$DateTime <- strptime(DateTime, format = "%d/%m/%Y %H:%M:%S")
powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y") #%y-no century, %Y century
str(powerdata)

# Subsetting
datesFeb <- as.Date(c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
powerdata_Feb <- subset(powerdata, powerdata$Date == datesFeb[1] | powerdata$Date == datesFeb[2])
str(powerdata_Feb)



########################## Plot 1
png(file = "Plot1.png")

par(mfcol = c(1,1), pin = c(4.5,4.5))
hist(powerdata_Feb$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()

