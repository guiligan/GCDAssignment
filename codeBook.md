CodeBook
========

After running run_analysis.R you will end with a tidy data from the accelerometer and gyroscope 3-axial processed signals. Variables names follows a very straight forward logic: DOMAIN.ORIGIN.SENSOR[.jerk|.magnitude].CALCULATION[.XYZ] as explained below, alwys on lower case:

##### DOMAIN
There are two different domain signals: **time** and  **frequency**. As stated on the original raw data.

##### .ORIGIN
The acceleration signal is separated in **body** and **gravity**

##### .SENSOR
Two sensor are used to capture the raw data: **accelerometer** and **gyroscope**

##### [.jerk|.magnitude]
Variables marked with **.jerk** represent the body linear acceleration and angular velocity derived in time. When **.magnitude**, it is calculated for the variable using Euclidean norm. *This is an optional parameter*

##### .CALCULATION
It can assume two different values, representing the averages of the results for the **.mean**, or the averages of the results for the **.standardDeviation**

##### [.XYZ]
For most of the variables, a direction will be declared as an XYZ coordinate system. *This is an optional parameter*

## Raw Data
The time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm.

Finally a Fast Fourier Transform (FFT) was applied to some of these signals.

These signals were used to estimate variables of the feature vector for each pattern.

## Obtaining the final data
The final data for this exercise is obtained in a few steps:

 1. Data is loaded from samsung test and train files, with also the activities and subjects of each entry. Activity labels, for bether reading is included;
 2. Each combination (subjects, activity and test|train data) is then merged filtering the required columns (only mean and standardDeviation data);
 3. The two resulting data tables from step two are merged to obtain a coplete list of data;
 4. Using *dplyr* library, data is grouped by subject and activity to make the final calculation of the mean of each of the variables;
 5. Readable names are given to each variable (column) of the data table. Activity id is changed with an activity name (WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING
 or LAYING
)