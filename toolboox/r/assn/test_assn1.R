source('~/Dropbox/dev/coursera/datasci/r/assn/pollutantmean.R')

# Tests
dir = file.path(getwd(), 'specdata')
stopifnot(pollutantmean(dir, "sulfate", 1:10)==4.064)
stopifnot(pollutantmean(dir, "nitrate", 70:72)==1.706)
stopifnot(pollutantmean(dir, "nitrate", 23)==1.281)

source('~/Dropbox/dev/coursera/datasci/r/assn/complete.R')

test1 <- complete("specdata", 1)
test2 <- complete("specdata", c(2, 4, 8, 10, 12))
test3 <- complete("specdata", 30:25)
test4 <- complete("specdata", 3)

source('~/Dropbox/dev/coursera/datasci/r/assn/corr.R')
cr <- corr("specdata", 150)
head(cr)