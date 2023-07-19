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
