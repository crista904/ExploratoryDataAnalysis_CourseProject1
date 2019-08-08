##  Overview of steps for plot 4
##  Step 1: Import data
##  Step 2: Ensure data is formatted correctly and columns are labelled
##  Step 3: Subset data
##  Step 4: Use mfrow function to indicate that you want 4 plots per pg then plot


##  Prior to starting ensure that you are in the correct working directory.
##  If not, set wd with setwd("x") function

##  Step 1: Import data using read.csv function

EPC <- read.csv("~/household_power_consumption.txt", sep=";", na.strings="?")


##  Step 2: Ensure data is formatted correctly and columns are labelled
##  Make a single column that contains both date and time 
##  Format from character to POSIXt
##  Using strptime() function instead of as.Date() because it contains both dates and times

EPC$DateTime<-paste(EPC$Date, EPC$Time)
EPC$DateTime<-strptime(EPC$DateTime, "%d/%m/%Y %H:%M:%S")

##  Validation
##  class() should = "POSIXlt" "POSIXt"
##  data.frame[,1:10] = independent observations

## Also need to convert Global_active_power to numeric using as.numeric() function

EPC$Global_active_power <- as.numeric(EPC$Global_active_power)
EPC$Sub_metering_1 <- as.numeric(EPC$Sub_metering_1)
EPC$Sub_metering_2 <- as.numeric(EPC$Sub_metering_2)
EPC$Sub_metering_3 <- as.numeric(EPC$Sub_metering_3)
EPC$Voltage <- as.numeric(EPC$SVoltage)

##  Step 3: Subset data
##  Only want two days - Feb 2, 2007 and Feb 1, 2007
##  Ensure each date keeps it's time or else graphs won't look right

EPC_subset <- subset(EPC, DateTime >= "2007-02-01 00:00:00" & DateTime <= "2007-02-02 12:59:59")

##  Step 4: Use mfrow function to indicate that you want 4 plots per pg then plot

png("plot4.png", width=480, height=480)  

par(mfrow = c(2,2))
#   Plot 1 - top left
plot(EPC_subset$DateTime, EPC_subset$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ")
#   Plot 2 - top right
plot(EPC_subset$DateTime, EPC_subset$Voltage, type = "l", xlab = "datetime", ylab ="Voltage")
#   Plot 3 - bottom left
plot(EPC_subset$DateTime, EPC_subset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ")
lines(EPC_subset$DateTime, EPC_subset$Sub_metering_2, col = "Red", type ="l")
lines(EPC_subset$DateTime, EPC_subset$Sub_metering_3, col = "Blue", type ="l")
legend("topright", col= c("Azure4", "Red", "Blue"), c("Submetering 1", "Submetering 2", "Submetering 3"), lwd = c(1,1))
#   Plot 4 - bottom right
plot(EPC_subset$DateTime, EPC_subset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
