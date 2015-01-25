# R Programming - Assignment 3

capwords <- function(s, strict = FALSE) {
  cap <- function(s) paste(toupper(substring(s, 1, 1)),
    {s <- substring(s, 2); if(strict) tolower(s) else s},
     sep = "", collapse = " ")

  sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
}

validateInput <- function(state, outcome, validStates,
                          validOutcomes = c('heart attack', 'heart failure', 'pneumonia')) {
  if (!is.element(outcome, validOutcomes))
    stop('invalid outcome')
  if (!is.null(state) && !is.element(state, validStates))
    stop('invalid state')
}

buildColumnName <- function(outcome) {
  mortal.prefix <- 'Hospital.30.Day.Death..Mortality..Rates.from.'
  # Build our column name from the requested outcome
  target.column <- paste0(mortal.prefix, gsub(' ', '.', capwords(outcome)))
}
