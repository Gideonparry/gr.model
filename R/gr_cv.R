#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param train_data The training data
#' @param test_data The testing data
#' @param formula1 The 1st formula to use. Default is logground
#' @param formula2 The 2nd fromula to use Returns as "new model"
#' @param rf_formula The formula to use for the random forest
#'
#'
#' @import Metrics
#' @import randomForest
#' @import stats


gr_cv <- function(train_data, test_data,
                  formula1 = "sqrtgr ~ logground",
                  forumula2 = "sqrtgr ~ logground + roofflat*Exposure +
                  roofflat*winter_wind +
                   log(Size) + temp_avg + Heated + Parapet",
                  rf_formula = gr ~ ground_max + roofflat + Exposure +
                    winter_wind + Size + temp_avg + Heated + Parapet){


  # Taking the original model with the specified train and test data
  original_model <- stats::lm(formula = formula1, train_data)
  original_prediction <- stats::predict(original_model, test_data)



  # Following the process with the linear model
  lin_mod <-  stats::lm(formula = forumula2,
                 data = train_data)
  lin_pred <- stats::predict(lin_mod, test_data)



  # Squaring the square root for common units

  og_gr_pred <- original_prediction^2
  lin_gr_pred <- lin_pred^2

  ## Random Forest model check



  ## It works as is, but making this an argument would be better
  train_rf <- randomForest::randomForest(formula = rf_formula,
                           data = train_data, na.action = na.omit)
  forest_preds <- stats::predict(train_rf, test_data)



  ## making a list of vectors of results and names to return

  results <- list(test_data$sqrtgr, test_data$gr, test_data$gr,
                  original_prediction, lin_pred, og_gr_pred, lin_gr_pred,
                  forest_preds, rep(mean(train_data$gr), length(test_data$gr)))

  names(results) <- c("Square root GR original test data",
                      "GR Original test data", "GR RF test data",
                      "original model predictions sqrt",
                      "New model predictions sqrt",
                      "Original model predictions gr",
                      "New model predictions gr", "Random Forest predictons",
                      "avg train data gr")


  results


}
