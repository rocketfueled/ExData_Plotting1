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
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
      plot(Global_active_power~timestamp, type = 'l',
           ylab = 'Global Active Power (kilowatt)', xlab = '')
      plot(Voltage~timestamp, type = 'l',
           ylab = 'Voltage (V)', xlab ='')
      plot(Sub_metering_1~timestamp, type = 'l',
           ylab = 'Energy Submetering', xlab = '')
      lines(Sub_metering_2~timestamp, col = 'Red')
      lines(Sub_metering_3~timestamp, col = 'Blue')
      legend('topright', col = c('black', 'red', 'blue'), lty = 1, lwd = 2,
             bty ='n', legend = c('Sub_metering_1', 'Sub_metering_2',
                                  'Sub_metering_3')
            )
      plot(Global_reactive_power~timestamp, type = 'l',
           ylab = 'Global Reactive Power (kilowatt)', xlab = '')
            }
     )

## Saving plot
dev.copy(png, file = 'Plot-4.png', height = 480, width = 480)
dev.off()
