early_months <-
  list.files(path = "D:/early_year", pattern = "\\.nc$", full.names = TRUE)

for (nc_file in early_months) {
  # Create the corresponding .rds file name
  rds_file <- sub("\\.nc$", ".rds", nc_file)

  grid_year <- wind_avg_grid(nc_file)

  # Call your function with the file names
  saveRDS(grid_year, rds_file)
}






late_months <-
  list.files(path = "D:/late_year", pattern = "\\.nc$", full.names = TRUE)


for (nc_file in late_months) {
  # Create the corresponding .rds file name
  rds_file <- sub("\\.nc$", ".rds", nc_file)

  grid_year <- wind_avg_grid(nc_file)

  # Call your function with the file names
  saveRDS(grid_year, rds_file)
}





test_months <-
  list.files(path = "D:/test", pattern = "\\.nc$", full.names = TRUE)

for (nc_file in test_months) {
  # Create the corresponding .rds file name
  rds_file <- sub("\\.nc$", ".rds", nc_file)

  grid_year <- wind_avg_grid(nc_file)

  # Call your function with the file names
  saveRDS(grid_year, rds_file)
}

test <- terra::unwrap(readRDS("D:/test/small_subset.rds"))
test



early_grids <-
  list.files(path = "D:/early_year", pattern = "\\.rds$", full.names = TRUE)

early_list <- lapply(early_grids, function(file) terra::unwrap(readRDS(file)))


late_grids <-
  list.files(path = "D:/late_year", pattern = "\\.rds$", full.names = TRUE)

late_list <- lapply(late_grids, function(file) terra::unwrap(readRDS(file)))


early_all <- (early_list[[1]] + early_list[[2]] + early_list[[3]] +
                early_list[[4]] + early_list[[5]] + early_list[[6]] +
                early_list[[7]] + early_list[[8]] + early_list[[9]] +
                early_list[[10]] + early_list[[11]] + early_list[[12]]
              + early_list[[13]] + early_list[[14]] + early_list[[15]] +
                early_list[[16]] + early_list[[17]] + early_list[[18]] +
                early_list[[19]] + early_list[[20]] + early_list[[21]] +
                early_list[[22]] + early_list[[23]] + early_list[[24]] +
                early_list[[25]] + early_list[[26]] + early_list[[27]] +
                early_list[[28]] + early_list[[29]] + early_list[[30]])/30

late_all <- (late_list[[1]] + late_list[[2]] + late_list[[3]] +
               late_list[[4]] + late_list[[5]] + late_list[[6]] +
               late_list[[7]] + late_list[[8]] + late_list[[9]] +
               late_list[[10]] + late_list[[11]] + late_list[[12]]
             + late_list[[13]] + late_list[[14]] + late_list[[15]] +
               late_list[[16]] + late_list[[17]] + late_list[[18]] +
               late_list[[19]] + late_list[[20]] + late_list[[21]] +
               late_list[[22]] + late_list[[23]] + late_list[[24]] +
               late_list[[25]] + late_list[[26]] + late_list[[27]] +
               late_list[[28]] + late_list[[29]] + late_list[[30]])/30

entire_map <- (early_all*4 + late_all*3)/7
entire_map

saveRDS(entire_map, "D:/wind_avg_map.rds")

point_of_interest <-
  terra::vect(matrix(c(-100, 29), ncol = 2), crs = crs(entire_map))

values_at_point <- terra::extract(entire_map, point_of_interest)
values_at_point
values_at_point[[2]]


terra::extract(entire_map, terra::vect(matrix(c(-100, 29), ncol = 2),
                                       crs = crs(entire_map)))[[2]]
