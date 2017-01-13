###Reading in data and creating subset
datafull <- read.table("household_power_consumption.txt", skip = 1, sep = ";")
names(datafull) <- c("Date","Time","Global_active_power","Global_reactive_power",
                     "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata <- subset(datafull, datafull$Date=="1/2/2007" | datafull$Date =="2/2/2007")


###Create a histograph for variable "Global_active_power" color the bars red, add the title "Global Active Power"
###and name the x-axis "Global Active Power (kilowatts)"
hist(as.numeric(as.character(subdata$Global_active_power)), col = "red", main = "Global Active Power", xlab = 
             "Global Active Power (kilowatts)")

###Create PNG File
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
