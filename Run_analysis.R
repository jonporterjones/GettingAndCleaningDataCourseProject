#You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#    Any measurement containing the text mean() or std()
# 3) Uses descriptive activity names to name the activities in the data set
#    Use the names from features.txt to label what I extracted from #2
# 4) Appropriately labels the data set with descriptive variable names. (this would just be mean/sd)
#    Add the activity, label, subject
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#    Take the average of each measurement grouped by activity/subject

# set wd
setwd('/Users/jonporterjones/Coursera/DataScienceI/GettingAndCleaningData/ProgramAssignment')

#1)  Read in all the data frames I am going to need.
# test
#returns a data table with 2947 rows and 561 columns
testData=read.table('./UCI HAR Dataset/test/X_test.txt')

#2947 observations.  only 1 column indicating the ID of the activity
testActivity=read.table('./UCI HAR Dataset/test/y_test.txt')

#2947 observations.  only 1 column indicating the ID of the subject
testSubject=read.table('./UCI HAR Dataset/test/subject_test.txt')

#train
#returns a data table with 7352 rows and 561 columns
TrainData=read.table('./UCI HAR Dataset/train/X_train.txt')

#7352 observations.  only 1 column indicating the ID of the activity
TrainActivity=read.table('./UCI HAR Dataset/train/y_train.txt')

#7352 observations.  only 1 column indicating the ID of the subject
TrainSubject=read.table('./UCI HAR Dataset/train/subject_train.txt')

# other
# list of 561 features, containing 2 columns
FeaturesLabels=read.table('./UCI HAR Dataset/features.txt')

# The activity labels we will use later when joining to our combined data set.
ActivityLabels=read.table('./UCI HAR Dataset/activity_labels.txt')

# 2) Start to process the data

# produce a data frame containing all of the indicies and corresponding labels that contain a mean or a std
UsedFeaturesFrame=FeaturesLabels[(grep('mean()',FeaturesLabels$V2,fixed=TRUE)),]
UsedFeaturesFrame=rbind(UsedFeaturesFrame,FeaturesLabels[(grep('std()',FeaturesLabels$V2,fixed=TRUE)),])

# now select only those columns from the test and train data and place them into new data frames
testDataMeasures=testData[,UsedFeaturesFrame$V1] #select columns from test
TrainDataMeasures=TrainData[,UsedFeaturesFrame$V1] #select same columns from train
names(testDataMeasures)=UsedFeaturesFrame$V2 # rename the columns in test
names(TrainDataMeasures)=UsedFeaturesFrame$V2 # rename the columns in train

# add columns to test and train for the activity and subject (using descriptive labels)
testDataMeasures$ActivityID=as.integer(testActivity$V1);
testDataMeasures$SubjectID=as.factor(testSubject$V1);
TrainDataMeasures$ActivityID=as.integer(TrainActivity$V1);
TrainDataMeasures$SubjectID=as.factor(TrainSubject$V1);

# create a single data frame by binding the testData rows to TrainData
MergeTrainDataAndTestData=rbind(testDataMeasures,TrainDataMeasures)

# Rename the columns on ActivityLabels so that the join works
names(ActivityLabels)[1]='ActivityID'
names(ActivityLabels)[2]='ActivityLabel'

# 4) MergeTrainDataAndTestData is my tidy data set for step 4
#   This command simply adds the lablels for the Activities.
MergeTrainDataAndTestData=merge(MergeTrainDataAndTestData,ActivityLabels)

# 5) Use the dplyr package to group by ActivityID and SubjectID
install.packages("dplyr")
library(dplyr)
MergeTrainDataAndTestDataGrouped=group_by(MergeTrainDataAndTestData,ActivityID,SubjectID,ActivityLabel)  #group_by creates factor groups
MergeTrainDataAndTestDataGrouped=summarise_each(MergeTrainDataAndTestDataGrouped,funs(mean)) #summarise_each will perform the listed function (mean) on each non-grouped column
write.table(MergeTrainDataAndTestDataGrouped,file='./MergeTrainDataAndTestDataGrouped.txt',row.names=FALSE)