# CodeBook for the course project 1

## Raw Dataset
The raw dataset for this analysis is downloaded from the UCI machine learning repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Detailed information on the dataset is available at the link site. Basically, a group of 30 volunteers each performed six activities wearing a Samsung Galaxy smartphone. The built-in accelerometer and gyroscope captures 3-axial linear acceleration and 3-axial angular velocity data at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, train set and test set. The train set has data from 21 volunteers and the test data has data from 9 volunteers. 

The following files are available for the train and test sets:
-Inertial signals.
-Identifier of the subject who performs the experiment(Subject_).
-Activity labels for each measurement(y_).
-Observations of 561 time and frequency domain variables(X_).

Common files for both sets:
-activity_labels
-features
-features info

## Analysis performed by run_analysis.R

The analysis will merge and clean the dataset, extracts only mean and standard deviation variables, give appropriate labels for the variables and activities, and finally, find the average of each variable for each activity and each subject.

1. Merges the training and the test sets to create one data set.
- read the files in test set and merge into one single dataset "test".
- read the files in train set and merge into one single dataset "train."
- merge "train" and "test" into one dataframe "all"".
- read "features.text" file, change the V2 column to character which is used to name the columns in "all" dataset.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- create a new dataset "meanstd" that only contains the measurements on the mean() and std() using grep function. Please note meanfreq() are not selected as they are weighted variables.

3.Uses descriptive activity names to name the activities in the data set.
- Use gsub to remove any non-alphabetic characters from the column names of "meanstd".
- change all column names of "meanstd" to lowercase, and fix typo/duplicates ("bodybody" are replaced with "body").

4.Appropriately labels the data set with descriptive activity names. 
- read "activity_labels.txt" file and rename the column as "activityid" and "activity"
- merge the "activity" dataset with the "meanstd" dataset based on "activityid", then each measurement are labeled as "walking", "laying" etc. rather than id number.
- get rid of the redundant "activityid" column from the resulting "labeled" dataset from the merging.

5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
- use aggregate function to calculate the average of each varibles in "labeled" for each activity and each subject, the result is stored in a new dataset "averagedata".
- write the new dataset to "averagerun.txt" file.

## Description of the new dataset

**Varibles**

- subjectid:Indentifier for each volunteer who performs the experiment
- activity:6 activities performed by the volunteer 

Three-dimensional signals in the x,y and z direction. Please refer to the Abbreviation section for information.
- tbodyacc
- tgravityacc
- tbodyaccjerk
- tbodygyro
- tbodygryojerk
- fbodyacc
- fbodyaccjerk
- fbodygyro

Magnitude signals calculated from the 3D signals using Euclidean norm.
- tbodyaccmag
- tgravityaccmag
- tbodyaccjerkmag
- tbodygyromag
- tbodygyrojerkmag
- fbodyaccmag
- fbodyaccjerkmag
- fbodygyromag
- fbodygyrojerkmag

All of the above signals has the following estimations:
- mean
- std

**Abbreviation**
t-time domain
f-frequency domain derived from time domain sigal by fast foutrier transform
acc-linear acceleration from the accelerometer
gyro-angular velocity from the gyroscope
jerk-jerk signal from body linear acceleration and angular velocity derived in time
body-body motion
gravity-gravitational motion
mean-mean value
std-standard deviation
