############################# Fig 3 ######################################################
fig3_g3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g3.csv",
                     header = FALSE)
fig3_g3 <- date_fix(fig3_g3, "1965-03-31")
fig3_g3
Sys.sleep(60)
write.table(fig3_g3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



fig3_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g1.csv",
                        header = FALSE)
fig3_g1 <- date_fix(fig3_g1, "1965-03-31")
fig3_g1
Sys.sleep(60)
write.table(fig3_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig3_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g2.csv",
                        header = FALSE)
fig3_g2 <- date_fix(fig3_g2, "1965-03-31")
fig3_g2
Sys.sleep(60)
write.table(fig3_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



fig3_g3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g3.csv",
                        header = FALSE)
fig3_g3 <- date_fix(fig3_g3, "1965-03-31")
fig3_g3
Sys.sleep(60)
write.table(fig3_g3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_g3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig3_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_r1.csv",
                    header = FALSE)
fig3_r1 <- date_fix(fig3_r1, "1965-03-31")
fig3_r1
Sys.sleep(60)
write.table(fig3_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig3_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_r2.csv",
                    header = FALSE)
fig3_r2 <- date_fix(fig3_r2, "1965-03-31")
fig3_r2
Sys.sleep(60)
write.table(fig3_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig3_r3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_r3.csv",
                    header = FALSE)
fig3_r3 <- date_fix(fig3_r3, "1965-03-31")
fig3_r3
Sys.sleep(60)
write.table(fig3_r3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_r3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig3_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_temp.csv",
                    header = FALSE)
fig3_temp <- date_fix(fig3_temp, "1965-03-31")
fig3_temp
Sys.sleep(60)
write.table(fig3_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig3_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_temp.csv",
                      header = FALSE)
fig3_temp <- date_fix(fig3_temp, "1965-03-31", wrongdate = "1964-11-10")
fig3_temp
Sys.sleep(60)
write.table(fig3_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig3_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_accume.csv",
                    header = FALSE)
fig3_accume <- date_fix(fig3_accume, "1965-03-31", wrongdate = "1964-11-07")
fig3_accume
Sys.sleep(60)
write.table(fig3_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig3_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


################################ fig 4 #########################################
library(lubridate)
fig4_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig4_accume.csv",
                      header = FALSE)
fig4_accume$V1 <- as.Date(fig4_accume$V1)
fig4_accume$V1 <- fig4_accume$V1 %m-% months(1)
fig4_accume
Sys.sleep(60)
write.table(fig4_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig4_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig4_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig4_temp.csv",
                        header = FALSE)
fig4_temp$V1 <- as.Date(fig4_temp$V1)
fig4_temp$V1 <- fig4_temp$V1 %m-% months(1)
fig4_temp
Sys.sleep(60)
write.table(fig4_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig4_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig4_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig4_wind.csv",
                      header = FALSE)
fig4_wind$V1 <- as.Date(fig4_wind$V1)
fig4_wind$V1 <- fig4_wind$V1 %m-% months(1)
fig4_wind
Sys.sleep(60)
write.table(fig4_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig4_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


############################### fig 5 ############################################
fig5_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5_accume.csv",
                        header = FALSE)
fig5_accume <- date_fix(fig5_accume, "1965-03-31")
fig5_accume
Sys.sleep(60)
write.table(fig5_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5_temp.csv",
                        header = FALSE)
fig5_temp <- date_fix(fig5_temp, "1965-03-31", wrongdate = "1964-12-01")
fig5_temp
Sys.sleep(60)
write.table(fig5_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig5_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5_wind.csv",
                      header = FALSE)
fig5_wind <- date_fix(fig5_wind, "1965-03-31", wrongdate = "1964-12-01")
fig5_wind
Sys.sleep(60)
write.table(fig5_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5a_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_g1.csv",
                      header = FALSE)
fig5a_g1 <- date_fix(fig5a_g1, "1965-03-31", wrongdate = "1964-12-01")
fig5a_g1
Sys.sleep(60)
write.table(fig5a_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


## At this point I realized "1964-12-01" was a better default for wrongdate than
## "1964-11-26" and made the change

fig5a_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_g2.csv",
                     header = FALSE)
fig5a_g2 <- date_fix(fig5a_g2, "1965-03-31")
fig5a_g2
Sys.sleep(60)
write.table(fig5a_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5a_g3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_g3.csv",
                     header = FALSE)
fig5a_g3 <- date_fix(fig5a_g3, "1965-03-31")
fig5a_g3
Sys.sleep(60)
write.table(fig5a_g3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_g3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5a_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_r1.csv",
                     header = FALSE)
fig5a_r1 <- date_fix(fig5a_r1, "1965-03-31")
fig5a_r1
Sys.sleep(60)
write.table(fig5a_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5a_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_r2.csv",
                     header = FALSE)
fig5a_r2 <- date_fix(fig5a_r2, "1965-03-31")
fig5a_r2
Sys.sleep(60)
write.table(fig5a_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig5a_r3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_r3.csv",
                     header = FALSE)
fig5a_r3 <- date_fix(fig5a_r3, "1965-03-31")
fig5a_r3
Sys.sleep(60)
write.table(fig5a_r3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5a_r3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5b_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_g1.csv",
                     header = FALSE)
fig5b_g1 <- date_fix(fig5b_g1, "1965-03-31")
fig5b_g1
Sys.sleep(60)
write.table(fig5b_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig5b_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_g2.csv",
                     header = FALSE)
fig5b_g2 <- date_fix(fig5b_g2, "1965-03-31")
fig5b_g2
Sys.sleep(60)
write.table(fig5b_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig5b_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_r1.csv",
                     header = FALSE)
fig5b_r1 <- date_fix(fig5b_r1, "1965-03-31")
fig5b_r1
Sys.sleep(60)
write.table(fig5b_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig5b_r2a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_r2a.csv",
                     header = FALSE)
fig5b_r2a <- date_fix(fig5b_r2a, "1965-03-31")
fig5b_r2a
Sys.sleep(60)
write.table(fig5b_r2a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_r2a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig5b_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_r2b.csv",
                     header = FALSE)
fig5b_r2b <- date_fix(fig5b_r2b, "1965-03-31")
fig5b_r2b
Sys.sleep(60)
write.table(fig5b_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig5b_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


######################################### fig 6 ################################
fig6_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_accume.csv",
                     header = FALSE)
fig6_accume <- last_month_fix(fig6_accume, 11, 5, 4, "1964-12-01")
fig6_accume
Sys.sleep(60)
write.table(fig6_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig6_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_g1.csv",
                        header = FALSE)
fig6_g1 <- last_month_fix(fig6_g1, 11, 5, 4, "1964-12-01")
fig6_g1
Sys.sleep(60)
write.table(fig6_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig6_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_g2.csv",
                        header = FALSE)
fig6_g2 <- last_month_fix(fig6_g2, 11, 5, 4, "1964-12-01")
fig6_g2
Sys.sleep(60)
write.table(fig6_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig6_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_r1.csv",
                        header = FALSE)
fig6_r1 <- last_month_fix(fig6_r1, 11, 5, 4, "1964-12-01")
fig6_r1
Sys.sleep(60)
write.table(fig6_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig6_r2a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_r2a.csv",
                        header = FALSE)
fig6_r2a <- last_month_fix(fig6_r2a, 11, 5, 4, "1964-12-01")
fig6_r2a
Sys.sleep(60)
write.table(fig6_r2a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_r2a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig6_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_r2b.csv",
                        header = FALSE)
fig6_r2b <- last_month_fix(fig6_r2b, 11, 5, 4, "1964-12-01")
fig6_r2b
Sys.sleep(60)
write.table(fig6_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig6_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_temp.csv",
                        header = FALSE)
fig6_temp <- last_month_fix(fig6_temp, 11, 5, 4, "1964-12-01")
fig6_temp
Sys.sleep(60)
write.table(fig6_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig6_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_wind.csv",
                        header = FALSE)
fig6_wind <- last_month_fix(fig6_wind, 11, 5, 4, "1964-12-01")
fig6_wind
Sys.sleep(60)
write.table(fig6_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig6_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

############################################ fig 7 ############################
fig7_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_accume.csv",
                        header = FALSE)
fig7_accume <- last_month_fix(fig7_accume, 11, 5, 4, "1964-12-01")
fig7_accume
Sys.sleep(60)
write.table(fig7_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")



## here I fixed the last_month_fix function. I had mistakes cancel each other
## out before, but now I actually have it all right.
fig7_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_g1.csv",
                        header = FALSE)
fig7_g1 <- last_month_fix(fig7_g1, 12, 5, 4, "1964-12-01")
fig7_g1
Sys.sleep(60)
write.table(fig7_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig7_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_g2.csv",
                    header = FALSE)
fig7_g2 <- last_month_fix(fig7_g2, 12, 5, 4, "1964-12-01")
fig7_g2
Sys.sleep(60)
write.table(fig7_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig7_g3 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_g3.csv",
                    header = FALSE)
fig7_g3 <- last_month_fix(fig7_g3, 12, 5, 4, "1964-12-01")
fig7_g3
Sys.sleep(60)
write.table(fig7_g3,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_g3.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig7_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r1.csv",
                    header = FALSE)
fig7_r1 <- last_month_fix(fig7_r1, 12, 5, 4, "1964-12-01")
fig7_r1
Sys.sleep(60)
write.table(fig7_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig7_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r2.csv",
                    header = FALSE)
fig7_r2 <- last_month_fix(fig7_r2, 12, 5, 4, "1964-12-01")
fig7_r2
Sys.sleep(60)
write.table(fig7_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig7_r3a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r3a.csv",
                    header = FALSE)
fig7_r3a <- last_month_fix(fig7_r3a, 12, 5, 4, "1964-12-01")
fig7_r3a
Sys.sleep(60)
write.table(fig7_r3a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r3a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig7_r3b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r3b.csv",
                    header = FALSE)
fig7_r3b <- last_month_fix(fig7_r3b, 12, 5, 4, "1964-12-01")
fig7_r3b
Sys.sleep(60)
write.table(fig7_r3b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_r3b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig7_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_temp.csv",
                    header = FALSE)
fig7_temp <- last_month_fix(fig7_temp, 12, 5, 4, "1964-12-01")
fig7_temp
Sys.sleep(60)
write.table(fig7_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig7_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_wind.csv",
                    header = FALSE)
fig7_wind <- last_month_fix(fig7_wind, 12, 5, 4, "1964-12-01")
fig7_wind
Sys.sleep(60)
write.table(fig7_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig7_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

#################################### fig 8 #####################################
fig8_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_accume.csv",
                      header = FALSE)
fig8_accume <- date_fix(fig8_accume, "1965-03-31")
fig8_accume
Sys.sleep(60)
write.table(fig8_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig8_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_g1.csv",
                      header = FALSE)
fig8_g1 <- date_fix(fig8_g1, "1965-03-31")
fig8_g1
Sys.sleep(60)
write.table(fig8_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig8_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_g2.csv",
                      header = FALSE)
fig8_g2 <- date_fix(fig8_g2, "1965-03-31")
fig8_g2
Sys.sleep(60)
write.table(fig8_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig8_r1a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_r1a.csv",
                      header = FALSE)
fig8_r1a <- date_fix(fig8_r1a, "1965-03-31")
fig8_r1a
Sys.sleep(60)
write.table(fig8_r1a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_r1a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig8_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_r1b.csv",
                      header = FALSE)
fig8_r1b <- date_fix(fig8_r1b, "1965-03-31")
fig8_r1b
Sys.sleep(60)
write.table(fig8_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig8_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_r2.csv",
                      header = FALSE)
fig8_r2 <- date_fix(fig8_r2, "1965-03-31")
fig8_r2
Sys.sleep(60)
write.table(fig8_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig8_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_temp.csv",
                      header = FALSE)
fig8_temp <- date_fix(fig8_temp, "1965-03-31")
fig8_temp
Sys.sleep(60)
write.table(fig8_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig8_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_wind.csv",
                      header = FALSE)
fig8_wind <- date_fix(fig8_wind, "1965-03-31")
fig8_wind
Sys.sleep(60)
write.table(fig8_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig8_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


## planning on doing all the nov - mar stuff left at once. fig 17 is feb - apr
################################# fig 17 ######################################
fig17_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_accume.csv",
                      header = FALSE)
fig17_accume$V1 <- as.Date(fig17_accume$V1)
fig17_accume$V1 <- fig17_accume$V1 %m-% months(1)
fig17_accume
Sys.sleep(60)
write.table(fig17_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig17_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_g1.csv",
                      header = FALSE)
fig17_g1$V1 <- as.Date(fig17_g1$V1)
fig17_g1$V1 <- fig17_g1$V1 %m-% months(1)
fig17_g1
Sys.sleep(60)
write.table(fig17_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig17_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_g2.csv",
                      header = FALSE)
fig17_g2$V1 <- as.Date(fig17_g2$V1)
fig17_g2$V1 <- fig17_g2$V1 %m-% months(1)
fig17_g2
Sys.sleep(60)
write.table(fig17_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig17_r1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_r1.csv",
                      header = FALSE)
fig17_r1$V1 <- as.Date(fig17_r1$V1)
fig17_r1$V1 <- fig17_r1$V1 %m-% months(1)
fig17_r1
Sys.sleep(60)
write.table(fig17_r1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_r1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig17_r2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_r2.csv",
                      header = FALSE)
fig17_r2$V1 <- as.Date(fig17_r2$V1)
fig17_r2$V1 <- fig17_r2$V1 %m-% months(1)
fig17_r2
Sys.sleep(60)
write.table(fig17_r2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_r2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig17_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_temp.csv",
                      header = FALSE)
fig17_temp$V1 <- as.Date(fig17_temp$V1)
fig17_temp$V1 <- fig17_temp$V1 %m-% months(1)
fig17_temp
Sys.sleep(60)
write.table(fig17_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig17_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_wind.csv",
                      header = FALSE)
fig17_wind$V1 <- as.Date(fig17_wind$V1)
fig17_wind$V1 <- fig17_wind$V1 %m-% months(1)
fig17_wind
Sys.sleep(60)
write.table(fig17_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig17_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


## opening temp folder to work on all left with the same issue
# Set the directory path to the folder containing the CSV files
folder_path <- "C:\\Users\\bean_student\\Documents\\temp\\data"

# Get the list of CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Create an empty list to store the data frames
data_frames <- list()

# Loop through each CSV file and read it as a data frame
for (file in csv_files) {
  data_frames[[file]] <- read.csv(file, header = FALSE)
}

length(data_frames)
data_frames[[53]]

data_frames <- lapply(data_frames, date_fix, "1965-03-31")
data_frames
N <- names(data_frames)
for (i in seq_along(N)) write.table(data_frames[[i]], file=N[i], row.names = FALSE, col.names = FALSE, sep=",")


######################################### fig 20 ################################
fig20_accume <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_accume.csv",
                        header = FALSE)
fig20_accume <- last_month_fix(fig20_accume, 11, 4, 3, "1964-11-01")
fig20_accume
Sys.sleep(60)
write.table(fig20_accume,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_accume.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_g1.csv",
                    header = FALSE)
fig20_g1 <- last_month_fix(fig20_g1, 11, 4, 3, "1964-11-01")
fig20_g1
Sys.sleep(60)
write.table(fig20_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig20_g2 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_g2.csv",
                    header = FALSE)
fig20_g2 <- last_month_fix(fig20_g2, 11, 4, 3, "1964-11-01")
fig20_g2
Sys.sleep(60)
write.table(fig20_g2,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_g2.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_r1a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r1a.csv",
                    header = FALSE)
fig20_r1a <- last_month_fix(fig20_r1a, 11, 4, 3, "1964-11-01")
fig20_r1a
Sys.sleep(60)
write.table(fig20_r1a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r1a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_r1b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r1b.csv",
                     header = FALSE)
fig20_r1b <- last_month_fix(fig20_r1b, 11, 4, 3, "1964-11-01")
fig20_r1b
Sys.sleep(60)
write.table(fig20_r1b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r1b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_r2a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r2a.csv",
                     header = FALSE)
fig20_r2a <- last_month_fix(fig20_r2a, 11, 4, 3, "1964-11-01")
fig20_r2a
Sys.sleep(60)
write.table(fig20_r2a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r2a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_r2b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r2b.csv",
                     header = FALSE)
fig20_r2b <- last_month_fix(fig20_r2b, 11, 4, 3, "1964-11-01")
fig20_r2b
Sys.sleep(60)
write.table(fig20_r2b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r2b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig20_r3a <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r3a.csv",
                      header = FALSE)
fig20_r3a <- last_month_fix(fig20_r3a, 11, 4, 3, "1964-11-01")
fig20_r3a
Sys.sleep(60)
write.table(fig20_r3a,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r3a.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_r3b <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r3b.csv",
                      header = FALSE)
fig20_r3b <- last_month_fix(fig20_r3b, 11, 4, 3, "1964-11-01")
fig20_r3b
Sys.sleep(60)
write.table(fig20_r3b,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_r3b.csv",
            row.names = FALSE, col.names = FALSE, sep=",")


fig20_temp <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_temp.csv",
                      header = FALSE)
fig20_temp <- last_month_fix(fig20_temp, 11, 4, 3, "1964-11-01")
fig20_temp
Sys.sleep(60)
write.table(fig20_temp,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_temp.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

fig20_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_wind.csv",
                      header = FALSE)
fig20_wind <- last_month_fix(fig20_wind, 11, 4, 3, "1964-11-01")
fig20_wind
Sys.sleep(60)
write.table(fig20_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig20_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

############################ fig 23 ###########################################
fig23_wind <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig23_wind.csv",
                       header = FALSE)
fig23_wind$V2 <- fig23_wind$V2 / 2
fig23_wind
write.table(fig23_wind,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data\\fig23_wind.csv",
            row.names = FALSE, col.names = FALSE, sep=",")
