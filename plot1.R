

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

png("plot1.png",width=480,height = 480)
par(mfrow = c(1, 1))
hist(as.numeric(data_select$Global_active_power),col = "red",xlab = 
       "Global Active Power (kilowatts)",main = "")
dev.off()