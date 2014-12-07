#read data from file "ExDA/household_power_consumption.txt" to data.table named data
data <- fread("ExDA//household_power_consumption.txt", na.strings = c("?"))
#subseting the data from the dates 2007-02-01 and 2007-02-02
data <- subset(data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
#change types of columns that will be used. They were character, because fread tried to save "?" symbols
data[, Global_active_power := as.numeric(Global_active_power)]
data[, Voltage := as.numeric(Voltage)]
data[, Sub_metering_1 := as.numeric(Sub_metering_1)]
data[, Sub_metering_2 := as.numeric(Sub_metering_2)]
data[, Sub_metering_3 := as.numeric(Sub_metering_3)]
data[, Global_reactive_power := as.numeric(Global_reactive_power)]
#save sum of Date and Time to list. It will be used several times
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
#set mfrow to show four plots
par(mfrow = c(2, 2))
#"with" helps to use data.table (or data.frame) columns without writing of data.table name each time
with (data, {
    #create first plot. It shows changes of Global_active_power at time
    plot(datetime, Global_active_power, main = "", ylab = "Global Active Power", xlab = "", type = "l")
    #create second plot. It shows changes of Voltage at time
    plot(datetime, Voltage, main = "", ylab = "Voltage", xlab = "datetime", type = "l")
    #create third plot, add 2 sets of points to it and a legend. It shows changes of sub meterings at time
    plot(datetime, Sub_metering_1, main = "", ylab = "Energy sub metering", xlab = "", type = "l")
    points(datetime, Sub_metering_2, type = "l", col = "red")
    points(datetime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.4,  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    #add fourth plot. It shows changes of Global_reactive_power at time
    plot(datetime, Global_reactive_power, main = "", ylab = "Global_reactive_power", xlab = "datetime", type = "l")
})
#copy plot to png device
dev.copy(png, "plot4.png")
dev.off()