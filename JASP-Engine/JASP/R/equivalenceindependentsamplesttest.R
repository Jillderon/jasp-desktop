#
# Copyright (C) 2013-2018 University of Amsterdam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

EquivalenceIndependentSamplesTTest <- function(jaspResults, dataset = NULL, options)
{
    # Set title:
    jaspResults$title <- "Equivalence Independent Samples T-Test"

    # Check if results can be computed:
    status <- .equivalenceSetStatus(options)

    # Read dataset:
    dataset <- .equivalenceReadData(dataset, options, status)

    # Error checking:
    .equivalenceCheckErrors(dataset, options, status)

    # Compute (a list of) results from which tables and plots can be created
    equivalenceResults <- .equivalenceComputeResults(dataset, jaspResults, options, status)
    status <- equivalenceResults$status
  
    # Output tables and plots based on results:
    .equivalenceTableTOST(jaspResults, options, equivalenceResults)
    .equivalenceTableEQB(jaspResults, options, equivalenceResults)
    .equivalenceTableDESC(jaspResults, options, equivalenceResults)
    .equivalencePlot(jaspResults, options, equivalenceResults)
}

.equivalenceSetStatus <- function(options) {
  status <- list(
    ready = TRUE,
    error = FALSE,
    errorMessage <- ""
  )
  
  browser()
  if (length(options$variables) == 0 || length(options$groupingVariable) == 0) {
    status$ready <- FALSE
  }

  return(status)
}

.equivalenceReadData <- function(dataset, options, status) {
  if (!is.null(dataset)) return(dataset)
  if (!status$ready) return()

  dataset <- readDataSetToEnd(columns.as.numeric = options$variables, columns.as.factor = options$groupingVariable)

  return(dataset)

}

.equivalenceCheckErrors <- function(dataset, options, status) {
    if (!status$ready) return()

    # TO DO: check for specific errors

    return()
}

# Results functions ----
.equivalenceComputeResults <- function(dataset, jaspResults, options, status) {
    if (!is.null(jaspResults[["stateEquivalenceResults"]]) && !is.null(jaspResults[["stateEquivalenceResults"]]$object))
        return(jaspResults[["stateEquivalenceResults"]]$object)

    # Dependent upon:
    jaspResults[["stateEquivalenceResults"]] <- createJaspState()
    jaspResults[["stateEquivalenceResults"]]$dependOnOptions(c("variables", "groupingVariable", "students",
                                                                "welchs", "lowerbound", "upperbound", "boundstype", "alpha"))
    browser()
    if (!status$ready)
        return(list(model = NULL, status = status))
  
    browser()
    equivalenceResults <- TOSTER::dataTOSTtwo(data = dataset,                                                  # data
                                           deps = .v(options$variables),                                    # name dependent variables in data
                                           group = .v(options$groupingVariable),                            # grouping variable in data
                                           var_equal = ifelse(options$"students", TRUE, FALSE),             # assume equal variances - if FALSE, Welch's test, if TRUE student's test
                                           low_eqbound = options$lowerbound,                                # the lower equivalence bounds
                                           high_eqbound = options$upperbound,                               # the upper equivalence bounds
                                           eqbound_type = ifelse(options$boundstype == "Raw", "raw", "d"),  # bounds type is raw or cohen's d
                                           alpha = options$alpha,                                           # default = 0.05
                                           desc = TRUE,                                                     # set TRUE for descriptive statistics
                                           plots = TRUE)                                                    # set TRUE for plots

    if (isTryError(equivalenceResults)) {
        status$error <- TRUE
        status$errorMessage <- .extractErrorMessage(equivalenceResults)
    }
    
    equivalenceResultsList <- list(
      equivalenceResults = equivalenceResults,
      status = status
    )
    
    jaspResults[["stateEquivalenceResults"]]$object <- equivalenceResultsList
    
    return(equivalenceResultsList)
    
}

.equivalenceTableTOST <- function(jaspResults, options, equivalenceResults) {
  # TO DO
  equivalenceResults$tost$asDF                   # a table
  
  return()
}

.equivalenceTableEQB <- function(jaspResults, options, equivalenceResults) {
  # TO DO
  #equivalenceTest$eqb$asDF                    # a table
  
  return()
}

.equivalenceTableDESC <- function(jaspResults, options, equivalenceResults) {
  # TO DO 
  # equivalenceTest$desc$asDF                   # a table
  return()
}

.equivalencePlot <- function(jaspResults, options, equivalenceResults) {
  # TO DO plot
  # equivalenceTest$plots                       # an array of images
  
  return()
}
