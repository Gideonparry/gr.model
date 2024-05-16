library(GGally)
library(ggplot2)
library(dplyr)
library(lubridate)
library(gr.model)


data <- read.csv("data-raw\\complete_data.csv")
metadata <- read.csv("data-raw\\gr_meta_ca_all.csv")
data$season <- rep(NA, nrow(data))
data$date <- as.Date(data$date)



## Adding season variable to data


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




ground_max <- data %>%
  group_by(building_code, city_code, season) %>%
  dplyr::filter(measurement == "ground") %>%
  summarise(ground_max = max(value))



roof_max <- data %>%
  group_by(building_code, city_code, season) %>%
  dplyr::filter(mma == "avg") %>%
  summarise(roof_max = max(value))

gr_data <- inner_join(ground_max, roof_max, by = c(
  "building_code", "city_code",
  "season"
))
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


#### getting average wind and temps


wind_avgs <- data %>%
  group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "wind") %>%
  summarise(
    wind_avg = mean(value), start_date = min(date),
    end_date = max(date)
  )


temp_avgs <- data %>%
  group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "temp") %>%
  summarise(
    temp_avg = mean(value), start_date = min(date),
    end_date = max(date)
  )
nrow(temp_avgs)

gr_data3 <- left_join(gr_data2, wind_avgs, by = c("city_code"))


gr_data_weather <- left_join(gr_data3, temp_avgs, by = c("city_code"))



gr_data_weather$sqrtgr <- sqrt(gr_data_weather$gr)
gr_data_weather$logground <- log(gr_data_weather$ground_max)

model <- lm(sqrtgr ~ logground, data = gr_data_weather)
summary(model)

model2 <- lm(sqrtgr ~ logground + wind_avg + temp_avg, gr_data_weather)
summary(model2)


pairs(gr_data_weather[, c(7, 8, 10, 12)])

## Adding building and city code

gr_all <- inner_join(gr_data_weather, metadata,
  by = c("building_code", "city_code")
)

gr_all$roofflat <- ifelse(gr_all$Roof_Type == "Flat", 1, 0)

model3 <- lm(sqrtgr ~ logground + wind_avg + temp_avg + roofflat +
               Exposure + Heated + Insulated + lat + long, gr_all)
summary(model3)
min(na.omit(gr_all$wind_avg))


################# other ways to do weather ##################################
above_freeze <- data %>%
  group_by(city_code, measurement, season) %>%
  dplyr::filter(measurement == "temp") %>%
  summarise(
    above_freeze = sum(value > 32) / length(value),
    start_date = min(date),
    end_date = max(date)
  )

### percentage days wind speed is over 10
winter_wind <- data %>%
  dplyr::group_by(city_code, measurement, season) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(
    winter_wind = sum(value > 10) / length(value),
    start_date = min(date),
    end_date = max(date)
  )




gr_total <- inner_join(gr_all, winter_wind, by = c("city_code", "season")) %>%
  left_join(above_freeze, by = c("city_code", "season"))

colnames(gr_total)
gr_total <- gr_total[, c(-11, -12, -15, -16, -37, -38, -41, -42)]





#### aggregate overall wind and temp
above_freeze_all <- data %>%
  group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "temp") %>%
  summarise(
    above_freeze_all = sum(value > 32) / length(value),
    start_date = min(date),
    end_date = max(date)
  )

### percentage days wind speed is over 10
winter_wind_all <- data %>%
  dplyr::group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(
    winter_wind_all = sum(value > 10) / length(value),
    start_date = min(date),
    end_date = max(date)
  )




gr_total <- inner_join(gr_total, winter_wind_all, by = c("city_code")) %>%
  left_join(above_freeze_all, by = c("city_code"))




#### getting average wind and temps for 3 months only
data2 <- data %>%
  dplyr::filter(lubridate::month(date) %in% c(12, 1, 2))

winter_wind_3month <- data2 %>%
  group_by(city_code, measurement) %>%
  dplyr::filter(measurement == "wind") %>%
  summarise(
    winter_wind_3month = sum(value > 10) / length(value),
    start_date = min(date), end_date = max(date)
  )

gr_total <- inner_join(gr_total, winter_wind_3month, by = c("city_code"))

############################ all this for the snow days stuff #################
# Group the data by building_code and season,
## and apply the function to each group
result_list <- data %>%
  dplyr::group_by(building_code, season) %>%
  dplyr::filter(measurement == "ground") %>%
  dplyr::do(add_missing_dates(.))

# Combine the result list into a single data frame
final_result_df <- dplyr::bind_rows(result_list)

final_result_df$measurement <- "ground"
final_result_df$city_code <- zoo::na.locf(final_result_df$city_code)
final_result_df$building_code <- zoo::na.locf(final_result_df$building_code)
final_result_df$season <- zoo::na.locf(final_result_df$season)
final_result_df$value <- linear_impute(final_result_df$value)

winter_wind_snow <- data %>%
  dplyr::group_by(city_code, date) %>%
  dplyr::filter(measurement == "wind") %>%
  dplyr::summarise(wind_val = mean(value)) %>%
  dplyr::inner_join(final_result_df, by = c("city_code", "date")) %>%
  dplyr::mutate(snow = ifelse(value > 1, 1, 0)) %>%
  dplyr::group_by(building_code) %>%
  dplyr::summarise(
    winter_wind_snow =
      sum(wind_val > 10 & snow == 1) / sum(snow == 1),
    start_date = min(date),
    end_date = max(date)
  )

gr_total <- inner_join(gr_total, winter_wind_snow, by = c("building_code"))

gr_total <- gr_total[gr_total$gr <= 2, ]



### Metric unit conversions
## converting psf to kpa
gr_total$ground_max <- gr_total$ground_max * 0.04788
gr_total$roof_max <- gr_total$roof_max * 0.04788
gr_total$logground <- log(gr_total$ground_max)


## mph to m/s
gr_total$wind_avg <- gr_total$wind_avg * 0.44704

## temp F to C
gr_total$temp_avg <- (gr_total$temp_avg - 32) * (5 / 9)

## ft^2 to m^2
gr_total$Size <- gr_total$Size * 0.09290304

gr_total$logsize <- log(gr_total$Size)


## doing og model with remaining data
model1 <- lm(sqrtgr ~ logground, gr_total)
summary(model1)






################## Plotting ggplot graphs #########################


#### Figure 2.2

ggplot(gr_total, aes(x = gr)) +
  geom_histogram(binwidth = 0.1, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  labs(
    title = "",
    x = "GR",
    y = "Frequency"
  ) +
  theme_bw()


## Figure 2.3

ggplot(gr_total[gr_total$gr <= 2, ], aes(x = logground, y = sqrtgr)) +
  geom_point() +
  labs(
    title = "",
    x = "log ground snow load",
    y = expression(sqrt(g[r]))
  ) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.5) +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 12, face = "bold")
  )


## Figure 2.4
gr_total |>
  ungroup() |>
  select(`Individual Season` = winter_wind,
         `All Aggregate` = winter_wind_all,
         `Three Month Aggregate` = winter_wind_3month,
         `Snow Day Aggregate` = winter_wind_snow) |>
  tidyr::pivot_longer(cols = everything()) |>
  ggplot(aes(x = value)) +
  geom_histogram(binwidth = 0.05, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  ylim(0, 210) +
  xlab("Proportion") +
  ylab("Frequency") +
  theme_bw() +
  theme(text = element_text(size = 16)) +
  facet_wrap(~ name, ncol = 2)
dev.off()

#### filer out useless colums
colnames(gr_total)

gr_total$Parapet <- ifelse(gr_total$Parapet > 0, 1, 0)

gr_total_seleted <- gr_total |> select(
  sqrtgr, logground,
  wind_avg, temp_avg, Roof_Type, Slope,
  roofflat, Size, Exposure, Heated, Insulated,
  Parapet, winter_wind, winter_wind_all,
  winter_wind_3month, winter_wind_snow,
  above_freeze, above_freeze_all
)

### More plots




## Figure 2.5
colnames(gr_total_seleted)
ggpairs(gr_total_seleted[c(3, 5, 15:16)]) + theme_bw() +
  theme(
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank()
  )

## Figure 2.6
ggpairs(gr_total_seleted[c(3, 6, 20)]) + theme_bw() +
  theme(
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank()
  )

## Figure 2.7
ggpairs(gr_total_seleted[c(3, 8, 10)]) + theme_bw() +
  theme(
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank()
  )


exposure_plot <- ggplot(gr_total, aes(x = Exposure)) +
  geom_histogram(binwidth = 1, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  labs(
    title = "",
    x = "Exposure",
    y = "Frequency"
  ) +
  ylim(0,400) +
  theme_bw()

heated_plot <- ggplot(gr_total, aes(x = Heated)) +
  geom_histogram(binwidth = 1, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  labs(
    title = "",
    x = "Heated",
    y = NULL
  ) +
  scale_x_continuous(breaks = seq(0, 1, 1)) +
  theme_bw() +
  ylim(0,400) +
  theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank()
  )

insulated_plot <- ggplot(gr_total, aes(x = Insulated)) +
  geom_histogram(binwidth = 1, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  labs(
    title = "",
    x = "Insulated",
    y = "Frequency"
  ) +
  scale_x_continuous(breaks = seq(0, 1, 1)) +
  ylim(0,400) +
  theme_bw()

parapet_plot <- ggplot(gr_total, aes(x = Parapet)) +
  geom_histogram(binwidth = 1, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  labs(
    title = "",
    x = "Parapet",
    y = NULL
  ) +
  scale_x_continuous(breaks = seq(0, 1, 1)) +
  theme_bw()+
  ylim(0,400) +
  theme(axis.text.y=element_blank(),
        axis.ticks.y=element_blank()
  )


## Figure 2.8
gridExtra::grid.arrange(exposure_plot, heated_plot, insulated_plot,
  parapet_plot,
  ncol = 2,
  widths = c(54,46)
)



##################### Adding mapped wind ####################################


gr_total$lat <- round(gr_total$lat * 4) / 4
gr_total$long <- round(gr_total$long * 4) / 4


whole_map <- terra::unwrap(readRDS("D:/whole_map.rds"))
whole_map

gr_total$est_wind <- terra::extract(
  whole_map,
  terra::vect(
    matrix(
      c(
        gr_total$long,
        gr_total$lat
      ),
      ncol = 2
    ),
    crs = terra::crs(whole_map)
  )
)[[2]]



### version 1 of data

# write.csv(gr_total, "data-raw//wind_all.csv")

###############################################################################
### adding mapped average wind #####

wind_avg_map <- terra::unwrap(readRDS("D:/wind_avg_map.rds"))
wind_avg_map

gr_total$est_wind_avg <- terra::extract(
  wind_avg_map,
  terra::vect(
    matrix(
      c(
        gr_total$long,
        gr_total$lat
      ),
      ncol = 2
    ),
    crs = terra::crs(wind_avg_map)
  )
)[[2]]


#### adding mapped average temp

temp_avg_map <- terra::unwrap(readRDS("D:/temp_avg_map.rds"))
temp_avg_map

gr_total$est_temp_avg <- terra::extract(
  temp_avg_map,
  terra::vect(
    matrix(
      c(
        gr_total$long,
        gr_total$lat
      ),
      ncol = 2
    ),
    crs = terra::crs(temp_avg_map)
  )
)[[2]]





gr_total$slope15 <- ifelse(gr_total$Slope > 15, 1, 0)

gr_total$exposed <- ifelse(gr_total$Exposure == 2, 1, 0)
gr_total$sheltered <- ifelse(gr_total$Exposure == 0, 1, 0)


## kelvin to celcius
gr_total$est_temp_avg <- gr_total$est_temp_avg - 273.15

## adding alters slope15
gr_total$slope_1_15 <- ifelse(gr_total$slope15 == 1 & gr_total$roofflat == 0,
  1, 0
)



## Scatters of Canadian data vs ERA 5 data
wind_avg_scat <- ggplot(gr_total, aes(x = wind_avg, y = est_wind_avg)) +
  geom_point() +
  labs(
    title = "",
    x = "Canadian Average wind",
    y = "Gridded average wind"
  ) +
  theme_bw()

w2_scat <- ggplot(gr_total, aes(x = winter_wind_all, y = est_wind)) +
  geom_point() +
  labs(
    title = "",
    x = "Canadian W2",
    y = "Gridded W2"
  ) +
  theme_bw()

temp_avg_scat <- ggplot(gr_total, aes(x = temp_avg, y = est_temp_avg)) +
  geom_point() +
  labs(
    title = "",
    x = "Canadian Average temp",
    y = "Gridded average temp"
  ) +
  theme_bw()



## Figure 2.9
gridExtra::grid.arrange(wind_avg_scat, w2_scat, temp_avg_scat, ncol = 3)
### version 2 of data
# write.csv(gr_total, "data-raw//updated_data.csv")
