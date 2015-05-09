## Will need modifications for if working on platforms other than Mac

## Prepare file
setwd("~/Documents/ExData_Plotting1")
if (!file.exists("data")) {
        dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
unzip("./data/household_power_consumption.zip", exdir = "./data")

## Prepare data
library("data.table")
data <- read.csv("./data/household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE)
data <- subset(data, (Date == "1/2/2007") | (Date == "2/2/2007"))
data[data == "?"] <- NA
data$Datetime <- paste(data$Date, data$Time, sep = " ")
data$Datetime <- strptime(data$Datetime, format = "%d/%m/%Y %H:%M:%S" )
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Plot data
library(datasets)
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(data$Datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data$Datetime, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)
plot(data$Datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "./figure/plot4.png")
dev.off
