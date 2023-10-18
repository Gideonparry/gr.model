#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param data The full data to perform models on
#' @param seed The Random number seed used to partition data
#' @param formula1 The 1st formula to use. Default is logground
#' @param formula2 The 2nd fromula to use Returns as "new model"
#' @param rf_formula The formula to use for the random forest
#'
#'
#' @import Metrics
#' @import randomForest
#' @import stats

acc_test <- function(data, k = 5,
                     formula1 = "sqrtgr ~ logground",
                     formula2 = "sqrtgr ~ logground + roofflat*Exposure +
                     roofflat*winter_wind +
                     log(Size) + temp_avg + Heated + Parapet",
                     rf_formula = gr ~ ground_max + roofflat + Exposure +
                       winter_wind + Size + temp_avg + Heated + Parapet) {

  ## setting each building as being in fold 1-k
  building_nums <- sample(rep_len(seq_len(k),
                                  length(unique(data$building_code))))

  # putting numbers to building codes
  test_build <- train_data <- test_data <-
    fold_results <- vector("list", k)
  for(i in seq_len(k)){
    test_build[[i]] <- unique(data$building_code)[building_nums == i]
    train_data[[i]] <- data[!(data$building_code %in% test_build[[i]]),]
    test_data[[i]] <- data[data$building_code %in% test_build[[i]],]
    fold_results[[i]] <- gr_cv(train_data[[i]], test_data[[i]],
                               formula1 = formula1,
                               forumula2 = formula2,
                               rf_formula = rf_formula)
  }

  results_builings <- list()
  for (i in 1:8){
    results_builings[[i]] <-
      unlist(lapply(fold_results, function(sub_list) sub_list[[i]]))
  }

  #sqrt_gr_test <- unlist(lapply(fold_results, function(sub_list) sub_list[[1]]))
  #gr_test <- unlist(lapply(fold_results, function(sub_list) sub_list[[2]]))
  #og_sqrt_preds <- unlist(lapply(fold_results,
  #                               function(sub_list) sub_list[[3]]))
  #new_sqrt_preds <- unlist(lapply(fold_results,
  #                                function(sub_list) sub_list[[4]]))
  #og_gr_preds <- unlist(lapply(fold_results, function(sub_list) sub_list[[5]]))
  #new_gr_preds <- unlist(lapply(fold_results, function(sub_list) sub_list[[6]]))
  #rf_gr_preds <- unlist(lapply(fold_results, function(sub_list) sub_list[[7]]))
  #train_avg <- unlist(lapply(fold_results, function(sub_list) sub_list[[8]]))


  rmse_buildings <- c()
  for(i in seq_len(4)){
    rmse_buildings[i] <-
      Metrics::rmse(results_builings[[2]][!is.na(results_builings[[i+4]])],
                                       na.omit(results_builings[[i+4]]))
  }


  #rmse_null <- Metrics::rmse(results_builings[[2]], results_builings[[5]])
  #rmse_og_build <- Metrics::rmse(results_builings[[2]], results_builings[[6]])
  #rmse_new_build <- Metrics::rmse(results_builings[[2]][!is.na(results_builings[[7]])],
  #                               na.omit(results_builings[[7]]))
  #rmse_rf_build <- Metrics::rmse(results_builings[[2]][!is.na(results_builings[[8]])],
   #                              na.omit(results_builings[[8]]))

  mdae_buildings <- c()
  for(i in seq_len(4)){
    mdae_buildings[i] <-
      stats::median(abs((results_builings[[2]][!is.na(results_builings[[i+4]])]
                         - na.omit(results_builings[[i+4]]))))
  }

  #mdae_null_build <- stats::median(abs((results_builings[[2]] - results_builings[[5]])))
  #mdae_og_build <- stats::median(abs((results_builings[[2]] - results_builings[[6]])))
  #mdae_new_build <- stats::median(abs((results_builings[[2]][!is.na(results_builings[[7]])] -
  #                                       na.omit(results_builings[[7]]))))
  #mdae_rf_build <- stats::median(abs((results_builings[[2]][!is.na(results_builings[[8]])] -
  #                                      na.omit(results_builings[[8]]))))


  # Partitioning based on observations
 ## setting each observation as being in fold 1-5
  obs_nums <- sample(rep_len(seq_len(k),nrow(data)))

  test_obs <- obs_train_data <- obs_test_data <-
    obs_fold_results <- vector("list", k)
  for(i in seq_len(k)){
    obs_train_data[[i]] <- data[obs_nums != i,]
    obs_test_data[[i]] <- data[obs_nums == i,]
    obs_fold_results[[i]] <- gr_cv(obs_train_data[[i]], obs_test_data[[i]],
                                   formula1 = formula1,
                                   forumula2 = formula2,
                                   rf_formula = rf_formula)
  }


  results_obs <- list()
  for (i in 1:8){
    results_obs[[i]] <-
      unlist(lapply(obs_fold_results, function(sub_list) sub_list[[i]]))
  }

  rmse_obs <- c()
  for(i in seq_len(4)){
    rmse_obs[i] <-
      Metrics::rmse(results_obs[[2]][!is.na(results_obs[[i+4]])],
                    na.omit(results_obs[[i+4]]))
  }


  mdae_obs <- c()
  for(i in seq_len(4)){
    mdae_obs[i] <-
      stats::median(abs((results_obs[[2]][!is.na(results_obs[[i+4]])] -
                         na.omit(results_obs[[i+4]]))))
  }


  #sqrt_gr_test_obs <- unlist(lapply(obs_fold_results,
  #                                  function(sub_list) sub_list[[1]]))
  #gr_test_obs <- unlist(lapply(obs_fold_results,
  #                             function(sub_list) sub_list[[2]]))
  #og_sqrt_preds_obs <- unlist(lapply(obs_fold_results,
  #                                   function(sub_list) sub_list[[3]]))
  #new_sqrt_preds_obs <- unlist(lapply(obs_fold_results,
  #                                    function(sub_list) sub_list[[4]]))
  #og_gr_preds_obs <- unlist(lapply(obs_fold_results,
  #                                 function(sub_list) sub_list[[5]]))
  #new_gr_preds_obs <- unlist(lapply(obs_fold_results,
  #                                  function(sub_list) sub_list[[6]]))
  #rf_gr_preds_obs <- unlist(lapply(obs_fold_results,
  #                                 function(sub_list) sub_list[[7]]))
  #train_avg_obs <- unlist(lapply(obs_fold_results,
  #                               function(sub_list) sub_list[[8]]))




  #rmse(sqrt_gr_test, og_sqrt_preds)
  #rmse(sqrt_gr_test[!is.na(new_sqrt_preds)], na.omit(new_sqrt_preds))

  #median(abs(sqrt_gr_test - og_sqrt_preds))
  #median(abs(sqrt_gr_test[!is.na(new_sqrt_preds)] - na.omit(new_sqrt_preds)))

  #rmse_null_obs <- Metrics::rmse(gr_test_obs, train_avg_obs)
  #rmse_og_obs <- Metrics::rmse(gr_test_obs, og_gr_preds_obs)
  #rmse_new_obs <- Metrics::rmse(gr_test_obs[!is.na(new_gr_preds_obs)],
  #                             na.omit(new_gr_preds_obs))
  #rmse_rf_obs <- Metrics::rmse(gr_test_obs[!is.na(rf_gr_preds_obs)],
  #                             na.omit(rf_gr_preds_obs))

  #mdae_null_obs <- stats::median(abs((gr_test_obs - train_avg_obs)))
  #mdae_og_obs <- stats::median(abs((gr_test_obs - og_gr_preds_obs)))
  #mdae_new_obs <- stats::median(abs((gr_test_obs[!is.na(new_gr_preds_obs)] -
  #                                     na.omit(new_gr_preds_obs))))
  #mdae_rf_obs <- stats::median(abs((gr_test_obs[!is.na(rf_gr_preds_obs)] -
  #                                    na.omit(rf_gr_preds_obs))))


  results <- rbind(rmse_buildings, mdae_buildings, rmse_obs, mdae_obs)
  colnames(results) <- c("null model", "original model", "new model",
                         "random forest")


  #results <- c(rmse_null, rmse_og_build, rmse_new_build, rmse_rf_build,
  #             mdae_null_build, mdae_og_build, mdae_new_build, mdae_rf_build,
  #             rmse_null_obs, rmse_og_obs, rmse_new_obs, rmse_rf_obs,
  #             mdae_null_obs, mdae_og_obs, mdae_new_obs, mdae_rf_obs)

  #names(results) <- c("Null model RMSE buildings",
  #                    "Original model rmse buildings",
  #                    "New Model rmse builings",
  #                   "Random Forest RMSE buildings",
  #                    "Null model med abs error buildings",
  #                    "Original model med abs error buildings",
  #                    "New Model med abs erroor builings",
  #                    "Random Forest med abd error buildings",
  #                    "Null Model RMSE obs",
  #                    "Original model rmse obs",
  #                    "New Model rmse obs",
  #                    "Random Forest RMSE obs",
  #                    "Null model median abd error obs",
  #                    "Original model med abs error obs",
  #                    "New Model med abs erroor obs",
  #                    "Random Forest med abd error obs")
  results

}
