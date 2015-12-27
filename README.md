

Overview:

run_analysis.R --> Contains the R script that 
	reads the master files Activities and Subject, 
	reads the "train" and "test" files, 
	set the right activities names for the Activities file
	merges the data (Activities, Subject, X and y Train and Test data)
	set and filter the right column names,
	summarise the data,
	write the output in a txt file
	
Instructions:

1) Unzip the "getdata-projectfiles-UCI HAR Dataset.zip" in the same level as the run_analysis.R script (The script expects that the UCI HAR Dataset is located in the same level)
2) Run the script
3) Visualize the output file "tidy_data_set.txt" in the same level directory as the script