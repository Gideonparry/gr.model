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

gr_all <- inner_join(gr_data2, metadata, by = c("building_code", "city_code"))

################# other ways to do weather ##################################


winter_wind <-  data %>%
  dplyr::group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(winter_wind = sum(value > 10)/length(value), start_date = min(date),
                   end_date = max(date))






View(winter_wind)





gr_total <- inner_join(gr_all, winter_wind, by = c("city_code"))
colnames(gr_total)

## doing og model with remaining data
model1 <- lm(sqrtgr ~ logground, gr_total)
summary(model1)


model2 <- lm(sqrtgr ~ logground + winter_wind, gr_total)
summary(model2)

gr_total$lat <- round(gr_total$lat * 4) / 4
gr_total$long <- round(gr_total$long * 4) / 4


whole_map <-readRDS("D:/whole_map.rds")
whole_map

gr_total$new_wind <- terra::extract(whole_map,
                                    terra::vect(matrix(c(gr_total$long,
                                                         gr_total$lat),
                                                       ncol = 2),
                                                crs = terra::crs(whole_map)))[[2]]

model3 <- lm(sqrtgr ~ logground + new_wind, gr_total)
summary(model3)
summary(model2)
summary(model1)

.1825 - .1593
.1711 - .1593
0.0118/0.0232
