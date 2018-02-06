The file run_analysis.R is designed to work on data from the data set described here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The unzipped data set is expected to be in a subdirectory called "UCI HAR Dataset" in order for the script to work.

Using this data set, the script produces a data frame containing averages for each mean and standard deviation measurement in the original data set, grouped by subject and activity. This data is produced using the following steps:

1. Creating readable and valid variable names from the files "activity_labels.txt", "features.txt", and the "y_*.txt" and "subject_*.txt" files of the train and test datasets.
2. Joining the test and train datasets using rbind, using the feature names as column names
3. Selecting only those variables containing a mean or standard deviation measurement
4. Adding the corresponding subject and activity to each row using cbind
5. Grouping the resulting data frame by subject and activity and summarizing the rest of the variables using the mean
