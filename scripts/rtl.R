#join datasets by ClustID
#Create ratios- original vs new for RT II and RT IV, new vs sheltered for RT II
#plot ratios of sheltered vs not sheltered with w2, boxplots/histogram with all

library(tidyverse)
library(RColorBrewer)
## reading in data
new_rtl <- readRDS("data-raw/new_gr_rt_test1_v3.RDS")
new_rtl_shelt <- readRDS("data-raw/new_gr_rt_test3_v3.RDS") |>
  dplyr::rename(RT_2_shelt = RT_2_new) |>
  dplyr::rename(RT_4_shelt = RT_4_new)



full_rtl <- read.csv("data-raw/final_table_trial.csv") |>
  dplyr::filter(CLUST %in% new_rtl$CLUST) |>
  dplyr::mutate(RT_II = RT_II*.04788) |>
  dplyr::mutate(RT_IV = RT_IV*.04788) |>
  dplyr::left_join(new_rtl, by = "CLUST") |>
  dplyr::left_join(new_rtl_shelt, by = "CLUST") |>
  dplyr::mutate(RATIO2 = RT_2_new/RT_II) |>
  dplyr::mutate(RATIO4 = RT_4_new/RT_IV) |>
  dplyr::mutate(RATIO2s = RT_2_shelt/RT_2_new) |>
  dplyr::mutate(RATIO4s = RT_4_shelt/RT_4_new)





### old vs new models
# Fig 4.1
full_rtl |>
  dplyr::select("RT II" = RATIO2,
         "RT IV" = RATIO4) |>
  tidyr::pivot_longer(cols = everything()) |>
  ggplot(aes(x = value)) +
  geom_histogram(binwidth = 0.0175, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  ylim(0, 2500) +
  xlab("Ratio") +
  ylab("Frequency") +
  geom_vline(xintercept = 1.0, color = "black", linetype = "dashed") +
  theme_bw() +
  theme(text = element_text(size = 16)) +
  facet_wrap(~ name, ncol = 1)
dev.off()



## Creating figure
gr_total <- read.csv("data-raw//updated_data.csv")
usa_data <- read.csv("data-raw//usa_data.csv")
era_both <- lm(
  sqrtgr ~ logground + roofflat + sheltered + est_wind +
    est_temp_avg + logsize + Parapet +
    roofflat:est_wind + roofflat:sheltered, gr_total
)
summary(era_both)

# getting quartiles

summary(usa_data$w2)
# temp was obtined from ERA 5 for simulations, but median is used to create the
# lines.

summary(usa_data$est_temp_avg)


q1_w <- 0.1158
q2_w <- 0.2255
q3_w <- 0.3702

q1_t <- 0.3697
q2_t <- 4.0384
q3_t <- 8.0230

## Setting the slope
sl <- -0.092911

## Intercept and slope for 1st quartiles. Going highest to lowest GR values
int1 <- (0.541586 + 0.088120 + q1_w*-0.218706 + q3_t*0.003875 + 0.004538*5.913
         - q1_w*0.031244)

int2 <- (0.541586 + 0.088120 + q2_w*-0.218706 +q2_t*0.003875 + 0.004538*5.913
         - q2_w*0.031244)

int3 <- (0.541586 + 0.088120 + q3_w*-0.218706 + q1_t*0.003875 + 0.004538*5.913
         - q3_w*0.031244)



# Fig 4.2
ggplot(gr_total, aes(x = logground, y = sqrtgr)) +
  geom_point() +
  labs(
    title = "",
    x = "log ground snow load",
    y = expression(sqrt(g[r]))
  ) +
  geom_abline(intercept = int1, slope = sl, color = "#1b9e77", linewidth = 1.5,
              linetype = "dashed") +
  geom_abline(intercept = int3, slope = sl, color = "#7570b3", linewidth = 1.5,
              linetype = "dashed") +
  geom_segment(aes(x = min(logground), y = min(logground) * -0.12 + 0.63,
                   xend = 0.87, yend = 0.87 * -0.12 + 0.63),
               color = "#d95f02", linewidth = 1.5) +
  geom_segment(aes(x = 0.87, y = 0.87 * -0.12 + 0.63, xend = max(logground),
                   yend = 0.87 * -0.12 + 0.63),
               color = "#d95f02", linewidth = 1.5) +
  scale_color_brewer(palette = "Dark2") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 12, face = "bold")
  )


## sheltered vs non sheltered
# Fig 4.3
full_rtl |>
  dplyr::select("RT II" = RATIO2s,
         "RT IV" = RATIO4s) |>
  tidyr::pivot_longer(cols = everything()) |>
  ggplot(aes(x = value)) +
  geom_histogram(binwidth = 0.0175, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  ylim(0, 500) +
  xlab("Ratio") +
  ylab("Frequency") +
  geom_vline(xintercept = 1.0, color = "black", linetype = "dashed") +
  theme_bw() +
  theme(text = element_text(size = 16)) +
  facet_wrap(~ name, ncol = 1)
dev.off()


full_rtl_box <- full_rtl |>
  dplyr::mutate(ECO3 = substr(ECO3, 1, regexpr("\\.", ECO3) - 1)) |>
  dplyr:: mutate(ECO3 = factor(ECO3, levels = c("5", "6", "7", "8", "9", "10",
                                        "11", "12", "13"))) |>
  dplyr::mutate(RATIO22 = RT_2_shelt/RT_II)



full_rtl_long <- pivot_longer(full_rtl_box, cols = c(RATIO2, RATIO22),
                              names_to = "Variable", values_to = "Value")

# Create the combined plot with facet wrapping
# Fig 4.5
ggplot(full_rtl_long, aes(x = ECO3, y = Value, fill = Variable)) +
  geom_hline(yintercept = 1.0, linetype = "dashed", color = "black") +
  geom_boxplot(position = position_dodge(width = 0.75)) +
  scale_fill_brewer(palette = "Dark2",
                    labels = c("Non Sheltered", "Sheltered")) +
  geom_vline(xintercept = seq(1.5, 12.5, 1), linetype = "solid",
             color = "gray50") +
  labs(title = NULL,
       x = "Level 1 Ecological Regions",
       y = "Ratio") +
  theme_bw() +
  theme(legend.title = element_blank(),
        legend.position = "bottom",
        axis.text = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 12, face = "bold")) +
  scale_y_continuous(breaks = seq(0.8, 1.8, 0.1))


## sample sizes
summary(full_rtl_box$ECO3)

mean(full_rtl$RATIO2)
mean(full_rtl_box$RATIO22)

