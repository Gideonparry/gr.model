data <- read.csv("data-raw/wind_all.csv")

## Setting seed to partion for reports winter wind
set.seed(1234)
results_list_reports <- list()
for(i in 1:25){
  results_list_reports[[i]] <- acc_test(data = data)
}

## Setting seed to partion for era5 winter wind
set.seed(1234)
results_list_era5 <- list()
for(i in 1:25){
  results_list_era5[[i]] <- acc_test(data = data,
                                formula2 = "sqrtgr ~ logground + est_wind")
}

## taking avg for reports
reports_sum <- results_list_reports[[1]]
for(i in 2:25){
  reports_sum <- reports_sum + results_list_reports[[i]]
}
reports_avg <- reports_sum/25
reports_avg


## taking avg for era5
era5_sum <- results_list_era5[[1]]
for(i in 2:25){
  era5_sum <- era5_sum + results_list_era5[[i]]
}
era5_avg <- era5_sum/25
era5_avg


