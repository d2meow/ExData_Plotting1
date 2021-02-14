#R script to create plot 1 from EDA course

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
        filter(Date >= "2007-02-01" & Date <= "2007-02-02")

#launch png graphics device session
png(filename = "Plot1.png", width = 480, height = 480)

#create histogram
hist(features$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

#close graphics device session
dev.off()
