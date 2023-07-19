library(stringr)
all_codes <- list.dirs("C:\Users\bean_student\Documents\meta_compatable\codes\moved_data",
                       recursive = FALSE)
all_codes <- str_sub(all_codes,-6,-1)
all_codes
data_list <- list()

for(i in seq_along(all_codes)){
  data_list[[i]] <- code_var(path, all_codes[i])
}
data_list[1]


######################## saving them ##########################################
for (i in data_list){
  N <- names(i)
  for (j in seq_along(i)) {
    # Get the dataset name (file name without extension)
    write.table(i[[j]], file=N[j], row.names = FALSE, col.names = TRUE, sep=",")
  }
}
