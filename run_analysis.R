# Getting and Cleaning Data Course Project
# Author: jpapp 11/4/2015

# Please review README.md for notes on using this script.
# Please review CodeBook.md for further notes on this script.

# Script Assignment:
#You should create one R script called run_analysis.R that does the following. 
# - Merges the training and the test sets to create one data set.
# - Extracts only the measurements on the mean and standard deviation for each measurement. 
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names. 
# - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Assumes that data lives in the UCI Har Dataset (as downloaded from the course website) in the working directory
# Assumes access to dplyr library for reshaping data
library('dplyr')

# grab descriptions for features and activities
features_file <- "./UCI Har Dataset/features.txt"
features <- (read.table(features_file))$V2

activity_file <- "./UCI Har Dataset/activity_labels.txt"
activity <- read.table(activity_file)
names(activity) <- c("Activity Number","Activity Name")

# collect and clean training set data

# file definitions
train_file <- "./UCI Har Dataset/train/X_train.txt"
train_label_file <- "./UCI Har Dataset/train/Y_train.txt"
train_subject_file <- "./UCI Har Dataset/train/subject_train.txt"

# read training data, assign feature names, only keep fields with mean and std
train_data <- read.table(train_file)
names(train_data) <- features
train_data <- train_data[grepl("mean|std",names(train_data))]

# read activity label data, enrich with activity descriptions
train_label_data <- read.table(train_label_file)
names(train_label_data) <- "Activity Number"
train_label_data <- merge(activity,train_label_data,by="Activity Number")

# read subject label data
train_subject_data <- read.table(train_subject_file)
names(train_subject_data) <- "Subject Number"

# merge all training data together
train <- cbind(train_subject_data,train_label_data,train_data)

# collect and clean test set data

# file definitions
test_file <- "./UCI Har Dataset/test/X_test.txt"
test_label_file <- "./UCI Har Dataset/test/Y_test.txt"
test_subject_file <- "./UCI Har Dataset/test/subject_test.txt"

# read test data, assign feature names, only keep fields with mean and std
test_data <- read.table(test_file)
names(test_data) <- features
test_data <- test_data[grepl("mean|std",names(test_data))]

# read activity label data, enrich with activity descriptions
test_label_data <- read.table(test_label_file)
names(test_label_data) <- "Activity Number"
test_label_data <- merge(activity,test_label_data,by="Activity Number")

# read subject label data
test_subject_data <- read.table(test_subject_file)
names(test_subject_data) <- "Subject Number"

# merge all test data together
test <- cbind(test_subject_data,test_label_data,test_data)

# combine train and test into single data set
d <- rbind(train,test)

# aggregate by 'Subject Number' and 'Activity Name' using the dplyr package
dg <- d %>% group_by(`Subject Number`,`Activity Name`)
td <- dg %>% summarise_each(funs(mean),-`Subject Number`,-`Activity Name`)

# uncomment to write tidy data out to file in working directory
write.table(td,"tidy_data.txt",row.names=FALSE)