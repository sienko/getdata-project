# getdata-project
This is the the project repository for the course "Getting and Cleaning Data" on Coursera.

## How to
The R script run_analysis.R is used to read the Samsung dataset and process it. The processing of the dataset involves 
1. Read the subject, activity and measures files for the test and training data sets
2. Merging the test and train datasets (first by type: subject, activity then measures), and then merge all 3 merged datasets
3. Including the descriptive column names as per the original code book, and only filter the mean and standard deviation readings
4. Merge in acitivity name from the activity_labels.txt file
5. Summarise the data by activity and subject, providing the mean of each of the remaining numeric variables
6. Write and return the summarised tidy dataset

It is assumed that the input data is in your working directory under subdirectories "test" and "train". The additional descriptive files (activity_labels.txt and features.txt) are assumed to be within the working directory.
