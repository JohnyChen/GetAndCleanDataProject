GetAndCleanDataProject
======================

use `read.table("./UCI HAR Dataset/data_average.txt")` to read the processed data set.

---
##Step 1: merge the data sets
Read data from ./UCI HAR Dataset/test/
```
x = read.table("./UCI HAR Dataset/test/X_test.txt")
y = read.table("./UCI HAR Dataset/test/y_test.txt")
subj = read.table("./UCI HAR Dataset/test/subject_test.txt")
```
Combine the three data sets from folder test (`x y and subj`)
I put `x` and `y` first, because I think they will be frequently used,
it will be more convenient to observe.
```
data_test = data.frame(subj,y,x)
```
Read data from ./UCI HAR Dataset/train/
Since x y subj won`t be used anymore, I overwrite them to make the code more space efficient.
```
x = read.table("./UCI HAR Dataset/train/X_train.txt")
y = read.table("./UCI HAR Dataset/train/y_train.txt")
subj = read.table("./UCI HAR Dataset/train/subject_train.txt")
```
Combine the three data sets from folder train (`x y and subj`)
```
data_train = data.frame(subj,y,x)
```
Combine `data_test` and `data_train`
```
data = rbind(data_test,data_train)
```



##Step 2: extract measurements on mean and standard deviation
Read data from ./UCI HAR Dataset/features.txt
```
features = read.table("./UCI HAR Dataset/features.txt")
```
Extract the feature names (the 2nd column) from `features`
```
vnames = as.vector(features[,2])
```
Determine which ones in `vnames` include `std()` or `mean()`.
I use `mean()` instead of `mean` to exclude `meanFreq`. 
And I set `value = FALSE` because I will need the indexes in the next step.
```
extract_names = grep("std()|mean()",vnames,value = FALSE)
```
Extract the data required in the following steps and overwrite `data`
```
data = data[c(1,2,extract_names+2)]
```


##Step 3: uese descriptive activity names to name the activities
Read the labels from ./UCI HAR Dataset/activity_labels.txt
```
actlabels = read.table("./UCI HAR Dataset/activity_labels.txt")
```
Change the activity number to descriptive labels
```
data[,2] = factor(data[,2],labels = actlabels[,2])
```


##Step 4: label the data set with descriptive variable names
Since I put the subject number and activity label in the first two columns, 
I add their names to the corresponding columns.
`extract_names` are indexes, `vnames[extract_names]` will give me the characters
```
names(data) = c("subject_num","activity_label",vnames[extract_names])
```


##Step 5: create a second independent data set with the average of each variable
`subject_all` indicates all 30 subject numbers, `activity_all` indicates all 6 activity labels
`combinations` indcates all 30x6=180 combinations of subject numbers and activity labels
```
subject_all = levels(factor(data[,1]))
activity_all = levels(factor(data[,2]))
combinations = cbind(subjec_num = rep(subject_all,each = length(activity_all)),activity_labels = activity_all)
```
Set average as an empty vector, it will be used to store the `average` of each combination
```
average = vector()
```
Loop the `combinations` and calculate the average of each variable using `colMeans()`,
and temporarily store the average in `temp`
```
for (i in 1:dim(combinations)[1]) {
  subject = as.numeric(combinations[i,1])
  activity = combinations[i,2]
  temp = colMeans(data[data[,1]==subject & data[,2]==activity,3:dim(data)[2]])
  average = rbind(average,temp)
}
```
Obtain the tidy data set required
```
data_average = cbind(combinations,average)
```
Since I already include the `combinations`, the following step is not necessary,
but it will make the data set look better. 
It will also be easier to extract the rows in further processing work.
```  
rownames(data_average) = paste(data_average[,1],data_average[,2])
```
Output the data_average to a txt file
```
write.table(data_average,"./UCI HAR Dataset/data_average.txt")
```



