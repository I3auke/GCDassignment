the script assumes the relevant files, are downloaded 
and extracted in the current working directory
files are read into dataframes, the relevant columns (mean and standarddeviation) will are
extracted, the 'subjects' and 'activity' data will be added by horizontal merges
and then the 'test' and 'train' data will be merged vertically
after that, the means of the variables are calculated per subject/activity-combination
and this data is written int an output datafile called "avg_act_subj.txt"