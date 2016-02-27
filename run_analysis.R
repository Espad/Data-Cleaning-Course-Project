#load required packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

require("data.table")
require("dplyr")


download_data_set <- function (){
  # Step 0
  # download dataset
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")
  
  # unzip dataset to /data directory
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
  
}


generate_tidy_data <- function(){
# read data datasets
testxDF <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
trainxDF <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

# read acitvity datasets
testyDF <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
trainyDF <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

#read subject files
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# read feature names for x data sets
namesList <- read.table("./data/UCI HAR Dataset/features.txt")

# read activity labels
namesActivity <- read.table("./data/UCI HAR Dataset/activity_labels.txt", colClasses = "character")


# Step 1
# Merge the training and test sets to create one data set
# final merge will be done at the last step, because processing of each part of data passes in order


#merge train and test activity datasets 
resulty <- bind_rows(testyDF, trainyDF)
#merge datasets with data
resultx <- bind_rows(testxDF, trainxDF)
#merge subjects dataset
resultSubjects <- bind_rows(testSubjects, trainSubjects)



# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
names(resultx) <- namesList$V2
subdataFeaturesNames<-namesList$V2[grep("mean\\(\\)|std\\(\\)", namesList$V2)]
resultx<-subset(resultx,select=as.character(subdataFeaturesNames))

# Step 3
# Use descriptive activity names to name the activities in the data set
resulty <- resulty %>%  
  rename(activity = V1) %>%
  mutate(activity = ifelse(activity == 1, namesActivity$V2[1],activity),
         activity = ifelse(activity == 2, namesActivity$V2[2],activity),
         activity = ifelse(activity == 3, namesActivity$V2[3],activity),
         activity = ifelse(activity == 4, namesActivity$V2[4],activity),
         activity = ifelse(activity == 5, namesActivity$V2[5],activity),
         activity = ifelse(activity == 6, namesActivity$V2[6],activity)
  )
#rename subjects
resultSubjects <- rename (resultSubjects,subject = V1)

# Step 4
# Appropriately label the data set with descriptive variable names
names(resultx)<-gsub("^t", "time", names(resultx))
names(resultx)<-gsub("^f", "frequency", names(resultx))
names(resultx)<-gsub("Acc", "accelerometer", names(resultx))
names(resultx)<-gsub("Gyro", "gyroscope", names(resultx))
names(resultx)<-gsub("Mag", "magnitude", names(resultx))
names(resultx)<-gsub("BodyBody", "body", names(resultx))
names(resultx)<-tolower(names(resultx))



# final merge
preresultdata <- bind_cols(resultSubjects, resulty,resultx)
# save as file
#write.table(data1, file = "tidydata1.txt",row.name=FALSE)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
resultdata<-aggregate(. ~subject + activity, preresultdata, mean)
resultdata<-resultdata[order(resultdata$subject,resultdata$activity),]
write.table(resultdata, file = "tidydata.txt",row.name=FALSE)
View(resultdata)
}


