## Read in data (assumes file has been downloaded and unzipped in working directory)

housepower <- read.table("./household_power_consumption.txt",
                         na.strings = "?",
                         sep = ";",
                         header = TRUE)

## Convert Date column data to date format

housepower$Date <- as.Date(housepower$Date, format="%d/%m/%Y")

## Subset data for 2007-02-01 and 2007-02-02 only

housedata <- housepower[(housepower$Date=="2007-02-01") | 
                          (housepower$Date=="2007-02-02"),]

## Create new DateTime column for Plots 2, 3, and 4

housedata$DateTime <- strptime(paste(housedata$Date, housedata$Time), "%Y-%m-%d %H:%M:%S")

## Plot Global Active Power by day of the week and output to PNG file.

png("plot2.png", width = 480, height = 480)

plot(housedata$DateTime, housedata$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

dev.off()


