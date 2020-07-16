## Getting and Cleaning Data - peer assessment project


## The original data was transformed by

1. Merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement. 
3. Using descriptive activity names to name the activities in the data set
4. Appropriately labeling the data set with descriptive activity names. 
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

## About R script
File with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work)

## About variables:   
* `test_set`, `test_label`, `train_set`, `train_label`, `subject_train` and `subject_test` contain the data from the downloaded files.
  * `test_set` and `train_set` are read from `X_test.txt` and `X_train.txt` respectively and contains the 561 features used in ML
  * `test_label` and `train_label` are read from `y_test.txt` and `y_train.txt` respectively and contains the labels used in ML
* `train_subject` and `test_subject` are read from `subject_train.txt` and `subject_test.txt` respectively and contains the subject identification for each observation.
* `features_name_mean_sd` contains the correct filtered names for the `test_set` and `train_set` dataset, which are applied to the column names stored in     
  * [1] "tBodyAcc-mean()-X"      "tBodyAcc-mean()-Y"      "tBodyAcc-mean()-Z"      "tBodyAcc-std()-X"      
  * [5] "tBodyAcc-std()-Y"       "tBodyAcc-std()-Z"       "tGravityAcc-mean()-X"   "tGravityAcc-mean()-Y"  
  * [9] "tGravityAcc-mean()-Z"   "tGravityAcc-std()-X"    "tGravityAcc-std()-Y"    "tGravityAcc-std()-Z"   
  * [13] "tBodyAccJerk-mean()-X"  "tBodyAccJerk-mean()-Y"  "tBodyAccJerk-mean()-Z"  "tBodyAccJerk-std()-X"  
  * [17] "tBodyAccJerk-std()-Y"   "tBodyAccJerk-std()-Z"   "tBodyGyro-mean()-X"     "tBodyGyro-mean()-Y"    
  * [21] "tBodyGyro-mean()-Z"     "tBodyGyro-std()-X"      "tBodyGyro-std()-Y"      "tBodyGyro-std()-Z"     
  * [25] "tBodyGyroJerk-mean()-X" "tBodyGyroJerk-mean()-Y" "tBodyGyroJerk-mean()-Z" "tBodyGyroJerk-std()-X" 
  * [29] "tBodyGyroJerk-std()-Y"  "tBodyGyroJerk-std()-Z"  "fBodyAcc-mean()-X"      "fBodyAcc-mean()-Y"     
  * [33] "fBodyAcc-mean()-Z"      "fBodyAcc-std()-X"       "fBodyAcc-std()-Y"       "fBodyAcc-std()-Z"      
  * [37] "fBodyAccJerk-mean()-X"  "fBodyAccJerk-mean()-Y"  "fBodyAccJerk-mean()-Z"  "fBodyAccJerk-std()-X"  
  * [41] "fBodyAccJerk-std()-Y"   "fBodyAccJerk-std()-Z"   "fBodyGyro-mean()-X"     "fBodyGyro-mean()-Y"    
  * [45] "fBodyGyro-mean()-Z"     "fBodyGyro-std()-X"      "fBodyGyro-std()-Y"      "fBodyGyro-std()-Z" 
* `label` contains the label for the each objservation in the dataset. The unique values are "1,2,3,4,5,6"     
  * [49] "label"                                  
* `subject` contains the subject identification for the each objservation in the dataset      
  * [50] "subject"
* `activity_label` contains the subject identification for the each objservation in the dataset. The unique values are "WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING"     
  * [51] "activity_label"
