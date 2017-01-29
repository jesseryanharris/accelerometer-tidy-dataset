# Tidy Dataset Derived from UCI HAR Dataset (Coursera "Getting and Cleaning Data" Course Project)
This repo contains the following files:

* **run_analysis.R:** Used to process the raw data in the UCI HAR dataset and output an independent tidy dataset to a file named "averages.txt".
* **CodeBook.md:** Describes the variables and summaries calculated in the averages.txt file.
* **README.md:** This file, which explains the methods used to process the UCI HAR dataset and output the tidy dataset, averages.txt.

## Running run_analysis.R
In order for run_analysis.R to work, you must download and unzip the UCI HAR dataset, which can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Place the unzipped "UCI HAR Dataset" folder in your R working directory.

**Note:** run_analysis.R requires the dplyr package.

## Reading averages.txt into R
You can read the averages.txt file outputted by the script back into R by placing it in your R working directory and running the following command:

> averages <- read.table(file = "averages.txt", header = TRUE)

## Explanation of the run_analysis.R script
The run_analysis.R script was written to meet the requirements set out in the course project instructions:
### 1\. Merges the training and the test sets to create one data set.
The script accomplishes this merge process by doing the following:

1. Using the read.csv function, the script loads the following raw data files as R data frames: features.txt, subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, y_train.txt.

    > features <- read.csv(file = "UCI HAR Dataset/features.txt", sep = "", header = FALSE)  
    > subject_test <- read.csv(file = "UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)  
    > x_test <- read.csv(file = "UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)  
    > y_test <- read.csv(file = "UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)  
    > subject_train <- read.csv(file = "UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)  
    > x_train <- read.csv(file = "UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)  
    > y_train <- read.csv(file = "UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)

2. For the R data frame generated from features.txt, the script drops the numbering column, then uses the matrix transpose function (t) to reshape the results into a 1 x 561 data frame. This causes the variable names to be arranged such that they can be easily assigned as variable names to the data in the next step.

    > features <- features %>% select(2) %>% t  
	
3. The names function is used to assign the variable names "Subject" and "Activity" to the subject and activity data frames. The names function is also used to assign the contents of the data frame generated from features.txt as the column names for the x_test and x_train data frames.

    > names(y_test) <- "Activity"  
    > names(subject_test) <- "Subject"  
    > names(y_train) <- "Activity"  
    > names(subject_train) <- "Subject"  
    > names(x_test) <- features  
    > names(x_test) <- make.unique(names(x_test))  
    > names(x_train) <- features  
    > names(x_train) <- make.unique(names(x_test))  

4. The dplyr bind_cols and bind_rows functions are used to attach all the data frames together, making a data frame called "complete".

    > test <- bind_cols(subject_test, y_test, x_test)  
    > train <- bind_cols(subject_train, y_train, x_train)  
    > complete <- bind_rows(test, train)  

### 2\. Extracts only the measurements on the mean and standard deviation for each measurement.
The dplyr select function is used to drop all columns *except* the Subject and Activity columns and all columns with variable names that contain "mean()", "std()". The resulting data frame is called "extract".

> extract <- select(complete, matches("Subject|Activity|mean\\(\\)|std\\(\\)"))

### 3\. Uses descriptive activity names to name the activities in the data set.
The gsub function is used to replace the numbers in the Activity column with a text description of the corresponding activity, based on the activity_labels.txt file in the UCI HAR dataset.

> extract$Activity <- gsub("1", "walking", extract$Activity)  
> extract$Activity <- gsub("2", "walking upstairs", extract$Activity)  
> extract$Activity <- gsub("3", "walking downstairs", extract$Activity)  
> extract$Activity <- gsub("4", "sitting", extract$Activity)  
> extract$Activity <- gsub("5", "standing", extract$Activity)  
> extract$Activity <- gsub("6", "laying", extract$Activity)  

### 4\. Appropriately labels the data set with descriptive variable names.
The gsub function is again used to make the variable names more descriptive. The principles I followed in trying to make the variables names more descriptive were:

* Avoid abbreviation when it harms readability.
* Use CamelCase style to delineate words rather than add whitespace or special characters.
* Avoid repetition where possible.
* Try not to make the variable names too long.

Unfortunately, I don't think it is possible to make the variable names *perfectly* descriptive unless they are a mile long. Also, my ability to make them more descriptive is limited by my lack of understanding of accelerometer and gyroscope data. But anyway, here are some of the choices I made:

* I eliminated the "t" from the beginning of all time domain values. In CodeBook.md I explain that unless otherwise indicated, all values belong to the time domain.
* For frequency domain values, I replaced the "f" with "FFT", and explained in CodeBook.md that this indicates the values were the results of a Fast Fourier Transform operation.
* I eliminated the duplication of the word "Body" that existed in some variable names in the UCI HAR dataset, as I believe that is a minor mistake in the original dataset.
* Based on the description of the UCI HAR dataset in features_info.txt and http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, I renamed "BodyGyro" to "AngularVelocity" and "BodyAccJerk" to "LinearJerk", as I felt these were more a little more understandable than the original names. I also trimmed the "AngularVelocityJerk" variable (resulted from the gsub operation on "BodyGyroJerk") to just "AngularJerk".
* I expanded "Acc" to "Accel" to make it slightly more obvious what this abbreviation stood for.
* I also added the word "Axis" to make it more immediately clear what the X-Y-Z values were about.

> names(extract) <- gsub("^f", "FFT", names(extract))  
> names(extract) <- gsub("^t", "", names(extract))  
> names(extract) <- gsub("-mean\\(\\)", "Mean", names(extract))  
> names(extract) <- gsub("-std\\(\\)", "StdDeviation", names(extract))  
> names(extract) <- gsub("BodyBody", "Body", names(extract))  
> names(extract) <- gsub("BodyGyro", "AngularVelocity", names(extract))  
> names(extract) <- gsub("AngularVelocityJerk", "AngularJerk", names(extract))  
> names(extract) <- gsub("BodyAccJerk", "LinearJerk", names(extract))  
> names(extract) <- gsub("BodyAcc", "BodyAccel", names(extract))  
> names(extract) <- gsub("GravityAcc", "GravityAccel", names(extract))  
> names(extract) <- gsub("-X", "XAxis", names(extract))  
> names(extract) <- gsub("-Y", "YAxis", names(extract))  
> names(extract) <- gsub("-Z", "ZAxis", names(extract))  

### 5\. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The dplyr group_by function is used to group the data by Subject and then Activity, then the result is piped to the dplyr summarise_each function to apply the mean function across all variables. I would like to acknowledge Stack Overflow user rrs's post on the following thread as the source for this method: http://stackoverflow.com/questions/21295936/can-dplyr-summarise-over-several-variables-without-listing-each-one.

> final <- group_by(extract, Subject, Activity) %>% summarise_each(funs(mean))
	
Finally, the write.table function is used to output the tidy data set as a file called "averages.txt".

> write.table(final, file = "averages.txt", row.names = FALSE)