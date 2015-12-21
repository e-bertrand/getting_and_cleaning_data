# Codebook for the [`summary_uci_har.txt`](https://s3.amazonaws.com/coursera-uploads/user-35028f96ffdc0b3269d98348/975119/asst-3/44ba7100a75b11e5a2c3af6173465df2.txt "summary_uci_har.txt file") data set
* Author: Enrique Bertrand
* Date: 2015-12-21
* Version: 1.1

----------

## Project Description
The Human Activity Recognition experiment at UC Irvine (UCI HAR; [see home page](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "UCI HAR home page")) collected its data in a number of sparse files (with a peculiar structure of rows and columns), which makes challenging subsequent analysis or further developments. The purpose of this project is to create a new dataset with a subset of the core measures in UCI HAR in a way compliant with the principles of tidy data sets (after Hadley Wickham's seminal paper ["Tidy Data"](http://www.jstatsoft.org/article/view/v059i10 "Tidy Data paper")).


##Study design and data processing

###Collection of the raw data
The files containing the raw data are available as a compressed file in: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "UCI HAR data set files")   

The files collect the results of experiments carried out with a group of 30 subjects performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist. 

Two sensors of the smartphone, an accelerometer and a gyroscope, produce signals that are filtered and post-processed in order to obtain 561 features associated to subject's movements under the different activities. 

The results are split in two sets, one for training and one for test, in the context of machine learning designs.

Once expanded the zip file, A `UCI HAR Dataset` directory is created in the working directory, with two subdirectories `train` and `test`.

###Notes on the original (raw) data 
According to the above point, the data under consideration are split in the following files:

- `train/X_train.txt`: a 7352 x 561 table with the features measured for the subjects in the train subset who performed the activities (names of features, i.e. columns in the table, are available in the `features.txt` file).

- `train/y_train.txt`: a 7352 x 1 table with the code of the activities measured for the subjects in the train subset (code of activities are described in `activity_labels.txt` file).

- `train/subject_train.txt`: a 7352 x 1 table with the id of the subjects in the train subset who performed the activities. 

- `test/X_test.txt`: a 2947 x 561 table with the features measured for the subjects in the test subset who performed the activities (names of features, i.e. columns in the table, are available in the `features.txt` file).

- `test/y_test.txt`: a 2947 x 1 table with the code of the activities measured for the subjects in the test subset (code of activities are described in `activity_labels.txt` file).

- `test/subject_test.txt`: a 2947 x 1 table with the id of the subjects in the test subset who performed the activities.

- `features.txt`: a 561 x 2 table with the list of all codes and full names of measured features.

- `activity_labels.txt`: a 6 x 2 table with the list of all codes and names of activities.

##Creating the tidy data file [`summary_uci_har.txt`](https://s3.amazonaws.com/coursera-uploads/user-35028f96ffdc0b3269d98348/975119/asst-3/44ba7100a75b11e5a2c3af6173465df2.txt "summary_uci_har.txt file")

###Guide to create the tidy data file
The tidy data file [`summary_uci_har.txt`](https://s3.amazonaws.com/coursera-uploads/user-35028f96ffdc0b3269d98348/975119/asst-3/44ba7100a75b11e5a2c3af6173465df2.txt "summary_uci_har.txt file") is created binding the train and test files listed above in a unique data set. The resulting data table is then cleaned and restructured according the tidy data good principles and practices (see Hadley Wickham's paper ["Tidy Data"](http://www.jstatsoft.org/article/view/v059i10 "Tidy Data paper")).

Only the 66 features related to the mean (mean() and the standard deviation (std()) measures are finally selected from the 561 original measured features. The final data set summarizes these features for every subject and activity included in the original raw files.

The script [`run_analysis.R`](https://github.com/e-bertrand/getting_and_cleaning_data/blob/master/run_analysis.R "run_analysis.R script") includes the following steps in order to create this tidy data set:

- Step 0: Load required packages.

- Step 1: Read train and test files, merging them in one data set of the class data.table. Assign alphabetic meaningful names to measurement columns from `features.txt` file.

- Step 2: Select only measurement columns that refers to `mean()` or `std()` type of features. 

- Step 3: Replace numeric codes in `activity` column by alphabetic values from `activity_labels.txt` file.

- Step 4: Apply appropriate labels to columns conforming to both R naming standards and tidy data conventions (whenever possible).

- Step 5: Create a new summary data set with the average of every measured sensor signal for every subject and activity. Save this data set as an external txt file in the working directory.   

- Last step: Clean the global environment deleting partial and midst results.

###Other aspects of the cleaning process

Following the good practices and principles for tidy data sets, names of columns and variables have been normalized:

- Converting some strings to lower case.
- Replacing code of activities by full names.
- Replacing some abbreviations in feature names by full concepts:
	- Initials "t" and "f", by "time" and "frequency" respectively.
	- Strings "Acc" by "accelerometer"; "Gyro" by "gyroscope"; "Mag" by "magnitude"; "std" by "stndeviation".
	
Although not conforming tidy names conventions, in the interest of clarity and legibility underscores are placed before "mean" and "stndeviation"; after "time" and "frequency"; and before "x", "y" and "z" axis symbols. (i.e "time\_gravityaccelerometer\_mean_z")

A more detailed description of what the cleaning script does is available in the [README.md](https://github.com/e-bertrand/getting_and_cleaning_data/blob/master/README.md "README.md document") document and in the own [`run_analysis.R`](https://github.com/e-bertrand/getting_and_cleaning_data/blob/master/run_analysis.R "run_analysis.R script") script. 

##Description of the structure and variables in [`summary_uci_har.txt`](https://s3.amazonaws.com/coursera-uploads/user-35028f96ffdc0b3269d98348/975119/asst-3/44ba7100a75b11e5a2c3af6173465df2.txt "summary_uci_har.txt file") data set  

The [`summary_uci_har.txt`](https://s3.amazonaws.com/coursera-uploads/user-35028f96ffdc0b3269d98348/975119/asst-3/44ba7100a75b11e5a2c3af6173465df2.txt "summary_uci_har.txt file") data set consists of a single comma-separated file with 11,880 observations (rows) x 4 variables (columns):   

- Considering that we have 30 subjects, 6 activities and 66 features this results in the 30 x 60 x 66 = 11,880 observations or rows.

- The final tidy data set has a "narrow" format of 4 columns because the 66 original measurement columns have been gathered in a two column structure: `sensorsignal` and `average`.

Each row in the file represents the average value of one of the 66 means / standard deviations from sensor signals for a particular subject doing one of the six activities. 

The 4 columns or variables are `subject`, `activity`, `sensorsignal`, and `average`:

- `subject`: 
	- Type: character. 
	- Semantic: It identifies the subject who have participated in the experiments and performed the activities. 
	- Range: from "1", "2", "3".. to "30".
#
- `activity`: 
	- Type: character. 
	- Semantic: each of the six activities performed by the subjects. 
	- Range: values are "WALKING", "WALKING\_UPSTAIRS", "WALKING\_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING".
#
- `sensorsignal`: 
	- Type: character. 
	- Semantic: each of 66 sensor signal feature names related with means and standard deviations (stndeviation).
	- Range: alphabetically ordered from "frequency\_bodyaccelerometer\_mean_x" to "time\_gravityaccelerometermagnitude\_stndeviation".
#
- `average`: 
	- Type: numeric. 
	- Semantic: the average (mean) of the different sensor signal measures grouped by subject and activity. 
	- Units: the units used for the "acceleration" (total and body) type features are 'g's (gravity of earth -> 9.80665 m/seg2); for the "gyroscope" type features units are rad/seg. All features are then normalized and bounded within [-1,1].
	- Range: from -1.0 to 1.0.

##Sources
In preparing the present codebook the following documents have been taken into account:
 
- UCI Human Activity Recognition Using Smartphones Data Set [basic info](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
- Hadley Wickham's paper ["Tidy Data"](http://www.jstatsoft.org/article/view/v059i10 "Tidy Data paper").
- David Hood's [advices about the project](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/).
- Gregory D. Horne's advices [about the content of project's documents](https://class.coursera.org/getdata-035/forum/thread?thread_id=83#comment-102).
- Joris Schut's [Codebook document template](https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41 "Codebook template").
