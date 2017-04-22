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
useful$Voltage<-as.numeric(as.character(useful$Voltage))
useful$Global_reactive_power<-as.numeric(as.character(useful$Global_reactive_power))
useful$DnT<-strptime(paste(useful$Date,useful$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S")

##Setting the device panel into 2 rows and 2 cols

png(filename = "Plot4.png", width = 480,height = 480)
par(mfcol=c(2,2))


##Plotting data on screen device and copying data from screen to PNG device
##1st Plot
with(useful,plot(DnT,Global_active_power,type = "l",main = "",xlab = "",ylab = "Global Active Power"))

##2nd plot
with(useful,plot(DnT,Sub_metering_1,type = "l",xlab = "",ylab = "Energy sub metering"))
  lines(useful$DnT,useful$Sub_metering_2,col="red")
  lines(useful$DnT,useful$Sub_metering_3,col="blue")
  legend("topright",lty = c(1,1,1),col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##3rd Plot
with(useful,plot(DnT,Voltage,type="l",xlab = "datetime"))

##4th Plot
with(useful,plot(DnT,Global_reactive_power,type="l",xlab = "datetime"))


##Setting Par to default
par(mfrow=c(1,1))
dev.off()