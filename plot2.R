##Reading in data and creating subset
datafull <- read.table("household_power_consumption.txt", skip = 1, sep = ";")
names(datafull) <- c("Date","Time","Global_active_power","Global_reactive_power",
                     "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subdata <- subset(datafull, datafull$Date=="1/2/2007" | datafull$Date =="2/2/2007")

###Change the data and time characters into date and time objects
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
subdata$Time <- strptime(subdata$Time, format="%H:%M:%S")
subdata[1:1440,"Time"] <- format(subdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subdata[1441:2880,"Time"] <- format(subdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

###Call the plot function
plot(subdata$Time,as.numeric(as.character(subdata$Global_active_power)),type="l",xlab="",
     ylab="Global Active Power (kilowatts)") 

###Add the title "Global Active Power vs Time"
title(main = "Global Active Power vs Time")

###Create PNG File
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
