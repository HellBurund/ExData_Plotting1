#read data from file "ExDA/household_power_consumption.txt" to data.table named data
data <- fread("ExDA//household_power_consumption.txt", na.strings = c("?"))
#subseting the data from the dates 2007-02-01 and 2007-02-02
data <- subset(data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
#change types of columns that will be used. They were character, because fread tried to save "?" symbols
data[, Sub_metering_1 := as.numeric(Sub_metering_1)]
data[, Sub_metering_2 := as.numeric(Sub_metering_2)]
data[, Sub_metering_3 := as.numeric(Sub_metering_3)]
#save sum of Date and Time to list. It will be used several times
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
#"with" helps to use data.table (or data.frame) columns without writing of data.table name each time
with (data, {
    #create a plot with first dataset and line type
    plot(datetime, Sub_metering_1, main = "", ylab = "Energy sub metering", xlab = "", type = "l")
    #add second dataset as red line
    points(datetime, Sub_metering_2, type = "l", col = "red")
    #add third dataset as blueline
    points(datetime, Sub_metering_3, type = "l", col = "blue")
})
#add legend to the top right corner. Set colored lines as indicators and text size
legend("topright", col = c("black", "red", "blue"), lty = 1, cex = 0.6, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#copy plot to png device
dev.copy(png, "plot3.png")
dev.off()