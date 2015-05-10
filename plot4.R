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

# Setup plot formatting
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0), ps=12)

# Start plotting
with(subsetData, {
  # Plot 2 graph (see plot2.R for information on how graph was derived)
  plot(Global_active_power~DateTime, type="l", ylab="Global Active Power", xlab="")
  
  # New plot Voltage~DateTime
  plot(Voltage~DateTime, type="l", ylab="Voltage", xlab="datetime")
  
  # Plot 3 graph (see plot3.R for information on how graph was derived)
  plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col="Red")
  lines(Sub_metering_3~DateTime, col="Blue")
  legend("topright", col=c("black","red","blue"), lty=1, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # New plot Global_reactive_power~DateTime
  plot(Global_reactive_power~DateTime, type="l", ylab="Global_reactive_power", xlab="datetime")
})

# Save the plot to 'plot4.png'
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()