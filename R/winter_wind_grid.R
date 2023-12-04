#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param file the file to return winter_wind from
#' @param var1 1st wind variable to use
#' @param var2 2nd wind variable to use
#'
#' @import terra


winter_wind_grid <- function(file, var1 = "u10", var2 = "v10") {
  ncrast <- terra::rast(file)

  u10 <- ncrast[var1]
  v10 <- ncrast[var2]


  wind_speed <- sqrt(u10^2 + v10^2)

  winter_wind <- sum(wind_speed > 4.4704) / nlyr(wind_speed)

  winter_wind
}


