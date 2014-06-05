
# calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The
# function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector
# monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the
# directory specified in the 'directory' argument and returns the mean of the pollutant across all
# of the monitors, ignoring any missing values coded as NA

pollutantmean <- function(directory, pollutant, id = 1:332) {

    # Initialize counters
    total <- 0
    count <- 0

    for (monitor in id) {
        # Generate the filename, zero-pad the monitor numbers
        filename <- paste(directory, "/", formatC(monitor, width=3, flag="0", format="d" ), ".csv", sep="")
        
        data <- read.csv(filename)

        # Skip empty readings
        values <- data[pollutant][ ! is.na(data[pollutant]) ]

        # Accumulate
        total <- total + sum(values)
        count <- count + length(values)
    }

    # Return the average
    total / count
}  # pollutantmean()
