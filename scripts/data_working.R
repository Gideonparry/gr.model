data <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\complete_data.csv")
metadata <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\gr_meta_ca_all.csv")
data$season <- rep(NA, nrow(data))
data$date <- as.Date(data$date)






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
ground_max <- data %>%
  group_by(building_code, city_code, season) %>%
  filter(measurement == "ground") %>%
  summarise(ground_max = max(value))


roof_max <- data %>%
  group_by(building_code, city_code, season) %>%
  filter(mma == "avg") %>%
  summarise(roof_max = max(value))

gr_data <- inner_join(ground_max, roof_max, by = c("building_code", "city_code",
                                                   "season"))
gr_data$gr <- gr_data$roof_max / gr_data$ground_max
View(gr_data)


### filtering out the arch hangars
arch_hangars <- c("clab02", "cxbc02", "nbon02", "oton07", "wnmb04")

gr_data2 <- gr_data %>%
  filter(!(building_code %in% arch_hangars))
nrow(gr_data)
nrow(gr_data2)


### reporducing linear model
gr_data2$sqrtgr <- sqrt(gr_data2$gr)
gr_data2$logground <- log(gr_data2$ground_max)

model <- lm(sqrtgr ~ logground, data = gr_data2)
summary(model)

#### getting average wind and temps
wind_avgs <-  data %>%
  group_by(city_code, season, measurement) %>%
  filter(measurement == "wind") %>%
  summarise(wind_avg = mean(value))

temp_avgs <-  data %>%
  group_by(city_code, season, measurement) %>%
  filter(measurement == "temp") %>%
  summarise(temp_avg = mean(value))
nrow(wind_avgs)
nrow(temp_avgs)

gr_data3 <- left_join(gr_data2, wind_avgs, by = c("city_code", "season"))
View(gr_data3)

gr_data_weather <- left_join(gr_data3, temp_avgs, by = c("city_code", "season"))
View(gr_data_weather)


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
  group_by(city_code, measurement, season) %>%
  filter(measurement == "temp") %>%
  summarise(above_freeze = sum(value > 32)/length(value))


### percentage days wind speed is over 10
over10 <-  data %>%
  group_by(city_code, measurement, season) %>%
  filter(measurement == "wind") %>%
  summarise(over10 = sum(value > 10)/length(value))





gr_total <- inner_join(gr_all, over10, by = c("city_code", "season")) %>%
  inner_join(above_freeze, by = c("city_code", "season"))

## doing og model with remaining data
model1 <- lm(sqrtgr ~ logground, gr_total)
summary(model1)

gr_total$residual <- residuals(model1)

#### models to predict residual
model4 <- lm(residual ~ over10 + above_freeze, gr_total)
summary(model4)
# adjusted R^2 0.06935

model5 <- lm(residual ~ wind_avg + temp_avg, gr_total)
summary(model5)
# adjusted R^2 0.04645

model6 <- lm(residual ~ over10 + temp_avg, gr_total)
summary(model6)
# adjusted R^2 0.09431

model7 <- lm(residual ~ wind_avg + above_freeze, gr_total)
summary(model7)
# adjusted R^2 0.05321


resid_data <- gr_total[,c(10, 12, 19:21, 23:25, 28:30, 32, 34:35)]

resid_no_na <- na.omit(resid_data)

resid_all <- lm(residual ~ ., resid_no_na)
resid_int <- lm(residual ~ 1, resid_no_na)


resid_forward <- step(resid_int, direction='both', scope=formula(resid_all),
                      trace=0)

resid_backward <- step(resid_all, direction='both', scope=formula(resid_all),
                       trace=0)

summary(resid_backward)

#### eval height wasn't included in either. Not looking too useful. Getting
## rid of it could reduce NAs.
