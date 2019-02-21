This project was completed as a part of the Johns Hopkins Coursera Data Science specialization.
Josh McNamara

===========
Components:
===========
* run_analysis.R
	This file transforms an accelerometry dataset into a tidy summary of the means and standard deviations of velocity associated with several activities.

* tidy_data.csv
	This is the tidy data output from the run_analysis.R script.

* tidy_summary_data.csv
	This is the tidy data output from the run_analysis.R script detailing category averages from different motion activities.

* UCI HAR Dataset
	This is the raw data repo used to feed this analysis.

=====================
How the script works:
=====================

The run_analysis.R script:

0. Works if the UCI HAR dataset directory is in the same directory as the script
1. Combines the test and training datasets into one R dataframe
2. Extracts the mean and standard deviation data for each variable
3. Adds descriptive names for the dataframe columns
4. Labels the data points with pertinent activity labels (whether the subject was sitting, standing, etc.)
5. Creates a second tidy dataframe summarizing the mean accelerometric measurements from the first dataframe with respect to each activity tag
6. Writes these dataframes to csv files in the same directory
