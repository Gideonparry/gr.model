#### adding headers to all files
pr2 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport2\\data")
pr2
N <- names(pr2)
for (i in seq_along(N)) write.table(pr2[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")

pr3 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport3\\data")
head(pr3)
N <- names(pr3)
for (i in seq_along(N)) write.table(pr3[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr4 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport4\\data")
head(pr4)
N <- names(pr4)
for (i in seq_along(N)) write.table(pr4[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")

pr5 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport5\\data")
head(pr5)
N <- names(pr5)
for (i in seq_along(N)) write.table(pr5[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr6 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport6\\data")
head(pr6)
N <- names(pr6)
for (i in seq_along(N)) write.table(pr6[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr7 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport7\\data")
head(pr7)
N <- names(pr7)
for (i in seq_along(N)) write.table(pr7[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr8 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport8\\data")
head(pr8)
N <- names(pr8)
for (i in seq_along(N)) write.table(pr8[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr9 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport9\\data")
head(pr9)
N <- names(pr9)
for (i in seq_along(N)) write.table(pr9[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr10 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport10\\data")
head(pr10)
N <- names(pr10)
for (i in seq_along(N)) write.table(pr10[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")


pr11 <- add_header("C:\\Users\\bean_student\\Documents\\GraphData\\ProgressReport11\\data")
head(pr11)
N <- names(pr11)
for (i in seq_along(N)) write.table(pr11[[i]],
                                    file=N[i], row.names = FALSE,
                                    col.names = TRUE, sep=",")
