# Read in 'household_power_consumption.txt' in working directory
rawData <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", quote='\"', stringsAsFactors=F)

# Convert date string into Date type
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")

# Subset data to just Feb 1st 2007 - Feb 2nd 2007
subsetData <- rawData[(rawData$Date >= "2007-02-01" & rawData$Date <= "2007-02-02"),]

# Make the plot
hist(subsetData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save the plot to 'plot1.png'
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()