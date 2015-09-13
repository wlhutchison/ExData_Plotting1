#
## prepDataset -- Download (if necessary) the household power consumption dataset and 
##    preprocess it for analysis and processing to complete the Course Project #1
##    assignment in the John's Hopkin's Exploring Data Analysis course.
#

##
## Check to see if we can load the sqldf package.  If not, install it and then load it.
##
if (require(sqldf)) {
  message("sqldf loaded successfully")  
} else {
  install.packages("sqldf")  
  library(sqldf)
}

##
## Check to see if we can load the dplyr package.  If not, install it and then load it.
##
if (require(dplyr)) {
  message("dplyr loaded successfully")
} else {
  install.packages("dplyr")
  library(dplyr)
}

##
## Set references to the online and local dataset files
##
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
zipFile <- "household_power_consumption.zip"
  
##
## Check to see if we have a local copy of the dataset. If not, download it and extract it.
##
if (!file.exists(dataFile)) {
  download.file(url= dataUrl, destfile= zipFile, quiet= T )
  unzip(zipfile= zipFile, files= dataFile)
}

##
## Define a customized Date class and a customized Time class that matches the format
## the dataset
##
setClass('myDate')
setClass('myTime')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S"))

##
## Define a sql statement that will extract only the entries on the dates of interest
##
sqlCommand <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"

##
## Define the class types for the columns in the dataset
##
dataColClasses <- c("myDate", "character", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric")

##
## Read the dataset retaining only the entries that match the sql extraction statement
## Note:  The first column will be converted to a Date (using the myDate anonymous function)
##        to facilitate the sql extraction
##
householdSubset <- read.csv2.sql(dataFile, sql= sqlCommand, sep=";", na.strings= "?",
                                 header= T, colClasses = dataColClasses )

##
## Combine the Data column and the Time column (still being treated as characters) into
## a single DateTime (date & time) class replacing the Date only column
## Note: After which, we can drop the redundant Time column
##
householdSubset$Date = strptime(x= paste(householdSubset$Date, householdSubset$Time),
                                format= "%d/%m/%Y %H:%M:%S", tz= "GMT")
householdSubset$Time <- NULL

##
## Silently return result
##
invisible(householdSubset)