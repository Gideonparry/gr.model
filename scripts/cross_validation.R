# Currently working in loadall mode. Make sure Metrics and randomForest are
# installed

data <- read.csv("data-raw/gr_model_data.csv")
data2 <- read.csv("data-raw/gr_model_data_2months.csv")
data3 <- read.csv("data-raw/gr_model_data_groundsnow.csv")
data4 <- read.csv("data-raw/all_wind_agg.csv")
data5 <- read.csv("data-raw/wind_3month_agg.csv")
data6 <- read.csv("data-raw/wind_snow_agg.csv")

set.seed(1234)
acc_test(data = data)
acc_test(data = data2)
acc_test(data = data3)
acc_test(data = data4)
acc_test(data = data5)
acc_test(data = data6)


acc_test(data = data, seed = 1234)[1:4]
acc_test(data = data, seed = 1234)[5:8]
acc_test(data = data, seed = 1234)[9:12]
acc_test(data = data, seed = 1234)[13:16]



acc_test(data = data, seed = 2319)[1:4]
acc_test(data = data, seed = 2319)[5:8]
acc_test(data = data, seed = 2319)[9:12]
acc_test(data = data, seed = 2319)[13:16]


## Getting just new results
acc_test(data = data, seed = 123,
                  formula2 = sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind +
                  log(Size) + temp_avg + Parapet)[c(3,7,11,15)]

acc_test(data = data,
         formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

acc_test(data = data, seed = 2319,
         formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]


## No building info
acc_test(data = data, seed = 123,
         formula2 = "sqrtgr ~ logground +
                  winter_wind +
                   temp_avg")[c(3,7,11,15)]

acc_test(data = data, seed = 1234,
         formula2 = "sqrtgr ~ logground +
                  winter_wind +
                   temp_avg")[c(3,7,11,15)]

acc_test(data = data, seed = 2319,
         formula2 = "sqrtgr ~ logground +
                  winter_wind +
                   temp_avg")[c(3,7,11,15)]


## drop heated/flat
acc_test(data = data, seed = 123,
         formula2 = "sqrtgr ~ logground + Exposure +
                  winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

acc_test(data = data, seed = 1234,
         formula2 = "sqrtgr ~ logground + Exposure +
                  winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

acc_test(data = data, seed = 2319,
         formula2 = "sqrtgr ~ logground + Exposure +
                  winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

## keep flat drop interaction
acc_test(data = data, seed = 123,
         formula2 = "sqrtgr ~ logground + roofflat + Exposure +
                  winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

acc_test(data = data, seed = 1234,
         formula2 = "sqrtgr ~ logground + roofflat + Exposure +
                  winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

acc_test(data = data, seed = 2319,
         formula2 = "sqrtgr ~ logground + roofflat + Exposure +
                  winter_wind +
                  log(Size) + temp_avg + Parapet")[c(3,7,11,15)]

### Exposure, flat and winter wind only
acc_test(data = data, seed = 123,
         formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind")[c(3,7,11,15)]

acc_test(data = data, seed = 1234,
         formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind")[c(3,7,11,15)]

acc_test(data = data, seed = 2319,
         formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind")[c(3,7,11,15)]

colnames(data)

### rf with weather, exposure and flat
acc_test(data, 123, rf_formula = gr ~ logground + temp_avg + Exposure +
           roofflat + winter_wind)[c(4,8,12,16)]

acc_test(data, 1234, rf_formula = gr ~ logground + temp_avg + Exposure +
           roofflat + winter_wind)[c(4,8,12,16)]

acc_test(data, 2319, rf_formula = gr ~ logground + temp_avg + Exposure +
           roofflat + winter_wind)[c(4,8,12,16)]



## rf with weather only
acc_test(data, 123, tree_vars = c(7,9,13,33))[c(4,8,12,16)]

acc_test(data, 1234, tree_vars = c(7,9,13,33))[c(4,8,12,16)]

acc_test(data, 2319, tree_vars = c(7,9,13,33))[c(4,8,12,16)]
