#read data from file "ExDA/household_power_consumption.txt" to data.table named data
data <- fread("ExDA//household_power_consumption.txt", na.strings = c("?"))
#subseting the data from the dates 2007-02-01 and 2007-02-02
data <- subset(data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
#change type of Global_active_power. It was character, because fread tried to save "?" symbols
data[, Global_active_power := as.numeric(Global_active_power)]
# "with" helps to use data.table (or data.frame) columns without writing of data.table name each time
with (data, {
    #sum of Date and Time is x-axis value and Global_active_power is y-axis value. Plot has "l" type, so it is line
    plot(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"), Global_active_power, main = "", ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
})
#copy plot to png device
dev.copy(png, "plot2.png")
dev.off()