############################# Fig 4 ############################################
fig4_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig4_g1.csv",
                      header = FALSE)
fig4_g1$V2 <- fig4_g1$V2 * 6
fig4_g1
Sys.sleep(60)
write.table(fig4_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig4_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig4_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig4_r1.csv",
                    header = FALSE)
fig4_r1$V2 <- fig4_r1$V2 * 6
fig4_r1
Sys.sleep(60)
write.table(fig4_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig4_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


#################################### fig 12 #####################################
library(lubridate)
fig12_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig12_r1b.csv",
                      header = FALSE)
fig12_r1b$V1 <- as.Date(fig12_r1b$V1)
fig12_r1b$V1 <- fig12_r1b$V1 %m-% months(1)
fig12_r1b
Sys.sleep(60)
write.table(fig12_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig12_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig12_r1c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig12_r1c.csv",
                      header = FALSE)
fig12_r1c$V1 <- as.Date(fig12_r1c$V1)
fig12_r1c$V1 <- fig12_r1c$V1 %m-% months(1)
fig12_r1c
Sys.sleep(60)
write.table(fig12_r1c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig12_r1c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


######################### fig 15 #################################################
fig15_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r1b.csv",
                      header = FALSE)
fig15_r1b$V1 <- as.Date(fig15_r1b$V1)
fig15_r1b$V1 <- fig15_r1b$V1 %m+% months(1)
fig15_r1b
Sys.sleep(60)
write.table(fig15_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig15_r1c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r1c.csv",
                      header = FALSE)
fig15_r1c$V1 <- as.Date(fig15_r1c$V1)
fig15_r1c$V1 <- fig15_r1c$V1 %m+% months(1)
fig15_r1c
Sys.sleep(60)
write.table(fig15_r1c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r1c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



fig15_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r2b.csv",
                      header = FALSE)
fig15_r2b$V1 <- as.Date(fig15_r2b$V1)
fig15_r2b$V1 <- fig15_r2b$V1 %m+% months(1)
fig15_r2b
Sys.sleep(60)
write.table(fig15_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig15_r2c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r2c.csv",
                      header = FALSE)
fig15_r2c$V1 <- as.Date(fig15_r2c$V1)
fig15_r2c$V1 <- fig15_r2c$V1 %m+% months(1)
fig15_r2c
Sys.sleep(60)
write.table(fig15_r2c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig15_r2c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


#################################### fig 16 ####################################
fig16_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r1b.csv",
                      header = FALSE)
fig16_r1b$V1 <- as.Date(fig16_r1b$V1)
fig16_r1b$V1 <- fig16_r1b$V1 %m+% months(1)
fig16_r1b
Sys.sleep(60)
write.table(fig16_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig16_r1c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r1c.csv",
                      header = FALSE)
fig16_r1c$V1 <- as.Date(fig16_r1c$V1)
fig16_r1c$V1 <- fig16_r1c$V1 %m+% months(1)
fig16_r1c
Sys.sleep(60)
write.table(fig16_r1c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r1c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



fig16_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r2b.csv",
                      header = FALSE)
fig16_r2b$V1 <- as.Date(fig16_r2b$V1)
fig16_r2b$V1 <- fig16_r2b$V1 %m+% months(1)
fig16_r2b
Sys.sleep(60)
write.table(fig16_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig16_r2c <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r2c.csv",
                      header = FALSE)
fig16_r2c$V1 <- as.Date(fig16_r2c$V1)
fig16_r2c$V1 <- fig16_r2c$V1 %m+% months(1)
fig16_r2c
Sys.sleep(60)
write.table(fig16_r2c,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data\\fig16_r2c.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


