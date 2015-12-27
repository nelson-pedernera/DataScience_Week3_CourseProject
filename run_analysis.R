
# run_analysis.R does the following points (not in the exactly order)

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 


#------------------------------------------------------------------------------------------------
# Set the Working Directory where the "UCI HAR Dataset" zip is unzip
# i.e. setwd('C:/Users/nelson.pedernera/Desktop/BigData/DataScience/MIII/03/CourseProject/') 
# Folder "UCI HAR Dataset" is expected to be under "CourseProject"
#------------------------------------------------------------------------------------------------

# Loading master tables features and activities
features<-read.table("/UCI HAR Datasetfeatures.txt")
activities<-read.table("/UCI HAR Datasetactivity_labels.txt")

#------------------------------------------------------------------------------------------------
# Loading train datasets
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

# Loading test datasets
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

#------------------------------------------------------------------------------------------------
# Joining y_train, y_test with Activities in order to get meaningful description of activities
library(plyr)
# 3) Uses descriptive activity names to name the activities in the data set
join_train_activities<-join(activities, y_train, type = "inner")
join_test_activities<-join(activities, y_test, type = "inner")

train_data_set<-cbind(join_train_activities$V2, subject_train, X_train)
test_data_set<-cbind(join_test_activities$V2, subject_test, X_test)

#------------------------------------------------------------------------------------------------
# Setting properly names to the datasets (train and test)

features_names<-make.names(features$V2)
names(train_data_set) = c("Activity", "Subject", features_names) 
names(test_data_set) = c("Activity", "Subject", features_names) 

#1) Merges the training and the test sets to create one data set.
join_data_set<-rbind(train_data_set, test_data_set)

#------------------------------------------------------------------------------------------------
# Deleting columns not in ".mean.." ("mean()") or ".std.." ("std()")
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
features_names_filtered<-c(grep(".mean..", names(join_data_set)),grep(".std..", names(join_data_set)))

# 4) Appropriately labels the data set with descriptive variable names. 
data_set_filtered<-join_data_set[,c(1, 2, features_names_filtered)]

#
# 5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Summarise all the data by Activities and Subjects removing NA or unused combinations
data_set_filtered$Subject<-as.factor(data_set_filtered$Subject)
all_data<-data_set_filtered %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

write.table(all_data, file = "tidy_data_set.txt", row.name=FALSE)
