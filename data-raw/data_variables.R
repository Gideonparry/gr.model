folder_path <- "C:/Users/bean_student/Documents/GraphData/all_data"
pattern <- "_[[:alpha:]]{3,}\\.csv"

# Get the list of CSV files in the folder
data_files <- list.files(path = folder_path, pattern = pattern, full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in data_files) {
  data_frames[[file]] <- read.csv(file)
}


for (i in seq_along(data_frames)){
  colnames(data_frames[[i]])[4] <- "city_code"
}
head(data_frames)
N <- names(data_frames)
for (i in seq_along(N)){
  write.table(data_frames[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}


####################### Adding city code to other data. ########################
library(stringr)

folder_path <- "C:/Users/bean_student/Documents/GraphData/all_data"
pattern <- "_[[:alpha:]]\\d[[:alpha:]]?\\.csv"

# Get the list of CSV files in the folder
data_files <- list.files(path = folder_path, pattern = pattern, full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in data_files) {
  data_frames[[file]] <- read.csv(file)
}


for (i in seq_along(data_frames)){
  data_frames[[i]][,6] <- data_frames[[i]][,4]
  data_frames[[i]][,4] <- str_sub(data_frames[[i]][,4], 1, -3)
  colnames(data_frames[[i]])[4] <- "city_code"
  colnames(data_frames[[i]])[6] <- "building_code"
}


head(data_frames)
N <- names(data_frames)
for (i in seq_along(N)){
  write.table(data_frames[[i]], file=N[i], row.names = FALSE, col.names = TRUE,
              sep=",")
}



######################## binding all data #####################################
library(dplyr)
folder_path <- "C:/Users/bean_student/Documents/GraphData/all_data"

pattern <- "*.csv"

# Get the list of CSV files in the folder
data_files <- list.files(path = folder_path, pattern = pattern, full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in data_files) {
  data_frames[[file]] <- read.csv(file)
}
complete_data <- bind_rows(data_frames)
write.table(complete_data,
            file = "C:\\Users\\bean_student\\Documents\\GraphData\\complete_data.csv",
            row.names = FALSE,
            col.names = TRUE,
            sep=",")

