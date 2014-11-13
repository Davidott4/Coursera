# run_analysis.r
# loads from files in Test and Train Folders
# adds data labels and creates a tidy data set
# of only Data values marked with mean or Std
# NOTE: MUST BE IN SAME DIRECTORY AS /UCI HAR DATASET

#install.packages("reshape2")
library(reshape2)

#BUILD FILES LIST
path <- paste(getwd(),"/UCI HAR Dataset", sep ="")
test_files <- list.files(paste(path,"/test", sep =""), full.names=TRUE, recursive = TRUE)
train_files <- list.files(paste(path,"/train", sep =""), full.names=TRUE, recursive = TRUE)

#READ DATA INTO DATA FRAMES
subject_train <- read.table(train_files[10])
subject_test <- read.table(test_files[10])
X_train <- read.table(train_files[11])
X_test <- read.table(test_files[11])
Y_train <- read.table(train_files[12])
Y_test <- read.table(test_files[12])


#ADD COLUMN NAMES
names(subject_train) <- "SubjectID"
names(subject_test) <- "SubjectID"

# 4 --APPROPRIATELY LABEL VARIABLE IDS
featureNames <- read.table(paste(path,"/features.txt", sep=""))
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

names(Y_train) <- "Activity"
names(Y_test) <- "Activity"

train_df <- cbind(subject_train, Y_train, X_train)
test_df <- cbind(subject_test, Y_test, X_test)
combined_df <- rbind(train_df, test_df)

# 2 -- EXTRACT ONLY THE MEASUREMENTS THAT CONTAIN MEAN OR STD

mean_df <- grep("mean", names(combined_df))
std_df <- grep("std", names(combined_df))

#ADD IN "ACTIVITIES COLUMN"
mean_std_df <- sort(c(mean_df, std_df, 1,2))

combined <- combined_df[,mean_std_df]

#3 USE DESRIPTIVE ACTIVITY NAMES
activity_df <- read.table(paste(path,"/activity_labels.txt", sep =""))
combined[,2] <- activity_df$V2[match(combined[,2],activity_df$V1)]

#5 CREATE A TINY DATA SET
tidy_df <- melt(combined, id=c("SubjectID","Activity"))
tidy_data <- dcast(tidy_df, SubjectID+Activity ~ variable, mean)
# WRITE TO CSV FILE
write.table(tidy_data, "tidy_data.txt", row.names=FALSE)
