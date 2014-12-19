# Full Dataset Creation, will do all the required steps to achieve the final
# result, thus allowing step by step running
finalDataset <- function (workingDir = FALSE, save = TRUE) {
    if (!loadDependencies()) return (FALSE)
    dataset <- createDataset (workingDir)
    if (any(dataset == FALSE)) return (FALSE)
    finalResult <- calculateDataset (dataset)
    if (any(finalResult == FALSE)) return (FALSE)
    if (save) write.table (finalResult, file="finalResult.txt", row.name=FALSE)
    return (finalResult)
}

# Load files required for the dataset, create the dataset, get required columns,
# name them and return the final result
createDataset <- function (workingDir = FALSE) {
    if (!loadDependencies()) return (FALSE)
    if (workingDir == FALSE) workingDir = "./SamsungDataset/"
    if (any(!file.exists (paste (workingDir, "X_test.txt", sep=""),
                          paste (workingDir, "y_test.txt", sep=""),
                          paste (workingDir, "X_train.txt", sep=""),
                          paste (workingDir, "y_train.txt", sep=""),
                          paste (workingDir, "subject_test.txt", sep=""),
                          paste (workingDir, "subject_train.txt", sep="")))) {
        writeLines ("Can't load files required to continue analysis!");
        return (FALSE)
    }
    
    test <- read.table(paste (workingDir, "X_test.txt", sep=""))
    train <- read.table(paste (workingDir, "X_train.txt", sep=""))
    testActivity <- read.table(paste (workingDir, "y_test.txt", sep=""))
    trainActivity <- read.table(paste (workingDir, "y_train.txt", sep=""))
    testSubjects <- read.table(paste (workingDir, "subject_test.txt", sep=""))
    trainSubjects <- read.table(paste (workingDir, "subject_train.txt", sep=""))
    
    columnsRequired <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,
                         122,123,124,125,126,161,162,163,164,165,166,201,202,
                         214,215,227,228,240,241,253,254,266,267,268,269,270,
                         271,345,346,347,348,349,350,424,425,426,427,428,429,
                         503,504,516,517,529,530,542,543)
    
    test <- cbind (testSubjects, testActivity, test[,columnsRequired])
    train <- cbind (trainSubjects, trainActivity, train[,columnsRequired])
    
    result <- rbind (test, train)
    names(result) <- c("subject.number",
                       "activity.name",
                       paste ("var_", 3:68, sep=""))
    return (result)
}

# Group data and calculate average of each variable for each activity and each
# subject
calculateDataset <- function (dataset, workingDir = FALSE) {
    if (!loadDependencies()) return (FALSE)
    if (any(dataset == FALSE)) return (FALSE)
    if (workingDir == FALSE) workingDir = "./SamsungDataset/"
    if (!file.exists (paste (workingDir, "activity_labels.txt", sep=""))) {
        writeLines ("Can't load files required to continue analysis!");
        return (FALSE)
    }
    
    activityLabels <- read.table(paste (workingDir, "activity_labels.txt", sep=""))
    result <- dataset %>%
                select (everything()) %>%
                    group_by (subject.number, activity.name) %>%
                        summarise_each (funs(mean))
    
    columnsNames <- c("subject.number",
                      "activity.name",
                      "time.body.accelerometer.mean.x", 
                      "time.body.accelerometer.mean.y", 
                      "time.body.accelerometer.mean.z", 
                      "time.body.accelerometer.standardDeviation.x", 
                      "time.body.accelerometer.standardDeviation.y", 
                      "time.body.accelerometer.standardDeviation.z", 
                      "time.gravity.accelerometer.mean.x", 
                      "time.gravity.accelerometer.mean.y", 
                      "time.gravity.accelerometer.mean.z", 
                      "time.gravity.accelerometer.standardDeviation.x", 
                      "time.gravity.accelerometer.standardDeviation.y", 
                      "time.gravity.accelerometer.standardDeviation.z", 
                      "time.body.accelerometer.jerk.mean.x", 
                      "time.body.accelerometer.jerk.mean.y", 
                      "time.body.accelerometer.jerk.mean.z", 
                      "time.body.accelerometer.jerk.standardDeviation.x", 
                      "time.body.accelerometer.jerk.standardDeviation.y", 
                      "time.body.accelerometer.jerk.standardDeviation.z", 
                      "time.body.gyroscope.mean.x", 
                      "time.body.gyroscope.mean.y", 
                      "time.body.gyroscope.mean.z", 
                      "time.body.gyroscope.standardDeviation.x", 
                      "time.body.gyroscope.standardDeviation.y", 
                      "time.body.gyroscope.standardDeviation.z", 
                      "time.body.gyroscope.jerk.mean.x", 
                      "time.body.gyroscope.jerk.mean.y", 
                      "time.body.gyroscope.jerk.mean.z", 
                      "time.body.gyroscope.jerk.standardDeviation.x", 
                      "time.body.gyroscope.jerk.standardDeviation.y", 
                      "time.body.gyroscope.jerk.standardDeviation.z", 
                      "time.body.accelerometer.magnitude.mean", 
                      "time.body.accelerometer.magnitude.standardDeviation", 
                      "time.gravity.accelerometer.magnitude.mean", 
                      "time.gravity.accelerometer.magnitude.standardDeviation", 
                      "time.body.accelerometer.jerk.magnitude.mean",
                      "time.body.accelerometer.jerk.magnitude.standardDeviation", 
                      "time.body.gyro.magnitude.mean", 
                      "time.body.gyro.magnitude.standardDeviation", 
                      "time.body.gyro.jerk.magnitude.mean", 
                      "time.body.gyro.jerk.magnitude.standardDeviation", 
                      "frequency.body.accelerometer.mean.x", 
                      "frequency.body.accelerometer.mean.y", 
                      "frequency.body.accelerometer.mean.z", 
                      "frequency.body.accelerometer.standardDeviation.x", 
                      "frequency.body.accelerometer.standardDeviation.y", 
                      "frequency.body.accelerometer.standardDeviation.z", 
                      "frequency.body.accelerometer.jerk.mean.x", 
                      "frequency.body.accelerometer.jerk.mean.y", 
                      "frequency.body.accelerometer.jerk.mean.z", 
                      "frequency.body.accelerometer.jerk.standardDeviation.x", 
                      "frequency.body.accelerometer.jerk.standardDeviation.y", 
                      "frequency.body.accelerometer.jerk.standardDeviation.z", 
                      "frequency.body.gyroscope.mean.x", 
                      "frequency.body.gyroscope.mean.y", 
                      "frequency.body.gyroscope.mean.z", 
                      "frequency.body.gyroscope.standardDeviation.x", 
                      "frequency.body.gyroscope.standardDeviation.y", 
                      "frequency.body.gyroscope.standardDeviation.z", 
                      "frequency.body.accelerometer.magnitude.mean", 
                      "frequency.body.accelerometer.magnitude.standardDeviation", 
                      "frequency.body.accelerometer.jerk.magnitude.mean", 
                      "frequency.body.accelerometer.jerk.magnitude.standardDeviation", 
                      "frequency.body.gyroscope.magnitude.mean", 
                      "frequency.body.gyroscope.magnitude.standardDeviation", 
                      "frequency.body.gyroscope.jerk.magnitude.mean", 
                      "frequency.body.gyroscope.jerk.magnitude.standardDeviation")
    
    #result$activity.name <- sapply(result$activity.name, function(x)activityLabels[x,2])
    names(result) <- columnsNames
    return (result)
}

# Load Library dependencies, throwing error when not found
loadDependencies <- function () {
    if ("dplyr" %in% rownames(installed.packages())) {
        library(dplyr)
        return (TRUE)
    }
    else {
        writeLines ("Dependency on dplyr library, please install before continuing!");
        return (FALSE)
    }
}