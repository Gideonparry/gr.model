data <- read.csv("C:\\Users\\bean_student\\Documents\\gr_model_data.csv")
acc_test(data = data, seed = 123,
         formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                     roofflat*winter_wind +
                     log(Size) + temp_avg + Parapet")






