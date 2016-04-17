#creates four line charts: global active power, voltage, energy sub metering and global
#reactive power from this data:
#http://archive.ics.uci.edu/ml/
#household_power_consumption.txt must be in the working directory
plot4 <- function() {  
  #we are going to use data.table...make sure it is loaded
  library(data.table) 
  library(lubridate)
  
  #load data from test files    
  tableData = read.table("household_power_consumption.txt", sep=";", header=TRUE) 
  
  par(mfrow=c(2,2))
  
  #pull out just the days we want to study
  startDate <- ymd_hms("2007-02-01-00-00-00")
  endDate <- ymd_hms("2007-02-03-00-00-00")
  tableData$Date <- dmy_hms(gsub(":", "-", paste(tableData$Date, tableData$Time, sep="-")))
  tableRange <- tableData[(tableData$Date >= startDate & tableData$Date <= endDate), ]

  #plot first chart--global active power line chart
  tableRange$Global_active_power <- as.numeric(as.character(tableRange$Global_active_power))
  plot(tableRange$Date, tableRange$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
  
  #plot second chard chart--voltage line chart
  tableRange$Voltage <- as.numeric(as.character(tableRange$Voltage))
  plot(tableRange$Date, tableRange$Voltage, ylab="Voltage", xlab="datetime", type="l")

  #plot third chart--sub metering
  tableRange$Sub_metering_1 <- as.numeric(as.character(tableRange$Sub_metering_1))
  tableRange$Sub_metering_2 <- as.numeric(as.character(tableRange$Sub_metering_2))
  tableRange$Sub_metering_3 <- as.numeric(as.character(tableRange$Sub_metering_3))
  plot(tableRange$Date, tableRange$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
  lines(tableRange$Date, tableRange$Sub_metering_1, col="black")
  lines(tableRange$Date, tableRange$Sub_metering_2, col="red")
  lines(tableRange$Date, tableRange$Sub_metering_3, col="blue")
#  legend("topright", legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))

  #plot fourth chart chart--global reactive power chart
  tableRange$Global_reactive_power <- as.numeric(as.character(tableRange$Global_reactive_power))
  plot(tableRange$Date, tableRange$Global_reactive_power, ylab="Voltage", xlab="Global_reactive_power", type="l")
 
  dev.copy(png, "plot4.png") 
  dev.off()
}