#load sqldf liberary
options(gsubfn.engine = "R")
library(sqldf)

#reading data from the dates 2007-02-01 and 2007-02-02. 
data<- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file
               WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)

#Remove the rows where Sub_metering_1, Sub_metering_2,Sub_metering_3, is NA
data<-data[data$Sub_metering_1 !="?",]
data<-data[data$Sub_metering_2 !="?",]
data<-data[data$Sub_metering_3 !="?",]

#conbine date and time values
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")


#Open png device; create  "plot3.png" in my working directory
png(file = "plot3.png")

## Create plot and send to a file 
plot(data$datetime, data$Sub_metering_1, type = "l",xlab="", ylab = "Energy sub metering")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l",col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

## Close the PNG file device
dev.off() 


