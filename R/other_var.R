#' sets variables based on file name
#'
#' takes files based on pattern and saves all rows of a variable
#'
#' @param folder_path The folder path to get to the files
#' @param pattern The pattern for the files chosen
#' @param column The column number to make the update to
#' @param varval The value to give the variables
#' @importFrom utils read.csv


other_var <- function(folder_path, pattern, column, varval) {
  # Get the list of CSV files in the folder
  roof_files <- list.files(path = folder_path, pattern = pattern,
                           full.names = TRUE)

  # Create an empty list to store the data frames
  data_frames <- list()

  # Loop through each CSV file and read it as a data frame
  for (file in roof_files) {
    data_frames[[file]] <- read.csv(file)
  }


  for (i in seq_along(data_frames)) {
    data_frames[[i]][, column] <- varval
  }
  data_frames
}
