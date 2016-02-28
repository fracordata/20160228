## Coursera Course: Getting and Cleaning Data
### Assignment: Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

The goal is to download a data set (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and to prepare tidy data that can be used for later analysis.

In this repo you can find these files:

* README.md: the presentation file that you are reading
* run_analysis.R: the R script used to generate the calculated_tidy_data.txt
* CookBook.md: a code book that describes the variables, the data, and any transformations or work performed to clean up the data.

#### Preconditions
* The data are downloded from the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The archive is unzippend in the R Studio working directory
* The archive is unzippend in the R Studio working directory
* To extracts only the measurements on the "mean" and "standard deviation" for each measurement we assumed that this measurements can be identified by this conditions:
** Measurements on the "mean": : all the features which name contains  the sting "mean()"
** Measurements on the "standard deviation": all the features which name contains  the sting "std()"

#### R script structure
The run_analysis.R script performs the following steps to clean the data:

* Read X_train.txt, y_train.txt and subject_train.txt from the "./UCI HAR Dataset/train" folder and store them in trainData, trainLabel and trainSubject variables respectively.
* Read X_test.txt, y_test.txt and subject_test.txt from the "./UCI HAR Dataset/test" folder and store them in testData, testLabel and testsubject variables respectively.
* Concatenate testData to trainData to generate a 10299x561 data frame, joinData; concatenate testLabel to trainLabel to generate a 10299x1 data frame, joinLabel; concatenate testSubject to trainSubject to generate a 10299x1 data frame, joinSubject.
* Read the features.txt file from the "/data" folder and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of joinData with the 66 corresponding columns.
* Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
* Read the activity_labels.txt file from the "./UCI HAR Dataset"" folder and store the data in a variable called activity.
* Clean the activity names in the second column of activity. We first make all names to lower cases. If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore.
* Transform the values of joinLabel according to the activity data frame.
* Combine the joinSubject, joinLabel and joinData by column to get a new cleaned 10299x68 data frame, cleanedData. Properly name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activity names; the last 66 columns contain measurements that range from -1 to 1 exclusive.
* Generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.
* Write the result out to "data_with_means.txt" file in current working directory.

#### Output file
The output file "data_with_means.txt" can be considered a tidy data set becouse verifies these conditions:
* It have headings so I know which columns are which.
* The variables are in different columns (depending on the wide/long form)
* There are no duplicate columns

