# 
# Getting and Cleaning Data
# Quiz 3, Questions 3-5
#
library(data.table)
library(dplyr)
library(Hmisc)

gdp <- fread('gdp.csv', skip=4, drop=c(3, 6:10), nrows=190,
             na.strings=c('NA', 'N/A', ''))
# Use same names as the 'edu' data set
setnames(gdp, c('CountryCode', 'Ranking', 'Long Name', 'GDP'))
# Convert ranking from character to integer
gdp$Ranking <- as.integer(gdp$Ranking)
gdp$GDP <- as.integer(gsub(',', '', gdp$GDP))

edu <- fread('edu.csv', na.strings=c('NA', 'N/A', ''))

# Set CountryCode as a key column
setkey(edu, CountryCode)
setkey(gdp, CountryCode)

# Merge our data sets on the key column
merged <- tbl_df(merge(gdp, edu))
# Remove spaces from names
setnames(merged, make.names(colnames(merged)))

# Question 3
num_united <- length(grep('^United', merged$Long.Name.x))
print('Number of countries that start with "United":')
print(num_united)

# Question 4
num_fiscal_june <- length(grep('Fiscal year end: June', merged$Special.Notes))
print('Number of countries whose Fiscal Year ends in June:')
print(num_fiscal_june)

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
times <- ymd(sampleTimes)
twelves <- times[year(times) == 2012]
mondays <- twelves[wday(twelves) == 2]
print(sprintf('Number of collections in 2012: %d', length(twelves)))
print(sprintf('Number of Mondays in 2012 collections: %d', length(mondays)))
