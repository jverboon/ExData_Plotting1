## Read in data, requires internet connection, may take awhile

temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
electric <- read.table(unz(temp, "household_power_consumption.txt"), 
                       sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
unlink(temp)

##subset to important dates

electric_feb <- subset(electric, Date=="1/2/2007"|Date=="2/2/2007")

##convert to date and time class objects
electric_feb$datetime <- paste(electric_feb$Date, electric_feb$Time, sep = " ")
electric_feb$datetime <- strptime(electric_feb$datetime, "%d/%m/%Y %H:%M:%S")

##make file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

##make plot
hist(electric_feb$Global_active_power, main = "Global Active Power",
     col = "red", xlab = "Global Active Power (kilowatts)")

##make the png
dev.off()