#read data from file "ExDA/household_power_consumption.txt" to data.table named data
data <- fread("ExDA//household_power_consumption.txt", na.strings = c("?"))
#subseting the data from the dates 2007-02-01 and 2007-02-02
data <- subset(data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
#change type of Global_active_power. It was character, because fread tried to save "?" symbols 
data[, Global_active_power := as.numeric(Global_active_power)]
#create a histogram
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
#copy plot to png device
dev.copy(png, "plot1.png")
dev.off()
