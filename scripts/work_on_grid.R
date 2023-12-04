early_months <-
  list.files(path = "D:/early_year", pattern = "\\.nc$", full.names = TRUE)

for (nc_file in early_months) {
  # Create the corresponding .rds file name
  rds_file <- sub("\\.nc$", ".rds", nc_file)

  grid_year <- winter_wind_grid(nc_file)

  # Call your function with the file names
  saveRDS(grid_year, rds_file)
}






late_months <-
  list.files(path = "D:/late_year", pattern = "\\.nc$", full.names = TRUE)


for (nc_file in late_months) {
  # Create the corresponding .rds file name
  rds_file <- sub("\\.nc$", ".rds", nc_file)

  grid_year <- winter_wind_grid(nc_file)

  # Call your function with the file names
  saveRDS(grid_year, rds_file)
}





test_months <-
  list.files(path = "D:/test", pattern = "\\.nc$", full.names = TRUE)

for (nc_file in test_months) {
  # Create the corresponding .rds file name
  rds_file <- sub("\\.nc$", ".rds", nc_file)

  grid_year <- winter_wind_grid(nc_file)

  # Call your function with the file names
  saveRDS(grid_year, rds_file)
}





