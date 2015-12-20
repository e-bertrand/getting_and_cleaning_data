# Codebook for the `summary_uci_har` data set
* Author: Enrique Bertrand
* Date: 2015-12-20
* Version: 1.0

----------

## Project Description
The Human Activity Recognition experiment at UC Irvine ([see home page](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "UCI HAR home page")) collected its data in a number of sparse files (with a preculiar structure of rows and columns), which makes challenging subsequent analysis or further developments. The purpose of this project is to create a new dataset with a subset of their core measures in a way compliant with the principles of tidy data sets (after Hadley Wickham's seminal paper ["Tidy Data"](http://www.jstatsoft.org/article/view/v059i10 "Tidy Data paper")).


##Study design and data processing

###Collection of the raw data
The files conataining raw data are available as a compressed file in: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "UCI HAR data set files")   

The files collect the results of experiments carried out with a group of 30 subjects performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The results are splitted in two sets, one for training and one for test, in the context of marchine learning designs.

Two sensors of the smartphone, an accelerometer and a gyroscope, produce signals that are filtered and postprocessed in order to obtain 561 features associated to subject's movements under the different activities. 

###Notes on the original (raw) data 
According to the above point the data are splitted in the following files in






##Creating the tidy datafile

###Guide to create the tidy data file
Description on how to create the tidy data file (1. download the data, ...)/

###Cleaning of the data
Short, high-level description of what the cleaning script does. [link to the readme document that describes the code in greater detail]()

##Description of the variables in the tiny_data.txt file
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable 1:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Annex
If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)