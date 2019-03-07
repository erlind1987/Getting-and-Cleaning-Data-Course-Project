#******************************************************************
# Download and unzip dataset steps
#******************************************************************
## Download the file inside "./data"  
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/UCI_HAR_Dataset.zip")

### Unzip the dataset into UCI HAR Dataset under "data" directory.
unzip("./data/UCI_HAR_Dataset.zip",exdir="./data")

## Step 0 -- Reading all input txt files.
### Read features.txt and activities.txt
features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

### Read txt files on test directory.
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "code")

### Read txt files on train directory.
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Step 1 -- Merge datasets step by step, first X , Y, Subject then Merge all together.
## dont forget to load library(dplyr)
X_Merge <- rbind(x_train, x_test)
Y_Merge <- rbind(y_train, y_test)
Subject_Merge <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject_Merge, Y_Merge, X_Merge)

### Step 2 -- Extracts only the measurements on the mean and standard deviation for each measurement.
Tidy <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

## Step 3 -- Uses descriptive activity names to name the activities in the data set.
Tidy$code <- activities[Tidy$code, 2]

## Step 4 -- Coorect the labeling the data set with descriptive variable names.
## use gsub to replace the abbreviated activity names with the full ones.
names(Tidy)[2] = "activity"
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-std()", "STD", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))


## Step 5 -- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
SecondTidy <- Tidy %>% 
              group_by(subject, activity) %>%
              summarise_all(list(mean))
write.table(SecondTidy, "SecondTidySet.txt", row.names = FALSE)





