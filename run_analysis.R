library(dplyr)
# load data for labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "feature"))
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
# make pretty and valid labels
feature_labels <- make.names(features$feature, unique = TRUE)
activities <- mutate(rbind(test_activities, train_activities), activity = activityLabels$activity[V1])
subjects <- rename(rbind(test_subjects, train_subjects), subject.id = V1)

# load data
testX <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature_labels)
trainX <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature_labels)
# merged test and train data set
full_data <- rbind(testX, trainX)
# select only the variables describing a mean or a standard deviation
means_stds <- full_data %>% select(matches("\\.mean\\.|\\.std\\."))
# add the subject id and activity
labeled_data <- cbind(subjects, activities["activity"], means_stds)
# group by subject.id and activity and calculate the mean for each variable
result <- labeled_data %>% 
  group_by(subject.id, activity) %>%
  summarize_all(mean)
result