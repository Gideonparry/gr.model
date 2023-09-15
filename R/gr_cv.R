#' Returns the rsme and median absolute error of different models
#'
#' Takes train and test data and comuptes different models to compare accuracy
#' measures
#'
#' @param train_data The training data
#' @param test_data The testing data
#'
#'
#' @import Metrics
#' @import randomForest
#' @import e1071
#'


gr_cv <- function(train_data, test_data){
  # Taking the original model with the specified train and test data
  original_model <- lm(sqrtgr ~ logground, train_data)
  original_prediction <- predict(original_model, test_data)

  rmse_og_sqrt <- rmse(test_data$sqrtgr, original_prediction)
  mdae_og_sqrt <- median(abs(original_prediction - test_data$sqrtgr))


  # Following the process with the linear model
  lin_mod <-  lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                   log(Size) + temp_avg + Heated + Parapet,
                 data = train_data)
  lin_pred <- predict(lin_mod, test_data)

  rmse_mlr_sqrt <- rmse(test_data$sqrtgr[!is.na(lin_pred)], na.omit(lin_pred))
  mdae_mlr_sqrt <-
    median(abs(na.omit(lin_pred) - test_data$sqrtgr[!is.na(lin_pred)]))



  # Squaring the square root for common units

  og_gr_pred <- original_prediction^2
  lin_gr_pred <- lin_pred^2

  rmse_og <- rmse(test_data$gr, og_gr_pred)
  mdae_og <- median(abs(test_data$gr - og_gr_pred))

  rsme_mlr <- rmse(test_data$gr[!is.na(lin_pred)], na.omit(lin_gr_pred))
  mdae_mlr <- median(abs(test_data$gr[!is.na(lin_gr_pred)] - na.omit(lin_gr_pred)))

  ## Random Forest model check

  forest_train <- na.omit(train_data[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])
  forest_test <- na.omit(test_data[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])

  train_rf <- randomForest(formula = gr ~ . -building_code -city_code -season,
                           data =forest_train)
  forest_preds <- predict(train_rf, forest_test)


  rmse_forest <- rmse(forest_test$gr, forest_preds)
  mdae_forest <- median(abs(forest_test$gr - forest_preds))







  pred_metrics <- c("Original model RMSE sqrt", "New model RSME sqrt",
                    "Original model median abs error sqrt",
                    "New model median abs error sqrt", "Original model RMSE",
                    "New model RMSE", "Random forest RMSE",
                    "Original Model median abs error",
                    "New Model median abs error",
                    "Random forest median abs error")
  pred_results <- c(rmse_og_sqrt, rmse_mlr_sqrt, mdae_og_sqrt, mdae_mlr_sqrt,
                    rmse_og, rsme_mlr, rmse_forest, mdae_og, mdae_mlr,
                    mdae_forest)

  cbind(pred_metrics,pred_results)
}
