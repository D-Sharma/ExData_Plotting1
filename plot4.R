
#----------------------------------
#Step 1: Read data and subset data
#---------------------------------

#Read the top lines from the dataset
#The NA values are represented by ?
#The separator for this dataset is ; (semi colan)
data <- read.table(file = "data/household_power_consumption.txt", sep = ";", nrows = 250000, header = T, na.strings = "?", stringsAsFactors = F)

#Concatenate date and time and convert it to data and time in R.
data$DateTime <- paste(data$Date, " ", data$Time)
data$DateTime <- strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")

#Convert data to Date type in R
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Subset data for first 2 days of february 2007 i.e.2007-02-01 and 2007-02-02
sub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

png(file = "plot4.png", bg = "white", width = 480, height = 480)

#------------------------------
#Step 2: Plot multiple graphs
#------------------------------

par(mfcol = c(2,2))

#Graph 1 - Global active power
#-------------------------------
plot( sub$DateTime, sub$Global_active_power, xlab = "", ylab = "Global Active Power", type ="l")

#Graph 2 - Energy sub metering
#-------------------------------
#Get min and max range for y axis
yrange <- range(c(sub$Sub_metering_1, sub$Sub_metering_2, sub$Sub_metering_3), na.rm = T)

# Plot the graph
plot( sub$DateTime, sub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type ="l", ylim = yrange, col = "black")

lines(sub$DateTime, sub$Sub_metering_2, col = "red")    # Add lines for sub_metering_2
lines(sub$DateTime, sub$Sub_metering_3, col = "blue")   # Add lines for sub_metering 3

legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), cex = 0.7, bty = "n")


#Graph 3 - Voltage
#--------------------
with(sub, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

#Graph 4 - Global reactive power
#------------------------------
with(sub, plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l"))

dev.off()   #Close the png device.