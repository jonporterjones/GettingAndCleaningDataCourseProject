# Getting and Cleaning Data Course Project Code Book
## This codebook describes the tidy data set named MergeTrainDataAndTestDataGroupedwith the average of each variable for each activity and each subject.  
## Section 1 describes all of the columns in the data set.
## Section 2 describes the process to manipulate this source data the resulting  data frame.

### Section 1 - Columns

ActivityID - The numeric identifier for each activity.  Valid values are 1-6.                  
SubjectID - The numeric identifier for each subject.  The subjects are anonymous, so there is no label for each subject.                   
ActivityLabel - The label for each activity.
 1 WALKING
 2 WALKING_UPSTAIRS
 3 WALKING_DOWNSTAIRS
 4 SITTING
 5 STANDING
 6 LAYING

### The remaining columns contain labels from features.txt.  
### The values are the average of the numeric values for each group.  The data is grouped by ActivityID, SubjectID, ActivityLabel
tBodyAcc-mean()-X           
tBodyAcc-mean()-Y           
tBodyAcc-mean()-Z          
tGravityAcc-mean()-X        
tGravityAcc-mean()-Y        
tGravityAcc-mean()-Z       
tBodyAccJerk-mean()-X       
tBodyAccJerk-mean()-Y       
tBodyAccJerk-mean()-Z      
tBodyGyro-mean()-X          
tBodyGyro-mean()-Y          
tBodyGyro-mean()-Z         
tBodyGyroJerk-mean()-X      
tBodyGyroJerk-mean()-Y      
tBodyGyroJerk-mean()-Z     
tBodyAccMag-mean()          
tGravityAccMag-mean()       
tBodyAccJerkMag-mean()     
tBodyGyroMag-mean()         
tBodyGyroJerkMag-mean()     
fBodyAcc-mean()-X          
fBodyAcc-mean()-Y           
fBodyAcc-mean()-Z           
fBodyAccJerk-mean()-X      
fBodyAccJerk-mean()-Y       
fBodyAccJerk-mean()-Z       
fBodyGyro-mean()-X         
fBodyGyro-mean()-Y          
fBodyGyro-mean()-Z          
fBodyAccMag-mean()         
fBodyBodyAccJerkMag-mean()  
fBodyBodyGyroMag-mean()     
fBodyBodyGyroJerkMag-mean()
tBodyAcc-std()-X            
tBodyAcc-std()-Y            
tBodyAcc-std()-Z           
tGravityAcc-std()-X         
tGravityAcc-std()-Y         
tGravityAcc-std()-Z        
tBodyAccJerk-std()-X        
tBodyAccJerk-std()-Y        
tBodyAccJerk-std()-Z       
tBodyGyro-std()-X           
tBodyGyro-std()-Y           
tBodyGyro-std()-Z          
tBodyGyroJerk-std()-X       
tBodyGyroJerk-std()-Y       
tBodyGyroJerk-std()-Z      
tBodyAccMag-std()           
tGravityAccMag-std()        
tBodyAccJerkMag-std()      
tBodyGyroMag-std()          
tBodyGyroJerkMag-std()      
fBodyAcc-std()-X           
fBodyAcc-std()-Y            
fBodyAcc-std()-Z            
fBodyAccJerk-std()-X       
fBodyAccJerk-std()-Y        
fBodyAccJerk-std()-Z        
fBodyGyro-std()-X          
fBodyGyro-std()-Y           
fBodyGyro-std()-Z           
fBodyAccMag-std()          
fBodyBodyAccJerkMag-std()   
fBodyBodyGyroMag-std()      
fBodyBodyGyroJerkMag-std() 

### Section 2 - Process

The file Run_analysis.R is well commented; briefly explained here for completeness.

1) Read all source files into separate data frames
2) Find all of the measures in features.txt that contain the text mean() or std().
and place these in the data frame UsedFeaturesFrame.
3) Next select only those columns from testData and TrainData found in UsedFeaturesFrame and use it to rename the columns.
4) Now add the ActivityID and SubjectID columns to the test and train data frames.
5) Now combine the test and train data to form the data frame MergeTrainDataAndTestData
6) Rename the columns in the data frame created from activity_labels.txt to ActivityID and ActivityLabel so that ActivityID matches a column in MergeTrainDataAndTestData to use in the merge.
7) Use the merge() function to add the Activity labels to MergeTrainDataAndTestData.
**This is the tidy data set referred to step 4 of the instructions.**
8) Use the dplyr package to group MergeTrainDataAndTestData by ActivityID, SubjectID, and ActivityLabel.  Use the summarise_each() function to to take the mean of each feature value.  
** This is the data frame described in step 5 of the instructions. **
This data frame is written to the file MergeTrainDataAndTestDataGrouped.txt in the final line of Run_analysis.R.