# Read in 'household_power_consumption.txt' in working directory
rawData <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", quote='\"', stringsAsFactors=F)

# Convert date string into Date type
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")

# Subset data to just Feb 1st 2007 - Feb 2nd 2007
subsetData <- rawData[(rawData$Date >= "2007-02-01" & rawData$Date <= "2007-02-02"),]

# Create new DateTime field (so we can have continuous line like in example plot rather than just by day or hour)
DateTime <- paste(as.Date(subsetData$Date), subsetData$Time)

# Add new DateTime field to dataframe 
subsetData$DateTime <- as.POSIXct(DateTime) # use standard time format

# Make the plot $Sub_metering1/2/3 by $DateTime
# type=l for line graph
# x-axis is blank
# y-axis = Energy sub metering
# title is blank
# Sub_metering_1 = Default (Black)
# Sub_metering_2 = Red
# Sub_metering_3 = Blue
with(subsetData, {
  plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
})

# Add legend in topright
legend("topright", col=c("black","red","blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save the plot to 'plot3.png'
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()