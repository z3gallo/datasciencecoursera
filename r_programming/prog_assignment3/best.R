
## To make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome
## dataset).  Coerce the data type since we read the data in as a character above.

## outcome[, 11] <- as.numeric(outcome[, 11])
## hist(outcome[, 11])

## Finding the best hospital in a state.  Write a function called best that take two arguments:
## the 2-character abbreviated name of a state and an outcome name. The function reads the
## outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that
## has the best (i.e. lowest) 30-day mortality for the specified outcome in that state. The hospital
## name is the name provided in the Hospital.Name variable. The outcomes can be one of "heart attack",
## "heart failure", or "pneumonia". Hospitals that do not have data on a particular outcome should be
## excluded from the set of hospitals when deciding the rankings. If there is a tie for the best
## hospital for a given outcome, then the hospital names should be sorted in alphabetical order and
## he first hospital in that set should be chosen.

best <- function(state, outcome) {
  
  ## Load up out data.
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  ## The examples show lowercase strings passed to the function so we need to normalize to
  ## match the column names in the dataset.  Also translate " " to "."
  
  firstLetterUpper <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2), sep="", collapse=" ")
  }
  
  normalized.outcome <- gsub(" ", ".", firstLetterUpper(outcome))
  full.outcome <- paste("Hospital.30.Day.Death..Mortality..Rates.from.", normalized.outcome, sep="")
  if ( ! full.outcome %in% colnames(data) ) {
    stop(paste("Invalid outcome '", outcome, "'", sep=""))
  }
  
  states <- unique(data$State)
  if ( ! state %in% states ) {
    stop(paste("Invalid state '", state, "'", sep=""))
  }
  
  ## Return hospital name in that state with lowest 30-day death
  
  ## Find the desired outcome matching the specified state. Remove NAs and
  ## cast outcome values to numeric.
  outcome.state <- data[data$State == state, c('State', 'Hospital.Name', full.outcome)]
  outcome.state[,3] <- suppressWarnings(as.numeric(outcome.state[,3]))
  outcome.state <- outcome.state[complete.cases(outcome.state),]
  
  ## Find the minimum row of the outcome values (column 3)
  minimum <- apply(outcome.state[3], 2, min)
  
  ## Select the rows that match the minimum. If there are multiple matches, return the first
  ## when sorted alphabetically (otherwise only 1 element is in the list)
  ## This also works: outcome.state[outcome.state[3] == minimum, 2]
  sort(outcome.state[outcome.state[3] == minimum, 2])[1]
}
