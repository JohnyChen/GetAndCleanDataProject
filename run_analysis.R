# step 1: merges the data sets
x = read.table("./UCI HAR Dataset/test/X_test.txt")
y = read.table("./UCI HAR Dataset/test/y_test.txt")
subj = read.table("./UCI HAR Dataset/test/subject_test.txt")
data_test = data.frame(subj,y,x)

x = read.table("./UCI HAR Dataset/train/X_train.txt")
y = read.table("./UCI HAR Dataset/train/y_train.txt")
subj = read.table("./UCI HAR Dataset/train/subject_train.txt")
data_train = data.frame(subj,y,x)

data = rbind(data_test,data_train)


# step 2: extracts measurements on mean and standard deviation
features = read.table("./UCI HAR Dataset/features.txt")
vnames = as.vector(features[,2])
extract_names = grep("std()|mean()",vnames,value = FALSE)
data = data[c(1,2,extract_names+2)]


# step 3: ueses descriptive activity names to name the activities
actlabels = read.table("./UCI HAR Dataset/activity_labels.txt")
data[,2] = factor(data[,2],labels = actlabels[,2])


# step 4: labels the data set with descriptive variable names
names(data) = c("subject_num","activity_label",vnames[extract_names])


# step 5: creates a second independent data set with the average of each variable
subject_all = levels(factor(data[,1]))
activity_all = levels(factor(data[,2]))
combinations = cbind(subjec_num = rep(subject_all,each = length(activity_all)),activity_labels = activity_all)

average = vector()
for (i in 1:dim(combinations)[1]) {
  subject = as.numeric(combinations[i,1])
  activity = combinations[i,2]
  temp = colMeans(data[data[,1]==subject & data[,2]==activity,3:dim(data)[2]])
  average = rbind(average,temp)
}

data_average = cbind(combinations,average)
rownames(data_average) = paste(data_average[,1],data_average[,2])
write.table(data_average,"./UCI HAR Dataset/data_average.txt")