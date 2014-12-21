## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)
pollutantmean <- function(directory, pollutant, id = 1:332) {
  # Build the filenames
  filenames <- lapply(id, function(x){
    sprintf('%03d.csv', x)
  })
  
  # Read file and return a list of each monitor's readings
  readings <- lapply(filenames, function(x){
    path <- file.path(directory, x)
    csv <- read.csv(file = path)
    # get values by pollutant
    raw <- csv[,pollutant]
  })
  
  # Concatenate readings
  nums <- unlist(readings)
  # Find mean
  m <- mean(nums, trim=0.0001, na.rm=T)
  # Truncate results to 3 decimal places
  round(m, digits=3)
}
