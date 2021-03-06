#******************************************************************
#Step 0: Understanding the data set that was provided
#******************************************************************
# Readme documentation: 
#   provided some understanding that this whole experiment is to use features extracted/derived from
#   accelerometer and gyroscope raw signals to predict the 6 actions
#   (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

# From the basic understanding of machine learning both training and test set contains contains features and labels.
# 'train/X_train.txt': Training set.
# 'train/y_train.txt': Training labels.
# 'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.
#******************************************************************
#Requirement 1:Merges the training and the test sets to create one data set.
#Step 1: Merges the training and the test sets to create one data set.
#Step 1.1: extract the Training set/labels and Test set/labels
#******************************************************************
test_set_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
test_label_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt"
test_subject_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"

train_set_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
train_label_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt"
train_subject_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"

test_set<-read.table(test_set_path)          #2947 observations x 561 variable (features)
test_label<-read.table(test_label_path)      #2947 observations x 1 variable (label)
test_subject<-read.table(test_subject_path)  #2947 observations x 1 variable (subject)
str(test_set)
str(test_label)
str(test_subject)
unique(test_label)                           #unique values are 1,2,3,4,5,6 corresponding to the 6 actions
train_set<-read.table(train_set_path)        #7352 observations x 561 variable (features)
train_label<-read.table(train_label_path)    #7352 observations x 1 variable (label)
train_subject<-read.table(train_subject_path)  #7352 observations x 1 variable (subject)
str(train_set)
str(train_label)
str(train_subject)
unique(train_label)                          #unique values are 1,2,3,4,5,6 corresponding to the 6 actions
#notice :
#  the split in observation is test 2947(29%) and train 7352(71%)
#  "train/Inertial Signals" and "test/Inertial Signals"
#  were not extracted because they are the 'raw data' used to extract/derive the features


#******************************************************************
#Step 1.2: exploring Inertial Signals
#please ignore this step if you are not interested in exploring Inertial Signals
#******************************************************************
set<-c("test","train")
for (j in seq_along(set) ){
  path=paste("./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/",set[j],"/Inertial Signals/",sep = "")
  file.names <- dir(path, pattern =".txt")
  for(i in 1:length(file.names)){
    print(file.names[i])
    file <- read.table(paste(path,file.names[i],sep = ""))
    names(file)<-file.names[i]               
    print(dim(file))                         #7352 observations x 128 variable
  }
}
#******************************************************************
#Step 1.3: Merging all the datasets
#          appending labels variables and the features variable
#          then combining test and train data set
#******************************************************************
test<-cbind(test_set,test_label,test_subject)
train<-cbind(train_set,train_label,train_subject)
complete<-rbind(test,train)                  #Expected
str(complete)                                #10299 observations x 563 variable (features+label+subject)

#******************************************************************
#Requirement 4: Appropriately labels the data set with descriptive variable names.
#Step 1.4: Appropriately labels the data set with descriptive variable names.
#          changing the names of complete data set using features.txt
#******************************************************************
features_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
features_name<-read.table(features_path)
features_name<-rbind(features_name,list(V1=c(562,563),V2=c("label","subject")))
str(features_name)                           #563 observations x 2 variable (index,feature names+label+subject)
names(complete)<-features_name[[2]]
str(complete)                                #10299 observations x  563 variables(features+label+subject)

#******************************************************************
#Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
#******************************************************************
features_name_mean_sd<-features_name[grepl("mean|std", features_name$V2),]
complete_mean_sd<-complete[,append(features_name_mean_sd[[2]],c("label","subject"))]
str(complete_mean_sd)                        #10299 observations x 81 variable (mean_sd_features+label)
# 'data.frame':	10299 obs. of  2 variables:
#   $ label  : int  5 5 5 5 5 5 5 5 5 5 ...
# $ subject: int  2 2 2 2 2 2 2 2 2 2 ...
# > features_name_mean_sd<-features_name[grepl("mean|std", features_name$V2),]
# > complete_mean_sd<-complete[,append(features_name_mean_sd[[2]],c("label","subject"))]
# > str(complete_mean_sd)   
# 'data.frame':	10299 obs. of  81 variables:
# $ tBodyAcc-mean()-X              : num  0.257 0.286 0.275 0.27 0.275 ...
# .                         .
# .                         .
# .                         .
# $ fBodyBodyGyroJerkMag-meanFreq(): num  0.0716 -0.4012 0.0629 0.1167 -0.1217 ...
# $ label                          : int  5 5 5 5 5 5 5 5 5 5 ...
# $ subject                        : int  2 2 2 2 2 2 2 2 2 2 ...
names(complete_mean_sd)
# > names(complete_mean_sd)
# [1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"              
# [4] "tBodyAcc-std()-X"                "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"               
# [7] "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"           
# [10] "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
# [13] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"          
# [16] "tBodyAccJerk-std()-X"            "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"           
# [19] "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"             
# [22] "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
# [25] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"         
# [28] "tBodyGyroJerk-std()-X"           "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"          
# [31] "tBodyAccMag-mean()"              "tBodyAccMag-std()"               "tGravityAccMag-mean()"          
# [34] "tGravityAccMag-std()"            "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
# [37] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"        
# [40] "tBodyGyroJerkMag-std()"          "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"              
# [43] "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"                "fBodyAcc-std()-Y"               
# [46] "fBodyAcc-std()-Z"                "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
# [49] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"          
# [52] "fBodyAccJerk-mean()-Z"           "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"           
# [55] "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"      
# [58] "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
# [61] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"              
# [64] "fBodyGyro-std()-Z"               "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"         
# [67] "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"              "fBodyAccMag-std()"              
# [70] "fBodyAccMag-meanFreq()"          "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
# [73] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"         
# [76] "fBodyBodyGyroMag-meanFreq()"     "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"     
# [79] "fBodyBodyGyroJerkMag-meanFreq()" "label"                           "subject"   

#******************************************************************
#Requirement 3: Uses descriptive activity names to name the activities in the data set
#Step 3: Uses descriptive activity names to name the activities in the data set
#******************************************************************
activity_label_path<-"./course3/Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"

activity_label<-features_name<-read.table(activity_label_path)
names(activity_label)<-c("label","activity_label")
complete_mean_sd_label <- merge(complete_mean_sd, activity_label,
                              by='label',all.x=TRUE)
str(complete_mean_sd_label)                  #10299 observation of  82 variables(mean_sd_features+label+activity label)
# 'data.frame':	10299 obs. of  82 variables:
#   $ label                          : int  1 1 1 1 1 1 1 1 1 1 ...
# $ tBodyAcc-mean()-X              : num  0.269 0.262 0.238 0.245 0.249 ...
# .                         .
# .                         .
# .                         .
# $ fBodyBodyGyroJerkMag-meanFreq(): num  -0.12175 0.34638 -0.00087 -0.01887 0.10134 ...
# $ subject                        : int  7 21 7 7 18 7 7 7 11 21 ...
# $ activity_label                 : chr  "WALKING" "WALKING" "WALKING" "WALKING" ...


#******************************************************************
#Requirement 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Step 4: create independent tidy data set with the average of each variable for each activity and each subject.
#******************************************************************

featuremean_activity_label<-aggregate(.~subject+activity_label,complete_mean_sd_label,mean)
featuremean_activity_label<-featuremean_activity_label[order(featuremean_activity_label$subject,featuremean_activity_label$label),]
str(featuremean_activity_label)
# 'data.frame':	180 obs. of  82 variables:
# $ subject                        : int  1 1 1 1 1 1 2 2 2 2 ...
# $ activity_label                 : chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...
# $ label                          : num  1 2 3 4 5 6 1 2 3 4 ...
# $ tBodyAcc-mean()-X              : num  0.277 0.255 0.289 0.261 0.279 ...
# .                         .
# .                         .
# .                         .
# $ fBodyBodyGyroJerkMag-meanFreq(): num  0.191 0.114 0.19 0.185 0.334 ...

write.table(featuremean_activity_label, "./course3/Assignment/featurMean.txt", row.name=FALSE)
