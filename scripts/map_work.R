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


ground_max <- data %>%
  group_by(building_code, city_code, season) %>%
  dplyr::filter(measurement == "ground") %>%
  summarise(ground_max = max(value))


roof_max <- data %>%
  group_by(building_code, city_code, season) %>%
  dplyr::filter(mma == "avg") %>%
  summarise(roof_max = max(value))

gr_data <- inner_join(ground_max, roof_max, by = c("building_code", "city_code",
                                                   "season"))

gr_data$gr <- gr_data$roof_max / gr_data$ground_max



### dplyr::filtering out the arch hangars
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

winter_wind <-  data %>%
  dplyr::group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(winter_wind = sum(value > 10)/length(value),
                   start_date = min(date),
                   end_date = max(date))




gr_wind <- inner_join(gr_data2, winter_wind, by = c("city_code"))



gr_total <- inner_join(gr_wind, metadata, by = c("building_code", "city_code"))

## OG model without obs with no wind
model2 <- lm(sqrtgr ~ logground, data = gr_total)
summary(model2)

model3 <- lm(sqrtgr ~ logground + winter_wind, data = gr_total)
summary(model3)

whole_map <- readRDS("C:\\Users\\bean_student\\Documents\\whole_map.rds")
whole_map <- terra::unwrap(whole_map)

gr_total$lat <- sapply(gr_total$lat, function(x) round(x / 0.25) * 0.25)
gr_total$long <- sapply(gr_total$long, function(x) round(x / 0.25) * 0.25)



gr_total$est_wind <-
  terra::extract(whole_map, terra::vect(matrix(c(gr_total$long, gr_total$lat),
                                               ncol = 2),
                                        crs = terra::crs(whole_map)))[[2]]

model4 <- lm(sqrtgr ~ logground + est_wind, data = gr_total)



summary(model2)
summary(model3)
summary(model4)

.1826-.1548
.1716-.1548

cor(gr_total$winter_wind,gr_total$est_wind)
