# R Programming - Assignment 3

capwords <- function(s, strict = FALSE) {
  cap <- function(s) paste(toupper(substring(s, 1, 1)),
                           {s <- substring(s, 2); if(strict) tolower(s) else s},
                           sep = "", collapse = " ")
  sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
}

best <- function(state, outcome) {
  outcomes <- read.csv('outcome-of-care-measures.csv',
                       colClasses='character')

  validOutcomes <- c('heart attack', 'heart failure', 'pneumonia')
  if (!is.element(outcome, validOutcomes))
    stop('invalid outcome')
  if (!is.element(state, outcomes$State))
    stop('invalid state')

  mortal.prefix <- 'Hospital.30.Day.Death..Mortality..Rates.from.'
  # Build our column name from the requested outcome
  target.column <- paste0(mortal.prefix, gsub(' ', '.', capwords(outcome)))

  # Filter on state
  outcomes.by_state <- outcomes[outcomes$State == state,]
  # Filter on hospital name and target disease
  rates <- outcomes.by_state[,c('Hospital.Name', target.column)]
  # Remove lines with NAs
  rates <- rates[complete.cases(rates),]
  rates[,target.column] <- as.numeric(rates[,target.column])
  # Sort by mortality rate then alphabetically
  rates.ordered <- rates[order(rates[,target.column],
                               rates$Hospital.Name,
                               na.last = T),]
  rates.ordered[1, 'Hospital.Name']


}
