##  Overview of steps for plotting plot 3
##  Step 1: Import data
##  Step 2: Ensure data is formatted correctly and columns are labelled
##  Step 3: Subset data
##  Step 4: Plot 3 lines on 1 plot and save as a PNG file


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

##  Step 3: Subset data
##  Only want two days - Feb 2, 2007 and Feb 1, 2007
##  Ensure each date keeps it's time or else graphs won't look right

EPC_subset <- subset(EPC, DateTime >= "2007-02-01 00:00:00" & DateTime <= "2007-02-02 12:59:59")

##  Step 4: Plot 3 lines on 1 plot and save as a PNG file

png("plot3.png", width=480, height=480)
plot(EPC_subset$DateTime, EPC_subset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ")
lines(EPC_subset$DateTime, EPC_subset$Sub_metering_2, col = "Red", type ="l")
lines(EPC_subset$DateTime, EPC_subset$Sub_metering_3, col = "Blue", type ="l")
legend("topright", col= c("Azure4", "Red", "Blue"), c("Submetering 1", "Submetering 2", "Submetering 3"), lwd = c(1,1))
dev.off()
