# Getting and Cleaning Data course project

## General

This repository hosts the R code and documentation files for the Data Science's track course "Getting and Cleaning data", available on coursera.

The dataset being used is: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Project definition

There were five requirements for the assignment:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## Files

The code takes for granted all the data is present in the same folder, un-compressed and without names altered.

`CodeBook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data.

`run_analysis.R` contains all the code to perform the analyses described in the 5 steps. They can be launched in RStudio by just importing the file.

The output file called `tidydata.txt`, and uploaded into the course project's form.

## Steps to work on this course project

1. Put ```run_analysis.R``` in your current work directory (command getwd() help you to get your current wd, setwd() to change wd).
2. Run in RStudio ```source("run_analysis.R")```.
3. Download and unzip the dataset into a ```data``` folder in your current work directory. You'll have a ```data\UCI HAR Dataset``` folder structure.
Or just run function download_data_set() that will make all required operations to download and unzip archive.
Function is available after you run ```run_analysis.R```
4. Run generate_tidy_data() function, then it will generate a new file ```tidydata.txt``` in your work directory.

## What the analysis file did:
All transformations details I have reviewed in CodeBook.md file.

## Dependencies

```run_analysis.R``` file will help you to install the dependencies automatically. It depends on ```data.table``` and ```dplyr```. 
Development environment: Windows 8.1 x64, R version 3.2.2, RStudio Version 0.99.489.
