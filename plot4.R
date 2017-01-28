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



########################## Plot 4

png(filename = "Plot4.png")

par(mfcol = c(2,2))
par(mar = c(5, 5, 3, 5),  mai = c(1, 1, 0.5, 0.15))

with(powerdata_Feb, {
        plot(x = DateTime, y = Global_active_power, type ="l", 
             ylab = "Global Active Power", xlab = "")
        
        plot(x =DateTime , y = Sub_metering_1, type ="l", col ="black",
             ylab = "Energy sub metering", xlab = "")
        lines(x =DateTime , y = Sub_metering_2, type ="l", col ="red")
        lines(x =DateTime , y = Sub_metering_3, type ="l", col ="blue")
        legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", 
                                                                              "Sub_metering_2",
                                                                              "Sub_metering_3"), bty = "n")
        
        plot(x =DateTime, y = Voltage, ylab = "Voltage", xlab = "datetime", type = "l")
        plot(x=DateTime, y = Global_reactive_power, xlab = "datetime", type = "l")
        
        
})
dev.off()
dev.set(2)

