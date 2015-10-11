##
##  Plot3 -- create a scatter plot from the Household Power Consumption dataset for the days
##    2007-02-01 (February 1st, 2007) and 2007-02-02 (February 2nd, 2007)
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
## Create the scatter ploat of the sub-meter [1-3] (with the desired colors, labels, and legend)
## as a png file.
##
png(filename= "plot3.png", bg= "transparent", width= 480, height= 480)
plot( householdSubset[,"Date"], householdSubset[,"Sub_metering_1"], type= "l", xlab= "", ylab= "Energy sub metering", col="black" )
points( householdSubset[,"Date"], householdSubset[,"Sub_metering_2"], type= "l", col= "red" )
points( householdSubset[,"Date"], householdSubset[,"Sub_metering_3"], type= "l", col= "blue" )
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col= c("black", "red", "blue") , lty= "solid", lwd=2 )

##
## Save the file
##
dev.off()
