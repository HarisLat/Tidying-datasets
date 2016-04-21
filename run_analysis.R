# Do the following when the working directory has been set to the UCI
# HAR Dataset file

# Read the txt files and name the variables

features = read.table('./features.txt',header=FALSE)
colnames(features)=c('featureID','feature')

activities = read.table('./activity_labels.txt',header=FALSE)
colnames(activities)=c('activityID','activity')

subjectTrain=read.table('./train/subject_train.txt',header=FALSE)
colnames(subjectTrain)="subjectID"

xTrain=read.table('./train/X_train.txt',header=FALSE)
colnames(xTrain)= features[,2]

yTrain=read.table('./train/y_train.txt',header=FALSE)
colnames(yTrain)="activityID"

# Merge the files to create the training dataset 

trainingData=cbind(yTrain,subjectTrain,xTrain)

# Do the same for test data

subjectTest=read.table('./test/subject_test.txt',header=FALSE)
colnames(subjectTest)="subjectID"

xTest=read.table('./test/X_test.txt',header=FALSE)
colnames(xTest)=features[,2]

yTest=read.table('./test/y_test.txt',header=FALSE)
colnames(yTest)="activityID"

testData=cbind(yTest,subjectTest,xTest)

# Merge test and training data to create one final dataset

finalData = rbind(trainingData,testData);

# Extract only the measurements on the mean and std

colNames = colnames(finalData)
extraction=(grepl("activity..",colNames)|grepl("subject..",colNames)|
                    grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) |
                    grepl("-std..",colNames))
finalData2=finalData[extraction==TRUE]

# Use descriptive activity names

finalData3=merge(finalData2,activities,by="activityID",all.x=TRUE)

#Label the dataset with descriptive variable names
colNames2=colnames(finalData3)

for (i in 1:length(colNames2)){
        
        colNames2[i]=gsub("\\()","",colNames2[i])
        colNames2[i]=gsub("-std","stdDev",colNames2[i])
        colNames2[i]=gsub("-mean","Mean",colNames2[i])
        colNames2[i]=gsub("^(t)","time",colNames2[i])
        colNames2[i]=gsub("^(f)","freq",colNames2[i])
        colNames2[i]=gsub("([Gg]ravity)","Gravity",colNames2[i])
        colNames2[i]=gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames2[i])
        colNames2[i]=gsub("([Gg]yro)","Gyro",colNames2[i])
        colNames2[i]=gsub("AccMag","AccMagnitude",colNames2[i])
        colNames2[i]=gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames2[i])
        colNames2[i]=gsub("JerkMag","JerkMagnitude",colNames2[i])
        colNames2[i]=gsub("GyroMag","GyroMagnitude",colNames2[i])
        
}

colnames(finalData3)=colNames2

# Create a second, independent tidy data set with the average of each 
# variable for each activity and each subject.

finalData4= finalData3[,names(finalData3) != "activity"]

tidyData=aggregate(finalData4[,names(finalData4) != c("activityID","subjectID")],
                   by=list(activityID=finalData4$activityID,subjectID=finalData4$subjectID),mean)  

tidyData=merge(tidyData,activities,by="activityID",all.x=TRUE)

# Create the table with the tidy dataset 

write.table(tidyData,'./tidyData.txt',row.names=TRUE,sep='\t')

