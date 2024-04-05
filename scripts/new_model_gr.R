library(tidyverse)

load("data-raw/eramod.RData")
usa_data <- read.csv("data-raw/usa_data.csv")
usa_data <- usa_data %>% rename(est_wind = w2)

set.seed(1234)
tdf <- usa_data[232,]

loads <- rtsnow::simulate_loads(

  n = 10,
  loc = tdf$LOCATION,
  scl = tdf$SCALE,
  shp = tdf$SHAPE,
  pr_zero = tdf$PROP_ZERO,
  years = 50,
  gr = NULL

)



# psf to kpa



# 1 psf equals 0.047880258888889 kpa.




# start of a function. get it to work for one row of the data with the simulate loads.

model_gr <- function(snow_loads, tdata, tlm, cap = 1, flat_line = 0.2,
                     metric_adjust = 1, se = 0.1578, sheltered = 0,
                     exposed = 0, Parapet = 0, Heated = 1, Insulated = 1,
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


  # 1 for roof being exposed 0 otherwise
  tdata$exposed <-
    ifelse("exposed" %in% colnames(tdata),
           tdata$exposed, exposed)

  # 1 for a parapet, 0 for no parapet
  tdata$Parapet <-
    ifelse("Parapet" %in% colnames(tdata),
           tdata$Parapet, Parapet)

  # 1 for heated 0 for unheated
  tdata$Heated <-
    ifelse("Heated" %in% colnames(tdata),
           tdata$Heated, Heated)

  # 1 for insulated, 0 for not insulated
  tdata$Insulated <-
    ifelse("Insulated" %in% colnames(tdata),
           tdata$Insulated, Insulated)

  # 1 for a flat roof, 0 for a not flat roof.
  tdata$roofflat <-
    ifelse("roofflat" %in% colnames(tdata),
           tdata$roofflat, 1)


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

preds <- model_gr(loads, tdf, era_both)
preds
