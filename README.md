# data_cleaning
This repo has been created for data cleaning course project of Coursera

## Please find below the flow of the code that is submitted in the repo:

1. Read all the test files (x_test, y_test, subject_test)
2. read all the train files (x_train, y_train, subject_train)
3. Cbind all 3 test file to get a single test file. It has 2947 observations and 563 (561 measurement + subject + activity) variables
4. Cbind all 3 train file to get a single train file. It has 7352 observations and 563 (561 measurement + subject + activity) variables
5. r bind test and train data to get a combined data set that contains 10299 observations and 563 variables
6. Using grep() function find out the columns which contains mean and standard deviation of measurements and subset the data only for those variables. After this step the data set contains 10299 rows and 88 variables
7. Read the activity description file and replace all the numeric activities( 1 to 6) with their proper description
8. Read the feature names and these descriptive names has been assigned to the variable
9. next step is to make the data tidy. For this aggregation has been used to take the average of all the variables across subject and activities. this final Tidy data set contains 180 observations and 88 variables.
10. The tidy data set has been written into a text file