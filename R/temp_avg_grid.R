#' Retuns average temp from raster
#'
#' @param file the file to return avg_temp from
#' @param var1 1st wind variable to use
#'
#' @import terra


temp_avg_grid <- function(file, var1 = "tm2") {
  ncrast <- terra::rast(file)

  tm2 <- ncrast[var1]

  avg_temp <- sum(tm2) / nlyr(tm2)

  avg_temp
}
