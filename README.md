the script assumes the relevant files, are downloaded 
and extracted in the current working directory

run the script and the output-file will be placed in the current working directory

1. files are read into dataframes
2. the relevant columns (mean and standarddeviation) are extracted
3. the 'subjects' and 'activity' data will be added by horizontal merges
4. the 'test' and 'train' data will be merged vertically
5. activity labels are added with a join
6. variable names are transformed into descriptive names
7. the means of the variables are calculated per subject/activity-combination
8. this data is written into an output datafile called "avg_act_subj.txt"