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


  rmse_buildings <- c()
  for(i in seq_len(4)){
    rmse_buildings[i] <-
      sqrt(mean((results_builings[[2]][!is.na(results_builings[[i+4]])] -
                                       na.omit(results_builings[[i+4]]))^2))
  }

  mdae_buildings <- c()
  for(i in seq_len(4)){
    mdae_buildings[i] <-
      stats::median(abs((results_builings[[2]][!is.na(results_builings[[i+4]])]
                         - na.omit(results_builings[[i+4]]))))
  }

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
      sqrt(mean((results_obs[[2]][!is.na(results_obs[[i+4]])] -
                    na.omit(results_obs[[i+4]]))^2))
  }


  mdae_obs <- c()
  for(i in seq_len(4)){
    mdae_obs[i] <-
      stats::median(abs((results_obs[[2]][!is.na(results_obs[[i+4]])] -
                         na.omit(results_obs[[i+4]]))))
  }


  results <- rbind(rmse_buildings, mdae_buildings, rmse_obs, mdae_obs)
  colnames(results) <- c("null model", "original model", "new model",
                         "random forest")
  results

}
