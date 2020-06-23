The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

2. Assign each data to variables
- features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
- subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
- dx_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
- dy_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
- subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
- dx_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
- dy_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

3. Merges the training and the test sets to create one data set
- Data_Labels (10299 rows, 1 column) is created by merging dY_train and dY_test
- Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
- Data (10299 rows, 563 column) is created by merging dX_train and dX_test

4. Making all variable names to lower case
colnames(data) <- tolower(make.names(colnames(data)))

5. Extracts only the measurements on the mean and standard deviation for each measurement
- Creating an empty dataframe and then including an index into this, so that it becomes easy to combine dataset
- Then using appropriate regular expression knowledge to extract only variable with mean() and standard deviation() in its names.
- Assigning these extracted variables into a new tidy dataframe as df

6. Remove Unwanted variables using select function.
df <- select(df,-c(V1))  

7. Referring labels with the activity names by looping over the dataset and assigning matched name

8. Appropriately labels the data set with descriptive variable names

All acc in column’s name replaced by Accelerometer
All gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All tbody in column’s name replaced by TimeBody
All fbody in column’s name replaced by FrequencyBody
All tgravity in column’s name replaced by TimeGravity

9. From the data set created an independent data set with the average of each variable for each activity and each subject
