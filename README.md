# GettingAndClearingData
coursera assignment

this repository contains two files:

run_ analysis.R
---------------
1. this file is the script to run in order to get the tidy dataset required in the assignment.
2. the script requires "data.table" package. if you don't have it installed already, the script will install and load it automatically.
3. to run the script, AN INTERNET CONNECTION IS REQUIRED.
4. There is no need to have the HAR dataset downloaded prior to running the script. The script will download it automatically) hence the internet connection :)) 

The script will do the following:
1. download original dataset
2. read the following data from it: test set, training set, activitiy and subject codes, activity labels and features labels.
3. merge training+test set and set names for all the columns in the new dataset.
4. keep only mean and stdev data for each measurment.
4. replace activity codes with activity names (e.g WALKING, LAYING, etc.)
5. create a tidy dataset, containing the averages of subject+activity for each column (see codebook for further details).
6. export the tidy dataset to a TXT file in your working directory.

RspecC3W4assignment.txt
-----------------------
this is the tidy data in TXT format, as required in the assignment. this is also the result of running "run_analysis.R"

codebook_tidyHAR.pdf
--------------------
the codebook of the variables in the tidy dataset in PDF format.


Enjoy :)
