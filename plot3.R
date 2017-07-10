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

## Plot Sub_metering_1, Sub_metering_2, and Sub_metering_3 by day of the week, 
## add a legend, and output to PNG file.

png("plot3.png", width = 480, height = 480)

## Plot the first Sub_metering data column

plot(housedata$DateTime, housedata$Sub_metering_1, 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "")

## Add additional Sub_metering data as requested

lines(housedata$DateTime, housedata$Sub_metering_2, col = "red")
      
lines(housedata$DateTime, housedata$Sub_metering_3, col = "blue")

## Create the legend

legend("topright", lty=1,
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
      )

dev.off()