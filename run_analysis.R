# 1. Merges the training and the test sets to create one data set.
wd <- 'C:\\Users\\Josh\\OneDrive - Johns Hopkins University\\coursera_data_science_program\\03_getting_and_cleaning_data\\course_project'
setwd(wd) # Lab computer

training <- read.table('UCI HAR Dataset/train/X_train.txt')
training_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
training_activities <- read.table('UCI HAR Dataset/train/y_train.txt')
training$dataset <- 'training'

test <- read.table('UCI HAR Dataset/test/X_test.txt')
test$dataset <- 'test'
test_subjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
test_activities <- read.table('UCI HAR Dataset/test/y_test.txt')


df <- rbind(cbind(training_subjects, training, training_activities), cbind(test_subjects, test, test_activities))

#df <- rbind(training,test)
df2 <- df

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- as.character(read.table('UCI HAR Dataset/features.txt')[,2])
features[562] <- 'dataset'
colnames(df) <- features
means <- as.character(features[grep('mean', features)])
stds <- append(as.character(features[grep('std', features)]), 'dataset')
keeps <- append(means, stds)
df <- subset(df,select=keeps)
head(df[1,])

# 3. Uses descriptive activity names to name the activities in the data set
colnames(df) <- gsub('^t', 'time_', colnames(df))
colnames(df) <- gsub('^f', 'frequency_', colnames(df))
colnames(df) <- gsub('\\(\\)', '', colnames(df))
colnames(df) <- gsub('-', '_', colnames(df))
colnames(df) <- gsub('BodyBody', 'Body', colnames(df))
colnames(df)
head(df[1,])

# 4. Appropriately labels the data set with descriptive variable names.
labels <- as.character(read.table('UCI HAR Dataset/activity_labels.txt')[,2])
descrip_train <- read.table('UCI HAR Dataset/train/y_train.txt')[,1]
descrip_train <- labels[descrip_train]
descrip_test <- read.table('UCI HAR Dataset/test/y_test.txt')[,1]
descrip_test <- labels[descrip_test]
df$activity <- 'NULL'
df[df$dataset=='training',]$activity <- descrip_train
df[df$dataset=='test',]$activity <- descrip_test
colnames(df)

subjects <- 

#You grouped the result by activity only where it should be grouped by subject and activity couple
# NAs are introduced in last column (called dataset).


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
YeOldeSummaryTable <- summarise_each(tbl = group_by(.data = df, activity), funs = 'mean')
YeOldeSummaryTable2 <- summarise_each(tbl = group_by(.data = YeOldeSummaryTable, subject), funs = 'mean')

head(YeOldeSummaryTable)

# Bonus - write data to file
write.csv(x = df, file = 'tidy_data.csv')
write.csv(x = YeOldeSummaryTable, file = 'tidy_summary_data.csv')



