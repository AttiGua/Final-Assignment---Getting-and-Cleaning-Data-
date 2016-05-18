# Reading Data

X_test = read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test = read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

X_train = read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train = read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

label = read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, stringsAsFactors = FALSE)

features = read.table("UCI HAR Dataset/features.txt")     

# 1)  Merges the training and the test sets to create one data set.
#     AND
# 4)  Appropriately labels the data set with descriptive variable names.
      
      subject = rbind(subject_train, subject_test) #subject
      y = rbind(y_train, y_test)                   #activity
      X = rbind(X_train, X_test)                   #features
      
      names(X) = t(features[2])
      
      tot = cbind(X,y,subject)
      
# 2)  Extracts only the measurements on the mean and standard deviation for each measurement.      
      
      mean_sd = grep(".*Mean.*|.*Std.*", names(tot), ignore.case=TRUE)
      col = c(mean_sd, 562, 563)
      extract = tot[,col]

# 3)  Uses descriptive activity names to name the activities in the data set   
      
      # Identification of "y" column
      
      names(extract) 
      head(extract[87]) #Column 'y' is 87th
      
      for (i in 1:6){
        extract[87][extract[87] == i] = as.character(label[i,2])
      }

# 5)  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.      
      
      tidyData = aggregate(. ~Subject + Activity, extract, mean)
      tidyData = tidyData[order(tidyData$Subject,tidyData$Activity),]
      write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
      
