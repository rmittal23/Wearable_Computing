# Loading important libraries
library(rio)
library(dplyr)
library(stringr)

# Loading the dataset
features = import("features.txt")
subject_test = read.table("test\\subject_test.txt", col.names = "subject")
activities = read.table("activity_labels.txt", col.names = c("labels","names"))
subject_train = read.table("train\\subject_train.txt", col.names = "subject")
dX_test = read.table("test\\X_test.txt", col.names = features$V2)
dY_test = read.table("test\\y_test.txt", col.names = "labels")
dX_train = read.table("train\\X_train.txt", col.names = features$V2)
dY_train = read.table("train\\y_train.txt", col.names = "labels")

# Merging the imported data
subject = rbind(subject_train, subject_test)
data = rbind(dX_train, dX_test)
data_labels = rbind(dY_train, dY_test)

# Making all variable names to lower case
colnames(data)=tolower(make.names(colnames(data)))

# Extracting only mean and std. measurement
df = data.frame()
j=2
for(k in 1:nrow(data))
{
  df[k,1]=k
}
for(i in names(data))
{
  if(str_detect(i,"\\.mean[.]|\\.std[.]"))
  {
    df[,j]=data[,i]
    colnames(df)[colnames(df)==colnames(df)[j]]=i
    j=j+1
  }
}

# Removing unwanted columns and adding important one
df = cbind(df, subject, data_labels)
df = select(df,-c(V1))

# Referring labels with the activity names
for(h in 1:nrow(df)){
  df[h,"activity"] = activities[df[h,"labels"],2]
}

# Putting appropriate labels for variables
names(df) = gsub("Acc", "Accelerometer", names(df), ignore.case = TRUE)
names(df) = gsub("Gyro", "Gyroscope", names(df), ignore.case = TRUE)
names(df) = gsub("BodyBody", "Body", names(df), ignore.case = TRUE)
names(df) = gsub("Mag", "Magnitude", names(df), ignore.case = TRUE)
names(df) = gsub("tBody", "TimeBody", names(df), ignore.case = TRUE)
names(df) = gsub("tgravity", "TimeGravity", names(df), ignore.case = TRUE)
names(df) = gsub("fBody", "FrquencyBody", names(df), ignore.case = TRUE)

# Average measurement for each activity and subject involved
new_df = group_by(df, activity, subject) %>% summarise_all(funs(mean))

# Writing and Saving the new data
write.table(new_df, "tidydata1.txt", row.name=TRUE)

