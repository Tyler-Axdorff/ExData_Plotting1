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

# Make the plot $Global_active_power by $DateTime
# type=l for line graph
# x-axis is blank
# y-axis = Global Active Power (kilowatts)
# title is blank
plot(subsetData$Global_active_power~subsetData$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Save the plot to 'plot2.png'
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()