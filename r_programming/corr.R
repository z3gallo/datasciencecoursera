# Take a directory of data files and a threshold for complete cases and calculates the correlation
# between sulfate and nitrate for monitor locations where the number of completely observed cases
# (on all variables) is greater than the threshold. The function should return a vector of
# correlations for the monitors that meet the threshold requirement. If no monitors meet the
# threshold requirement, then the function should return a numeric vector of length 0.

corr <- function(directory, threshold = 0) {
    id <- 1:332
    correlations <- vector(mode="numeric", length=0)
    
    for (monitor in id) {
        # Generate the filename, zero-pad the monitor numbers
        filename <- paste(directory, "/", formatC(monitor, width=3, flag="0", format="d" ), ".csv", sep="")
        data <- read.csv(filename)

        # Skip this file if we don't meet the threshold of complete cases
        valid <- complete.cases(data)
        num.complete <- length(data$Date[valid])
        if ( ! (num.complete > threshold) ) { next }

        # Append to the list of correlations, using only complete objects
        correlations <- append(correlations, cor(data$nitrate, data$sulfate, use="complete.obs"))
    }
    correlations
}  # corr()
