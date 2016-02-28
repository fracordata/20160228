## ############################################################################################
## File: run_analysis.R
## Version: 1.0
## Date: 28/02/2016
## 
## 1. Merges the "training" and the "test" sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
## ############################################################################################
run_analysis <- function(){
  # Step1. Merges the training and the test sets to create one data set.
  # setwd("~/Desktop/Online Coursera/Coursera-Getting-and-Cleaning-Data/peer_assessment/")
  
  trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
  # dim(trainData) # 7352 Osservations * 561 Variables

  trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
  # 7352    # Activity IDs associated to the 7352 Observation
  
  trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
  # dim(testData) # 2947 Osservations * 561 Variables
  
  testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt") 
  # dim(testLabel) # Activity IDs associated to the 2947 Observation
  
  testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

  # Concatenate testData to trainData to generate a 10299x561 data frame,joinData;
  joinData <- rbind(trainData, testData)

  # Concatenate testLabel to trainLabel to generate a 10299x1 data frame, joinLabel;
  joinLabel <- rbind(trainLabel, testLabel)

  # Concatenate testSubject to trainSubject to generate a 10299x1 data frame, joinSubject.
  joinSubject <- rbind(trainSubject, testSubject)

  # Step2. Extracts only the measurements on the mean and standard 
  # deviation for each measurement. 
  
  # Read the features.txt file from the "/data" folder and store the data in a variable called features.
  features <- read.table("./UCI HAR Dataset/features.txt")

  # We only extract the measurements on the mean and standard deviation.
  # Use regular expression: label which contains "mean(" or "std(" 
  # This results in a 66 indices list. 
  meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])

  # We get a subset of joinData with the 66 corresponding columns.
  # 'data.frame':	10299 obs. of  66 variables
  joinData <- joinData[, meanStdIndices]

  # Clean the column names of the subset.
  # We remove the "()" and "-" symbols in the names
  # Make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
  names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
  names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
  names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
  names(joinData) <- gsub("-", " ", names(joinData)) # replace "-" with " " in column names 

  
  
  # Step3. Uses descriptive activity names to name the activities in 
  # the data set
  
  # Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called activity.
  activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  # Clean the activity names in the second column of activity.
  # We first make all names to lower cases.
  # If the name has an underscore between letters, we remove the underscore and capitalize the letter immediately after the underscore
  activity[ , 2] <- tolower(gsub("_", "", activity[, 2]))
  
  # substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
  # substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
  
  # Transform the values of joinLabel according to the activity data frame
  activityLabel <- activity[joinLabel[, 1], 2]
  joinLabel[, 1] <- activityLabel
  names(joinLabel) <- "activity"
  
  
  # Step4. Appropriately labels the data set with descriptive activity 
  # names. 
  names(joinSubject) <- "subject"
  cleanedData <- cbind(joinSubject, joinLabel, joinData)
  # dim(cleanedData) # 10299*68
  # write.table(cleanedData, "merged_data.txt") # write out the 1st dataset
  
  # Step5. Creates a second, independent tidy data set with the average of 
  # each variable for each activity and each subject. 
  subjectLen <- length(table(joinSubject)) # 30
  activityLen <- dim(activity)[1] # 6
  columnLen <- dim(cleanedData)[2]
  result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
  result <- as.data.frame(result)
  colnames(result) <- colnames(cleanedData)
  row <- 1
  for(i in 1:subjectLen) {# for each subject
    for(j in 1:activityLen) {# for each activity
      result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
      result[row, 2] <- activity[j, 2]
      bool1 <- i == cleanedData$subject
      bool2 <- activity[j, 2] == cleanedData$activity
      result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
      row <- row + 1
    }
  }
  #head(result)
  write.table(result, "data_with_means.txt", row.name=FALSE) # write out the 2nd dataset

}