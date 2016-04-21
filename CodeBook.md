**Data**

The dataset contains information for 30 volunteers, each one performing six activities: Walking, Walking upstairs, Walking downstairs, Sitting, Standing, Laying. The embedded accelerometer and gyroscope measure 3-axial linear acceleration and 3-axial angular velocity. The dataset was randomly splitted in two sets: the training dataset (70% of the volunteers) and the test dataset (30% of the volunteers)

**Variables**

The variables provided for each observation in the dataset are: an identifier of the subject, the activity label, 3-axial acceleration, 3-axial angular velocity and a vector with 561 time and frequency related features.

**Transformations**

1.  After setting the working directory to UCI HAR, files were read, columns were assigned with names and the training dataset was merged with the test dataset
2.  A logical vector was created in order to extract only measurements on mean and standard deviation
3.  The dataset was merged with activity labels to include the descriptive names
4.  The gsub function was used to clean the name of the variables
5.  A tidy dataset was created with the "aggregate" function
