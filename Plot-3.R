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

## Plotting
with(data, 
     {plot(Sub_metering_1~timestamp, type = 'l',
           ylab = 'Global Active Power (kilowatt)', xlab = '')
      lines(Sub_metering_2~timestamp, col = 'Red')
      lines(Sub_metering_3~timestamp, col = 'Blue')
      }
     )
legend('topright', col = c('black', 'red', 'blue'), lty = 1, lwd = 2,
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
      )

## Saving plot
dev.copy(png, file = 'Plot-3.png', height = 480, width = 480)
dev.off()
