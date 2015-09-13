##
##  Plot2 -- create a scatter plot from the Household Power Consumption dataset for the days
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
## Create the scatter plot of the Global Active Power (with the desired colors, and labels)
## as a png file.
##
png(filename= "plot2.png", bg= "transparent")
plot( householdSubset[,"Date"], householdSubset[,"Global_active_power"], type= "l", xlab= "", ylab= "Global Active Power (kilowatts)" )

##
## Save the file
##
dev.off()
