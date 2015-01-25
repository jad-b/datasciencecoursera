# R Programming - Assignment 3
source('util.R')

rankall <- function(outcome, num = 'best') {
  # Read in data, validate input, figure out our target column
  # Filter on Hospital name, state, and target column
  # For each state, ascending alphabetically
  #   Sort subset of hospitals in state by target column
  #   Append hospital and state to growing data frame
  outcomes <- read.csv('rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv',
                       colClasses='character',
                       na.strings=c('Not Available'))
  validateInput(state=NULL,
                outcome, validStates = outcomes$State)
  target.column <- buildColumnName(outcome)

  # Filter on hospital name and target disease
  rates <- outcomes[,c('State', 'Hospital.Name', target.column)]
  # Remove lines with NAs
#   rates[rates[,target.column] == 'Not Available',] <- NA
  rates <- rates[complete.cases(rates),]
  # Convert data to numeric
  rates[,target.column] <- as.numeric(rates[,target.column])

  # Perform ranking lookup
  rankLookup <- function(data, target='Hospital.Name'){
    target <- 'Hospital.Name'
    if (num == 'best')
      data[1, target]
    else if (num == 'worst')
      data[nrow(data), target]
    else
      data[num, target]
  }

  df <- data.frame(hospital = character(), state = character(), stringsAsFactors = F)
  # Filter on state
  state.unique <- sort(unique(rates$State))
  for (state in state.unique) {
    # Select for 'state'
    state.rates <- rates[with(rates, State == state),]
    # Order data by ranking, then Hospital Name
    state.ordered <- state.rates[order(state.rates[,target.column],
                                       state.rates$Hospital.Name,
                                       na.last = T),]
    # Append (Hospital.Name, State) to data frame
    df[nrow(df) + 1,] <- c(rankLookup(state.ordered), state)
  }
  # Assign States to row names
  row.names(df) <- state.unique
  df
}
