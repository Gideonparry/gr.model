library(Metrics)
library(randomForest)

data <- read.csv("C:\\Users\\bean_student\\Documents\\gr_model_data.csv")
data2 <- data
data2$Exposure <- ifelse(is.na(data2$Exposure), 1, data2$Exposure)
set.seed(123)

## taking sample to partition buildings
train_nums <- sample(length(unique(data$building_code)),
                     length(unique(data$building_code))*(2/3))

## separating out the buildings
train_buildings <- unique(data$building_code)[train_nums]
test_buildings <- unique(data$building_code)[-train_nums]

## creating the datasets
train_data <- data[data$building_code %in% train_buildings,]
test_data <- data[data$building_code %in% test_buildings,]

## using original model
original_model <- lm(sqrtgr ~ logground, train_data)
original_prediction <- predict(original_model, test_data)

## getting rmse and median absoloute error
rmse(test_data$sqrtgr, original_prediction)
abs_error_og <- abs(original_prediction - test_data$sqrtgr)
median(abs_error_og)


## repeating the above with my proposed linear model
lin_mod <-  lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                 log(Size) + temp_avg + Heated + Parapet,
               data = train_data)
lin_pred <- predict(lin_mod, test_data)

rmse(test_data$sqrtgr[!is.na(lin_pred)], na.omit(lin_pred))

abs_error_lin <- abs(na.omit(lin_pred) - test_data$sqrtgr[!is.na(lin_pred)])
median(abs_error_lin)


## comparing to averaging all sqrtgr
avg_pred <- rep(mean(test_data$sqrtgr),length(test_data$sqrtgr))
rmse(test_data$sqrtgr, avg_pred)

abs_error_avg <- abs(avg_pred - test_data$sqrtgr)
median(abs_error_avg)


# comparing accuracy for gr (not sqrt) each method to make later comparisons
# more useful

og_gr_pred <- original_prediction^2
lin_gr_pred <- lin_pred^2

rmse(test_data$gr, og_gr_pred)
median(abs(test_data$gr - og_gr_pred))

rmse(test_data$gr[!is.na(lin_pred)], na.omit(lin_gr_pred))
median(abs(test_data$gr[!is.na(lin_gr_pred)] - na.omit(lin_gr_pred)))


#################### Trying with imputation on Exposure ########################

train_data2 <- data2[data2$building_code %in% train_buildings,]
test_data2 <- data2[data2$building_code %in% test_buildings,]


lin_mod2 <-  lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                 log(Size) + temp_avg + Heated + Parapet,
               data = train_data2)
lin_pred2 <- predict(lin_mod2, test_data2)

## Looking at RMSE of all of them
rmse(test_data$sqrtgr, original_prediction)
rmse(test_data$sqrtgr[!is.na(lin_pred)], na.omit(lin_pred))
rmse(test_data2$sqrtgr[!is.na(lin_pred2)], na.omit(lin_pred2))

## comparing median absolute errors

abs_error_lin2 <- abs(na.omit(lin_pred2) - test_data2$sqrtgr[!is.na(lin_pred2)])

median(abs_error_og)
median(abs_error_lin)
median(abs_error_lin2)

## squaring the squared GR
lin_gr_pred2 <- lin_pred2^2

rmse(test_data$gr, og_gr_pred)
rmse(test_data$gr[!is.na(lin_pred)], na.omit(lin_gr_pred))
rmse(test_data2$gr[!is.na(lin_pred2)], na.omit(lin_gr_pred2))


median(abs(test_data$gr - og_gr_pred))
median(abs(test_data$gr[!is.na(lin_gr_pred)] - na.omit(lin_gr_pred)))
median(abs(test_data2$gr[!is.na(lin_gr_pred2)] - na.omit(lin_gr_pred2)))




###### Random Forest
forest_train1 <- na.omit(train_data[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])
forest_test1 <- na.omit(test_data[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])


train_rf <- randomForest(formula = gr ~ . -building_code -city_code -season,
                         data =forest_train1)
varImpPlot(train_rf)

forest_preds1 <- predict(train_rf, forest_test1)
rmse(forest_test1$gr, forest_preds1)
median(abs(forest_test1$gr - forest_preds1))


### trying with imputed data
forest_train2 <- na.omit(train_data2[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])
forest_test2 <- na.omit(test_data2[,c(2:5, 7, 11, 13, 19:22, 25:27, 33, 35)])

train_rf2 <- randomForest(formula = gr ~ . -building_code -city_code -season,
                         data =forest_train2)
varImpPlot(train_rf2)

forest_preds2 <- predict(train_rf2, forest_test2)
rmse(forest_test2$gr, forest_preds2)
median(abs(forest_test2$gr - forest_preds2))


# comparing accuracy for all models. Order is original model, linear without
# imputation, linear with imputation, rf without imputation, rf with imputation.

rmse(test_data$gr, og_gr_pred)
rmse(test_data$gr[!is.na(lin_pred)], na.omit(lin_gr_pred))
rmse(test_data2$gr[!is.na(lin_pred2)], na.omit(lin_gr_pred2))
rmse(forest_test1$gr, forest_preds1)
rmse(forest_test2$gr, forest_preds2)


median(abs(test_data$gr - og_gr_pred))
median(abs(test_data$gr[!is.na(lin_gr_pred)] - na.omit(lin_gr_pred)))
median(abs(test_data2$gr[!is.na(lin_gr_pred2)] - na.omit(lin_gr_pred2)))
median(abs(forest_test1$gr - forest_preds1))
median(abs(forest_test2$gr - forest_preds2))


## Random forest is worse in both cases. Maybe another apporach is better.
# Maybe there is some overfitting in linear models. It seems the imputed data
# is not working well however.
