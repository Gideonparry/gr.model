path <- "C:\\Users\\bean_student\\Documents\\meta_compatable\\codes\\moved_data"
all_codes <- list.dirs(path, recursive = FALSE)
all_codes <- sub(".*moved_data/", "", all_codes)
all_codes
data_list <- list()

for(i in seq_along(all_codes)){
  data_list[[i]] <- code_var(path, all_codes[i], 4)
}
length(data_list)
data_list[1]

data_list[124]
######################## saving them ##########################################
for (i in data_list){
  N <- names(i)
  for (j in seq_along(i)) {
    # Get the dataset name (file name without extension)
    write.table(i[[j]], file=N[j], row.names = FALSE, col.names = TRUE, sep=",")
  }
}

###################### moving to new folder with all of them ##################
# Set your chosen path
chosen_path <- "C:/Users/bean_student/Documents/GraphData/all_data"

# Get a list of all files in subdirectories
file_list <- list.files("C:/Users/bean_student/Documents/meta_compatable/codes/moved_data",
                        recursive = TRUE, full.names = TRUE)

# Move files to the chosen path
for (file in file_list) {
  new_path <- file.path(chosen_path, basename(file))
  file.copy(file, new_path)
}

################### setting what the measurement is ############################
roof_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                       "_r", 3, "roof")
head(roof_list)
tail(roof_list)
N <- names(roof_list)
for (i in seq_along(N)){
  write.table(roof_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}


ground_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                       "_g", 3, "ground")
head(ground_list)
tail(ground_list)
N <- names(ground_list)
for (i in seq_along(N)){
  write.table(ground_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}


accume_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                         "accume", 3, "accume")
head(accume_list)
tail(accume_list)
N <- names(accume_list)
for (i in seq_along(N)){
  write.table(accume_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}

sun_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                         "sun", 3, "sun")
head(sun_list)
tail(sun_list)
N <- names(sun_list)
for (i in seq_along(N)){
  write.table(sun_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}

temp_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                         "temp", 3, "temp")
head(temp_list)
tail(temp_list)
N <- names(temp_list)
for (i in seq_along(N)){
  write.table(temp_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}

wind_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                         "wind", 3, "wind")
head(wind_list)
tail(wind_list)
N <- names(wind_list)
for (i in seq_along(N)){
  write.table(wind_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}




max_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                      "_r\\da", 5, "max")
head(max_list)
tail(max_list)
N <- names(max_list)
for (i in seq_along(N)){
  write.table(max_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}


avg_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                      "_r\\db", 5, "avg")
head(avg_list)
tail(avg_list)
N <- names(avg_list)
for (i in seq_along(N)){
  write.table(avg_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}

min_list <- other_var("C:\\Users\\bean_student\\Documents\\GraphData\\all_data",
                      "_r\\dc", 5, "min")
head(min_list)
tail(min_list)
N <- names(min_list)
for (i in seq_along(N)){
  write.table(min_list[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}
