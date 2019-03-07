# Peer-graded Assignment: Getting and Cleaning Data Course Project

This course project is about creating a script run_analysis.R, which performs the following 5 steps with a set of data:

  > 1. Merges the training and the test sets to create one data set.
  > 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  > 3. Uses descriptive activity names to name the activities in the data set
  > 4. Appropriately labels the data set with descriptive variable names.
  > 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and        each subject.
  

# 1. Download the dataset.
 Dataset is downloaded and then unzipped inside directory "./data/UCI HAR Dataset" 
# 2. Import all text files into tables and assign variables to each of them. 

- features <- features.txt;
contains tAcc-XYZ and tGyro-XYZ  from the accelerometer and gyroscope
- activites<- activity_labels.txt;
contains all the activities performed
-  subject_test <- subject_test.txt;
contains test data on the tested subjects
- x_test <- X_test.txt;
contains recorded features test data
- y_test <- y_test.txt;
contains test data of activities’code labels
- subject_train <- subject_train.txt;
contains train data for subjects being observed
- x_train <- X_train.txt;
contains recorded features train data
- y_train <- y_train.txt;
contains train data of activities (code) labels
# 3. Merges the data sets (train and test) to create one data set
Use  rbind() to merge the X ,Y and Subject of test and train data respectively and then use cbind() to merge them altogether into Merged_Data 
# 4. Extracts only the measurements on the mean and std for each measurement
Tidy is the tidy version of Merged_Data where we have extracted only the columns of subject, Code(of Activity), mean and std for each measurement by using contains() for the last two columns 

# 5. Uses descriptive activity names to name the activities in the data set
All abbreviated values of code are replaced with their corresponding on activities.
# 6. Lastly is created a second subset of data from Tidy data set, with the average of each variable for each activity and each subject
SecondTidySet <- is created by grouping the data from Tidy by subject and Activity and then summarise_all() is used together with list(mean) which calculates the mean for each variable (subject and activity).


