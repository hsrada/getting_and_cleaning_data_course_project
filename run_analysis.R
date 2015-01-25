#A R script called run_analysis.R that does the following:
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)

#reading text files

activity_labels<-read.table("activity_labels.txt",header=FALSE)
features<-read.table("features.txt",header=FALSE)

#renaming column names 
subject_test<-read.table("./test/subject_test.txt",header=FALSE)
X_test<-read.table("./test/X_test.txt",header=FALSE)
y_test<-read.table("./test/y_test.txt",header=FALSE)

subject_train<-read.table("./train/subject_train.txt",header=FALSE)
X_train<-read.table("./train/X_train.txt",header=FALSE)
y_train<-read.table("./train/y_train.txt",header=FALSE)

colnames(features)<-c("Serial No.","Feature Name")
colnames(activity_labels)<-c("Activity ID","Activity Name")

colnames(subject_test)<-c("Subject_ID")
colnames(subject_train)<-c("Subject_ID")
colnames(y_test)<-c("Activity_ID")
colnames(y_train)<-c("Activity_ID")
colnames(X_test)<-features[,2]
colnames(X_train)<-features[,2]

#creating the training set
training_set<-cbind(subject_train,y_train,X_train)

#creating the test set
test_set<-cbind(subject_test,y_test,X_test)

#Step 1
#merged data set of training and test data set 
complete_dataset<-rbind(training_set,test_set) 

#Step 2
#extracting only columns with mean and standard deviation
extract_col<-grepl("mean\\(\\)",colnames(complete_dataset))|grepl("std\\(\\)",colnames(complete_dataset))
extracted_dataset<-complete_dataset[,colnames(complete_dataset)[extract_col]]
dataset<-cbind(complete_dataset[,1:2],extracted_dataset)

#Step 3
#Descriptive activity names to name the activities in the data set
data3<-merge(dataset,activity_labels)

#Step 4
#Making variable names more descriptive
temp_col<-colnames(data3)
for(i in 1:length(temp_col)){
temp_col[i]=gsub("\\(\\)","",temp_col[i])
temp_col[i]=gsub("-",".",temp_col[i])
temp_col[i]=gsub("[Mm]ag","Magnitude",temp_col[i])
temp_col[i]=gsub("mean","Mean",temp_col[i])
temp_col[i]=gsub("std","Std",temp_col[i])
temp_col[i]=gsub("[Aa]cc","Accelerometer",temp_col[i])
temp_col[i]=gsub("[Gg]yro","Gyroscope",temp_col[i])
}

colnames(data3)<-temp_col
data4<-data3

#Step 5
#Creating  independent tidy data set with the average of each variable for each activity and each subject
data5<-ddply(data4,c("Subject_ID","Activity_ID"),numcolwise(mean))
write.table(data5,"tidy_data.txt",row.name=FALSE)

