# Building up a tidy data set from UCI HAR experiment data

This repository contains the following files:

- An R script (`run_analysis.R`), which creates and exports a single tidy data set (`summary_uci_har`) from the set of files that make up the UCI Human Activity Recognition experiment. The final data set summarizes the average value of means and standard deviations from the different sensor signals that have been measured.

- A codebook (`Codebook.md`) with the description of the raw data to be cleaned, and the transformations, variables, etc. included in the final tidy dataset.

## Getting the data and running the script

1. The data can be downloaded from: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "UCI HAR data set files")  
Expand the zip file maintaining the directory structure. A `UCI HAR Dataset` directory with two subdirectories `train` and `test` will be created in the working directory. Names and content of the files once expanded the zip file must not be changed.

2. Before running the R script, the following packages must be installed in the R environment:

	- `data.table`
	- `tidyr`
	- `dplyr`    
                                                             
3. Save and run the R script from the working directory where the original `UCI HAR Dataset.zip` has been expanded. That is, a directory `UCI HAR Dataset`, and its subdirectories `train` and `test`, must exist in the same working directory where script is running. Set the working directory in R adequately.

## Basic purpose and structure of the R script `run_analysis.R`

The basic purpose of the script is to bind the data of the UCI HAR experiment, which are splitted in different files, in a unique data set and then to proceed to clean it and restructuring it according the tidy data good principles and practices (see Hadley Wickham's paper ["Tidy Data"](http://www.jstatsoft.org/article/view/v059i10 "Tidy Data paper")).

The final data set `summary_uci_har` summarizes for every subject and activity some of the variables (all of those related to mean and standard deviation of sensor signals) included in the original raw files.

The script includes the following steps in order to create this tidy data set:

- Step 0: Load required packages

- Step 1: Read train and test files, merging them in one data set. For the sake of speed, data.tables and fread() function have been used instead of more usual data.frames and read.x methods. Finally, assign alfabetic meaningfull names to measurement columns from `features.txt` file.

- Step 2: Select, together `subject` and `activity` columns, only measurement columns with `mean()` or `std()` strings in their names. 

- Step 3: Replace numeric codes in `activity` column by alphabetic values from `activity_labels.txt` file.

- Step 4: Apply appropiate labels to columns conforming to both R naming standards and tidy data conventions (whenever possible). In the interest of clarity an legibility, some underscore characters have been maintained. 

- Step 5: Create a new summary data set (`summary_uci_har`), with the average of every measured sensor signal for every subject and activity. Tidy data set has a "narrow" format because measurement columns are gathered in a `sensorsignal` and `average` value structure. Export and save this data set as an external txt file in the working directory.   

- Last step: Clean the global environment off partial and midst results.

## Detailed info about `summary_uci_har` data set
Please see the `Codebook.md` document in this same repository to get detailed information about the structure of the `summary_uci_har` data set, the raw data where it comes from, and how it has been created.
