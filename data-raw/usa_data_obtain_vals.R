usa_data <- read.csv("D:/rt_loads_final_09012020_3_alt.csv")

usa_data$LATITUDE <- round(usa_data$LATITUDE * 4) / 4
usa_data$LONGITUDE <- round(usa_data$LONGITUDE * 4) / 4


whole_map <-readRDS("D:/whole_map.rds")
whole_map <- terra::unwrap(whole_map)

usa_data$w2 <- terra::extract(whole_map,
                                    terra::vect(matrix(c(usa_data$LONGITUDE,
                                                         usa_data$LATITUDE),
                                                       ncol = 2),
                                              crs = terra::crs(whole_map)))[[2]]

wind_avg_map <-readRDS("D:/wind_avg_map.rds")
wind_avg_map <- terra::unwrap(wind_avg_map)

usa_data$est_wind_avg <- terra::extract(wind_avg_map,
                                        terra::vect(matrix(c(usa_data$LONGITUDE,
                                                             usa_data$LATITUDE),
                                                           ncol = 2),
                                          crs = terra::crs(wind_avg_map)))[[2]]

temp_avg_map <-readRDS("D:/temp_avg_map.rds")
temp_avg_map <- terra::unwrap(temp_avg_map)

usa_data$est_temp_avg <- terra::extract(temp_avg_map,
                                        terra::vect(matrix(c(usa_data$LONGITUDE,
                                                             usa_data$LATITUDE),
                                                           ncol = 2),
                                          crs = terra::crs(temp_avg_map)))[[2]]

usa_data$est_temp_avg <- usa_data$est_temp_avg - 273.15
View(usa_data)
