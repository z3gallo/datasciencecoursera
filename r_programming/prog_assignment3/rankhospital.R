
## Write a function called rankhospital that takes three arguments: the 2-character abbreviated name
## of a state (state), an outcome (outcome), and the ranking of a hospital in that state for that
## outcome (num).  The num argument can take values \best", \worst", or an integer indicating the
## ranking (smaller numbers are better). If the number given by num is larger than the number of
## hospitals in that state, then the function should return NA. ties should be broken by using the
## hospital name.

rankhospital <- function(state, outcome, num = "best") {
  
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
  
  ## Map "best" to the top ranked hospital (lowest mortality rate) and "worst" to the bottom ranked
  ## hospital (highest mortality rate)
  
  if ( "best" == num ) {
    num <- 1
  } else if ( "worst" == num ) {
    num = nrow(outcome.state)    
  }

  ## Sort the data and return the hospital with the desired rank.  Break ties using the hospital
  ## name
  outcome.state[order(outcome.state[3], outcome.state[2]),][num, 2]
  
}
