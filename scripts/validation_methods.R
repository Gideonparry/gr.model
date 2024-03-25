gr_total <- read.csv("data-raw//updated_data.csv")
gr_total$logsize <- log(gr_total$Size)

set.seed(1234)
all_results <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground +
                      winter_wind_all  + temp_avg +
                  above_freeze_all + sheltered +
                  exposed  +  Parapet + Heated
                + Insulated + roofflat  + roofflat:winter_wind_all +
                  roofflat:sheltered,
                               rf_formula = gr ~ ground_max +
                                 winter_wind_all  + temp_avg +
                                 above_freeze_all +  sheltered +
                                 exposed  +  Parapet + Heated
                               + Insulated + roofflat)
all_results


set.seed(1234)
w2_ta_results <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                                 +  winter_wind_all  +
                                   temp_avg +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat +
                                   roofflat:winter_wind_all +
                                   roofflat:sheltered,

                              rf_formula = gr ~ ground_max
                              +  winter_wind_all  +
                                temp_avg +  sheltered +
                                exposed + Parapet + Heated
                              + Insulated + roofflat)
w2_ta_results

set.seed(1234)
w2_af_results <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                                 +  winter_wind_all  +
                                   above_freeze_all +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat +
                                   roofflat:winter_wind_all +
                                   roofflat:sheltered,

                                 rf_formula = gr ~ ground_max
                                 +  winter_wind_all  +
                                   above_freeze_all +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat)
w2_af_results




set.seed(1234)
wa_af_results <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                                 +  wind_avg  +
                                   above_freeze_all +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat +
                                   roofflat:wind_avg +
                                   roofflat:sheltered,

                                 rf_formula = gr ~ ground_max
                                 +  wind_avg  +
                                   above_freeze_all +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat)
wa_af_results

set.seed(1234)
wa_ta_results <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                                 +  wind_avg  +
                                   temp_avg +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat +
                                   roofflat:wind_avg +
                                   roofflat:sheltered,

                                 rf_formula = gr ~ ground_max
                                 +  winter_wind_all  +
                                   temp_avg +  sheltered +
                                   exposed + Parapet + Heated
                                 + Insulated + roofflat )
wa_ta_results

set.seed(1234)
build_results1 <- cross_valid_acc(data = gr_total,
                                  formula2 = sqrtgr ~ logground +  sheltered +
                                   exposed  +  Parapet + Heated +logsize
                                 + Insulated + roofflat +
                                   roofflat:sheltered,

                                 rf_formula = gr ~ ground_max +  sheltered +
                                   exposed  +  Parapet + Heated +logsize
                                 + Insulated + roofflat )
build_results1


set.seed(1234)
build_results2 <- cross_valid_acc(data = gr_total,
                                  formula2 = sqrtgr ~ logground +  sheltered +
                                    exposed  +  Parapet + Heated
                                  + Insulated + roofflat +
                                    roofflat:sheltered,

                                  rf_formula = gr ~ ground_max +  sheltered +
                                    exposed  +  Parapet + Heated
                                  + Insulated + roofflat )
build_results2


set.seed(1234)
weather <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground +
                             winter_wind_all  + temp_avg +
                             above_freeze_all ,


                           rf_formula = gr ~ ground_max +
                             winter_wind_all  + temp_avg +
                             above_freeze_all)
weather


set.seed(1234)
w2_ta_weather <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground +
                             winter_wind_all  + temp_avg  ,


                           rf_formula = gr ~ ground_max +
                             winter_wind_all  + temp_avg)
w2_ta_weather

set.seed(1234)
wa_af_weather <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground +
                                   wind_avg  + above_freeze_all ,


                                 rf_formula = gr ~ ground_max +
                                   wind_avg  + above_freeze_all)
wa_af_weather


set.seed(1234)
w2_af_weather <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground +
                                   winter_wind_all  + above_freeze_all ,


                                 rf_formula = gr ~ ground_max +
                                   winter_wind_all  + above_freeze_all)
w2_af_weather

set.seed(1234)
wa_ta_weather <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground +
                                   wind_avg  + temp_avg ,


                                 rf_formula = gr ~ ground_max +
                                   wind_avg  + temp_avg)
wa_ta_weather


set.seed(1234)
ERA5_w2 <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                             +  est_wind  +
                               est_temp_avg +  sheltered +
                               exposed + Parapet + Heated
                             + Insulated + roofflat +
                               roofflat:est_wind +
                               roofflat:sheltered,

                             rf_formula = gr ~ ground_max
                             +  est_wind  +
                               est_temp_avg +  sheltered +
                               exposed + Parapet + Heated
                             + Insulated + roofflat )
ERA5_w2

set.seed(1234)
ERA5_wa <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                           +  est_wind_avg  +
                             est_temp_avg +  sheltered +
                             exposed + Parapet + Heated
                           + Insulated + roofflat +
                             roofflat:est_wind_avg +
                             roofflat:sheltered,

                           rf_formula = gr ~ ground_max
                           +  est_wind_avg  +
                             est_temp_avg +  sheltered +
                             exposed + Parapet + Heated
                           + Insulated + roofflat )
ERA5_wa

set.seed(1234)
ERA5_ta <- cross_valid_acc(data = gr_total, formula2 = sqrtgr ~ logground
                             +   est_temp_avg +  sheltered +
                               exposed + Parapet + Heated
                             + Insulated + roofflat +
                             roofflat:sheltered,

                             rf_formula = gr ~ ground_max
                             + est_temp_avg +  sheltered +
                               exposed + Parapet + Heated
                             + Insulated + roofflat )
ERA5_ta
