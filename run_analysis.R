 ## R script

## This R script is called run_analysis.R and does the following:

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Install and require data.table package.
install.packages("data.table")
  require("data.table")

# Install and require reshape2 package.
install.packages("reshape2")
  require("reshape2")

# Read data from activity_labels.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Read data from features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each feature.
extracted_measurements <- grepl("mean|std", features)

# Read data from X_test & y_test.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Read data from subject_test.
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,extracted_measurements]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("activity_ID", "activity_Label")
names(subject_test) = "subject"

# Combine the data from x_test and y_test
test_data <- cbind(as.data.frame(subject_test), y_test, X_test)

# Read data from X_train & y_train.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Read data from subject_train.
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each feature.
X_train = X_train[,extracted_measurements]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("activity_ID", "activity_Label")
names(subject_train) = "subject"

# Combine data from x_train and y_train.
train_data <- cbind(as.data.frame(subject_train), y_train, X_train)

# Merge data from test and train and create one single data set. 
data = rbind(test_data, train_data)

id_labels   = c("subject", "activity_ID", "activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# create a tidy data set with the average of each variable for each activity and each subject.
tidy_data   = dcast(melt_data, subject + activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
