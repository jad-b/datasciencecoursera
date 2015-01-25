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
#
# `tbl_df` used throughout the script to make debugging easier.

#   activity and subject
library(dplyr)
library(tidyr)

# Change to data directory
setwd('UCI HAR Dataset/')

# Load and training and test data
# Load our variable/columns w/ int primary keys 
features <- tbl_df(read.table('features.txt', col.names=c('id', 'feature')))
# Load our activity types w/ int primary keys
activity_labels <- read.table('activity_labels.txt',
                              col.names=c('id', 'activity'),
                              colClasses=c('integer', 'character'))
# Categorize our activity types; Walking, Laying, etc.
activities <- factor(activity_labels$activity)

X_train <- tbl_df(read.table('train/X_train.txt', col.names=features$feature))
X_test <- tbl_df(read.table('test/X_test.txt', col.names=features$feature))

# Assign subjects and activity factors before merging
subject_train <- tbl_df(read.table('train/subject_train.txt', col.names=c('subject')))
subject_test <- tbl_df(read.table('test/subject_test.txt', col.names=c('subject')))
X_train$subject <- subject_train$subject
X_test$subject <- subject_test$subject

y_train <- tbl_df(read.table('train/y_train.txt', col.names='activity'))
y_test <- tbl_df(read.table('test/y_test.txt', col.names='activity'))
levels(y_train$activity) <- activities
levels(y_test$activity) <- activities
X_train$activity <- factor(y_train$activity, labels=activity_labels$activity)
X_test$activity <- factor(y_test$activity, labels=activity_labels$activity)

           # Merge training & test data
meanstd <- (rbind_list(X_train, X_test) %>%
           # Extract columns related to the mean and std dev
           select(contains('mean'), contains('std'), 
                  one_of(c('subject', 'activity'))) %>%
           tbl_df

# Improve variable names via string substitution
names(meanstd) <- gsub("-", ".", names(meanstd))
names(meanstd) <- gsub("BodyBody", "Body", names(meanstd))
names(meanstd) <- gsub("^f", "Frequency", names(meanstd))
names(meanstd) <- gsub("^t", "Time", names(meanstd))
names(meanstd) <- gsub("mean\\(\\)", "Mean", names(meanstd))
names(meanstd) <- gsub("std\\(\\)", "StandardDeviation", names(meanstd))


# Take the mean of each column, besides our appended subject & activity
# Prepare
activities <- levels(meanstd$activity)
subjects <- unique(meanstd$subject)
target_columns <- names(meanstd)[!(names(meanstd) %in% c('subject', 'activity'))]
# Prepare lengths
activity_length <- length(activities)
subject_length <- length(subjects)
targets_length <- length(target_columns)
# Prepare blank 3D array
arr <- array(NaN, c(activity_length, subject_length, targets_length))
# Fill the array; scope from activity -> measured -> subject ID
for(i in 1:activity_length){
  for(j in 1:subject_length){
    for(k in 1:targets_length) {
      arr[i, j, k] <-  mean(meanstd[,target_columns[k]][meanstd$activity==activities[i] &
                                                        meanstd$subject==subjects[j]])
    }
  }
}


# Convert 3D array to a data frame
tidy_frame <- as.data.frame(arr, responseName = 'Average')

# Output resulting data as a *.txt file
write.table(x = tidy_frame, file = 'HAR_tidy.txt', row.name = FALSE)
