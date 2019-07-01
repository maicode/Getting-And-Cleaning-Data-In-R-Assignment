#We will use these libraries for our analysis.
library(plyr)
library(data.table)
library(stringr)

#
y_train_table <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")
y_test_table <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
activity_labels <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")
X_train_table <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
X_test_table <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
features <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
subject_train <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test <- read.table("C:\\Users\\Hampster-Admin\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
#
#
#
y_bound<- rbind(y_train_table, y_test_table) #Binding y test to the bottom of y train.
y_bound <- join(y_bound, activity_labels) #Joining activity labels and y table.
y_tidy <- subset(y_bound, select = -c(V1)) #Removing unused column.
colnames(y_tidy) <- "Activity" #Renaming variable, ensuring no conflicting column names when joining with X table..

Sub_bound<- rbind(subject_train, subject_test) #Binding Subject test to bottom of Subject train.
colnames(Sub_bound) <- "Subject" #Renaming variable, ensuring no conflicting column names when joining with X table.

X_bound<- rbind(X_train_table, X_test_table) #Binding X test to the bottom of X train.
X_tidy <- subset(features, select = -c(V1)) #Removing unused column.
setnames(X_bound, c(colnames(X_bound)), as.character(X_tidy[,])) #Renaming our columns to be more descriptive using names from features.
X_mean_std <- subset(X_bound, select = c(str_detect(colnames(X_bound), "std") | str_detect(colnames(X_bound), "mean"))) #Searching for and selecting only columns with "mean" or "std".

newdf <- cbind(X_mean_std, Sub_bound, y_tidy) #Binding Activity and Subject dfs to our "mean" and "std" feature df.

group_df <- group_by(newdf, Subject, Activity) #Grouping dataset by Subject and Activity.
tidy_df <- aggregate(group_df[1:79], by = list(Subject = group_df$Subject, Activity = group_df$Activity), mean) #Finding mean by group. Result is a 180x81 tidy dataset.

write.table(tidy_df, file = "tidy_data.txt", row.names = FALSE) #Writing final dataset to new txt