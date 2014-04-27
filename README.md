README.txt
========================================================


The dataset includes the following files:
-------------------------

- 'README.md'

- 'Assignment.md': describes the assignment and source data, plus test code exploring the data

- 'getdata-projectfiles-UCI HAR Dataset.zip': zip file with all of the source data

- 'run_analysis.R': script which reads the source data and generates a summary text file

- 'AvgVars_bySubject_byActivity.txt'


Script design
-------------------------

This script does the folowing:

1. If the zip file doesn't exist, download it

2. Extract from the zip files needed:
     - X_train.txtz: training data set
     - y_train.txt: training activity codes
     - subject_train.txt: training subjects
     - X_test.txt: test data set
     - y_test.txt: test activity codes
     - subject_test.txt: test subjects
     - activity_labels.txt: activity labels
     - features.txt: feature labels

3. Load the data into memory

4. Prepare the data:
     - apply feature labels to data column names
     - add subject list as a column in data files
     - add activity codes as a column in data files
     - rbind the training and test data sets together
     - join to the activity labels
     - generate a factor index of features w/"mean()" or "std()" in the name (66 columns)
     - subset the data set to just the mean/std columns
     - melt the data set by subject and activity label
     - dcast the melted data to aggregate means by subject and activity label

5. Write out the summary data (180 rows * 68 columns) to a file called 'AvgVars_bySubject_byActivity.txt'

6. delete the files extracted from the zip


To run the script
-------------------------

1. Download 'run_analysis.R' and 'getdata-projectfiles-UCI HAR Dataset.zip' to your working directory

2. Ensure you have plyr and reshape2 packages installed

3. source run_analysis.R with print.eval=TRUE if you want to see progress statements


Description of the resulting output file
-------------------------

The resulting output file, 'AvgVars_bySubject_byActivity.txt', contains a header row and 180 data rows (30 subjects * 6 activities recorded). The data is aggregated to the subject/activity level.

field name | definition  
--- | ---
sub | code indicating a specific subject (person) in the study, values range from 1 to 30  
activity | activity performed by the subject (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)  
tBodyAcc-mean()-X | mean of values in this field in the source system by subject and activity  
tBodyAcc-mean()-Y | mean of values in this field in the source system by subject and activity  
tBodyAcc-mean()-Z | mean of values in this field in the source system by subject and activity  
tBodyAcc-std()-X | mean of values in this field in the source system by subject and activity  
tBodyAcc-std()-Y | mean of values in this field in the source system by subject and activity  
tBodyAcc-std()-Z | mean of values in this field in the source system by subject and activity  
tGravityAcc-mean()-X | mean of values in this field in the source system by subject and activity  
tGravityAcc-mean()-Y | mean of values in this field in the source system by subject and activity  
tGravityAcc-mean()-Z | mean of values in this field in the source system by subject and activity  
tGravityAcc-std()-X | mean of values in this field in the source system by subject and activity  
tGravityAcc-std()-Y | mean of values in this field in the source system by subject and activity  
tGravityAcc-std()-Z | mean of values in this field in the source system by subject and activity  
tBodyAccJerk-mean()-X | mean of values in this field in the source system by subject and activity  
tBodyAccJerk-mean()-Y | mean of values in this field in the source system by subject and activity  
tBodyAccJerk-mean()-Z | mean of values in this field in the source system by subject and activity  
tBodyAccJerk-std()-X | mean of values in this field in the source system by subject and activity  
tBodyAccJerk-std()-Y | mean of values in this field in the source system by subject and activity  
tBodyAccJerk-std()-Z | mean of values in this field in the source system by subject and activity  
tBodyGyro-mean()-X | mean of values in this field in the source system by subject and activity  
tBodyGyro-mean()-Y | mean of values in this field in the source system by subject and activity  
tBodyGyro-mean()-Z | mean of values in this field in the source system by subject and activity  
tBodyGyro-std()-X | mean of values in this field in the source system by subject and activity  
tBodyGyro-std()-Y | mean of values in this field in the source system by subject and activity  
tBodyGyro-std()-Z | mean of values in this field in the source system by subject and activity  
tBodyGyroJerk-mean()-X | mean of values in this field in the source system by subject and activity  
tBodyGyroJerk-mean()-Y | mean of values in this field in the source system by subject and activity  
tBodyGyroJerk-mean()-Z | mean of values in this field in the source system by subject and activity  
tBodyGyroJerk-std()-X | mean of values in this field in the source system by subject and activity  
tBodyGyroJerk-std()-Y | mean of values in this field in the source system by subject and activity  
tBodyGyroJerk-std()-Z | mean of values in this field in the source system by subject and activity  
tBodyAccMag-mean() | mean of values in this field in the source system by subject and activity  
tBodyAccMag-std() | mean of values in this field in the source system by subject and activity  
tGravityAccMag-mean() | mean of values in this field in the source system by subject and activity  
tGravityAccMag-std() | mean of values in this field in the source system by subject and activity  
tBodyAccJerkMag-mean() | mean of values in this field in the source system by subject and activity  
tBodyAccJerkMag-std() | mean of values in this field in the source system by subject and activity  
tBodyGyroMag-mean() | mean of values in this field in the source system by subject and activity  
tBodyGyroMag-std() | mean of values in this field in the source system by subject and activity  
tBodyGyroJerkMag-mean() | mean of values in this field in the source system by subject and activity  
tBodyGyroJerkMag-std() | mean of values in this field in the source system by subject and activity  
fBodyAcc-mean()-X | mean of values in this field in the source system by subject and activity  
fBodyAcc-mean()-Y | mean of values in this field in the source system by subject and activity  
fBodyAcc-mean()-Z | mean of values in this field in the source system by subject and activity  
fBodyAcc-std()-X | mean of values in this field in the source system by subject and activity  
fBodyAcc-std()-Y | mean of values in this field in the source system by subject and activity  
fBodyAcc-std()-Z | mean of values in this field in the source system by subject and activity  
fBodyAccJerk-mean()-X | mean of values in this field in the source system by subject and activity  
fBodyAccJerk-mean()-Y | mean of values in this field in the source system by subject and activity  
fBodyAccJerk-mean()-Z | mean of values in this field in the source system by subject and activity  
fBodyAccJerk-std()-X | mean of values in this field in the source system by subject and activity  
fBodyAccJerk-std()-Y | mean of values in this field in the source system by subject and activity  
fBodyAccJerk-std()-Z | mean of values in this field in the source system by subject and activity  
fBodyGyro-mean()-X | mean of values in this field in the source system by subject and activity  
fBodyGyro-mean()-Y | mean of values in this field in the source system by subject and activity  
fBodyGyro-mean()-Z | mean of values in this field in the source system by subject and activity  
fBodyGyro-std()-X | mean of values in this field in the source system by subject and activity  
fBodyGyro-std()-Y | mean of values in this field in the source system by subject and activity  
fBodyGyro-std()-Z | mean of values in this field in the source system by subject and activity  
fBodyAccMag-mean() | mean of values in this field in the source system by subject and activity  
fBodyAccMag-std() | mean of values in this field in the source system by subject and activity  
fBodyBodyAccJerkMag-mean() | mean of values in this field in the source system by subject and activity  
fBodyBodyAccJerkMag-std() | mean of values in this field in the source system by subject and activity  
fBodyBodyGyroMag-mean() | mean of values in this field in the source system by subject and activity  
fBodyBodyGyroMag-std() | mean of values in this field in the source system by subject and activity  
fBodyBodyGyroJerkMag-mean() | mean of values in this field in the source system by subject and activity  
fBodyBodyGyroJerkMag-std() | mean of values in this field in the source system by subject and activity  


