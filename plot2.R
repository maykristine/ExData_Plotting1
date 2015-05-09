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

## Plot data
library(datasets)
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "./figure/plot2.png")
dev.off
