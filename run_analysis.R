

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./UCI HAR Dataset.zip", method ="curl")
dateDownloaded<-date()

#Loading the files into R
X_test<-read.table("C:/Users/parva_000/Documents/WK3Assignment/test/X_test.txt");
y_test<-read.table("C:/Users/parva_000/Documents/WK3Assignment/test//y_test.txt");
subject_test<-read.table("C:/Users/parva_000/Documents/WK3Assignment/test/subject_test.txt")
X_train<-read.table("C:/Users/parva_000/Documents/WK3Assignment/train/X_train.txt")
y_train<-read.table("C:/Users/parva_000/Documents/WK3Assignment/train/y_train.txt")
subject_train<-read.table("C:/Users/parva_000/Documents/WK3Assignment/train/subject_train.txt")
features<-read.table("C:/Users/parva_000/Documents/WK3Assignment/features.txt")
activity<-read.table("C:/Users/parva_000/Documents/WK3Assignment/activity_labels.txt")


#Performing a quick check on each data table to make sure the data has loaded correctly
dim(X_test)        ##[1] 2947  561
dim(y_test)        ##[1] 2947    1
dim(subject_test)  ##[1] 2947    1
dim(X_train)       ##[1] 7352  561
dim(y_train)       ##[1] 7352    1
dim(subject_train) ##[1] 7352    1
dim(features)      ##[1] 561   2
dim(activity)      ##[1] 6 2
 

#Bind the various datasets together
Raw<-rbind(X_test,X_train)
ActivityID<-rbind(y_test,y_train)
subjectID<-rbind(subject_test,subject_train)
Features_inc <- grep("mean\\(\\)|std\\(\\)", features[, 2])
dim(Raw)           ##[1] 10299   561
dim(ActivityID)    ##[1] 10299     1
dim(subjectID)     ##[1] 10299     1



#Giving the column subjectID a header name
colnames(subjectID)<-"SubID"


#Merging Activity labels with Y
library(plyr)
Activity<-join(ActivityID,activity)
Activity2<-Activity[,2]
Activity2<-data.frame(Activity2)
colnames(Activity2)<-"Activity_Label"


#Labelling the "Raw" data
Raw<-Raw[,Features_inc]
names(Raw)<gsub("\\(\\)", "", features[Features_inc, 2]) # remove "()"


#Complete data set made
Alldata<-cbind(subjectID,Raw,Activity2)
write.table(Alldata,"merged_Alldata.txt")
