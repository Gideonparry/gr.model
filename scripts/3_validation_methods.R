library(gr.model)

gr_total <- read.csv("data-raw//updated_data.csv")


set.seed(1234)
w2_ca <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + winter_wind_all,
  rf_formula = gr ~ ground_max + winter_wind_all
)
w2_ca

set.seed(1234)
w2_ERA5_only <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + est_wind,
  rf_formula = gr ~ ground_max + winter_wind_all
)
w2_ERA5_only



set.seed(1234)
all_results <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + roofflat + sheltered +
    winter_wind_all + temp_avg + above_freeze_all + logsize + Parapet +
    roofflat:winter_wind_all + roofflat:sheltered,
  rf_formula = gr ~ ground_max + roofflat + sheltered + winter_wind_all +
    temp_avg + above_freeze_all + logsize + Parapet
)
all_results


set.seed(1234)
ta_results <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + roofflat + sheltered +
    winter_wind_all + temp_avg  + logsize + Parapet +
    roofflat:winter_wind_all + roofflat:sheltered,
  rf_formula = gr ~ ground_max + roofflat + sheltered + winter_wind_all +
    temp_avg + logsize + Parapet
)
ta_results

set.seed(1234)
af_results <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + roofflat + sheltered +
    winter_wind_all + above_freeze_all + logsize + Parapet +
    roofflat:winter_wind_all + roofflat:sheltered,
  rf_formula = gr ~ ground_max + roofflat + sheltered + winter_wind_all +
   above_freeze_all + logsize + Parapet
)
af_results





set.seed(1234)
build_results <- cross_valid_acc(
  data = gr_total,
  formula2 =  sqrtgr ~ logground + logsize + Parapet + roofflat +
    sheltered + roofflat:sheltered,
  rf_formula = gr ~ ground_max + logsize + Parapet + roofflat +
    sheltered
)
build_results





set.seed(1234)
weather <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + winter_wind_all + temp_avg +
    above_freeze_all + winter_wind_all*sheltered,
  rf_formula = gr ~ ground_max + winter_wind_all + temp_avg + above_freeze_all +
    sheltered
)
weather


set.seed(1234)
ta_weather <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + winter_wind_all + temp_avg +
   winter_wind_all*sheltered,
  rf_formula = gr ~ ground_max + winter_wind_all + temp_avg + above_freeze_all +
    sheltered
)
ta_weather

set.seed(1234)
af_weather <- cross_valid_acc(
  data = gr_total, formula2 = sqrtgr ~ logground + winter_wind_all +
    above_freeze_all + winter_wind_all*sheltered,
  rf_formula = gr ~ ground_max + winter_wind_all + above_freeze_all +
    sheltered
)
af_weather



set.seed(1234)
era5_w2_ta <- cross_valid_acc(
  data = gr_total,
  formula2 = sqrtgr ~ logground + roofflat + sheltered +
    est_wind + est_temp_avg + logsize + Parapet + roofflat:est_wind +
    roofflat:sheltered,
  rf_formula = gr ~ ground_max + roofflat + sheltered +
    est_wind + est_temp_avg + logsize + Parapet
)
era5_w2_ta


set.seed(1234)
era5_ta <- cross_valid_acc(
  data = gr_total,
  formula2 = sqrtgr ~ logground + roofflat + sheltered +
     est_temp_avg + logsize + Parapet +
    roofflat:sheltered,
  rf_formula = gr ~ ground_max + roofflat + sheltered +
     est_temp_avg + logsize + Parapet
)
era5_ta
