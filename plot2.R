#load sqldf liberary
options(gsubfn.engine = "R")
library(sqldf)

#reading data from the dates 2007-02-01 and 2007-02-02. 
data<- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file
WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)

#Remove the rows where Global_active_power is NA
data<-data[data$Global_active_power !="?",]

#conbine date and time values
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")


#Open png device; create  "plot2.png" in my working directory
png(file = "plot2.png")

## Create plot and send to a file 
plot(data$datetime, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

## Close the PNG file device
dev.off() 

