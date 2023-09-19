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



  # Following the process with the linear model
  lin_mod <-  lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                   log(Size) + temp_avg + Heated + Parapet,
                 data = train_data)
  lin_pred <- predict(lin_mod, test_data)



  # Squaring the square root for common units

  og_gr_pred <- original_prediction^2
  lin_gr_pred <- lin_pred^2

  ## Random Forest model check

  forest_train <- na.omit(train_data[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])
  forest_test <- na.omit(test_data[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])

  train_rf <- randomForest(formula = gr ~ . -building_code -city_code -season,
                           data =forest_train)
  forest_preds <- predict(train_rf, forest_test)



  ## making a list of vectors of results and names to return

  results <- list(test_data$sqrtgr, test_data$gr, forest_test$gr,
                  original_prediction, lin_pred, og_gr_pred, lin_gr_pred,
                  forest_preds)

  names(results) <- c("Square root GR original test data",
                      "GR Original test data", "GR RF test data",
                      "original model predictions sqrt",
                      "New model predictions sqrt",
                      "Original model predictions gr",
                      "New model predictions gr", "Random Forest predictons")


  results


}
