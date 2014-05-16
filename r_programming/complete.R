# Read a directory full of files and reports the number of completely observed cases in each data
# file. The function should return a data frame where the first column is the name of the file and
# the second column is the number of complete cases

complete <- function(directory, id = 1:332) {

    # Initialize arrays
    files <- c()
    complete <- c()

    for (monitor in id) {
        # Generate the filename, zero-pad the monitor numbers
        filename <- paste(directory, "/", formatC(monitor, width=3, flag="0", format="d" ), ".csv", sep="")
        files <- append(files, monitor)
        data <- read.csv(filename)

        # Determine the number of complete cases
        valid <- complete.cases(data)
        complete <- append(complete, length(data$Date[valid]))
    }
    
    # Return the datra frame
    data.frame(id=files, nobs=complete)
}  # complete()
