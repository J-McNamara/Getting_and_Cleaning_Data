# 1. Merges the training and the test sets to create one data set.
training <- read.table('UCI HAR Dataset/train/X_train.txt')
training_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
training_activities <- read.table('UCI HAR Dataset/train/y_train.txt')
test <- read.table('UCI HAR Dataset/test/X_test.txt')
test_subjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
test_activities <- read.table('UCI HAR Dataset/test/y_test.txt')

df <- rbind(cbind(training_subjects, training, training_activities), cbind(test_subjects, test, test_activities))

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- as.character(read.table('UCI HAR Dataset/features.txt')[,2])
colnames(df) <- c('subject', features, 'activity')
means <- as.character(features[grep('mean', features)])
stds <- as.character(features[grep('std', features)])
keeps <- c('subject', 'activity', means, stds) 
df <- subset(df,select=keeps)

# 3. Uses descriptive activity names to name the activities in the data set
colnames(df) <- gsub('^t', 'time_', colnames(df))
colnames(df) <- gsub('^f', 'frequency_', colnames(df))
colnames(df) <- gsub('\\(\\)', '', colnames(df))
colnames(df) <- gsub('-', '_', colnames(df))
colnames(df) <- gsub('BodyBody', 'Body', colnames(df))

# 4. Appropriately labels the data set with descriptive variable names.
labels <- as.character(read.table('UCI HAR Dataset/activity_labels.txt')[,2])
df$activity <- labels[df$activity]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
summary_table <- df %>% 
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

# Bonus - write data to file
write.csv(x = df, file = 'tidy_data.csv')
write.csv(x = summary_table, file = 'summary_tidy_data.csv')
write.table(x = summary_table, file = 'summary_tidy_data.txt', row.name=FALSE)


