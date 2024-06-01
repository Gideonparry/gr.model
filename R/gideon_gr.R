#' Helps create RTL simulations
#'
#'
#' @param snow_loads a simulated set of snow loads, using existing functions in rtsnow.
#' @param data dataset with exactly one row that contains the building and wind statistics necessary to run your model
#' @param tlm linear model that you have previously fit, and you can save this as .Rdata file, that you load when you run the script
#' @param cap Do not let the simulated value exceed the cap (in this case = 1) cap should also be bounded below by zero.
#' @param flat_line set value, for comparison purposes, the mean of the distribution cannot fall below this value.
#' @param se The standard error for the model
#' @param sheltered 1 if shelteded, 0 if not
#' @param Parapet 1 if roof contains parapet, 0 if not
#' @param logsize log of area of the roof
#' @param rooffalt 1 if roof is flat (0 degrees), 0 if not
#'
#'
#' @export

model_gr <- function(snow_loads, tdata, tlm, cap = 1, flat_line = 0.2,
                     metric_adjust = 1, se = 0.1625, sheltered = 0,
                      Parapet = 0, logsize = 5.913,
                     roofflat = 1) {

  # snow_loads - a simulated set of snow loads, using existing functions
  # in rtsnow.
  # data - dataset with exactly one row that contains the building and wind
  # statistics necessary to run your model.
  # tlm - linear model that you have previously fit, and you can save this
  # as .Rdata file, that you load when you run the script
  # cap - Do not let the simulated value exceed the cap (in this case = 1)
  # cap should also be bounded below by zero.
  # flat_line = set value, for comparison purposes, the mean of the distribution
  # cannot fall below this value.


  # 1 for roof being sheltered 0 othersies,
  tdata$sheltered <-
    ifelse("sheltered" %in% colnames(tdata),
           tdata$sheltered, sheltered)



  # 1 for a parapet, 0 for no parapet
  tdata$Parapet <-
    ifelse("Parapet" %in% colnames(tdata),
           tdata$Parapet, Parapet)


  # 1 for a flat roof, 0 for a not flat roof.
  tdata$roofflat <-
    ifelse("roofflat" %in% colnames(tdata),
           tdata$roofflat, roofflat)

  #  default is average log of roof size in data.
  tdata$logsize <-
    ifelse("logsize" %in% colnames(tdata),
           tdata$logsize, logsize)


  # Creating data frame of log ground loads
  sdf <- data.frame(logground = log(snow_loads))

  ## Joining to row of other variables
  tdata <- cbind(tdata, sdf, row.names = NULL)
  ## Predictions from variables
  tmeans <- predict(tlm, newdata = tdata)
  print(tmeans)

  tmeans <- pmax(tmeans, flat_line)

  final_sim <- rnorm(length(tmeans), tmeans, se)

  pmin(pmax(final_sim, 0)^2, cap)

}
