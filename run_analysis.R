# Course Project 1: analysis on human activity recognition using smartphone data set from UCI machine learning repository 

#read data set and merge
xTest<-read.table("UCI HAR Dataset/test/X_test.txt")
SubjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt")
yTest<-read.table("UCI HAR Dataset/test/y_test.txt")
test<-cbind(SubjectTest,yTest,xTest)

xTrain<-read.table("UCI HAR Dataset/train/X_train.txt")
SubjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
yTrain<-read.table("UCI HAR Dataset/train/y_train.txt")
train<-cbind(SubjectTrain,yTrain,xTrain)

all<-rbind(train,test)

#subset mean and std variable
features<-read.table("UCI HAR Dataset/features.txt")
features$V2<-as.character(features$V2)
colnames(all)<-c("subjectid","activityid",features$V2)

meanstd<-all[,c("subjectid","activityid",features[grep("mean\\(\\)|std\\(\\)",features$V2),]$V2)]

#rename variables
variables<-gsub("[^[:alnum:]]","", colnames(meanstd))
colnames(meanstd)<-gsub("bodybody","body",tolower(variables))

#label activities
activity<-read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity)<-c("activityid","activity")
labeled<-merge(meanstd,activity,by="activityid")
labeled$activityid<-NULL

#calculate average of each variable for each subject and each activity
averagedata<-aggregate(. ~ subjectid+activity, labeled, mean)

#write new dataset to text file
write.table(averagedata,"averagerun.txt")
