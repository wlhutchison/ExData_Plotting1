##
##  Plot4 -- create four distinct graphs from the Household Power Consumption dataset
##     for the days 2007-02-01 (February 1st, 2007) and 2007-02-02 (February 2nd, 2007)
##

##
## Set dataset references
##
requiredDataset <- "householdSubset"
prepDataset <- "prepDataset.R"

##
## Check if the preprocessed dataset exists.  If not, execute the script that will create it
##
if (!exists(requiredDataset)) {
  source(prepDataset)
  
  ##
  ## After executing the script to create the preprocessed dataset, check for its existance
  ## If it is still missing halt the program and alert the user
  ##
  if (!exists(requiredDataset))
    stop("Unable to process household power consumption dataset")
}

##
## Open (create) a png file that will be used to hold/display four distinct graphs
##
png(filename= "plot4.png", bg= "transparent", width= 480, height= 480)

##
## Configure the graphics systems to display the graphs in a 2 x 2 grid
par(mfrow=c(2,2))

##
## Create the scatter plat of the Global Active Power
## as a png file.  Graph will be in Row 1, Column 1
##
plot( householdSubset[,"Date"], householdSubset[,"Global_active_power"], type= "l", xlab= "", ylab= "Global Active Power (kilowatts)" )

##
## Create the scatter plat of the Voltage
## as a png file.  Graph will be in Row 1, Column 2
##
plot( householdSubset[,"Date"], householdSubset[,"Voltage"], type= "l", xlab= "", ylab= "Voltage" )

##
## Create the scatter ploat of the sub-meter [1-3] (with the desired colors, labels, and legend)
## as a png file.  Graph will be in Row 2, Column 1
##
plot( householdSubset[,"Date"], householdSubset[,"Sub_metering_1"], type= "l", xlab= "", ylab= "Energy sub metering" )
points( householdSubset[,"Date"], householdSubset[,"Sub_metering_2"], type= "l", col= "red" )
points( householdSubset[,"Date"], householdSubset[,"Sub_metering_3"], type= "l", col= "blue" )
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col= c("gray", "red", "blue") , lty= "solid", lwd=2 )

##
## Create the scatter plat of the Global Reactive Power
## as a png file.  Graph will be in Row 1, Column 1
##
plot( householdSubset[,"Date"], householdSubset[,"Global_reactive_power"], type= "l", xlab= "", ylab= "Global Reactive Power (kilowatts)" )

##
## Save the file
##
dev.off()
