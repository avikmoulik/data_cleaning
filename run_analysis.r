## reading all test files
##----------------------------------------------
subject_test<-read.table("/home/avik/rfile/UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("/home/avik/rfile/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("/home/avik/rfile/UCI HAR Dataset/test/y_test.txt")

## reading all train files
##----------------------------------------------
subject_train<-read.table("/home/avik/rfile/UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("/home/avik/rfile/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("/home/avik/rfile/UCI HAR Dataset/train/y_train.txt")

##Step 1
## Merging test and train data frames
##----------------------------------------------
test_data<- cbind(subject_test,y_test,x_test)
train_data<- cbind(subject_train,y_train,x_train)

# this is the merged data set
test_train_data_v1<- rbind(test_data,train_data) 


##Step 2
## keeping only mean and Standard deviation measurements
##--------------------------------------------------------
# Reading the names of the features and getting the column numbers where it is mean or STD
features<-read.table("/home/avik/rfile/UCI HAR Dataset/features.txt")
ind_mean_std<-c(grep('mean',features$V2,ignore.case = T),grep('std',features$V2,ignore.case = T))

#First two columns are subjects and activity they performed, So addind 2 with this column numbers
ind_mean_std<-ind_mean_std+2

#Adding first two column index also:
final_ind<-c(1,2,ind_mean_std)

#subsetting the combined dataset only for the required variables:
test_train_data_v2<-test_train_data_v1[,final_ind]

##Step 3
## Using descriptive activity names to name the activities in the data set
##-------------------------------------------------------------------------
# reading activity labels
activity_labels<-read.table("/home/avik/rfile/UCI HAR Dataset/activity_labels.txt")

#joining with the dataset
test_train_data_v3<-merge(x=test_train_data_v2,y=activity_labels,by.x='V1.1',by.y='V1',all=T,sort=F)

#keeping required columns and arrenging them in required order:
test_train_data_v3<-test_train_data_v3[,c(2,89,3:88)]

##Step 4
## Appropriately labeling the data set with descriptive variable names
##-------------------------------------------------------------------------
# Extracting the columns names from the feature file
namefeatures<-as.character(features$V2)

#Adding two aditional names for first two columns
final_name<-c('Subject','Activity',namefeatures)

#Extracting only required names
required_names<-final_name[final_ind]
required_names<-gsub("\\()","",required_names,ignore.case = TRUE)

#renaming the columns
test_train_data_v4<-test_train_data_v3
names(test_train_data_v4)<-required_names

##Step 5
## From the data set in step 4, creating a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
##-------------------------------------------------------------------------
test_train_data_v5<-aggregate(.~Subject+Activity,data=test_train_data_v4,FUN=mean)

## test_train_data_v5 is the wide format tidy data

## Writing it into a text file

write.table(x =test_train_data_v5 ,file = "/home/avik/rfile/final_tidy_data.txt",row.names = F)





