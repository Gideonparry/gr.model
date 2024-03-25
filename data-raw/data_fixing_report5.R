########################## fig 3 ###########################################
fig3_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig3_g2.csv",
                    header = FALSE)
fig3_g2$V2 <- fig3_g2$V2 * 3/2
fig3_g2
Sys.sleep(60)
write.table(fig3_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig3_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



################################## fig 18 #######################################
library(lubridate)
fig18_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_accume.csv",
                      header = FALSE)
fig18_accume$V1 <- as.Date(fig18_accume$V1)
fig18_accume$V1 <- fig18_accume$V1 %m-% months(1)
fig18_accume
Sys.sleep(60)
write.table(fig18_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig18_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_g1.csv",
                     header = FALSE)
fig18_g1$V1 <- as.Date(fig18_g1$V1)
fig18_g1$V1 <- fig18_g1$V1 %m-% months(1)
fig18_g1
Sys.sleep(60)
write.table(fig18_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig18_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_g2.csv",
                      header = FALSE)
fig18_g2$V1 <- as.Date(fig18_g2$V1)
fig18_g2$V1 <- fig18_g2$V1 %m-% months(1)
fig18_g2
Sys.sleep(60)
write.table(fig18_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig18_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_r1.csv",
                     header = FALSE)
fig18_r1$V1 <- as.Date(fig18_r1$V1)
fig18_r1$V1 <- fig18_r1$V1 %m-% months(1)
fig18_r1
Sys.sleep(60)
write.table(fig18_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig18_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_r2.csv",
                     header = FALSE)
fig18_r2$V1 <- as.Date(fig18_r2$V1)
fig18_r2$V1 <- fig18_r2$V1 %m-% months(1)
fig18_r2
Sys.sleep(60)
write.table(fig18_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig18_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_temp.csv",
                     header = FALSE)
fig18_temp$V1 <- as.Date(fig18_temp$V1)
fig18_temp$V1 <- fig18_temp$V1 %m-% months(1)
fig18_temp
Sys.sleep(60)
write.table(fig18_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig18_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_wind.csv",
                     header = FALSE)
fig18_wind$V1 <- as.Date(fig18_wind$V1)
fig18_wind$V1 <- fig18_wind$V1 %m-% months(1)
fig18_wind
Sys.sleep(60)
write.table(fig18_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig18_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

################################# fig 19 ######################################
fig19_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_accume.csv",
                         header = FALSE)
fig19_accume$V1 <- as.Date(fig19_accume$V1)
fig19_accume$V1 <- fig19_accume$V1 %m-% months(1)
fig19_accume
Sys.sleep(60)
write.table(fig19_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig19_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g1.csv",
                     header = FALSE)
fig19_g1$V1 <- as.Date(fig19_g1$V1)
fig19_g1$V1 <- fig19_g1$V1 %m-% months(1)
fig19_g1
Sys.sleep(60)
write.table(fig19_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig19_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g2.csv",
                     header = FALSE)
fig19_g2$V1 <- as.Date(fig19_g2$V1)
fig19_g2$V1 <- fig19_g2$V1 %m-% months(1)
fig19_g2
Sys.sleep(60)
write.table(fig19_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig19_g3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g3.csv",
                     header = FALSE)
fig19_g3$V1 <- as.Date(fig19_g3$V1)
fig19_g3$V1 <- fig19_g3$V1 %m-% months(1)
fig19_g3
Sys.sleep(60)
write.table(fig19_g3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig19_g4 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g4.csv",
                     header = FALSE)
fig19_g4$V1 <- as.Date(fig19_g4$V1)
fig19_g4$V1 <- fig19_g4$V1 %m-% months(1)
fig19_g4
Sys.sleep(60)
write.table(fig19_g4,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_g4.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig19_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r1.csv",
                     header = FALSE)
fig19_r1$V1 <- as.Date(fig19_r1$V1)
fig19_r1$V1 <- fig19_r1$V1 %m-% months(1)
fig19_r1
Sys.sleep(60)
write.table(fig19_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig19_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r2.csv",
                     header = FALSE)
fig19_r2$V1 <- as.Date(fig19_r2$V1)
fig19_r2$V1 <- fig19_r2$V1 %m-% months(1)
fig19_r2
Sys.sleep(60)
write.table(fig19_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig19_r3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r3.csv",
                     header = FALSE)
fig19_r3$V1 <- as.Date(fig19_r3$V1)
fig19_r3$V1 <- fig19_r3$V1 %m-% months(1)
fig19_r3
Sys.sleep(60)
write.table(fig19_r3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig19_r4 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r4.csv",
                     header = FALSE)
fig19_r4$V1 <- as.Date(fig19_r4$V1)
fig19_r4$V1 <- fig19_r4$V1 %m-% months(1)
fig19_r4
Sys.sleep(60)
write.table(fig19_r4,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_r4.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig19_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_temp.csv",
                       header = FALSE)
fig19_temp$V1 <- as.Date(fig19_temp$V1)
fig19_temp$V1 <- fig19_temp$V1 %m-% months(1)
fig19_temp
Sys.sleep(60)
write.table(fig19_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig19_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_wind.csv",
                       header = FALSE)
fig19_wind$V1 <- as.Date(fig19_wind$V1)
fig19_wind$V1 <- fig19_wind$V1 %m-% months(1)
fig19_wind
Sys.sleep(60)
write.table(fig19_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data\\fig19_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


