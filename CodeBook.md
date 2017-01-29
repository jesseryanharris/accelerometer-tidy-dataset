# The averages.txt dataset
This dataset is derived from the UCI HAR Dataset described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The averages.txt dataset contains the *mean values of all the mean and standard deviation values* for each combination of subject and activity described in the UCI HAR dataset. Please see README.md for more information on the processing tasks performed in order to create the averages.txt dataset.

# A guide to reading the variables
Hopefully the variables are fairly self-explanatory, however some additional description is probably helpful. To avoid repetition, I have not included a description for each variable; following is a "legend" of sorts that should clarify what the variables are measuring.

* **Subject:** The person performing the activity, indicated by a number between 1 and 30.
* **Activity:** The type of activity being performed by the subject.
* **StdDeviation:** Standard deviation.
* **Mag:** Magnitude calculated using the Euclidean norm.
* **BodyAccel:** Body linear acceleration; "tBodyAcc" in UCI HAR dataset.
* **GravityAccel:** Gravity acceleration; "tGravityAcc" in UCI HAR dataset.
* **AngularVelocity:** Angular velocity derived from BodyAccel ("tBodyAcc") values; AngularVelocity is "tBodyGyro" in the UCI HAR dataset.
* **LinearJerk:** Jerk signal derived in time from body linear acceleration signal; "tBodyAccJerk" in UCI HAR dataset.
* **AngularJerk:** Jerk signal derived in time from angular velocity; "tBodyGyroJerk" in UCI HAR dataset.
* **FFT:** Indicates that the value is a result of a Fast Fourier Transform operation, that is, it has been converted from time domain to frequency domain.

## Notes:
* As indicated above, all variables are understood to indicate that the value given is a mean of the measurement being described; if "Mean" also appears in the variable name, it means that the values in this variable are the mean of several mean values (an average of a series of averages).
* With the exception of Subject, Activity, and variables prefixed with "FFT", all variables belong to the time domain.
* For a more technical description of how the original values were derived from the raw signal data, see "features_info.txt" in the UCI HAR dataset.

# Complete list of variables
* Subject
* Activity
* BodyAccelMeanXAxis
* BodyAccelMeanYAxis
* BodyAccelMeanZAxis
* BodyAccelStdDeviationXAxis
* BodyAccelStdDeviationYAxis
* BodyAccelStdDeviationZAxis
* GravityAccelMeanXAxis
* GravityAccelMeanYAxis
* GravityAccelMeanZAxis
* GravityAccelStdDeviationXAxis
* GravityAccelStdDeviationYAxis
* GravityAccelStdDeviationZAxis
* LinearJerkMeanXAxis
* LinearJerkMeanYAxis
* LinearJerkMeanZAxis
* LinearJerkStdDeviationXAxis
* LinearJerkStdDeviationYAxis
* LinearJerkStdDeviationZAxis
* AngularVelocityMeanXAxis
* AngularVelocityMeanYAxis
* AngularVelocityMeanZAxis
* AngularVelocityStdDeviationXAxis
* AngularVelocityStdDeviationYAxis
* AngularVelocityStdDeviationZAxis
* AngularJerkMeanXAxis
* AngularJerkMeanYAxis
* AngularJerkMeanZAxis
* AngularJerkStdDeviationXAxis
* AngularJerkStdDeviationYAxis
* AngularJerkStdDeviationZAxis
* BodyAccelMagMean
* BodyAccelMagStdDeviation
* GravityAccelMagMean
* GravityAccelMagStdDeviation
* LinearJerkMagMean
* LinearJerkMagStdDeviation
* AngularVelocityMagMean
* AngularVelocityMagStdDeviation
* AngularJerkMagMean
* AngularJerkMagStdDeviation
* FFTBodyAccelMeanXAxis
* FFTBodyAccelMeanYAxis
* FFTBodyAccelMeanZAxis
* FFTBodyAccelStdDeviationXAxis
* FFTBodyAccelStdDeviationYAxis
* FFTBodyAccelStdDeviationZAxis
* FFTLinearJerkMeanXAxis
* FFTLinearJerkMeanYAxis
* FFTLinearJerkMeanZAxis
* FFTLinearJerkStdDeviationXAxis
* FFTLinearJerkStdDeviationYAxis
* FFTLinearJerkStdDeviationZAxis
* FFTAngularVelocityMeanXAxis
* FFTAngularVelocityMeanYAxis
* FFTAngularVelocityMeanZAxis
* FFTAngularVelocityStdDeviationXAxis
* FFTAngularVelocityStdDeviationYAxis
* FFTAngularVelocityStdDeviationZAxis
* FFTBodyAccelMagMean
* FFTBodyAccelMagStdDeviation
* FFTLinearJerkMagMean
* FFTLinearJerkMagStdDeviation
* FFTAngularVelocityMagMean
* FFTAngularVelocityMagStdDeviation
* FFTAngularJerkMagMean
* FFTAngularJerkMagStdDeviation