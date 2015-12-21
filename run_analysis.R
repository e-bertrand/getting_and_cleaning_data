##############################################################################
# This script produce and export a single tidy dataset ("summary_uci_har.txt") 
# from the set of files that make up the UCI Human Activity Recognition 
# experiment. The final dataset summarizes the average value of means and 
# standard deviations from the different sensor signals that have been measured.
#
# ATTENTION: the script must be run in the directory where the original 
# "UCI HAR Dataset.zip" has been expanded. That is, a directory 
# "UCI HAR Dataset", and its subdirectories "train" and "test", must exist in
# the same directory where script is running.
##############################################################################
#
##############################################################################
# Step 0. Loading required packages
##############################################################################
#
library(dplyr)
library(data.table)
library(tidyr)
#
##############################################################################
# Step 1. Reading train and test files, merging in one data set and assigning
#         alfabetic names to x_ measures
##############################################################################
#
## Reading files
#
subject_train_dt <- fread("UCI HAR Dataset/train/subject_train.txt",
                          col.names = c("subject"),
                          stringsAsFactors=FALSE)

y_train_dt <- fread("UCI HAR Dataset/train/y_train.txt",
                    col.names = c("activity"),
                    stringsAsFactors=FALSE)

x_train_dt <- fread("UCI HAR Dataset/train/X_train.txt", 
                    stringsAsFactors=FALSE)

subject_test_dt <- fread("UCI HAR Dataset/test/subject_test.txt", 
                         col.names = c("subject"),
                         stringsAsFactors=FALSE)

y_test_dt <- fread("UCI HAR Dataset/test/y_test.txt",
                   col.names = c("activity"),
                   stringsAsFactors=FALSE)

x_test_dt <- fread("UCI HAR Dataset/test/X_test.txt", 
                   stringsAsFactors=FALSE)
#
## Merging data tables in one global dt called uci_har_dt, first binding test
## files and theh train files by column and finally binding results by rows
#
uci_har_dt <- rbind(cbind(subject_train_dt, y_train_dt, x_train_dt),
                    cbind(subject_test_dt, y_test_dt, x_test_dt))
#
## Assigning alfabetic names to x_ measures (columns 3 to 563) from
## "features.txt" file. As the file has duplicated elements, special characters
## etc. the function make.names() with unique = TRUE is used to guarantee 
## unicity and compliance with R naming standards
#
features_dt <- fread("UCI HAR Dataset/features.txt",
                     col.names = c("code", "name"),
                     stringsAsFactors=FALSE)

feature_names <- make.names(features_dt$name, unique = TRUE)
names(uci_har_dt)[3:563] <- feature_names
#
###############################################################################
# Step 2. Together "subject" and "activity" columns, extract measurement columns
#         with "mean" or "std" in their names. Be aware that column names have 
#         been already adapted to R naming standards in Step 1, so "_mean()" is
#         now ".mean.." and so on
#         
###############################################################################
#
uci_har_dt <- select(uci_har_dt, subject, activity, 
                        contains(".mean.."),
                        contains(".std.."))
#
###############################################################################
# Step 3. Replace numeric codes for activities by alphabetic values from
#         "activity_labels.txt" file
###############################################################################
#
activity_labels_dt <- fread("UCI HAR Dataset/activity_labels.txt",
                            col.names = c("code", "act_name"),
                            stringsAsFactors=FALSE)
#
## the join add a new column with name "act_name" at the end of uci_har_dt
#
uci_har_dt$activity <-  full_join(uci_har_dt, activity_labels_dt, 
                               by = c("activity" = "code"))$act_name
#
###############################################################################
# Step 4. Applying appropiate labels to columns conforming to both R naming
#         standards and tidy data conventions (whenever possible)
###############################################################################
#
## Making all of the letters lower case
#
names(uci_har_dt) <- tolower(names(uci_har_dt))
#
## Replacing some abreviations by full concepts. 
## Although not conforming tidy names conventions, in the interest of clarity 
## an legibility underscores are placed before "mean" and "stndeviation" and 
## after "time" and "frequency"
#
## regular expresions of texts to be repleced
#
exp_ini <- c("^t", "^f", 
             "acc", "gyro", "mag", 
             ".mean..", ".std..",
              "\\.x", "\\.y", "\\.z")
#
## text replacements; element i is the replacemente of element i in exp_ini
#
exp_rep <- c("time_", "frequency_", 
             "accelerometer", "gyroscope", "magnitude",
             "_mean", "_stndeviation",
             "_x", "_y", "_z")
#
## changing column names of uci_har_dt according previously defined vectors
#
for (i in exp_ini) {
  names(uci_har_dt) <- gsub(i, exp_rep[which(exp_ini == i)], names(uci_har_dt))
}
#
###############################################################################
# Step 5. Producing a summary data set with average of every measure by
#         particpant and activity and saving it in an external txt file.
#         Measure Columns are gathered in a sensor_signal -> value structure
###############################################################################
#
summary_uci_har <- uci_har_dt %>%
                  gather(sensorsignal, average, 
                         3:length(uci_har_dt)) %>%
                  arrange(subject, activity, sensorsignal) %>%
                  group_by(subject, activity, sensorsignal) %>%
                  summarize_each(funs(mean))

#
# Defining fixed variables as factors (character). sensorsignal is already a
# factor
#
summary_uci_har$subject <- as.factor(summary_uci_har$subject)
summary_uci_har$activity <- as.factor(summary_uci_har$activity)

#
# Exporting the data.table as a text file in the working directory
#
write.table(summary_uci_har, file = "summary_uci_har.txt", sep = ",",
            row.names = FALSE)
#
###############################################################################
# Step 99. Cleaning the global environment by removing intermediate data tables
###############################################################################
#
rm("activity_labels_dt", "features_dt", "feature_names")
rm("subject_train_dt", "x_train_dt", "y_train_dt")
rm("subject_test_dt", "x_test_dt", "y_test_dt")
rm("exp_ini", "exp_rep", "i")
#