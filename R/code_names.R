#' sets the code variable based on folder name.
#'
#' Takes the folder name and sets the code variable based on that
#'
#' @param path the path of the folder containing the subfolder
#' @param folder The names of the subfolder
#' @param colums The column number to make the update to



code_var <- function(path, folder, column){
  # Set the directory path to the folder containing the CSV files
  folder_path <- paste(path, "\\", folder, sep = "")

  # Get the list of CSV files in the folder
  csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

  # Create an empty list to store the data frames
  data_frames <- list()

  # Loop through each CSV file and read it as a data frame
  for (file in csv_files) {
    data_frames[[file]] <- read.csv(file)
  }



  for (i in seq_along(data_frames)){
    data_frames[[i]][,column] <- folder
  }

  data_frames
}

library(stringr)
all_codes <- list.dirs("D:\\moved_data-selected", recursive = FALSE)
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


############################### roofs #############################################
folder_path <- "D:\\moved_data-selected\\wnmb04"
pattern = "_r"
column = 3
varval = "roof"


other_var <- function(folder_path, pattern, column, varval){
  # Get the list of CSV files in the folder
  roof_files <- list.files(path = folder_path, pattern = pattern, full.names = TRUE)

  # Create an empty list to store the data frames
  data_frames <- list()

  # Loop through each CSV file and read it as a data frame
  for (file in roof_files) {
    data_frames[[file]] <- read.csv(file)
  }
  head(data_frames)

  for (i in seq_along(data_frames)){
    data_frames[[i]][,column] <- varval
  }
 data_frames
}

