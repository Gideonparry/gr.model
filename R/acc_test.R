#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param data The full data to perform models on
#' @param seed The Random number seed used to partition data
#' @param formula1 The 1st formula to use. Default is logground
#' @param formula2 The 2nd fromula to use Returns as "new model"
#' @param tree_vars The column numbers of variable to use in the random forest
#' @param rf_y A currently failed attempt at making the y variable in rf an agrument
#'
#'
#' @import Metrics
#' @import randomForest
#' @import stats






acc_test <- function(data, seed,
                     formula1 = "sqrtgr ~ logground",
                     formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                     roofflat*winter_wind +
                     log(Size) + temp_avg + Heated + Parapet",
                     tree_vars = c(7, 11, 13, 19:22, 25:27, 33, 35),
                     rf_y = "gr") {

  set.seed(seed)


  ## setting each building as being in fold 1-5
  building_nums <- sample(rep_len(1:5,length(unique(data$building_code))))


  # putting numbers to building codes
  test_build1 <- unique(data$building_code)[building_nums == 1]
  test_build2 <- unique(data$building_code)[building_nums == 2]
  test_build3 <- unique(data$building_code)[building_nums == 2]
  test_build4 <- unique(data$building_code)[building_nums == 4]
  test_build5 <- unique(data$building_code)[building_nums == 5]


  ## making train and test data based on each fold
  train_data1 <- data[!(data$building_code %in% test_build1),]
  test_data1 <- data[data$building_code %in% test_build1,]

  train_data2 <- data[!(data$building_code %in% test_build2),]
  test_data2 <- data[data$building_code %in% test_build2,]

  train_data3 <- data[!(data$building_code %in% test_build3),]
  test_data3 <- data[data$building_code %in% test_build3,]

  train_data4 <- data[!(data$building_code %in% test_build4),]
  test_data4 <- data[data$building_code %in% test_build4,]

  train_data5 <- data[!(data$building_code %in% test_build5),]
  test_data5 <- data[data$building_code %in% test_build5,]




  fold1_results <- gr_cv(train_data1, test_data1,
                         formula1 = formula1,
                         forumula2 = formula2,
                         tree_vars = tree_vars,
                         rf_y = rf_y)
  fold2_results <- gr_cv(train_data2, test_data2,
                         formula1 = formula1,
                         forumula2 = formula2,
                         tree_vars = tree_vars,
                         rf_y = rf_y)
  fold3_results <- gr_cv(train_data3, test_data3,
                         formula1 = formula1,
                         forumula2 = formula2,
                         tree_vars = tree_vars,
                         rf_y = rf_y)
  fold4_results <- gr_cv(train_data4, test_data4,
                         formula1 = formula1,
                         forumula2 = formula2,
                         tree_vars = tree_vars,
                         rf_y = rf_y)
  fold5_results <- gr_cv(train_data5, test_data5,
                         formula1 = formula1,
                         forumula2 = formula2,
                         tree_vars = tree_vars,
                         rf_y = rf_y)

  sqrt_gr_test <- c(fold1_results[[1]], fold2_results[[1]], fold3_results[[1]],
                    fold4_results[[1]], fold5_results[[1]])

  gr_test <- c(fold1_results[[2]], fold2_results[[2]], fold3_results[[2]],
               fold4_results[[2]], fold5_results[[2]])

  rf_gr_test <- c(fold1_results[[3]], fold2_results[[3]], fold3_results[[3]],
                  fold4_results[[3]], fold5_results[[3]])

  og_sqrt_preds <- c(fold1_results[[4]], fold2_results[[4]], fold3_results[[4]],
                     fold4_results[[4]], fold5_results[[4]])

  new_sqrt_preds <- c(fold1_results[[5]], fold2_results[[5]], fold3_results[[5]],
                      fold4_results[[5]], fold5_results[[5]])

  og_gr_preds <- c(fold1_results[[6]], fold2_results[[6]], fold3_results[[6]],
                   fold4_results[[6]], fold5_results[[6]])

  new_gr_preds <- c(fold1_results[[7]], fold2_results[[7]], fold3_results[[7]],
                    fold4_results[[7]], fold5_results[[7]])

  rf_gr_preds <- c(fold1_results[[8]], fold2_results[[8]], fold3_results[[8]],
                   fold4_results[[8]], fold5_results[[8]])

  train_avg <- c(fold1_results[[9]], fold2_results[[9]], fold3_results[[9]],
                   fold4_results[[9]], fold5_results[[9]])

  # rmse(sqrt_gr_test, og_sqrt_preds)
  #rmse(sqrt_gr_test[!is.na(new_sqrt_preds)], na.omit(new_sqrt_preds))

  #median(abs(sqrt_gr_test - og_sqrt_preds))
  #median(abs(sqrt_gr_test[!is.na(new_sqrt_preds)] - na.omit(new_sqrt_preds)))

  rmse_null <- Metrics::rmse(gr_test, train_avg)
  rmse_og_build <- Metrics::rmse(gr_test, og_gr_preds)
  rmse_new_build <- Metrics::rmse(gr_test[!is.na(new_gr_preds)],
                                 na.omit(new_gr_preds))
  rmse_rf_build <- Metrics::rmse(rf_gr_test, rf_gr_preds)

  mdae_null_build <- stats::median(abs((gr_test - train_avg)))
  mdae_og_build <- stats::median(abs((gr_test - og_gr_preds)))
  mdae_new_build <- stats::median(abs((gr_test[!is.na(new_gr_preds)] -
                                         na.omit(new_gr_preds))))
  mdae_rf_build <- stats::median(abs((rf_gr_test - rf_gr_preds)))


  # Partitioning based on observations

  ## setting each observation as being in fold 1-5
  obs_nums <- sample(rep_len(1:5,nrow(data)))

  obs_train_data1 <- data[obs_nums != 1,]
  obs_test_data1 <- data[obs_nums == 1,]

  obs_train_data2 <- data[obs_nums != 2,]
  obs_test_data2 <- data[obs_nums == 2,]

  obs_train_data3 <- data[obs_nums != 3,]
  obs_test_data3 <- data[obs_nums == 3,]

  obs_train_data4 <- data[obs_nums != 4,]
  obs_test_data4 <- data[obs_nums == 4,]

  obs_train_data5 <- data[obs_nums != 5,]
  obs_test_data5 <- data[obs_nums == 5,]


  obs_fold1_results <- gr_cv(obs_train_data1, obs_test_data1)
  obs_fold2_results <- gr_cv(obs_train_data2, obs_test_data2)
  obs_fold3_results <- gr_cv(obs_train_data3, obs_test_data3)
  obs_fold4_results <- gr_cv(obs_train_data4, obs_test_data4)
  obs_fold5_results <- gr_cv(obs_train_data5, obs_test_data5)

  sqrt_gr_test_obs <- c(obs_fold1_results[[1]], obs_fold2_results[[1]],
                        obs_fold3_results[[1]],
                        obs_fold4_results[[1]], obs_fold5_results[[1]])

  gr_test_obs <- c(obs_fold1_results[[2]], obs_fold2_results[[2]],
                   obs_fold3_results[[2]],
                   obs_fold4_results[[2]], obs_fold5_results[[2]])

  rf_gr_test_obs <- c(obs_fold1_results[[3]], obs_fold2_results[[3]],
                      obs_fold3_results[[3]],
                      obs_fold4_results[[3]], obs_fold5_results[[3]])

  og_sqrt_preds_obs <- c(obs_fold1_results[[4]], obs_fold2_results[[4]],
                         obs_fold3_results[[4]],
                         obs_fold4_results[[4]], obs_fold5_results[[4]])

  new_sqrt_preds_obs <- c(obs_fold1_results[[5]], obs_fold2_results[[5]],
                          obs_fold3_results[[5]],
                          obs_fold4_results[[5]], obs_fold5_results[[5]])

  og_gr_preds_obs <- c(obs_fold1_results[[6]], obs_fold2_results[[6]],
                       obs_fold3_results[[6]],
                       obs_fold4_results[[6]], obs_fold5_results[[6]])

  new_gr_preds_obs <- c(obs_fold1_results[[7]], obs_fold2_results[[7]],
                        obs_fold3_results[[7]],
                        obs_fold4_results[[7]], obs_fold5_results[[7]])

  rf_gr_preds_obs <- c(obs_fold1_results[[8]], obs_fold2_results[[8]],
                       obs_fold3_results[[8]],
                       obs_fold4_results[[8]], obs_fold5_results[[8]])

  train_avg_obs <- c(obs_fold1_results[[9]], obs_fold2_results[[9]],
                       obs_fold3_results[[9]],
                       obs_fold4_results[[9]], obs_fold5_results[[9]])

  #rmse(sqrt_gr_test, og_sqrt_preds)
  #rmse(sqrt_gr_test[!is.na(new_sqrt_preds)], na.omit(new_sqrt_preds))

  #median(abs(sqrt_gr_test - og_sqrt_preds))
  #median(abs(sqrt_gr_test[!is.na(new_sqrt_preds)] - na.omit(new_sqrt_preds)))

  rmse_null_obs <- Metrics::rmse(gr_test_obs, train_avg_obs)
  rmse_og_obs <- Metrics::rmse(gr_test_obs, og_gr_preds_obs)
  rmse_new_obs <- Metrics::rmse(gr_test_obs[!is.na(new_gr_preds_obs)],
                               na.omit(new_gr_preds_obs))
  rmse_rf_obs <- Metrics::rmse(rf_gr_test_obs, rf_gr_preds_obs)

  mdae_null_obs <- stats::median(abs((gr_test_obs - train_avg_obs)))
  mdae_og_obs <- stats::median(abs((gr_test_obs - og_gr_preds_obs)))
  mdae_new_obs <- stats::median(abs((gr_test_obs[!is.na(new_gr_preds_obs)] -
                                       na.omit(new_gr_preds_obs))))
  mdae_rf_obs <- stats::median(abs((rf_gr_test_obs - rf_gr_preds_obs)))

  results <- c(rmse_null, rmse_og_build, rmse_new_build, rmse_rf_build,
               mdae_null_build, mdae_og_build, mdae_new_build, mdae_rf_build,
               rmse_null_obs, rmse_og_obs, rmse_new_obs, rmse_rf_obs,
               mdae_null_obs, mdae_og_obs, mdae_new_obs, mdae_rf_obs)

  names(results) <- c("Null model RMSE buildings",
                      "Original model rmse buildings",
                      "New Model rmse builings",
                      "Random Forest RMSE buildings",
                      "Null model med abs error buildings",
                      "Original model med abs error buildings",
                      "New Model med abs erroor builings",
                      "Random Forest med abd error buildings",
                      "Null Model RMSE obs",
                      "Original model rmse obs",
                      "New Model rmse obs",
                      "Random Forest RMSE obs",
                      "Null model median abd error obs",
                      "Original model med abs error obs",
                      "New Model med abs erroor obs",
                      "Random Forest med abd error obs")
  results

}
