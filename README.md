run_analysis.r
===================
when run in the same directory as the UCI HAR dataset, this script will read the datasets, specifically the subject lines, as well as the X and y datasets. It will merge them together, with he Subject lines, the Y activity type(running, walking, etc.) and the X data.

run_analysis then cleans the data, by removing all but columns related to standard deviation and mean. Then the script will create a tidy data set, including only the mean of each point (I.E.: Subject 1, Running) 
