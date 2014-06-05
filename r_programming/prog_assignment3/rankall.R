
## Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital
## ranking (num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data
## frame containing the hospital in each state that has the ranking specified in num.

rankall <- function(outcome, num = "best") {
  
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
  
  ## Sort the data and return the hospital with the desired rank.  Break ties using the hospital
  ## name
  
  ## Extract the list of unique states from the data frame
  ## Also works: levels(as.factor(outcome.subset$State))
  
  states <- data$State[ ! duplicated(data$State) ]
  hospital = vector()
  
  ## For each state, extract the desired outcome, convert to numeric, remove NAs, and extract
  ## the hospital with the desired rank.  Add that hospital to the list for the data frame.
  
  for ( state in states) {
    outcome.subset <- data[data$State == state, c('Hospital.Name', full.outcome)]
    outcome.subset[,2] <- suppressWarnings(as.numeric(outcome.subset[,2]))
    outcome.subset <- outcome.subset[complete.cases(outcome.subset),]
    
    ## Map "best" to the top ranked hospital (lowest mortality rate) and "worst" to the bottom ranked
    ## hospital (highest mortality rate)
    
    state.num <- num
    
    if ( "best" == num ) {
      state.num <- 1
    } else if ( "worst" == num ) {
      state.num = nrow(outcome.subset)  
    }
    
    hospital <- append(hospital, outcome.subset[order(outcome.subset[2], outcome.subset[1]),][state.num, 1])
  }
  
  data.frame(hospital = hospital, state = states)
}
