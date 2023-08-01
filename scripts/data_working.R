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

################# other ways to do wind ##################################
wind_max <-  data %>%
  group_by(city_code, date, measurement, season) %>%
  filter(measurement == "wind") %>%
  summarise(wind_max = max(value))
View(wind_max)

### percentage days above 25
over25 <-  data %>%
  group_by(city_code, measurement, season) %>%
  filter(measurement == "wind") %>%
  summarise(over25 = sum(value > 25)/length(value))
View(over25)




gr_wind <- inner_join(gr_all, over25, wind_max, by = c("city_code", "season"))
model4 <- lm(sqrtgr ~ logground +  Exposure + wind_avg + temp_avg +
             roofflat, gr_wind)
summary(model4)

##### roofflat does better than slope in models. Average of temp and wind seems
## to add to model as well
