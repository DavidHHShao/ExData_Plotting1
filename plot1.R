#load sqldf liberary
options(gsubfn.engine = "R")
library(sqldf)

#reading data from the dates 2007-02-01 and 2007-02-02. 
data<- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file
WHERE Date in ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)

#Remove the rows where Global_active_power is NA
data<-data[data$Global_active_power !="?",]


#png Open png device; create  "plot1.png" in my working directory
png(file = "plot1.png")

## Create plot and send to a file 
hist(data$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", col = "red", breaks = 13, 
     ylim = c(0,1200), xlim = c(0, 6), xaxp = c(0, 6, 3), yaxp=c(0,1200,6) )

## Close the PNG file device
dev.off() 

