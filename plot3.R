#clear environment
rm(list = ls())

#install required packages 
if(!require(data.table)){
    install.packages("data.table")
    library(data.table)
}

#read data
rawData <- fread("household_power_consumption.txt", na.strings = '?' )

#filtered data for 2007-02-01 and 2007-02-02
filteredData <- subset(rawData, Date == "1/2/2007" | Date == "2/2/2007")

#reformat fields
filteredData$DateTime <- as.POSIXct(strptime(paste(filteredData$Date, filteredData$Time), "%d/%m/%Y %H:%M:%S"))
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
filteredData$Global_reactive_power <- as.numeric(filteredData$Global_reactive_power)
filteredData$Voltage <- as.numeric(filteredData$Voltage)
filteredData$Global_intensity <-as.numeric(filteredData$Global_intensity)
filteredData$Sub_metering_1 <- as.numeric(filteredData$Sub_metering_1)
filteredData$Sub_metering_2 <- as.numeric(filteredData$Sub_metering_2)
filteredData$Sub_metering_3 <- as.numeric(filteredData$Sub_metering_3)

#create the plot
par(cex = .75)
plot(filteredData$DateTime, filteredData$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
lines(filteredData$DateTime, filteredData$Sub_metering_1, type = "l", col = "black")
lines(filteredData$DateTime, filteredData$Sub_metering_2, type = "l", col = "red")
lines(filteredData$DateTime, filteredData$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))


dev.copy(png, file = "plot3.png")
dev.off()
