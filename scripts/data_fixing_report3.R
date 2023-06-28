############################# Fig 4 ######################################################
fig4b_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_g1.csv",
                     header = FALSE)
fig4b_g1 <- last_month_fix(fig4b_g1, 11, 4, 5, "1958-11-01")
fig4b_g1
Sys.sleep(60)
write.table(fig4b_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig4b_r1a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_r1a.csv",
                     header = FALSE)
fig4b_r1a <- last_month_fix(fig4b_r1a, 11, 4, 5, "1958-11-01")
fig4b_r1a
Sys.sleep(60)
write.table(fig4b_r1a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_r1a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig4b_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_r1b.csv",
                      header = FALSE)
fig4b_r1b <- last_month_fix(fig4b_r1b, 11, 4, 5, "1958-11-01")
fig4b_r1b
Sys.sleep(60)
write.table(fig4b_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig4b_r1c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_r1c.csv",
                      header = FALSE)
fig4b_r1c <- last_month_fix(fig4b_r1c, 11, 4, 5, "1958-11-01")
fig4b_r1c
Sys.sleep(60)
write.table(fig4b_r1c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig4b_r1c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



######################################### fig 6 ################################
library(lubridate)
fig6_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r1b.csv",
                      header = FALSE)
fig6_r1b$V1 <- as.Date(fig6_r1b$V1)
fig6_r1b$V1 <- fig6_r1b$V1 %m-% months(2)
fig6_r1b
Sys.sleep(60)
write.table(fig6_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig6_r1c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r1c.csv",
                     header = FALSE)
fig6_r1c$V1 <- as.Date(fig6_r1c$V1)
fig6_r1c$V1 <- fig6_r1c$V1 %m-% months(2)
fig6_r1c
Sys.sleep(60)
write.table(fig6_r1c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r1c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig6_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r2b.csv",
                     header = FALSE)
fig6_r2b$V1 <- as.Date(fig6_r2b$V1)
fig6_r2b$V1 <- fig6_r2b$V1 %m-% months(2)
fig6_r2b
Sys.sleep(60)
write.table(fig6_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig6_r2c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r2c.csv",
                     header = FALSE)
fig6_r2c$V1 <- as.Date(fig6_r2c$V1)
fig6_r2c$V1 <- fig6_r2c$V1 %m-% months(2)
fig6_r2c
Sys.sleep(60)
write.table(fig6_r2c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig6_r2c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

################################## Fig 24 #####################################
fig24_r1c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r1c.csv",
                     header = FALSE)
fig24_r1c$V1 <- as.Date(fig24_r1c$V1)
fig24_r1c$V1 <- fig24_r1c$V1 %m-% months(1)
fig24_r1c
Sys.sleep(60)
write.table(fig24_r1c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r1c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r2b.csv",
                      header = FALSE)
fig24_r2b$V1 <- as.Date(fig24_r2b$V1)
fig24_r2b$V1 <- fig24_r2b$V1 %m-% months(1)
fig24_r2b
Sys.sleep(60)
write.table(fig24_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig24_r2c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r2c.csv",
                      header = FALSE)
fig24_r2c$V1 <- as.Date(fig24_r2c$V1)
fig24_r2c$V1 <- fig24_r2c$V1 %m-% months(1)
fig24_r2c
Sys.sleep(60)
write.table(fig24_r2c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r2c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_r3b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r3b.csv",
                      header = FALSE)
fig24_r3b$V1 <- as.Date(fig24_r3b$V1)
fig24_r3b$V1 <- fig24_r3b$V1 %m-% months(1)
fig24_r3b
Sys.sleep(60)
write.table(fig24_r3b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r3b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_r3c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r3c.csv",
                      header = FALSE)
fig24_r3c$V1 <- as.Date(fig24_r3c$V1)
fig24_r3c$V1 <- fig24_r3c$V1 %m-% months(1)
fig24_r3c
Sys.sleep(60)
write.table(fig24_r3c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data\\fig24_r3c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")
