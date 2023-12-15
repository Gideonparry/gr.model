data <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\complete_data.csv")
metadata <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\gr_meta_ca_all.csv")
data$season <- rep(NA, nrow(data))
data$date <- as.Date(data$date)


## try assumption of 1 for missing exposure, 0 for heated, insulated and parpaet



data$season <- ifelse((data$date > as.Date("1957-07-01") &
                         data$date < as.Date("1958-07-01")), 2, data$season)
data$season <- ifelse((data$date > as.Date("1958-07-01") &
                         data$date < as.Date("1959-07-01")), 3, data$season)
data$season <- ifelse((data$date > as.Date("1959-07-01") &
                         data$date < as.Date("1960-07-01")), 4, data$season)
data$season <- ifelse((data$date > as.Date("1960-07-01") &
                         data$date < as.Date("1961-07-01")), 5, data$season)
data$season <- ifelse((data$date > as.Date("1961-07-01") &
                         data$date < as.Date("1962-07-01")), 6, data$season)
data$season <- ifelse((data$date > as.Date("1962-07-01") &
                         data$date < as.Date("1963-07-01")), 7, data$season)
data$season <- ifelse((data$date > as.Date("1963-07-01") &
                         data$date < as.Date("1964-07-01")), 8, data$season)
data$season <- ifelse((data$date > as.Date("1964-07-01") &
                         data$date < as.Date("1965-07-01")), 9, data$season)
data$season <- ifelse((data$date > as.Date("1965-07-01") &
                         data$date < as.Date("1966-07-01")), 10, data$season)
data$season <- ifelse((data$date > as.Date("1966-07-01") &
                         data$date < as.Date("1967-07-01")), 11, data$season)

################# summarise by building code and season #####################


library(dplyr)
library(lubridate)
library(tidyr)
library(zoo)


ground_max <- data %>%
  dplyr::group_by(building_code, city_code, season) %>%
  dplyr::filter(measurement == "ground") %>%
  dplyr::summarise(ground_max = max(value))



roof_max <- data %>%
  dplyr::group_by(building_code, city_code, season) %>%
  dplyr::filter(mma == "avg") %>%
  dplyr::summarise(roof_max = max(value))

gr_data <- inner_join(ground_max, roof_max, by = c("building_code", "city_code",
                                                   "season"))
gr_data$gr <- gr_data$roof_max / gr_data$ground_max



### filtering out the arch hangars
arch_hangars <- c("clab02", "cxbc02", "nbon02", "oton07", "wnmb04")

gr_data2 <- gr_data %>%
  dplyr::filter(!(building_code %in% arch_hangars))
nrow(gr_data)
nrow(gr_data2)


### reproducing linear model
gr_data2$sqrtgr <- sqrt(gr_data2$gr)
gr_data2$logground <- log(gr_data2$ground_max)

model <- lm(sqrtgr ~ logground, data = gr_data2)
summary(model)

#### getting average wind and temps

wind_avgs <-  data %>%
  dplyr::group_by(city_code, season, measurement) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(wind_avg = mean(value), start_date = min(date),
                   end_date = max(date)) %>%
  dplyr::filter(month(start_date) != month(end_date))


temp_avgs <-  data %>%
  dplyr::group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "temp") %>%
  dplyr::summarise(temp_avg = mean(value), start_date = min(date),
                   end_date = max(date)) %>%
  dplyr::filter(month(start_date) != month(end_date))
nrow(temp_avgs)

gr_data3 <- left_join(gr_data2, wind_avgs, by = c("city_code", "season"))


gr_data_weather <- left_join(gr_data3, temp_avgs, by = c("city_code"))



gr_data_weather$sqrtgr <- sqrt(gr_data_weather$gr)
gr_data_weather$logground <- log(gr_data_weather$ground_max)

model <- lm(sqrtgr ~ logground, data = gr_data_weather)
summary(model)

model2 <- lm(sqrtgr ~ logground + wind_avg + temp_avg, gr_data_weather)
summary(model2)


pairs(gr_data_weather[,c(7,8,10,12)])

gr_all <- inner_join(gr_data_weather, metadata, by = c("building_code", "city_code"))

gr_all$roofflat <- ifelse(gr_all$Roof_Type == "Flat" , 1, 0)

model3 <- lm(sqrtgr ~ logground + wind_avg + temp_avg + roofflat +
               Exposure + Heated + Insulated + lat + long, gr_all)
summary(model3)
min(na.omit(gr_all$wind_avg))

################# other ways to do weather ##################################
above_freeze <-  data %>%
  dplyr::group_by(city_code, measurement, season) %>%
  dplyr::filter(measurement == "temp") %>%
  dplyr::summarise(above_freeze = sum(value > 32)/length(value), start_date = min(date),
                   end_date = max(date)) %>%
  dplyr::filter(month(start_date) != month(end_date))

# Group the data by building_code and season, and apply the function to each group
result_list <- data %>%
  dplyr::group_by(building_code, season) %>%
  dplyr::filter(measurement == "ground") %>%
  dplyr::do(add_missing_dates(.))

# Combine the result list into a single data frame
final_result_df <- bind_rows(result_list)

final_result_df$measurement = "ground"
final_result_df$city_code <- na.locf(final_result_df$city_code)
final_result_df$building_code <- na.locf(final_result_df$building_code)
final_result_df$season <- na.locf(final_result_df$season)
final_result_df$value <- linear_impute(final_result_df$value)


winter_wind <- data %>%
  dplyr::group_by(city_code, date) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(wind_val = mean(value)) %>%
  dplyr::inner_join(final_result_df, by =  c("city_code", "date")) %>%
  dplyr::mutate(snow = ifelse(value > 1, 1, 0)) %>%
  dplyr::group_by(building_code) %>%
  dplyr::summarise(winter_wind = sum(wind_val > 10 & snow == 1)/sum(snow == 1),
                   start_date = min(date),
                   end_date = max(date))






View(winter_wind)





gr_total <- inner_join(gr_all, winter_wind, by = c("building_code")) %>%
  inner_join(above_freeze, by = c("city_code", "season"))

colnames(gr_total)
gr_total <- gr_total[,c(-11,-12,-15,-16,-36,-37, -40, -41 )]

## doing og model with remaining data
model1 <- lm(sqrtgr ~ logground, gr_total)
summary(model1)

gr_total$residual <- residuals(model1)

# Not taking size of parapet into account, just if it's there or not
gr_total$Parapet <- ifelse(gr_total$Parapet > 0, 1, 0)

#### models to predict residual
model4 <- lm(residual ~ winter_wind + above_freeze, gr_total)
summary(model4)
# adjusted R^2 0.06935

model5 <- lm(residual ~ wind_avg + temp_avg, gr_total)
summary(model5)
# adjusted R^2 0.04645

model6 <- lm(residual ~ winter_wind + temp_avg, gr_total)
summary(model6)
# adjusted R^2 0.09431

model7 <- lm(residual ~ wind_avg + above_freeze, gr_total)
summary(model7)
# adjusted R^2 0.05321


resid_data <- gr_total[,c(10, 12, 19:21, 23:26, 28:30, 31, 33:34)]

resid_no_na <- na.omit(resid_data)

resid_all <- lm(residual ~ ., resid_no_na)
resid_int <- lm(residual ~ 1, resid_no_na)


resid_forward <- step(resid_int, direction='both', scope=formula(resid_all),
                      trace=0)

resid_backward <- step(resid_all, direction='both', scope=formula(resid_all),
                       trace=0)

summary(resid_backward)
summary(resid_forward)

colnames(gr_total)

## looking at tree for potential interactions
library(rpart)
library(rpart.plot)
tree <- rpart(formula = residual ~ roofflat + Exposure + winter_wind  +
                Size + Heated + Parapet, data = resid_no_na)
prp(tree)

pruned_tree <- prune(tree, cp = 0.1)
prp(pruned_tree)
## looking at transformations

gr_vars <- gr_total[,c(7,8,30,23,31,28,20,24)]
pairs(gr_vars)
par(mfrow = c(2, 2))
plot(gr_vars$sqrtgr,(gr_vars$winter_wind))
plot(gr_vars$sqrtgr,log(gr_vars$winter_wind))
plot(gr_vars$sqrtgr,sqrt(gr_vars$winter_wind))
plot(gr_vars$sqrtgr,(gr_vars$winter_wind)^2)

## log appears to be the closest to linear.


### looking at size
par(mfrow = c(2, 2))
plot(gr_vars$sqrtgr,(gr_vars$Size))
plot(gr_vars$sqrtgr,log(gr_vars$Size))
plot(gr_vars$sqrtgr,sqrt(gr_vars$Size))
plot(gr_vars$sqrtgr,(gr_vars$Size)^2)
## again log looks best

## looking at lat
par(mfrow = c(2, 2))
plot(gr_vars$sqrtgr,(gr_vars$lat))
plot(gr_vars$sqrtgr,log(gr_vars$lat))
plot(gr_vars$sqrtgr,sqrt(gr_vars$lat))
plot(gr_vars$sqrtgr,(gr_vars$lat)^2)


par(mfrow = c(1, 1))
## these all look the same


## model with varibales suggested by forward regression
model8 <- lm(sqrtgr ~ logground + roofflat + Exposure + log(winter_wind) +
               lat + log(Size) + Heated, gr_total)
summary(model8)

## transforming those varaibles and retrying step procedures
resid_transform <- resid_no_na
resid_transform$winter_wind <- log(resid_transform$winter_wind)
resid_transform$Size <- log(resid_transform$Size)

####### retrying step
resid_all2 <- lm(residual ~ ., resid_transform)
resid_int2 <- lm(residual ~ 1, resid_transform)


resid_forward2 <- step(resid_int2, direction='both', scope=formula(resid_all2),
                       trace=0)

resid_backward2 <- step(resid_all2, direction='both', scope=formula(resid_all2),
                        trace=0)

summary(resid_backward2)
summary(resid_forward2)


par(mfrow = c(1, 1))
plot(fitted(resid_forward2), resid(resid_forward2))
qqnorm(resid(resid_forward2), pch = 1, frame = FALSE)
qqline(resid(resid_forward2), col = "steelblue", lwd = 2)


# Size is odd. It looks like the big buildings highly influence the results,
# but then when we take the log of size their influence significantly diminishes

# Looking at tree with new suggestion

tree2 <- rpart(formula = residual ~ roofflat + Exposure + winter_wind + lat,
               data = resid_transform)

prp(tree2)

## checking new suggested model
model9 <- lm(sqrtgr ~ logground + roofflat + Exposure + log(winter_wind) + lat,
             data = gr_total)

summary(model9)
plot(fitted(model9), resid(model9))


qqnorm(resid(model9), pch = 1, frame = FALSE)
qqline(resid(model9), col = "steelblue", lwd = 2)

shapiro.test(resid(model9))


### looks ok other than a few outlier points
library(olsrr)

ols_plot_cooksd_chart(model9)
# 105, 302, 304, 158

ols_plot_resid_stand(model9)
# 105, 158, 33`, 324`

ols_plot_resid_lev(model9)
# 105, 158, 300, 302, 304

head(sort(resid(model9)))
head(sort(resid(model9),TRUE))
## removing big outliers
gr_total_no_out <- gr_total[-c(134, 187, 196, 360),]

model10 <- lm(sqrtgr ~ logground + roofflat + Exposure + log(winter_wind) + lat,
              data = gr_total_no_out)

summary(model10)
plot(fitted(model10), resid(model10))


qqnorm(resid(model10), pch = 1, frame = FALSE)
qqline(resid(model10), col = "steelblue", lwd = 2)

shapiro.test(resid(model10))


## removing those 4 points seems to have done a lot for normality assumption
# On the very low end, residuals are all positive. Other than that I don't see
# much of a pattern


### no geography forward and backward
resid_no_geo <- resid_no_na[,-10:-11]

tree_resid <- rpart(formula = residual ~ roofflat + Exposure + winter_wind + temp_avg
                    + Size + Heated, data = resid_no_na)
prp(tree_resid)
# roofflat and exposure could interact

resid_all3 <- lm(residual ~ . + roofflat*Exposure + roofflat*winter_wind,
                 resid_no_geo[resid_no_geo$residual <= 1,])
resid_int3 <- lm(residual ~ 1, resid_no_geo[resid_no_geo$residual <= 1,])

resid_forward3 <- step(resid_int3, direction='both', scope=formula(resid_all3),
                       trace=1)

resid_backward3 <- step(resid_all3, direction='both', scope=formula(resid_all3),
                        trace=1)

summary(resid_backward3)
summary(resid_forward3)


#positive coeficents on slope and heated don't make sense.

library(glmnet)
y <- resid_no_geo$residual[resid_no_geo$residual <= 1]
x <- data.matrix(resid_no_geo[resid_no_geo$residual <= 1,
                              colnames(resid_no_geo)[1:12]])
cv_model <- cv.glmnet(x, y, alpha = 1)


best_lambda <- cv_model$lambda.min
best_lambda

plot(cv_model)
best_model <- glmnet(x, y, alpha = 1, lambda = best_lambda)
coef(best_model)

# The lasso model eliminates slope, and it was confusing so I think I'll leave
# it out. Insulated was also not included here. I'll try with and without
plot(gr_total$gr,gr_total$Heated)
median(na.omit(gr_total$gr[gr_total$Heated == 1]))
median(na.omit(gr_total$gr[gr_total$Heated == 0]))

plot(resid_no_geo$residual,resid_no_geo$Heated)
median(resid_no_geo$residual[resid_no_geo$Heated == 1])
median(resid_no_geo$residual[resid_no_geo$Heated == 0])


# Heated having a positive coefficient makes even less sense now

### looking at potentional transformations for temp
par(mfrow = c(2, 2))
plot(gr_total$sqrtgr,(gr_total$temp_avg))
plot(gr_total$sqrtgr,log(gr_total$temp_avg))
plot(gr_total$sqrtgr,sqrt(gr_total$temp_avg))
plot(gr_total$sqrtgr,(gr_total$temp_avg)^2)
par(mfrow = c(1, 1))

## genuinley looks best untransformed

model11 <- lm(sqrtgr ~ logground + roofflat*Exposure + log(winter_wind) + roofflat*winter_wind +
                log(Size) + temp_avg + Heated + Insulated + Parapet,
              data = gr_total)

summary(model11)
plot(fitted(model11), resid(model11))


qqnorm(resid(model11), pch = 1, frame = FALSE)
qqline(resid(model11), col = "steelblue", lwd = 2)

shapiro.test(resid(model11))

## Looks like it assumptions would be met without outliers

# the is 1 observation with GR over 3. The graph matches, but there is probably
# some mistake so that will be removed

model12 <- lm(sqrtgr ~ logground + roofflat*Exposure  + roofflat*winter_wind +
                log(Size) + temp_avg + Heated + Insulated + Parapet,
              data = gr_total)

summary(model12)
plot(fitted(model12), resid(model12))


qqnorm(resid(model12), pch = 1, frame = FALSE)
qqline(resid(model12), col = "steelblue", lwd = 2)

shapiro.test(resid(model12))

library(psych)
model_vars <- gr_total[,c("sqrtgr", "logground", "roofflat", "Exposure",
                          "winter_wind", "temp_avg", "Size", "Heated", "Insulated")]
model_vars$winter_wind <- log(model_vars$winter_wind)
model_vars$Size <- log(model_vars$Size)

pairs.panels(model_vars)


## heated and insulated have multicolieiarity. 0.77 correlation Insulated will
# be dropped since it is the less significant of the 2 and npt recomenned by
# Lasso


### New model without heated
model13 <- lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                log(Size) + temp_avg + Heated + Parapet,
              data = gr_total)

summary(model13)
plot(fitted(model13), resid(model13),
     main = "Residual Plot With Outlier Point",
     xlab = "Predicted Value",
     ylab = "Residual Value")

abline(h = 0)


qqnorm(resid(model13), pch = 1, frame = FALSE,
       main = "QQ Plot With Outlier Point")
qqline(resid(model13), col = "steelblue", lwd = 2)

shapiro.test(resid(model13))

## after dropping big gr (>3)
model14 <- lm(sqrtgr ~ logground + roofflat*Exposure + roofflat*winter_wind +
                log(Size) + temp_avg + Heated + Parapet,
              data = gr_total[gr_total$gr <= 2,])
summary(model14)
plot(fitted(model14), resid(model14),
     main = "Residual Plot Without Outlier Point",
     xlab = "Predicted Value",
     ylab = "Residual Value")

abline(h = 0)


qqnorm(resid(model14), pch = 1, frame = FALSE,
       main = "QQ Plot Without Outlier Point")

qqline(resid(model14), col = "steelblue", lwd = 2)

shapiro.test(resid(model14))




summary(model13)
summary(model14)


############ report plots
par(mfrow = c(2, 2))
plot((gr_total$Size),gr_total$sqrtgr,
     main = " Size No transformation",
     xlab = "Size",
     ylab = "sqrtgr")
plot(log(gr_total$Size),gr_total$sqrtgr,
     main = " Size log transformation",
     xlab = "Log Size",
     ylab = "sqrtgr")

plot((gr_total$winter_wind),gr_total$sqrtgr,
     main = "Winter Wind No transformation",
     xlab = "Winter Wind",
     ylab = "sqrtgr")
plot(log(gr_total$winter_wind),gr_total$sqrtgr,
     main = "Winter Wind log transformation",
     xlab = "Log Winter Wind",
     ylab = "sqrtgr")


write.csv(gr_total[gr_total$gr <= 2,], "data-raw//wind_snow_agg.csv")
