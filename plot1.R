#clear environment
rm(list = ls())

#install required packages
if(!require(data.table)){
    install.packages("data.table")
    library(data.table)
}

#read data
rawData <- fread("household_power_consumption.txt", na.strings = '?', )

#filtered data for 2007-02-01 and 2007-02-02
filteredData <- subset(rawData, Date == "1/2/2007" | Date == "2/2/2007")

#reformat fields
filteredData$Date <- as.Date(filteredData$Date)
filteredData$Time <- as.POSIXct(strptime(paste(filteredData$Date, filteredData$Time), "%m-%d-%Y %H:%M:%s"))
filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
filteredData$Global_reactive_power <- as.numeric(filteredData$Global_reactive_power)
filteredData$Voltage <- as.numeric(filteredData$Voltage)
filteredData$Global_intensity <-as.numeric(filteredData$Global_intensity)
filteredData$Sub_metering_1 <- as.numeric(filteredData$Sub_metering_1)
filteredData$Sub_metering_2 <- as.numeric(filteredData$Sub_metering_2)
filteredData$Sub_metering_3 <- as.numeric(filteredData$Sub_metering_3)

hist(filteredData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")