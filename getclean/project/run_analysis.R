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
#   activity and subject

# Load and training and test data
features <- read.table('features.txt', col.names=c('id', 'feature'))
activity_labels <- read.table('activity_labels.txt',
                              col.names=c('id', 'activity'),
                              colClasses=c('integer', 'character'))
activities <- factor(activity_labels$activity)

X_train <- read.table('train/X_train.txt', col.names=features$feature)
X_test <- read.table('test/X_test.txt', col.names=features$feature)

# Assign subjects and activity factors before merging
subject_train <- read.table('train/subject_train.txt', col.names=c('subject'))
subject_test <- read.table('test/subject_test.txt', col.names=c('subject'))
X_train$subject <- subject_train$subject
X_test$subject <- subject_test$subject

y_train <- read.table('train/y_train.txt', col.names='activity')
y_test <- read.table('test/y_test.txt', col.names='activity')
levels(y_train$activity) <- activities
levels(y_test$activity) <- activities
X_train$activity <- factor(y_train$activity, labels=activity_labels$activity)
X_test$activity <- factor(y_test$activity, labels=activity_labels$activity)

# merge training & test data
merged <- rbind(X_train, X_test)

# Extract columns related to the mean and std dev
extract <- merged[,c(grep("mean|std", names(merged), value=T),
                     'subject', 'activity')]

# Improve variable names
names(extract) <- gsub("^t", "Time", names(extract))
names(extract) <- gsub("^f", "Frequency", names(extract))
names(extract) <- gsub("BodyBody", "Body", names(extract))
names(extract) <- gsub("-", ".", names(extract))
names(extract) <- gsub("mean\\(\\)", "Mean", names(extract))
names(extract) <- gsub("std\\(\\)", "StandardDeviation", names(extract))


# Take the mean of each column, besides our appended subject & activity
# Prepare
activities <- levels(extract$activity)
subjects <- unique(extract$subject)
target_columns <- names(extract)[!(names(extract) %in% c('subject', 'activity'))]
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
      arr[i, j, k] <-  mean(extract[,target_columns[k]][extract$activity==activities[i] &
                                                        extract$subject==subjects[j]])
    }
  }
}


# Convert 3D array to a data frame
tidy_frame <- as.data.frame(arr, responseName = 'Average')

# Output resulting data as a *.txt file
write.table(x = tidy_frame, file = 'HAR_tidy.txt', row.name = FALSE)
