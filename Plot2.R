##Downloading and Unzipping file
fname<-"Power_Data.zip"
if(!file.exists(fname)) {
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "Power_Data.zip")
}
unzip("Power_Data.zip")

library(lubridate)

data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)
##Parsing the Date column into a date object
data$Date<-dmy(data$Date)

##Subsetting Data to just two dates
useful<-subset(data,data$Date=="2007-02-01" | data$Date=="2007-02-02")

##converting the required column of data into numeric data
useful$Global_active_power<-as.numeric(as.character(useful$Global_active_power))
useful$Sub_metering_1<-as.numeric(as.character(useful$Sub_metering_1))
useful$Sub_metering_2<-as.numeric(as.character(useful$Sub_metering_2))
useful$Sub_metering_3<-as.numeric(as.character(useful$Sub_metering_3))
useful$DnT<-strptime(paste(useful$Date,useful$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S")

##Plotting data on screen device and copying data from screen to PNG device
with(useful,plot(DnT,Global_active_power,type = "l",main = "",xlab = "",ylab = "Global Active Power(kilowatts)"))
dev.copy(png,"Plot2.png",width=480,height=480)
dev.off()
