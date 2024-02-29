gr_total <- read.csv("data-raw//wind_all.csv")
gr_total <- gr_total[gr_total$gr <= 2,]


### using average wind speeds
set.seed(1234)
seeds <- sample(1:10000, 25)
results_list_avg <- list()
for(i in 1:25){
  set.seed(seeds[i])
  results_list_avg[[i]] <- acc_test(data = gr_total, formula2 =
                "sqrtgr ~ logground + wind_avg + temp_avg +
                roofflat + Size + Exposure +  Insulated +
                Parapet + roofflat*Exposure + roofflat*wind_avg",
                rf_formula = gr ~ ground_max +
                  wind_avg + temp_avg +
                  roofflat + Size + Exposure +  Insulated +
                  Parapet)
}

## taking avg for avg wind speeds
avg_sum <- results_list_avg[[1]]
for(i in 2:25){
  avg_sum <- avg_sum + results_list_avg[[i]]
}
avg_avg <- avg_sum/25
avg_avg
t(avg_avg)


### using w2
results_list_w2 <- list()
for(i in 1:25){
  set.seed(seeds[i])
  results_list_w2[[i]] <- acc_test(data = gr_total, formula2 =
                                      "sqrtgr ~ logground + winter_wind_all +
                                      temp_avg +
                roofflat + Size + Exposure +  Insulated +
                Parapet + roofflat*Exposure + roofflat*winter_wind_all",
                                    rf_formula = gr ~ ground_max +
                                      winter_wind_all + temp_avg +
                                      roofflat + Size + Exposure +  Insulated +
                                      Parapet)
}

## taking w2 for w2 wind speeds
w2_sum <- results_list_w2[[1]]
for(i in 2:25){
  w2_sum <- w2_sum + results_list_w2[[i]]
}
w2_avg <- w2_sum/25
w2_avg
t(w2_avg)

### adding only building info to model
results_list_building <- list()
for(i in 1:25){
  set.seed(seeds[i])
  results_list_building[[i]] <- acc_test(data = gr_total, formula2 =
                                     "sqrtgr ~ logground +
                roofflat + Size + Exposure +  Insulated +
                Parapet + roofflat*Exposure",
                                   rf_formula = gr ~ ground_max +
                                     roofflat + Size + Exposure +  Insulated +
                                     Parapet)
}

## taking results with weather
building_sum <- results_list_building[[1]]
for(i in 2:25){
  building_sum <- building_sum + results_list_building[[i]]
}
building_avg <- building_sum/25
building_avg
t(building_avg)


### adding only weather info to model
results_list_weather <- list()
for(i in 1:25){
  set.seed(seeds[i])
  results_list_weather[[i]] <- acc_test(data = gr_total, formula2 =
                                      "sqrtgr ~ logground + winter_wind_all +
                                      temp_avg + Exposure",
                                        rf_formula = gr ~ ground_max +
                                          winter_wind_all + temp_avg +
                                         Exposure)
}

## taking results with weather
weather_sum <- results_list_weather[[1]]
for(i in 2:25){
  weather_sum <- weather_sum + results_list_weather[[i]]
}
weather_avg <- weather_sum/25
weather_avg
t(weather_avg)




### adding only weather with average info to model
results_list_weather_a <- list()
for(i in 1:25){
  set.seed(seeds[i])
  results_list_weather_a[[i]] <- acc_test(data = gr_total, formula2 =
                                          "sqrtgr ~ logground + wind_avg +
                                      temp_avg + Exposure",
                                        rf_formula = gr ~ ground_max +
                                          wind_avg + temp_avg +
                                          Exposure)
}

## taking results with weather_a
weather_a_sum <- results_list_weather_a[[1]]
for(i in 2:25){
  weather_a_sum <- weather_a_sum + results_list_weather_a[[i]]
}
weather_a_avg <- weather_a_sum/25
weather_a_avg
t(weather_a_avg)

