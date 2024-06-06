#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param data The full data to perform models on
#' @param k Number of Cross Validation folds
#' @param formula1 The 1st formula to use. Default is logground
#' @param formula2 The 2nd fromula to use Returns as "new model"
#' @param rf_formula The formula to use for the random forest
#'
#' @import randomForest
#' @import stats
#' @export

cross_valid_acc <- function(data, k = 5,
                            formula1 = "sqrtgr ~ logground",
                            formula2 = "sqrtgr ~ logground + winter_wind_all",
                            rf_formula = gr ~ ground_max + roofflat + Exposure +
                            winter_wind + Size + temp_avg + Heated + Parapet) {
  seeds <- sample(1:10000, 25)
  results_list <- list()
  for (i in 1:25) {
    set.seed(seeds[i])
    results_list[[i]] <- acc_test(
      data = data,
      formula1 = formula1,
      formula2 = formula2,
      rf_formula = rf_formula
    )
  }

  ## taking avg for avg wind speeds
  result_sum <- results_list[[1]]
  for (i in 2:25) {
    result_sum <- result_sum + results_list[[i]]
  }
  result_avg <- result_sum / 25
  t(result_avg)
}
