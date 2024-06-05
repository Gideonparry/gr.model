#' Adds a header row
#'
#' This functions adds a header row to the date and names the column.
#'
#' @param folder_path the path of the folder being edited
#' @param existing_colums The names of the existing column
#' @param new_columns The names of the new columns
#' @importFrom utils read.csv
#'
add_header <- function(folder_path, existing_colums = c("date", "value"),
                       new_columns = c("measurement", "building_code", "mma")) {
  # Get the list of CSV files in the folder
  csv_files <- list.files(
    path = folder_path, pattern = "*.csv",
    full.names = TRUE
  )

  # Create an empty list to store the data frames
  data_frames <- list()

  # Loop through each CSV file and read it as a data frame
  for (file in csv_files) {
    data_frames[[file]] <- read.csv(file, header = FALSE)
  }


  data_frames <- lapply(data_frames, function(df) {
    colnames(df) <- existing_colums
    return(df)
  })


  data_frames <- lapply(data_frames, function(df) {
    df[, new_columns] <- NA
    return(df)
  })



  data_frames
}
