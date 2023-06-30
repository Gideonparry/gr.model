########################## fig 12 ############################################
fig12a_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g1.csv",
                     header = FALSE)
fig12a_g1$V1 <- as.Date(fig12a_g1$V1)
fig12a_g1$V1 <- fig12a_g1$V1 %m+% months(1)
fig12a_g1
Sys.sleep(60)
write.table(fig12a_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g2.csv",
                      header = FALSE)
fig12a_g2$V1 <- as.Date(fig12a_g2$V1)
fig12a_g2$V1 <- fig12a_g2$V1 %m+% months(1)
fig12a_g2
Sys.sleep(60)
write.table(fig12a_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_g3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g3.csv",
                      header = FALSE)
fig12a_g3$V1 <- as.Date(fig12a_g3$V1)
fig12a_g3$V1 <- fig12a_g3$V1 %m+% months(1)
fig12a_g3
Sys.sleep(60)
write.table(fig12a_g3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g1.csv",
                      header = FALSE)
fig12a_g1$V1 <- as.Date(fig12a_g1$V1)
fig12a_g1$V1 <- fig12a_g1$V1 %m+% months(1)
fig12a_g1
Sys.sleep(60)
write.table(fig12a_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r1.csv",
                      header = FALSE)
fig12a_r1$V1 <- as.Date(fig12a_r1$V1)
fig12a_r1$V1 <- fig12a_r1$V1 %m+% months(1)
fig12a_r1
Sys.sleep(60)
write.table(fig12a_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r2.csv",
                      header = FALSE)
fig12a_r2$V1 <- as.Date(fig12a_r2$V1)
fig12a_r2$V1 <- fig12a_r2$V1 %m+% months(1)
fig12a_r2
Sys.sleep(60)
write.table(fig12a_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_r3a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r3a.csv",
                      header = FALSE)
fig12a_r3a$V1 <- as.Date(fig12a_r3a$V1)
fig12a_r3a$V1 <- fig12a_r3a$V1 %m+% months(1)
fig12a_r3a
Sys.sleep(60)
write.table(fig12a_r3a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r3a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12a_r3b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r3b.csv",
                      header = FALSE)
fig12a_r3b$V1 <- as.Date(fig12a_r3b$V1)
fig12a_r3b$V1 <- fig12a_r3b$V1 %m+% months(1)
fig12a_r3b
Sys.sleep(60)
write.table(fig12a_r3b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig12a_r3b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

######################################## fig 18 ####################################
fig18_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig18_g1.csv",
                    header = FALSE)
fig18_g1$V2 <- fig18_g1$V2 + 40
fig18_g1$V2 <- fig18_g1$V2 * 2/3
fig18_g1
Sys.sleep(60)
write.table(fig18_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig18_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig18_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig18_r1.csv",
                     header = FALSE)
fig18_r1$V2 <- fig18_r1$V2 + 40
fig18_r1$V2 <- fig18_r1$V2 * 2/3
fig18_r1
Sys.sleep(60)
write.table(fig18_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig18_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

############################################# fig 20 ############################
library(lubridate)
fig24_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_accume.csv",
                       header = FALSE)
fig24_accume$V1 <- as.Date(fig24_accume$V1)
fig24_accume$V1 <- fig24_accume$V1 %m-% months(1)
fig24_accume
Sys.sleep(60)
write.table(fig24_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig24_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_g1.csv",
                         header = FALSE)
fig24_g1$V1 <- as.Date(fig24_g1$V1)
fig24_g1$V1 <- fig24_g1$V1 %m-% months(1)
fig24_g1
Sys.sleep(60)
write.table(fig24_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig24_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_g2.csv",
                         header = FALSE)
fig24_g2$V1 <- as.Date(fig24_g2$V1)
fig24_g2$V1 <- fig24_g2$V1 %m-% months(1)
fig24_g2
Sys.sleep(60)
write.table(fig24_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_r1a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r1a.csv",
                         header = FALSE)
fig24_r1a$V1 <- as.Date(fig24_r1a$V1)
fig24_r1a$V1 <- fig24_r1a$V1 %m-% months(1)
fig24_r1a
Sys.sleep(60)
write.table(fig24_r1a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r1a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r1b.csv",
                         header = FALSE)
fig24_r1b$V1 <- as.Date(fig24_r1b$V1)
fig24_r1b$V1 <- fig24_r1b$V1 %m-% months(1)
fig24_r1b
Sys.sleep(60)
write.table(fig24_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



fig24_r2a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r2a.csv",
                         header = FALSE)
fig24_r2a$V1 <- as.Date(fig24_r2a$V1)
fig24_r2a$V1 <- fig24_r2a$V1 %m-% months(1)
fig24_r2a
Sys.sleep(60)
write.table(fig24_r2a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r2a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r2b.csv",
                         header = FALSE)
fig24_r2b$V1 <- as.Date(fig24_r2b$V1)
fig24_r2b$V1 <- fig24_r2b$V1 %m-% months(1)
fig24_r2b
Sys.sleep(60)
write.table(fig24_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_temp.csv",
                         header = FALSE)
fig24_temp$V1 <- as.Date(fig24_temp$V1)
fig24_temp$V1 <- fig24_temp$V1 %m-% months(1)
fig24_temp
Sys.sleep(60)
write.table(fig24_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig24_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_wind.csv",
                         header = FALSE)
fig24_wind$V1 <- as.Date(fig24_wind$V1)
fig24_wind$V1 <- fig24_wind$V1 %m-% months(1)
fig24_wind
Sys.sleep(60)
write.table(fig24_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data\\fig24_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")
