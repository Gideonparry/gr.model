## opening temp folder to work on all left with the same issue
# Set the directory path to the folder containing the CSV files
folder_path <- "C:\\Users\\bean_student\\Documents\\temp11\\data\\10-04"

# Get the list of CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in csv_files) {
  data_frames[[file]] <- read.csv(file, header = FALSE)
}

length(data_frames)
names(data_frames)
data_frames[[36]]

data_frames <- lapply(data_frames, date_dir_fix, "1966-10-01", "1967-04-30")
data_frames[[36]]
data_frames
N <- names(data_frames)
for (i in seq_along(N)) write.table(data_frames[[i]], file=N[i], row.names = FALSE, col.names = FALSE, sep=",")



## some were oct-apr, others nov-may, seperated them out to do twice
folder_path <- "C:\\Users\\bean_student\\Documents\\temp11\\data\\11-05"

# Get the list of CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in csv_files) {
  data_frames[[file]] <- read.csv(file, header = FALSE)
}

length(data_frames)
names(data_frames)

data_frames <- lapply(data_frames, date_dir_fix, "1966-11-01", "1967-05-30")

data_frames
N <- names(data_frames)
for (i in seq_along(N)) write.table(data_frames[[i]], file=N[i], row.names = FALSE, col.names = FALSE, sep=",")



## Fixing wrong start date on later runs.
folder_path <- "C:\\Users\\bean_student\\Documents\\temp11\\data\\wrongstart"

# Get the list of CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in csv_files) {
  data_frames[[file]] <- read.csv(file, header = FALSE)
}

length(data_frames)
names(data_frames)
data_frames <- lapply(data_frames, date_fix, "1967-05-31", "1966-10-01",
                      "1966-11-10")

data_frames
N <- names(data_frames)
for (i in seq_along(N)) write.table(data_frames[[i]], file=N[i], row.names = FALSE, col.names = FALSE, sep=",")
