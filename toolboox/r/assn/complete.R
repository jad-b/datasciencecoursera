## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases
complete <- function(directory, id = 1:332) {
  nvals <- length(id)
  # Create an empty data frame
  frame <- data.frame(id=rep(NA, nvals), nobs=rep(NA, nvals))
  
  # Need to iterate up from one, to track row in data.frame
  indices <- 1:nvals
  for (idx in indices){
    i <- id[idx]
    filename <- sprintf('%03d.csv', i)
    path <- file.path(directory, filename)
    csv <- read.csv(file = path)
    frame[idx, ] <- c(i, sum(complete.cases(csv), na.rm=T))
  }
  
  frame
}