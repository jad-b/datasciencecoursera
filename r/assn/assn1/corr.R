## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0
corfile <- 

## Return a numeric vector of correlations
corr <- function(directory, threshold = 0) {
  files <- list.files(path=directory)
  n <- length(files)
  
  # Pre-allocate a vector
  vector <- numeric(length = n)
  indices <- 1:n
  for (idx in indices){
    name <- file.path(directory, files[idx])
    csv <- read.csv(name)
    # Check for completeness
    cmpl <- complete.cases(csv) 
    if (sum(cmpl) > threshold){
      clean <- csv[cmpl,]
      # Check for correlation 
      vector[idx] <- cor(clean$sulfate, clean$nitrate)
    } 
  }
  ret <- round(vector[vector != 0.0], digits=5)
}