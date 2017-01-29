# As noted in README.md, you will need to unzip the UCI HAR Dataset data and
# place the entire "UCI HAR Dataset" folder in your working directory

# load dplyr package for quicker/easier data manipulation
library(dplyr)

# load all raw data
features <- read.csv(file = "UCI HAR Dataset/features.txt", sep = "", header = FALSE)
subject_test <- read.csv(file = "UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
x_test <- read.csv(file = "UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
y_test <- read.csv(file = "UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
subject_train <- read.csv(file = "UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
x_train <- read.csv(file = "UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
y_train <- read.csv(file = "UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)

# drop numbering column in features data frame (the variable names),
# then transpose from 561 x 1 to 1 x 561, so it can be attached to x_test
features <- features %>% select(2) %>% t

# attach variable names to x_test data frame. make.unique is used as some
# variable names in the raw data are not unique, which would cause problems
# in later steps
names(y_test) <- "Activity"
names(subject_test) <- "Subject"
names(y_train) <- "Activity"
names(subject_train) <- "Subject"
names(x_test) <- features
names(x_test) <- make.unique(names(x_test))
names(x_train) <- features
names(x_train) <- make.unique(names(x_test))

# bind test data together, then train data together, then bind the resulting
# test and train data together
test <- bind_cols(subject_test, y_test, x_test)
train <- bind_cols(subject_train, y_train, x_train)
complete <- bind_rows(test, train)

# keep only variables that indicate a mean or standard deviation
extract <- select(complete, matches("Subject|Activity|mean\\(\\)|std\\(\\)"))

# replace activity numbers with descriptive names
extract$Activity <- gsub("1", "walking", extract$Activity)
extract$Activity <- gsub("2", "walking upstairs", extract$Activity)
extract$Activity <- gsub("3", "walking downstairs", extract$Activity)
extract$Activity <- gsub("4", "sitting", extract$Activity)
extract$Activity <- gsub("5", "standing", extract$Activity)
extract$Activity <- gsub("6", "laying", extract$Activity)

# make variable names more descriptive
names(extract) <- gsub("^f", "FFT", names(extract))
names(extract) <- gsub("^t", "", names(extract))
names(extract) <- gsub("-mean\\(\\)", "Mean", names(extract))
names(extract) <- gsub("-std\\(\\)", "StdDeviation", names(extract))
names(extract) <- gsub("BodyBody", "Body", names(extract))
names(extract) <- gsub("BodyGyro", "AngularVelocity", names(extract))
names(extract) <- gsub("AngularVelocityJerk", "AngularJerk", names(extract))
names(extract) <- gsub("BodyAccJerk", "LinearJerk", names(extract))
names(extract) <- gsub("BodyAcc", "BodyAccel", names(extract))
names(extract) <- gsub("GravityAcc", "GravityAccel", names(extract))
names(extract) <- gsub("-X", "XAxis", names(extract))
names(extract) <- gsub("-Y", "YAxis", names(extract))
names(extract) <- gsub("-Z", "ZAxis", names(extract))

# get average for each variable
final <- group_by(extract, Subject, Activity) %>% summarise_each(funs(mean))

# output tidied data set containing the averages for each variable
write.table(final, file = "averages.txt", row.names = FALSE)