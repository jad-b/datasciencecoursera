# Averages Values for Human Activity Recognition by Smartphones

Provided for "Getting & Cleaning Data", course 3 in the Data Science
Specialization in Coursera

### Assumptions:
* Your working directory contains `run_analysis.R` and `UCI HAR Dataset/`
* You have R 3.1.2 installed
* You have `dplyr`, `tidyr`, and `data.table` packages installed

### Output:
* A `HAR_tidy.txt` file, containing the mean values of each observed variable
by subject AND by activity. Thus, you have 180 rows describing the means of
Subject 4 doing *something*. Else, we'd need to create two separate tables, or
insert a *lot* of NAs.

### Naming
Variable names were taken from the original data and spruced up a bit. 
Here's a legend for some of the abbreviations:
* Acc = Acceleration
* Gyro = Gyroscope
* Time = Time domain signals
* Frequency = Frequency domain signals
* X, Y, Z = Direction of movement in the 3-axial plane.

### run_analysis.R

The script first merges the observation data, found under
`{test,train}/X_{test,train}.txt` using `rbind`. Observation variables names
are attached, duplicate columns are removed, and columns relating to the mean 
or standard deviation are selected for. 

The six types of activities are loaded (WALKING, SITTING, STAIRS, etc.) and
joined with their raw IDs. The selected mean|std data, activity, and subject
data are all bound (`cbind`).  

Column name improvment is carried out via `gsub`. 

The data is tidied by taking the mean of each variable by activity and subject. 
Finally, the tidied data is written to `HAR_tidy.txt` in the working directory.
