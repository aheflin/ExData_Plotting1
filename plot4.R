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

###Create the plot to include the 4 images
par(mfrow=c(2,2))

###Call the plot function to include all 4 graphs
with(subdata,{
        plot(subdata$Time,as.numeric(as.character(subdata$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
        plot(subdata$Time,as.numeric(as.character(subdata$Voltage)), type="l",xlab="datetime",ylab="Voltage")
        plot(subdata$Time,subdata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
        with(subdata,lines(Time,as.numeric(as.character(Sub_metering_1))))
        with(subdata,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
        with(subdata,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
        legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
        plot(subdata$Time,as.numeric(as.character(subdata$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

###Create PNG File
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()