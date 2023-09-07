library(Metrics)

data <- read.csv("D:\\gr_model_data.csv")
set.seed(1234)

## taking sample to partition buildings
train_nums <- sample(length(unique(data$building_code)),
                     length(unique(data$building_code))*(2/3))

## separating out the buildings
train_buildings <- unique(data$building_code)[train_nums]
valid_buildings <- unique(data$building_code)[-train_nums]

## creating the datasets
train_data <- data[data$building_code %in% train_buildings,]
valid_data <- data[data$building_code %in% valid_buildings,]

## using original model
original_model <- lm(sqrtgr ~ logground, train_data)
original_prediction <- predict(original_model, valid_data)

## getting rmse and median absoloute error
rmse(valid_data$sqrtgr, original_prediction)
abs_error_og <- abs(original_prediction - valid_data$sqrtgr)
median(abs_error_og)


## repeating the above with my proposed linear model
lin_mod <-  lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                 log(Size) + temp_avg + Heated,
               data = train_data)
lin_pred <- predict(lin_mod, valid_data)

rmse(valid_data$sqrtgr[!is.na(lin_pred)], na.omit(lin_pred))

abs_error_lin <- abs(na.omit(lin_pred) - valid_data$sqrtgr[!is.na(lin_pred)])
median(abs_error_lin)


## comparing to averaging all sqrtgr
avg_pred <- rep(mean(valid_data$sqrtgr),length(valid_data$sqrtgr))
rmse(valid_data$sqrtgr, avg_pred)

abs_error_avg <- abs(avg_pred - valid_data$sqrtgr)
median(abs_error_avg)


