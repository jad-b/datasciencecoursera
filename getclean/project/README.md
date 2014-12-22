# Averages Values for Human Activity Recognition by Smartphones

Provided for "Getting & Cleaning Data", course 3 in the Data Science
Specialization in Coursera

Assuming 1) Your working directory is within the unzipped sample data provided on the course project page, you should be capable of running
`source('run_analysis.R')` to set the script in motion.

__Important!__:
I may be walking a path-less traveled here (i.e., wrong), but I decided to interpet:

> the average of each variable for each activity and each subject.

to mean the average of each measured mean & std deviation column
*by* type of activity *by* subject. You end up getting a 3-dimensional
array, which I then output as as a data frame. I expect this to be a
non-typical response, but what the hell, it was more fun.

__Input__:
* All necessary training and test data

__Output__:
* A 'HAR_tidy.txt' file, containing the 3D array translated into a
data frame (using, appropriately, `as.data.frame`). This comes out as
a 6 x (30*79) data frame, where x = the 6 activities, and the average
variable results by subject are "flattened" and appended one after
the other. Interesting, no?
