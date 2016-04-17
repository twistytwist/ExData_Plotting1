#creates a line chart of global active power from this data:
#http://archive.ics.uci.edu/ml/
#household_power_consumption.txt must be in the working directory
plot2 <- function() {  
  #we are going to use data.table...make sure it is loaded
  library(data.table) 
  library(lubridate)
  
  #load data from test files    
  tableData = read.table("household_power_consumption.txt", sep=";", header=TRUE) 
  
  #pull out just the days we want to study
  startDate <- ymd_hms("2007-02-01-00-00-00")
  endDate <- ymd_hms("2007-02-03-00-00-00")
  tableData$Date <- dmy_hms(gsub(":", "-", paste(tableData$Date, tableData$Time, sep="-")))
  tableRange <- tableData[(tableData$Date >= startDate & tableData$Date <= endDate), ]
  
  #plot global active power line chart to png
  tableRange$Global_active_power <- as.numeric(as.character(tableRange$Global_active_power))
  png("plot2.png", width=480, height=480)
  plot(tableRange$Date, tableRange$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
  dev.off()
}