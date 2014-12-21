Getting and Cleaning Data Project
=================
You should create one R script called run_analysis.R that does the following. 

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps taken for this project.

1. Download the UCI HAR Dataset folder and save it in local drive.

2. Set working directory to UCI HAR Dataset file. Create an r script called "run_analysis", that does the above requirements and save it in the UCI HAR Dataset folder.

3. Run source code "run_analysis" to generate a text file "tidy_data.txt" with the dataset from the merged data.

Dependencies

run_analysis.R depends on reshape2 and data.table which are installed and loaded from the source code.

