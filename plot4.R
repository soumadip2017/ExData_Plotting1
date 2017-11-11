## plot4.R draws the fourth plot for the assignment

## Load data.table library

library(data.table)

## the downloaded and unzipped file is kept on the working directory -- Important criterion
## and first step is to read the .txt file , identifying properly the separators used in the 
## file and defining the Classes of the columns (defining the class of the columns correctly is 
## very important )
## ? are to be considered as not available value
## the following code performs the reading of the file 
consumption.data <- read.table("household_power_consumption.txt", 
                               sep = ";",
                               header = TRUE,
                               colClasses = c("character","character",rep("numeric",7)),
                               na = "?")
## Converting the Date field to a standard and desired format 
consumption.data$Date <- as.Date(consumption.data$Date,format='%d/%m/%Y')

## Only selecting 2 days from the full file i.e. 2007-02-01 and 2007-02-02
consumption.data.2dates <- subset(consumption.data, Date == "2007-02-01" | Date == "2007-02-02")

## So consumption.data.2dates is the file which would be used for further processing 

consumption.data.2dates$Time <- format(strptime(consumption.data.2dates$Time, format = "%H:%M:%S"),"%H:%M:%S")
##consumption.data.2dates$Global_active_power 
##<- as.numeric(as.character(consumption.data.2dates$Global_active_power))

## A good step is to take a backup of the file with 2 dates just in case it gets corrupted 
## during coding so the reading of the full big file could be avoided
## in case some way the data gets corrupted
## this is not a mandatory step but adds value

consumption.data.bkup <- consumption.data.2dates

## Combining the date and time so that we get the day of the week 
## which is required on the x-axis of the plot

datetime <- as.POSIXct(
    paste(consumption.data.2dates$Date,consumption.data.2dates$Time), 
    format="%Y-%m-%d %H:%M:%S" ) 

### now drawing the plot 
## the *.png file gets saved on your working directory

##defining frame so that we 2 rows and 2 columns of plots 
par(mfrow = c(2, 2))

## drawing the top left plot
plot(datetime, consumption.data.2dates$Global_active_power,
     type = "l",
     xlab = " ",
     ylab = "Global Active Power")

## drawing the top right plot
plot(datetime, consumption.data.2dates$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## drawing the bottom left plot
plot(datetime, consumption.data.2dates$Sub_metering_1,
     type = "l",xlab = " ",ylab = "Energy Submetering")
lines(datetime, consumption.data.2dates$Sub_metering_2, type="l", col="red")
lines(datetime, consumption.data.2dates$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1),bty="n", cex=.8, inset=.05)

## drawing the bottom right plot
plot(datetime, consumption.data.2dates$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_Active_Power")

dev.copy(png, file="plot4.png", width = 480, height = 480)
dev.off()


