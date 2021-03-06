# CodeBook

Pertains to the data stored in `HAR_tidy.txt`, as generated by `run_analysis.R`.

__A note about notation__: {X,Y,Z} is a summary description for three individual
columns, where the X, Y, Z refer to movement in a 3-axial plane. A `*` denotes
where additional variable name would follow, much like a wildcard character in
a shell expression.

Prefixes:
  * __Time*__: Time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
  * __Frequency*__: Frequency domain signals, produced from applying a Fast Fourier Transform.

Sources:
  * __BodyAcc__: Body acceleration
  * __BodyGyro__: Body gyroscopic movement
  * __GravityAcc__: Gravity acceleration

Derivations:
  * __BodyAccJerk__, __BodyGyroJerk__: Jerk signals calculated from body linear
  acceleration and angular velocity
  * __BodyAccMag__, __GravityAccMag__, __BodyAccJerkMag__, __BodyGyroMag__,
  __BodyGyroJerkMag__: Magnitude of 3D signals, calculated using Euclidean norm

* Activity
  * Activity performed during observation
    * Values:
      1. WALKING
      1. WALKING_UPSTAIRS
      1. WALKING_DOWNSTAIRS
      1. SITTING
      1. STANDING
      1. LAYING
* Subject
  * Subject ID
    * Values: 1 through 30

What follows is a collection of all variables summarized by their mean in
`HAR_tidy.txt`, the output of `run_analysis.R`.
* TimeBodyAcc.Mean.{X,Y,Z}
* TimeGravityAcc.Mean.{X,Y,Z}
* TimeBodyAccJerk.Mean.{X,Y,Z}
* TimeBodyGyro.Mean.{X,Y,Z}
* TimeBodyGyroJerk.Mean.{X,Y,Z}
* TimeBodyAccMag.Mean
* TimeGravityAccMag.Mean
* TimeBodyAccJerkMag.Mean
* TimeBodyGyroMag.Mean
* TimeBodyGyroJerkMag.Mean
* FrequencyBodyAcc.Mean.{X,Y,Z}
* FrequencyBodyAccJerk.Mean.{X,Y,Z}
* FrequencyBodyGyro.Mean.{X,Y,Z}
* FrequencyBodyAccMag.Mean
* FrequencyBodyAccJerkMag.Mean
* FrequencyBodyGyroMag.Mean
* FrequencyBodyGyroJerkMag.Mean
* TimeBodyAcc.StandardDeviation.{X,Y,Z}
* TimeGravityAcc.StandardDeviation.{X,Y,Z}
* TimeBodyAccJerk.StandardDeviation.{X,Y,Z}
* TimeBodyGyro.StandardDeviation.{X,Y,Z}
* TimeBodyGyroJerk.StandardDeviation.{X,Y,Z}
* TimeBodyAccMag.StandardDeviation
* TimeGravityAccMag.StandardDeviation
* TimeBodyAccJerkMag.StandardDeviation
* TimeBodyGyroMag.StandardDeviation
* TimeBodyGyroJerkMag.StandardDeviation
* FrequencyBodyAcc.StandardDeviation.{X,Y,Z}
* FrequencyBodyAccJerk.StandardDeviation.{X,Y,Z}
* FrequencyBodyGyro.StandardDeviation.{X,Y,Z}
* FrequencyBodyAccMag.StandardDeviation
* FrequencyBodyAccJerkMag.StandardDeviation
* FrequencyBodyGyroMag.StandardDeviation
* FrequencyBodyGyroJerkMag.StandardDeviation
