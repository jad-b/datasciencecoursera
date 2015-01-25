# R Programming - Assignment 3
source('util.R')

rankhospital <- function(state, outcome, num = 'best') {
  outcomes <- read.csv('rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv',
                       colClasses='character')
  validateInput(state, outcome, validStates = outcomes$State)
  target.column <- buildColumnName(outcome)

  # Filter on state
  outcomes.by_state <- outcomes[outcomes$State == state,]
  # Filter on hospital name and target disease
  rates <- outcomes.by_state[,c('Hospital.Name', target.column)]
  # Remove lines with NAs
  rates[rates[,target.column] == 'Not Available',] <- NA
  rates <- rates[complete.cases(rates),]
  # Convert data to numeric
  rates[,target.column] <- as.numeric(rates[,target.column])
  # Sort by mortality rate, then alphabetically
  rates.ordered <- rates[order(rates[,target.column],
                               rates$Hospital.Name,
                               na.last = T),]

  hname <- 'Hospital.Name'
  if (num == 'best')
    rates.ordered[1, hname]
  else if (num == 'worst')
    rates.ordered[nrow(rates.ordered), hname]
  else
    rates.ordered[num, hname]
}
