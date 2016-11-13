## Setting up dataset
powersource <- read.csv('household_power_consumption.txt', header = T,
                        sep = ';', na.strings = '?', nrows = 2075259,
                        check.names = F, stringsAsFactors = F,
                        comment.char = '', quote = '\"')
powersource$Date <- as.Date(powersource$Date, format = '%d/%m/%Y')

## Narrowing the dataset
data <- subset(powersource,
               subset = (Date >= '2007-02-01' & Date <= '2007-02-02')
               )
rm(powersource)

## Conversion of dates
timestamps <- paste(as.Date(data$Date), data$Time)
data$timestamp <- as.POSIXct(timestamps)

## Plotting graph
plot(data$Global_active_power~data$timestamp, type ='l',
     ylab = 'Global Active Power (kW)', xlab = '')

## Saving plot
dev.copy(png, file = 'Plot-2.png', height = 480, width = 480)
dev.off()
