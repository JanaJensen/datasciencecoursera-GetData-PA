Getting and Cleaning Data Project
========================================================

Class:      https://class.coursera.org/getdata-002  
Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net  

Assignment Instructions
-------------------------

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following.   
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive activity names.   
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.   

Human Activity Recognition Using Smartphones Data Set 
-------------------------
**Abstract:** Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

 Summary  |  Value
--- | ---
Data Set Characteristics: | Multivariate, Time-Series
Attribute Characteristics: | N/A
Associated Tasks: | Classification, Clustering
Number of Instances: | 10299
Number of Attributes: | 561
Missing Values? | N/A
Area: | Computer
Date Donated: | 2012-12-10
Number of Web Hits: | 76879


**Source:**

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy.  
activityrecognition '@' smartlab.ws  
www.smartlab.ws  

### Human Activity Recognition Using Smartphones Dataset (Version 1.0)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

#### The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

#### Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

#### License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Exploring the data
-------------------------

```r
################
# Set-Up
################
setwd("~/GitHub/datasciencecoursera-GetData-PA")

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

# download data for the project, if it isn't already present
if(!file.exists(zipfile)){download.file(fileUrl,destfile=zipfile)}

# extract just the files we want into the working directory (omit zip paths)
unzip(zipfile, files=wantfiles, junkpaths=TRUE, list=FALSE)

# how many rows in total
trainLines <- length(readLines("X_train.txt"))  # how many rows in source file
testLines  <- length(readLines("X_test.txt"))   # how many rows in source file
c(trainLines,testLines)
```

```
## [1] 7352 2947
```

```r

################
# load data files
################

trainData  <- read.table("X_train.txt",nrows=5)
testData   <- read.table("X_test.txt",nrows=5)
trainSubs  <- read.table("subject_train.txt")
testSubs   <- read.table("subject_test.txt")
trainLbls  <- read.table("Y_train.txt")
testLbls   <- read.table("Y_test.txt" )
actvtyLbls <- read.table("activity_labels.txt")
features   <- read.table("features.txt")

################
# examine data
################

names(trainData)        # 561 vars
```

```
##   [1] "V1"   "V2"   "V3"   "V4"   "V5"   "V6"   "V7"   "V8"   "V9"   "V10" 
##  [11] "V11"  "V12"  "V13"  "V14"  "V15"  "V16"  "V17"  "V18"  "V19"  "V20" 
##  [21] "V21"  "V22"  "V23"  "V24"  "V25"  "V26"  "V27"  "V28"  "V29"  "V30" 
##  [31] "V31"  "V32"  "V33"  "V34"  "V35"  "V36"  "V37"  "V38"  "V39"  "V40" 
##  [41] "V41"  "V42"  "V43"  "V44"  "V45"  "V46"  "V47"  "V48"  "V49"  "V50" 
##  [51] "V51"  "V52"  "V53"  "V54"  "V55"  "V56"  "V57"  "V58"  "V59"  "V60" 
##  [61] "V61"  "V62"  "V63"  "V64"  "V65"  "V66"  "V67"  "V68"  "V69"  "V70" 
##  [71] "V71"  "V72"  "V73"  "V74"  "V75"  "V76"  "V77"  "V78"  "V79"  "V80" 
##  [81] "V81"  "V82"  "V83"  "V84"  "V85"  "V86"  "V87"  "V88"  "V89"  "V90" 
##  [91] "V91"  "V92"  "V93"  "V94"  "V95"  "V96"  "V97"  "V98"  "V99"  "V100"
## [101] "V101" "V102" "V103" "V104" "V105" "V106" "V107" "V108" "V109" "V110"
## [111] "V111" "V112" "V113" "V114" "V115" "V116" "V117" "V118" "V119" "V120"
## [121] "V121" "V122" "V123" "V124" "V125" "V126" "V127" "V128" "V129" "V130"
## [131] "V131" "V132" "V133" "V134" "V135" "V136" "V137" "V138" "V139" "V140"
## [141] "V141" "V142" "V143" "V144" "V145" "V146" "V147" "V148" "V149" "V150"
## [151] "V151" "V152" "V153" "V154" "V155" "V156" "V157" "V158" "V159" "V160"
## [161] "V161" "V162" "V163" "V164" "V165" "V166" "V167" "V168" "V169" "V170"
## [171] "V171" "V172" "V173" "V174" "V175" "V176" "V177" "V178" "V179" "V180"
## [181] "V181" "V182" "V183" "V184" "V185" "V186" "V187" "V188" "V189" "V190"
## [191] "V191" "V192" "V193" "V194" "V195" "V196" "V197" "V198" "V199" "V200"
## [201] "V201" "V202" "V203" "V204" "V205" "V206" "V207" "V208" "V209" "V210"
## [211] "V211" "V212" "V213" "V214" "V215" "V216" "V217" "V218" "V219" "V220"
## [221] "V221" "V222" "V223" "V224" "V225" "V226" "V227" "V228" "V229" "V230"
## [231] "V231" "V232" "V233" "V234" "V235" "V236" "V237" "V238" "V239" "V240"
## [241] "V241" "V242" "V243" "V244" "V245" "V246" "V247" "V248" "V249" "V250"
## [251] "V251" "V252" "V253" "V254" "V255" "V256" "V257" "V258" "V259" "V260"
## [261] "V261" "V262" "V263" "V264" "V265" "V266" "V267" "V268" "V269" "V270"
## [271] "V271" "V272" "V273" "V274" "V275" "V276" "V277" "V278" "V279" "V280"
## [281] "V281" "V282" "V283" "V284" "V285" "V286" "V287" "V288" "V289" "V290"
## [291] "V291" "V292" "V293" "V294" "V295" "V296" "V297" "V298" "V299" "V300"
## [301] "V301" "V302" "V303" "V304" "V305" "V306" "V307" "V308" "V309" "V310"
## [311] "V311" "V312" "V313" "V314" "V315" "V316" "V317" "V318" "V319" "V320"
## [321] "V321" "V322" "V323" "V324" "V325" "V326" "V327" "V328" "V329" "V330"
## [331] "V331" "V332" "V333" "V334" "V335" "V336" "V337" "V338" "V339" "V340"
## [341] "V341" "V342" "V343" "V344" "V345" "V346" "V347" "V348" "V349" "V350"
## [351] "V351" "V352" "V353" "V354" "V355" "V356" "V357" "V358" "V359" "V360"
## [361] "V361" "V362" "V363" "V364" "V365" "V366" "V367" "V368" "V369" "V370"
## [371] "V371" "V372" "V373" "V374" "V375" "V376" "V377" "V378" "V379" "V380"
## [381] "V381" "V382" "V383" "V384" "V385" "V386" "V387" "V388" "V389" "V390"
## [391] "V391" "V392" "V393" "V394" "V395" "V396" "V397" "V398" "V399" "V400"
## [401] "V401" "V402" "V403" "V404" "V405" "V406" "V407" "V408" "V409" "V410"
## [411] "V411" "V412" "V413" "V414" "V415" "V416" "V417" "V418" "V419" "V420"
## [421] "V421" "V422" "V423" "V424" "V425" "V426" "V427" "V428" "V429" "V430"
## [431] "V431" "V432" "V433" "V434" "V435" "V436" "V437" "V438" "V439" "V440"
## [441] "V441" "V442" "V443" "V444" "V445" "V446" "V447" "V448" "V449" "V450"
## [451] "V451" "V452" "V453" "V454" "V455" "V456" "V457" "V458" "V459" "V460"
## [461] "V461" "V462" "V463" "V464" "V465" "V466" "V467" "V468" "V469" "V470"
## [471] "V471" "V472" "V473" "V474" "V475" "V476" "V477" "V478" "V479" "V480"
## [481] "V481" "V482" "V483" "V484" "V485" "V486" "V487" "V488" "V489" "V490"
## [491] "V491" "V492" "V493" "V494" "V495" "V496" "V497" "V498" "V499" "V500"
## [501] "V501" "V502" "V503" "V504" "V505" "V506" "V507" "V508" "V509" "V510"
## [511] "V511" "V512" "V513" "V514" "V515" "V516" "V517" "V518" "V519" "V520"
## [521] "V521" "V522" "V523" "V524" "V525" "V526" "V527" "V528" "V529" "V530"
## [531] "V531" "V532" "V533" "V534" "V535" "V536" "V537" "V538" "V539" "V540"
## [541] "V541" "V542" "V543" "V544" "V545" "V546" "V547" "V548" "V549" "V550"
## [551] "V551" "V552" "V553" "V554" "V555" "V556" "V557" "V558" "V559" "V560"
## [561] "V561"
```

```r
str(trainData[,1:10])   # all numbers
```

```
## 'data.frame':	5 obs. of  10 variables:
##  $ V1 : num  0.289 0.278 0.28 0.279 0.277
##  $ V2 : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166
##  $ V3 : num  -0.133 -0.124 -0.113 -0.123 -0.115
##  $ V4 : num  -0.995 -0.998 -0.995 -0.996 -0.998
##  $ V5 : num  -0.983 -0.975 -0.967 -0.983 -0.981
##  $ V6 : num  -0.914 -0.96 -0.979 -0.991 -0.99
##  $ V7 : num  -0.995 -0.999 -0.997 -0.997 -0.998
##  $ V8 : num  -0.983 -0.975 -0.964 -0.983 -0.98
##  $ V9 : num  -0.924 -0.958 -0.977 -0.989 -0.99
##  $ V10: num  -0.935 -0.943 -0.939 -0.939 -0.942
```

```r
str(trainLbls)          # 7352 obs of 1 var, one for each row in data
```

```
## 'data.frame':	7352 obs. of  1 variable:
##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
```

```r
table(trainLbls)        # var values are 1:6
```

```
## trainLbls
##    1    2    3    4    5    6 
## 1226 1073  986 1286 1374 1407
```

```r
str(trainSubs)          # 7352 obs of 1 var, one for each row in data
```

```
## 'data.frame':	7352 obs. of  1 variable:
##  $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
```

```r
table(trainSubs)        # 21 subjects w/300+ rows each
```

```
## trainSubs
##   1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27 
## 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 
##  28  29  30 
## 382 344 383
```

```r

names(testData)         # same as trainData
```

```
##   [1] "V1"   "V2"   "V3"   "V4"   "V5"   "V6"   "V7"   "V8"   "V9"   "V10" 
##  [11] "V11"  "V12"  "V13"  "V14"  "V15"  "V16"  "V17"  "V18"  "V19"  "V20" 
##  [21] "V21"  "V22"  "V23"  "V24"  "V25"  "V26"  "V27"  "V28"  "V29"  "V30" 
##  [31] "V31"  "V32"  "V33"  "V34"  "V35"  "V36"  "V37"  "V38"  "V39"  "V40" 
##  [41] "V41"  "V42"  "V43"  "V44"  "V45"  "V46"  "V47"  "V48"  "V49"  "V50" 
##  [51] "V51"  "V52"  "V53"  "V54"  "V55"  "V56"  "V57"  "V58"  "V59"  "V60" 
##  [61] "V61"  "V62"  "V63"  "V64"  "V65"  "V66"  "V67"  "V68"  "V69"  "V70" 
##  [71] "V71"  "V72"  "V73"  "V74"  "V75"  "V76"  "V77"  "V78"  "V79"  "V80" 
##  [81] "V81"  "V82"  "V83"  "V84"  "V85"  "V86"  "V87"  "V88"  "V89"  "V90" 
##  [91] "V91"  "V92"  "V93"  "V94"  "V95"  "V96"  "V97"  "V98"  "V99"  "V100"
## [101] "V101" "V102" "V103" "V104" "V105" "V106" "V107" "V108" "V109" "V110"
## [111] "V111" "V112" "V113" "V114" "V115" "V116" "V117" "V118" "V119" "V120"
## [121] "V121" "V122" "V123" "V124" "V125" "V126" "V127" "V128" "V129" "V130"
## [131] "V131" "V132" "V133" "V134" "V135" "V136" "V137" "V138" "V139" "V140"
## [141] "V141" "V142" "V143" "V144" "V145" "V146" "V147" "V148" "V149" "V150"
## [151] "V151" "V152" "V153" "V154" "V155" "V156" "V157" "V158" "V159" "V160"
## [161] "V161" "V162" "V163" "V164" "V165" "V166" "V167" "V168" "V169" "V170"
## [171] "V171" "V172" "V173" "V174" "V175" "V176" "V177" "V178" "V179" "V180"
## [181] "V181" "V182" "V183" "V184" "V185" "V186" "V187" "V188" "V189" "V190"
## [191] "V191" "V192" "V193" "V194" "V195" "V196" "V197" "V198" "V199" "V200"
## [201] "V201" "V202" "V203" "V204" "V205" "V206" "V207" "V208" "V209" "V210"
## [211] "V211" "V212" "V213" "V214" "V215" "V216" "V217" "V218" "V219" "V220"
## [221] "V221" "V222" "V223" "V224" "V225" "V226" "V227" "V228" "V229" "V230"
## [231] "V231" "V232" "V233" "V234" "V235" "V236" "V237" "V238" "V239" "V240"
## [241] "V241" "V242" "V243" "V244" "V245" "V246" "V247" "V248" "V249" "V250"
## [251] "V251" "V252" "V253" "V254" "V255" "V256" "V257" "V258" "V259" "V260"
## [261] "V261" "V262" "V263" "V264" "V265" "V266" "V267" "V268" "V269" "V270"
## [271] "V271" "V272" "V273" "V274" "V275" "V276" "V277" "V278" "V279" "V280"
## [281] "V281" "V282" "V283" "V284" "V285" "V286" "V287" "V288" "V289" "V290"
## [291] "V291" "V292" "V293" "V294" "V295" "V296" "V297" "V298" "V299" "V300"
## [301] "V301" "V302" "V303" "V304" "V305" "V306" "V307" "V308" "V309" "V310"
## [311] "V311" "V312" "V313" "V314" "V315" "V316" "V317" "V318" "V319" "V320"
## [321] "V321" "V322" "V323" "V324" "V325" "V326" "V327" "V328" "V329" "V330"
## [331] "V331" "V332" "V333" "V334" "V335" "V336" "V337" "V338" "V339" "V340"
## [341] "V341" "V342" "V343" "V344" "V345" "V346" "V347" "V348" "V349" "V350"
## [351] "V351" "V352" "V353" "V354" "V355" "V356" "V357" "V358" "V359" "V360"
## [361] "V361" "V362" "V363" "V364" "V365" "V366" "V367" "V368" "V369" "V370"
## [371] "V371" "V372" "V373" "V374" "V375" "V376" "V377" "V378" "V379" "V380"
## [381] "V381" "V382" "V383" "V384" "V385" "V386" "V387" "V388" "V389" "V390"
## [391] "V391" "V392" "V393" "V394" "V395" "V396" "V397" "V398" "V399" "V400"
## [401] "V401" "V402" "V403" "V404" "V405" "V406" "V407" "V408" "V409" "V410"
## [411] "V411" "V412" "V413" "V414" "V415" "V416" "V417" "V418" "V419" "V420"
## [421] "V421" "V422" "V423" "V424" "V425" "V426" "V427" "V428" "V429" "V430"
## [431] "V431" "V432" "V433" "V434" "V435" "V436" "V437" "V438" "V439" "V440"
## [441] "V441" "V442" "V443" "V444" "V445" "V446" "V447" "V448" "V449" "V450"
## [451] "V451" "V452" "V453" "V454" "V455" "V456" "V457" "V458" "V459" "V460"
## [461] "V461" "V462" "V463" "V464" "V465" "V466" "V467" "V468" "V469" "V470"
## [471] "V471" "V472" "V473" "V474" "V475" "V476" "V477" "V478" "V479" "V480"
## [481] "V481" "V482" "V483" "V484" "V485" "V486" "V487" "V488" "V489" "V490"
## [491] "V491" "V492" "V493" "V494" "V495" "V496" "V497" "V498" "V499" "V500"
## [501] "V501" "V502" "V503" "V504" "V505" "V506" "V507" "V508" "V509" "V510"
## [511] "V511" "V512" "V513" "V514" "V515" "V516" "V517" "V518" "V519" "V520"
## [521] "V521" "V522" "V523" "V524" "V525" "V526" "V527" "V528" "V529" "V530"
## [531] "V531" "V532" "V533" "V534" "V535" "V536" "V537" "V538" "V539" "V540"
## [541] "V541" "V542" "V543" "V544" "V545" "V546" "V547" "V548" "V549" "V550"
## [551] "V551" "V552" "V553" "V554" "V555" "V556" "V557" "V558" "V559" "V560"
## [561] "V561"
```

```r
str(testData[,1:10])    # 561 vars, all numbers
```

```
## 'data.frame':	5 obs. of  10 variables:
##  $ V1 : num  0.257 0.286 0.275 0.27 0.275
##  $ V2 : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278
##  $ V3 : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295
##  $ V4 : num  -0.938 -0.975 -0.994 -0.995 -0.994
##  $ V5 : num  -0.92 -0.967 -0.97 -0.973 -0.967
##  $ V6 : num  -0.668 -0.945 -0.963 -0.967 -0.978
##  $ V7 : num  -0.953 -0.987 -0.994 -0.995 -0.994
##  $ V8 : num  -0.925 -0.968 -0.971 -0.974 -0.966
##  $ V9 : num  -0.674 -0.946 -0.963 -0.969 -0.977
##  $ V10: num  -0.894 -0.894 -0.939 -0.939 -0.939
```

```r
str(testLbls)           # 2947 obs of 1 var, one for each row in data
```

```
## 'data.frame':	2947 obs. of  1 variable:
##  $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
```

```r
table(testLbls)         # var values are 1:6
```

```
## testLbls
##   1   2   3   4   5   6 
## 496 471 420 491 532 537
```

```r
str(testSubs)           # 2947 obs of 1 var, one for each row in data
```

```
## 'data.frame':	2947 obs. of  1 variable:
##  $ V1: int  2 2 2 2 2 2 2 2 2 2 ...
```

```r
table(testSubs)         # 9 subjects w/300+ rows each (no overlap w/train)
```

```
## testSubs
##   2   4   9  10  12  13  18  20  24 
## 302 317 288 294 320 327 364 354 381
```

```r

actvtyLbls              # decodes the 6 labels
```

```
##   V1                 V2
## 1  1            WALKING
## 2  2   WALKING_UPSTAIRS
## 3  3 WALKING_DOWNSTAIRS
## 4  4            SITTING
## 5  5           STANDING
## 6  6             LAYING
```

```r

str(features)           # 561 obs of 2 vars, 2nd is the actual feature names
```

```
## 'data.frame':	561 obs. of  2 variables:
##  $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...
```

```r

################
# see whether we've correctly inferred how to put the data together
################

# apply feature names to column headers
names(trainData) <- features[,2]
names(testData)  <- features[,2]

# add subjects to data (factor so we can group by it)
trainData$sub <- as.factor(trainSubs[1:5,1])
testData$sub  <- as.factor(testSubs[1:5,1])

# add labels to data
trainData$lbl <- trainLbls[1:5,1]
testData$lbl  <- testLbls[1:5,1]

# identify which rows came from which data set for debugging purposes
trainData$src <- rep("train",nrow(trainData))
testData$src  <- rep("test",nrow(testData))

# combine the two data sets into one
allData <- rbind(trainData,testData)

# apply the activity labels
names(actvtyLbls) <- c("lbl","activity")
allData2 <- arrange(join(allData,actvtyLbls),lbl)
```

```
## Joining by: lbl
```

```r

# list mean() and std() columns (assignment step 2)
meanstdCols <- features[grepl("mean\\(\\)",features$V2)|grepl("std\\(\\)",features$V2),1]

# subset data to mean() and std() columns plus subject and activity
meanstdData <- allData2[,c(meanstdCols,562,565)]

# summarize the data
meltData <- melt(meanstdData,
                 id=c("sub","activity"),
                 na.rm=TRUE)
aggData <- dcast(meltData,       # input data
                 sub + activity  # one row per each value
                 ~ variable,     # one col for each value
                 mean)           # how to aggregate

################
# See the result
################

aggData # full set will have 180 obs. of  68 variables
```

```
##   sub activity tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z
## 1   1 STANDING            0.2805          -0.01979          -0.12171
## 2   2 STANDING            0.2728          -0.02459          -0.09979
##   tBodyAcc-std()-X tBodyAcc-std()-Y tBodyAcc-std()-Z tGravityAcc-mean()-X
## 1          -0.9966          -0.9780          -0.9668               0.9665
## 2          -0.9792          -0.9596          -0.9042               0.9299
##   tGravityAcc-mean()-Y tGravityAcc-mean()-Z tGravityAcc-std()-X
## 1              -0.1434               0.1042             -0.9955
## 2              -0.2912               0.1390             -0.9798
##   tGravityAcc-std()-Y tGravityAcc-std()-Z tBodyAccJerk-mean()-X
## 1             -0.9867             -0.9519               0.07528
## 2             -0.9701             -0.8941               0.07296
##   tBodyAccJerk-mean()-Y tBodyAccJerk-mean()-Z tBodyAccJerk-std()-X
## 1               0.01061             -0.008117              -0.9938
## 2               0.01550             -0.021309              -0.9660
##   tBodyAccJerk-std()-Y tBodyAccJerk-std()-Z tBodyGyro-mean()-X
## 1              -0.9853              -0.9922          -0.026256
## 2              -0.9667              -0.9698          -0.009285
##   tBodyGyro-mean()-Y tBodyGyro-mean()-Z tBodyGyro-std()-X
## 1           -0.07674            0.09347           -0.9843
## 2           -0.13122            0.14430           -0.9448
##   tBodyGyro-std()-Y tBodyGyro-std()-Z tBodyGyroJerk-mean()-X
## 1           -0.9888           -0.9885                -0.1000
## 2           -0.9355           -0.9630                -0.1271
##   tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z tBodyGyroJerk-std()-X
## 1               -0.04334               -0.05916               -0.9906
## 2               -0.06164               -0.06790               -0.9641
##   tBodyGyroJerk-std()-Y tBodyGyroJerk-std()-Z tBodyAccMag-mean()
## 1               -0.9957               -0.9931            -0.9804
## 2               -0.9673               -0.9719            -0.9525
##   tBodyAccMag-std() tGravityAccMag-mean() tGravityAccMag-std()
## 1           -0.9785               -0.9804              -0.9785
## 2           -0.9184               -0.9525              -0.9184
##   tBodyAccJerkMag-mean() tBodyAccJerkMag-std() tBodyGyroMag-mean()
## 1                -0.9919               -0.9931             -0.9786
## 2                -0.9709               -0.9544             -0.9076
##   tBodyGyroMag-std() tBodyGyroJerkMag-mean() tBodyGyroJerkMag-std()
## 1            -0.9821                 -0.9948                -0.9946
## 2            -0.9169                 -0.9728                -0.9598
##   fBodyAcc-mean()-X fBodyAcc-mean()-Y fBodyAcc-mean()-Z fBodyAcc-std()-X
## 1           -0.9957           -0.9796           -0.9751          -0.9971
## 2           -0.9714           -0.9570           -0.9318          -0.9835
##   fBodyAcc-std()-Y fBodyAcc-std()-Z fBodyAccJerk-mean()-X
## 1          -0.9774          -0.9642               -0.9938
## 2          -0.9627          -0.8975               -0.9632
##   fBodyAccJerk-mean()-Y fBodyAccJerk-mean()-Z fBodyAccJerk-std()-X
## 1               -0.9855               -0.9898              -0.9944
## 2               -0.9665               -0.9645              -0.9727
##   fBodyAccJerk-std()-Y fBodyAccJerk-std()-Z fBodyGyro-mean()-X
## 1              -0.9860              -0.9935            -0.9818
## 2              -0.9697              -0.9740            -0.9334
##   fBodyGyro-mean()-Y fBodyGyro-mean()-Z fBodyGyro-std()-X
## 1            -0.9909            -0.9883           -0.9851
## 2            -0.9354            -0.9587           -0.9490
##   fBodyGyro-std()-Y fBodyGyro-std()-Z fBodyAccMag-mean() fBodyAccMag-std()
## 1           -0.9876           -0.9896            -0.9804           -0.9796
## 2           -0.9361           -0.9681            -0.9344           -0.9231
##   fBodyBodyAccJerkMag-mean() fBodyBodyAccJerkMag-std()
## 1                    -0.9923                   -0.9925
## 2                    -0.9541                   -0.9538
##   fBodyBodyGyroMag-mean() fBodyBodyGyroMag-std()
## 1                 -0.9877                -0.9815
## 2                 -0.9247                -0.9258
##   fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std()
## 1                     -0.9946                    -0.9946
## 2                     -0.9608                    -0.9610
```

