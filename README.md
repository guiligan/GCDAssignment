Getting and Cleaning Data Course Assignment
===========================================
This repository contains the files required to the John Hopkins Bloomberg School of Public Health coursera Getting and Cleaning Data course assigment.

The scripts has a dependecy o **dplyr** library.

##### Files & Folders
Here you will find:

 - **codeBook.md**: the code book (a.k.a. the variable definitions of the dataset)
 - **finalResult.txt**: the final dataset after running the R script
 - **README.md**: instructions on how to obtain the data using the *run_analysis.R* script
 - **run_analysis.R**: R functions to create the final dataset
 - **/SamsungDataset**: contains all data required to run the analysis

## Functions
The *run_analysis.R* contains 4 different functions:

###### finalDataset (workingDir = FALSE, save = TRUE)
This function will run all required functions to obtain the final dataset. Both arguments are optional.

 - *workingDir* is the directory where the data is. If false, it will use the default */samsungDataset* dir.
 - *save* will automatically save the final dataset without row names to *finalResult.txt*

The final dataset result is returned.

###### createDataset (workingDir = FALSE)
 - *workingDir* is the directory where the data is. If false, it will use the default */samsungDataset* dir.

The function will load all data related to the Samsung test and training. Each combination (subjects, activity and test|train data) is then merged filtering the required columns (only mean and standardDeviation data). The two resulting data tables from step two are merged to obtain a coplete list of data.

The resulting dataset is returned.

###### calculateDataset (dataset)
Requires the dataset created by the **createDataset** function. Using *dplyr* library, data is grouped by subject and activity to make the final calculation of the mean of each of the variables. Readable names are given to each variable (column) of the data table. The activity id is changed with an activity name (WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING
 or LAYING
).

The final dataset is returned.

###### loadDependencies()
This script requires **dplyr** library. If installed it is loaded, if not, then an error is given to the user.

Boolean TRUE or FALSE is returned.