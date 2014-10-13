#load sqldf liberary
options(gsubfn.engine = "R")
library(sqldf)

#reading data from the dates 2007-02-01 and 2007-02-02. 
data<- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file
                    WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)

#Remove the rows where Sub_metering_1, Sub_metering_2,Sub_metering_3 are NA
data<-data[data$Sub_metering_1 !="?",]
data<-data[data$Sub_metering_2 !="?",]
data<-data[data$Sub_metering_3 !="?",]

#Remove the rows where Global_active_power, Global_reactive_power, Voltage  are  NA
data<-data[data$Global_active_power !="?",]
data<-data[data$Global_reactive_power!="?",]
data<-data[data$ Voltage !="?",]

#conbine date and time values
data$datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

#Open png device; create  "plot4.png" in my working directory
png(file = "plot4.png")

# Create plots and send to a file 

# Create 2X2 matrix for displaying images
par(mfrow = c(2, 2))

# Create  plot1 on topLeft 
plot(data$datetime, data$Global_active_power, type = "l",  xlab = "", 
     ylab = "Global Active Power")

#Create  plot2 on topRight
plot(data$datetime, data$Voltage, xlab = "datetime",ylab = "Voltage", type = "l")

# Create plot3 on bottomLeft
plot(data$datetime, data$Sub_metering_1, type = "l",
     xlab = "",ylab = "Energy sub metering", col = "black")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
        bty = "n")

# Create plot4 bottomRight
plot(data$datetime, data$Global_reactive_power, type = "l", 
     xlab = "datetime",ylab = "Global_reactive_power",ylim = c(0, 0.5))

## Close the PNG file device
dev.off() 

