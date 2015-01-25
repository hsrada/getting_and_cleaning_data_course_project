#Code Book

A code book that describes the variables, the data, and any transformations or work performed to clean up the data as part of the course project of Getting and Cleaning Data on Coursera.

#Data

The data can be downloaded from the following link : 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#Dataset Overview

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years for six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Accelerometer and Gyroscope sensors readings were captured at a constant rate of 50Hz.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt' : description of the various features 
- 'features.txt': list of 561 features
- 'activity_labels.txt': Matches the activity id with activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The set of variables that were estimated from the signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.


#Data Transformation

The data was processed using the run_analysis.R script. 
#The goals of the project were : 
#1.Merge the training and the test sets to create one data set.

The training and test dataset was first created by combining the subjectID, ActivityID and feature vector.
The two sets were then combined to form a single set. 
Transformations were done using rbind and cbind.

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

Only the relevant columns were subsetted. grepl() was used to find the relevant columns.

#3.Uses descriptive activity names to name the activities in the data set

The activity_labels.txt was merged with the above dataset. The Activity Name column describes the activity being performed.

#4.Appropriately labels the data set with descriptive variable names. 

The column names were made more descriptive.Dashes and paranthesis were removed, among other modifications.

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

A data set tinydata.txt containing 180 observations was created containing average data values for all 30 subjects for all the six activities.
