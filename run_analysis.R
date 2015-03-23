# This code is run to create a tidy dataset for ...

doTidy <- function()
{
  #load the dplyr library
  library(dplyr)
  
  #read the column names for the features
  msrs_hdr <- read.table("./features.txt", col.names=c("col_id","col_name"))
  
  #read the test datasets: subjects, activities and measures
  test_subj <- read.table("./test/subject_test.txt", header=F, col.names="subject")
  test_subj <- mutate(test_subj, rowid=seq(1:nrow(test_subj)), src="test")
  test_actv <- read.table("./test/y_test.txt", header=F, col.names="activity")
  test_actv <- mutate(test_actv, rowid=seq(1:nrow(test_actv)), src="test")
  test_msrs <- read.table("./test/X_test.txt", header=F, col.names=msrs_hdr$col_name)
  test_msrs <- mutate(test_msrs, rowid=seq(1:nrow(test_msrs)), src="test")
  
  #read the train datasets: subjects, activities and measures
  train_subj <- read.table("./train/subject_train.txt", header=F, col.names="subject")
  train_subj <- mutate(train_subj, rowid=seq(1:nrow(train_subj)), src="train")
  train_actv <- read.table("./train/y_train.txt", header=F, col.names="activity")
  train_actv <- mutate(train_actv, rowid=seq(1:nrow(train_actv)), src="train")
  train_msrs <- read.table("./train/X_train.txt", header=F, col.names=msrs_hdr$col_name)
  train_msrs <- mutate(train_msrs, rowid=seq(1:nrow(train_msrs)), src="train")
  
  #read the activity name labels
  activity_labels <- read.table("./activity_labels.txt",header=F, col.names=c("activity","activity_name"))
  
  #merge the datasets by row i.e. test and train
  subj <- rbind(test_subj, train_subj)
  actv <- rbind(test_actv, train_actv)
  msrs <- rbind(test_msrs, train_msrs)
  
  #merge in the activity labels
  actv <- merge(actv, activity_labels, by="activity")
  
  #merge the datasets by column, using the surrogate keys added. assumption is that the 
  #datasets were already ordered each subject with the corresponding activity and measures
  tidy <- merge(subj, actv, by=c("rowid","src"),all=T)
  tidy <- merge(tidy, msrs, by=c("rowid","src"),all=T)
  tidy <- select(tidy, subject, activity_name, contains("mean.."), contains("std.."))
  
  #order the tidy data frame...just for  aesthetics
  tidy <- arrange(tidy, subject, activity_name)
  
  #do the summarised data frame
  summ_tidy <- tidy %>% group_by(subject, activity_name) %>% summarise_each(funs(mean))
  
  #write the final summarised data frame
  write.table(summ_tidy, "./summ_tidy.txt", row.names=F)
  
  return (summ_tidy)
}