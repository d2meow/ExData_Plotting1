#R script to create plot 12from EDA course

#download data and unzip file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "Power_Consumption.zip", method = "curl")
downloadedDate <- date()
unzip("Power_Consumption.zip")


#load libraries
library(dplyr)
library(lubridate)

#read in features.txt to be used as table header
features <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character",rep("numeric", 7)), na.strings = "?" ) %>%
        mutate(Date = dmy(Date)) %>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
        mutate(DateTime = ymd_hms(paste(Date, Time)),
                Weekday = wday(DateTime, label = TRUE, abbr = TRUE))

#launch png graphics device session
png(filename = "Plot3.png", width = 480, height = 480)

#create line plot
plot(x = features$DateTime,
     y = features$Sub_metering_1,
     type = "l",
     col = "black",
     ylab = "Energy sub-metering",
     xlab = "")

lines(x = features$DateTime, y = features$Sub_metering_2, type = "l", col = "red")
lines(x = features$DateTime, y = features$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
#close graphics device session
dev.off()
