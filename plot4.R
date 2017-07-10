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

## Create four graphs vs day of the week: one for Global Active Power, one for
## Voltage, one for Energy sub metering, and one for Global Reactive Power,
## then output to PNG file.

png("plot4.png", width = 480, height = 480)

## Set plots in two rows and two columns

par(mfrow = c(2,2))

# Plot using with command

with(housedata, {
  plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", 
        xlab = "")
  plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", 
       xlab = "")
  lines(DateTime, Sub_metering_2, col = "red")
  lines(DateTime, Sub_metering_3, col = "blue")
  legend("topright", lty=1, bty = "n", cex = 0.8,
         col=c("black", "red", "blue"),
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})

dev.off()