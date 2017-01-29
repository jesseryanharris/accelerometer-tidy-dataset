# Tidy Dataset Derived from UCI HAR Dataset (Coursera "Getting and Cleaning Data" Course Project)
The tidy dataset contained in this GitHub repo (filename: averages.csv) is derived from the UCI HAR dataset, which I downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script in this repo was used to process the raw data in the UCI HAR dataset and output the tidied version, the averages.csv file.

## Explanation of the run_analysis.R script
The run_analysis.R script was written to meet the requirements set out in the course project instructions:
> "Merges the training and the test sets to create one data set."

The script accomplishes this merge process by doing the following:
1. Using the read.csv function, the script loads the following raw data files as R data frames: features.txt, subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, y_train.txt.
2. For the R data frame generated from features.txt, the script drops the numbering column, then uses the matrix transpose function (t) to reshape the results into a 1 x 561 data frame. This causes the variable names to be horizontally arranged so they can be easily attached to the data in the next step.
3. The names function is used to assign the variable names "Subject" and "Activity" to the subject and activity data frames. The names function is also used to attach the data frame generated from features.txt to the x_test data frame.
4. The dplyr bind_cols and bind_rows functions are used to attach all the data frames together.

> "Extracts only the measurements on the mean and standard deviation for each measurement."

The dplyr select function is used to drop all columns except the Subject and Activity columns and all columns with variable names that contain "mean()", "std()".

> "Uses descriptive activity names to name the activities in the data set"

The gsub function is used to replace the numbers in the Activity column with a text description of the corresponding activity, based on the activity_labels.txt file in the UCI HAR dataset. 

> "Appropriately labels the data set with descriptive variable names."

The gsub function is again used to make the variable names more descriptive. 


From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
