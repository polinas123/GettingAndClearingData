# I work with data.table. this will install the package if missing:
if (!"data.table" %in% installed.packages()){
        install.packages("data.table")
}
require(data.table)        

# download file
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = URL, destfile = "UCI_HAR_Dataset.zip")

#read test set and training set
tmp <- unzip(zipfile = "UCI_HAR_Dataset.zip")
test <- fread(input = tmp[grep(x = tmp, "test/X_test.txt")])
train <- fread(input = tmp[grep(x = tmp, "train/X_train.txt")])

# read activities and subjects (codes) into each dataset:
activities_train <- fread(input = tmp[grep(x = tmp, "train/y_train.txt")])
subjects_train <- fread(input = tmp[grep(x = tmp, "train/subject_train.txt")])
activities_test <- fread(input = tmp[grep(x = tmp, "test/y_test.txt")])
subjects_test <- fread(input = tmp[grep(x = tmp, "test/subject_test.txt")])
train[,activity := activities_train]
train[,subject := subjects_train]
test[,activity := activities_test]
test[,subject := subjects_test]

# Merge the training and the test sets to create one data set, called HAR:
HAR = rbind(train, test)
# Appropriately label the data set with descriptive variable names.
labels <- fread(input = tmp[grep(x = tmp, "features.txt")], select = 2)
colnames(HAR) <- c(labels, "activity", "subject")

# Kepp only the measurements on the mean and standard deviation for each measurement.
m.loc = grep(x = labels$V2, "mean()")
s.loc = grep(x = labels$V2, "std()") 
features = sort(c(m.loc,s.loc))
HAR <- HAR[,c(which(colnames(HAR) == "activity"), 
              which(colnames(HAR) == "subject"),
              features), with = F]

# Use descriptive activity names, instead of codes
setkey(HAR, "activity")
activily_labels <- fread(input = tmp[grep(x = tmp, "activity_labels.txt")])
lapply(X = seq_along(activily_labels$V2), 
       FUN = function(i, lab = activily_labels) {
               HAR[.(lab$V1[i]), activity_name := lab$V2[i]]
               })
HAR[, activity := NULL]

# create atidy data set with the average of each variable for each activity and each subject.
setcolorder(x = HAR, neworder = c("subject", "activity_name", colnames(HAR)[2:80]))
setkey(HAR, "subject", "activity_name")

tidy <- HAR[, lapply(.SD, mean), by = .(subject, activity_name), .SDcols = colnames(HAR)[3:length(HAR)]]

# export data set as TXT:
write.table(x = tidy, file = "RspecC3W4assignment.txt", row.names = F)

