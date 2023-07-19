#' sets the code variable based on folder name.
#'
#' Takes the folder name and sets the code variable based on that
#'
#' @param path the path of the folder containing the subfolder
#' @param folder The names of the subfolder
#' @param colum The column number to make the update to



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


