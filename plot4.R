require(data.table)
require(dplyr)
require(lubridate)

fileZipPath<-"household.zip"
filePath<-"household_power_consumption.txt"

URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(fileZipPath)){
  download.file(URL,fileZipPath)
}

if(!file.exists(filePath)){
  unzip(fileZipPath)
}

if(!exists("datah")){
  datah<-fread(filePath)
}

if(!exists("data_select")){
  data_select<-filter(datah,Date=="1/2/2007" | Date=="2/2/2007")
  data_select<-mutate(data_select,datetime=dmy_hms(sprintf("%s %s",Date,Time)))
}

png("plot4.png",width=480,height = 480)

par(mfrow = c(2, 2))

plot(data_select$datetime,data_select$Global_active_power,type = "l", ylab = 
       "Global Active Power", xlab="")

plot(data_select$datetime,data_select$Voltage,type = "l",ylab = "Voltage", 
     xlab = "datetime")

plot(data_select$datetime,data_select$Sub_metering_1,type = "l",col="black", 
     xlab = "",ylab="Energy sub metering",lwd=1)

lines(data_select$datetime,data_select$Sub_metering_2, col="red",lwd=1)
lines(data_select$datetime,data_select$Sub_metering_3, col="blue",lwd=1)
legend("topright", col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd=1)

plot(data_select$datetime,data_select$Global_reactive_power,type = "l")

dev.off()