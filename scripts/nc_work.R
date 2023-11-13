#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param file the file to return winter_wind from
#' @param var1 1st wind variable to use
#' @param var2 2nd wind variable to use
#'
#' @import ncdf4


winter_wind_grid <- function(file, var1 = "u10", var2 = "v10") {
  ncin <- ncdf4::nc_open(file)

  u10 <- ncdf4::ncvar_get(ncin,var1)
  v10 <- ncdf4::ncvar_get(ncin,var2)


  wind_speed <- sqrt(u10^2 + v10^2)

  winter_wind <- apply(wind_speed, c(1, 2), function(slice) {
    sum(slice > 4.4704) / length(slice)
  })

  winter_wind
}

