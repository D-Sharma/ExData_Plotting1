
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

hist(sub$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()   #Close the png device.