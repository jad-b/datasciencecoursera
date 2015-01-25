#!/usr/bin/env R
#
# run_analysis.R
# ==============
# This script performs the following:
# 1) Merges training and test data sets
# 2) Extracts only the measurements on the mean and std dev for each
#   measurement
# 3) Names the data set activities appropiately
# 4) Labels the data set with variable names
# 5) Creates a second, independent data set from #4 of the averages for each
# Notes:
#   * `tbl_df` used throughout the script to make debugging easier.
#   * Data sets are named and labeled before merging. Helps keep track
#     of what data's what.
#
library(data.table)
library(dplyr)
library(tidyr)

# Change to data directory
setwd('UCI HAR Dataset/')

# Load our variable/columns names
features <- tbl_df(fread('features.txt', drop=1))
setnames(features, 'feature')

# Load our observational data
X_data <- tbl_df(data.table(rbind(read.table('train/X_train.txt'),
                            read.table('test/X_test.txt'))))

# Assign feature names
setnames(X_data, features$feature)
# Remove duplicate column entries; learning about *those* was fun
unique_x <- X_data[, unique(colnames(X_data))] 
# Extracts measurements on the mean and standard deviation
meanstd <- select(unique_x, contains('mean()'), contains('std()'))

# Load our activity types
activities <- tbl_df(fread('activity_labels.txt',
                           colClasses=c('integer', 'character'),
                           stringsAsFactors=T,
                           drop=1))    # Don't need row IDs as a column
setnames(activities, 'Activity')

# Load activity data
# Activity data is stored as vectors of the numeric value of the activity
y_data <- data.table(c(scan('train/y_train.txt'), scan('test/y_test.txt')))
setnames(y_data, 'Activity')
# Replace the numeric values with activity category labels; WALKING, etc.
y_data$Activity <- factor(y_data$Activity, labels=activities$Activity)

# Subject data is a vector of subject IDs, one per observation row
subjects <- data.table(c(scan('train/subject_train.txt'),
                         scan('test/subject_test.txt')))
setnames(subjects, 'Subject')

# Merge the observations, activities, and subject IDs
data <- cbind(meanstd, 
              y_data,
              subjects)

# 33 mean() observations
# 33 std() observations (according to grep)
# 1 Subject column
# 1 Activity column
# --- Total is:
# 68
stopifnot(ncol(data) == 68)


# Improve variable names via string substitution
setnames(data, gsub("-", ".", colnames(data)))
setnames(data, gsub("BodyBody", "Body", colnames(data)))
setnames(data, gsub("^f", "Frequency", colnames(data)))
setnames(data, gsub("^t", "Time", colnames(data)))
setnames(data, gsub("mean\\(\\)", "Mean", colnames(data)))
setnames(data, gsub("std\\(\\)", "StandardDeviation", colnames(data)))


# Take the mean of each variable, by subject and by activity (separately)
tidy = data[, lapply(.SD, mean), by=c('Activity', 'Subject')]

# Return to our previous directory
setwd('..')

# Output resulting data as a *.txt file
write.table(x = tidy, file = 'HAR_tidy.txt', row.name = FALSE)

