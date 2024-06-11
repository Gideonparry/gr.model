#' Retuns average temp from raster
#'
#' @param file the file to return avg_temp from
#' @param var1 1st wind variable to use
#'
#' @importFrom terra rast
#' @importFrom terra nlyr


temp_avg_grid <- function(file, var1 = "t2m") {
  ncrast <- terra::rast(file)

  avg_temp <- sum(ncrast) / terra::nlyr(ncrast)

  avg_temp
}
