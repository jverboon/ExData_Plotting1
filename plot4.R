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
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

## make multiple plots on 1, plot 4

par(mfrow = c(2,2))

##top left
plot(electric_feb$datetime, electric_feb$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab ="") 
##top right
plot(electric_feb$datetime, electric_feb$Voltage, type = "l", 
     ylab = "Voltage", xlab ="datetime")

##bottom left
plot(electric_feb$datetime, electric_feb$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab ="")
with(electric_feb, lines(datetime, Sub_metering_2, col = "Red"))
with(electric_feb, lines(datetime, Sub_metering_3, col = "Blue"))
with(electric_feb, legend("topright", lwd = 1, col = c("black", "blue", "red"), 
                          legend = c("Sub_metering_1", "Sub_metering_2", 
                                     "Sub_metering_3"), bty = "n"))
##bottom right
plot(electric_feb$datetime, electric_feb$Global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab ="datetime")


##make the png
dev.off()
