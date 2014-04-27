#############################
# Class:      https://class.coursera.org/getdata-002
# Assignment: Getting and Cleaning Data Project
# Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net
#############################
# Per instructions:
#     - run_analysis.R can be run as long as the Samsung data is in your
#       working directory.
#     - The output should be the tidy data set you submit for part 1.
#############################

################
# Set-Up
################
library(plyr)
library(reshape2)

# constants
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "getdata-projectfiles-UCI HAR Dataset.zip"
outfile="AvgVars_bySubject_byActivity.txt"
wantfiles <- c("UCI HAR Dataset/train/X_train.txt",        # training set
               "UCI HAR Dataset/train/y_train.txt",        # training labels
               "UCI HAR Dataset/train/subject_train.txt",  # training subjects
               "UCI HAR Dataset/test/X_test.txt",          # test set
               "UCI HAR Dataset/test/y_test.txt",          # test labels
               "UCI HAR Dataset/test/subject_test.txt",    # test subjects
               "UCI HAR Dataset/activity_labels.txt",      # activity labels
               "UCI HAR Dataset/features.txt")             # feature decodes
deletefiles<- c("X_train.txt","y_train.txt","subject_train.txt",
                "X_test.txt","y_test.txt","subject_test.txt",
                "activity_labels.txt","features.txt")

noquote("checking for source zip file . . .")

# download data for the project, if it isn't already present
if(!file.exists(zipfile)){download.file(fileUrl,destfile=zipfile)}

# free up memory after last use
rm(fileUrl)

# extract just the files we want into the working directory (omit zip paths)
unzip(zipfile, files=wantfiles, junkpaths=TRUE, list=FALSE)

# free up memory after last use
rm(zipfile); rm(wantfiles)

################
# load data files
################

noquote("load data files . . .")

trainData  <- read.table("X_train.txt")
testData   <- read.table("X_test.txt")
trainSubs  <- read.table("subject_train.txt")
testSubs   <- read.table("subject_test.txt")
trainLbls  <- read.table("Y_train.txt")
testLbls   <- read.table("Y_test.txt" )
actvtyLbls <- read.table("activity_labels.txt")
features   <- read.table("features.txt")

################
# prep data
################

noquote("prepare data . . .")

# apply feature names to column headers
names(trainData) <- features[,2]
names(testData)  <- features[,2]

# add subjects to data (factor so we can group by it)
trainData$sub <- as.factor(trainSubs[,1])
testData$sub  <- as.factor(testSubs[,1])

# add labels to data
trainData$lbl <- trainLbls[,1]
testData$lbl  <- testLbls[,1]

# identify which rows came from which data set for debugging purposes
trainData$src <- rep("train",nrow(trainData))
testData$src  <- rep("test",nrow(testData))

# combine the two data sets into one
allData <- rbind(trainData,testData)

# free up memory after last use
rm(trainData); rm(testData)
rm(trainSubs); rm(testSubs)
rm(trainLbls); rm(testLbls)

# apply the activity labels
names(actvtyLbls) <- c("lbl","activity")
allData2 <- arrange(join(allData,actvtyLbls),lbl)

# free up memory after last use
rm(allData); rm(actvtyLbls)

# list mean() and std() columns (assignment step 2)
meanstdCols <- features[grepl("mean\\(\\)",features$V2)|grepl("std\\(\\)",features$V2),1]

# subset data to mean() and std() columns plus subject and activity
meanstdData <- allData2[,c(meanstdCols,562,565)]

# free up memory after last use
rm(allData2); rm(features); rm(meanstdCols)

# summarize the data
meltData <- melt(meanstdData,
                 id=c("sub","activity"),
                 na.rm=TRUE)
aggData <- dcast(meltData,       # input data
                 sub + activity  # one row per each value
                 ~ variable,     # one col for each value
                 mean)           # how to aggregate
# aggData has 180 obs. of  68 variables

################
# write out the file
################
noquote(paste("writing output to ",outfile))
write.table(aggData,file=outfile)

# free up memory after last use
rm(meanstdData); rm(meltData); rm(aggData)
rm(outfile)

################
# clean up files extracted from zip
################
unlink(deletefiles)

# free up memory after last use
rm(deletefiles)

noquote("run complete")