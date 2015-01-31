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

# Sort by Ranking, desc
sorted <- arrange(merged, desc(Ranking))

# Question 3
print('Question 3) Number of matching rows:')
print(nrow(sorted))
print('Question 3b) 13th from last Country in GDP Ranking')
print(sorted$Long.Name.x[13])

# Question 4
# Convert Income Group into a factor for comparison
sorted$Income.Group <- factor(sorted$Income.Group)
# Group on Income.Group so we can summarise
grouped <- group_by(sorted, Income.Group)
print('Question 4) Mean GDP Ranking by Income Groups')
# Compare the mean Ranking of each Income Group...group
income_ranking <- summarise(grouped, avgRanking=mean(Ranking))
print(income_ranking)

# Question 5
# Divide ranking into five quantiles and show number of countries in each
# by Income Group
gdp_by_group <- table(cut2(grouped$Ranking, g=5), grouped$Income.Group)
print('Question 5) GDP Ranking vs Income Group')
print(gdp_by_group[1,])

