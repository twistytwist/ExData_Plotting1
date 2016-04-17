#creates a histogram of global active power from this data:
#http://archive.ics.uci.edu/ml/
#household_power_consumption.txt must be in the working directory
plot1 <- function() {  
  #we are going to use data.table...make sure it is loaded
  library(data.table) 
  library(lubridate)
  
  #load data from test files    
  tableData = read.table("household_power_consumption.txt", sep=";", header=TRUE) 

  #pull out just the days we want to study
  startDate <- ymd("2007-02-01")
  endDate <- ymd("2007-02-02")
  tableData$Date <- dmy(as.character(tableData$Date))
  tableRange <- tableData[(tableData$Date >= startDate & tableData$Date <= endDate), ]
  
  #plot global active power histogram to png
  png("plot1.png", width=480, height=480)
  hist(as.numeric(as.character(tableRange$Global_active_power)), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()
}