library(lubridate)

################################### Progress report 2 #######################
fig2_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport2\\data\\fig2_r1b.csv", header = FALSE)
fig2_r1b <- date_dir_fix(fig2_r1b, 11, 5, 1957-11-01)

write.table(fig1_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport2\\data\\fig1_r1b.csv",
          row.names = FALSE, col.names = FALSE, sep=",")


