## Coursera Course: Getting and Cleaning Data
### Assignment: Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

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

* Load test and training data sets into data frames ("trainData", "testData")
* Load source variable names for test and training data sets ("trainLabel", "testLabel")
* Loaded subjects IDs for test and training data sets ("trainSubject", "testSubject")
* Concatenate test and training data frames using rbind ("joinData")
* Concatenate source variable names for test and training data sets using rbind ("joinLabel")
* Concatenate subjects IDs for test and training data sets using rbind ("joinSubject")
* Read the features.txt file and, using regular expression, extract the measurements on the mean and standard deviation.
* Get a subset of joinData with only the measurements on the mean and standard deviation.
* Replaced activity IDs with the activity labels for readability
* Combined the data frames to produce the "cleanedData" data frame containing the subjects, measurements and activities
* Applied the mean calculations across the groups
* Produced "data_with_means.txt" as the expected output


#### Output file
The output file "data_with_means.txt" can be considered a tidy data set becouse verifies these conditions:
* It have headings so I know which columns are which.
* The variables are in different columns (depending on the wide/long form)
* There are no duplicate columns

