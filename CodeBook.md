Code Book for data_average.txt
-----------------------------------------

	variables used in the processing script (run_analysis.R)
	---------------------------------------------------------------
		x
			temporarily stores data read from x_test.txt and x_train.txt
		y
			temporarily stores data read from y_test.txt and y_train.txt
		subj
			temporarily stores data read from subject_test.txt and subject_train.txt
		data_test
			stores data after merging x y subj read from the folder "test"
		data_train
			stores data after merging x y subj read from the folder "train"
		data
			stores all the data of data_test and data_train 
			(required in step 1)
		features
			stores data read from features.txt
		vnames
			stores all the feature names, i.e. the variable names for data 
			(not including "subject_num","activity_labels")
		extract_names
			the names of columns to be extracted, i.e. those include mean() and std()
			(required in step 2)
		actlabels
			stores the activity labels read from activity_labels.txt
		subject_all
			all the subject numbers, i.e. 1:30
		activity_all
			all the six activity names
		combinations
			all the different combinations of subject numbers and activity names
		average
			average of each extracted variables for each combination
		data_average
			the tidy data set required in step 5, which will be written into data_average.txt
		
	
	variables of data_average.txt 
	---------------------------------------------------------------------------------------
		column names
			subject_num
				the subject number, 1-30
			activity_labels
				the activity labels, 1-6
			(other column names are reserved from the original data)
				
		row names
			of the row names, the first number indicates the corresponding subject number
			followed by the subject's activity label
			for example, row "1 WALKING" contains the data of subject 1 walking
		
		
		
		
		
		