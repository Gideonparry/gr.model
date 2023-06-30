############################# Fig 18 ######################################################
fig18_g1 <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport7\\data\\fig18_g1.csv",
                     header = FALSE)
fig18_g1 <- last_month_fix(fig18_g1, 11, 4, 5, "1962-11-01")
fig18_g1
Sys.sleep(60)
write.table(fig18_g1,"C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport7\\data\\fig18_g1.csv",
            row.names = FALSE, col.names = FALSE, sep=",")

