
## the script assumes the files mentioned in the assignment, are downloaded 
## and extracted in the current working directory
## files will be read into dataframes, the relevant columns will be
## extracted, the 'subjects' and 'activity' data will be added
## and then the 'test' and 'train' data will be merged
## after that, the means of the variables are calculated per subject/activity-combination

## Read test, train and feature data
df_test<-read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
df_train<-read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
df_features<- read.table("UCI HAR Dataset/features.txt", sep="", header=FALSE)

## Change column-names to the names in the names in the 'features'-file
names(df_test)<-df_features[[2]]
names(df_train)<-df_features[[2]]
## extracting the mean() and std() columns into a new dataframe
df_test01<-df_test[,grep('mean\\(\\)|std\\(\\)', names(df_test), value=TRUE)]
df_train01<-df_train[,grep('mean\\(\\)|std\\(\\)', names(df_train), value=TRUE)]

## read the subjects data and change names
df_subj_tst<-read.table("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
df_subj_trn<-read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
names(df_subj_tst)<-'subjects'
names(df_subj_trn)<-'subjects'

## read the activities data and change names
df_act_tst<-read.table("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
df_act_trn<-read.table("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
names(df_act_tst)<-'activities'
names(df_act_trn)<-'activities'

## merge tables horizontally
df_test02<-cbind(df_test01,df_subj_tst,df_act_tst)
df_train02<-cbind(df_train01,df_subj_trn,df_act_trn)
## merge test and train tables vertically 
df<-rbind(df_test02,df_train02)
## read activity-label data, merge activity-labels to dataset and 
## delete numeric activities-column
df_actlbl<-read.table("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
names(df_actlbl)<-c('activities','activity_label')
df01<-merge(x = df, y = df_actlbl, by = "activities", all.x=TRUE)
df02<-df01[, !(colnames(df01) %in% c("activities"))]
names<-names(df02)

## change column-names into descriptive variable names 
names<-sub("^t","time_", names)
names<-sub("^f","frequency_", names)
names<-sub("Acc","_Acceleration", names)
names<-sub("Gyro","_Gyroscope", names)
names<-sub("Mag","_Magnitude", names)
names<-sub("std","_standarddeviation", names)
names(df02)<-names

## melt table in order to calculate means per activity/subject combination
library(dplyr)
library(reshape2)
melted <- melt(df02, id.vars=c("subjects", "activity_label"))
grouped <- group_by(melted, subjects, activity_label)
means<-summarise(grouped, mean=mean(value))
#write result into output-file 
write.table(means,file='avg_act_subj.txt', row.name=FALSE)
