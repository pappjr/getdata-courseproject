## README
Notes on using run_analysis.R.

# Pre-requisites
This script assumes raw data has been downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
This script assumes the raw data has been unzipped into the R working directory and no other modifications have been made to the data or directory structure.
This script requires the 'dplyr' library for reshaping the data.

# Running the script
To use this script, download the raw data set from the UCI HAR - or Coursera - website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Unzip the downloaded zip file into a directory within the R working directory named "UCI HAR Dataset" - you can find the current R working directory using the getwd command.
Download run_analysis.R and save to the R working directory
In R, be sure your working directory is set to the directory containing the "UCI HAR Dataset" directory - using setwd command
Use the source command to run run_analysis.R
The script will create a number of objects in your environment - most importantly data frame 'td' which represents the 'tidy data'.
The script will also create tidy_data.txt which contains the same data from 'td' printed to a .txt file.