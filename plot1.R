## plot1.R draws the plot Global Active Power (kilowatts) vs Frequency
## the first plot of the assignment
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


## A good step is to take a backup of the file with 2 dates just in case it gets corrupted 
## during coding so the reading of the full big file could be avoided
## in case some way the data gets corrupted
## this is not a mandatory step but adds value

consumption.data.bkup <- consumption.data.2dates

### now drawing the plot 
## the *.png file gets saved on your working directory
par(mfrow=c(1,1))
hist(consumption.data.2dates$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequncy",
     col = "red")
dev.copy(png, file="plot1.png", width = 480, height = 480)
dev.off()


