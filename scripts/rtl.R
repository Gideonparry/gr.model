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
  dplyr::mutate(RATIO2 = RT_II/RT_2_new) |>
  dplyr::mutate(RATIO4 = RT_IV/RT_4_new) |>
  dplyr::mutate(RATIO2s = RT_2_new/RT_2_shelt) |>
  dplyr::mutate(RATIO4s = RT_4_new/RT_4_shelt)



### old vs new models
full_rtl |>
  dplyr::select("RT II" = RATIO2,
         "RT IV" = RATIO4) |>
  tidyr::pivot_longer(cols = everything()) |>
  ggplot(aes(x = value)) +
  geom_histogram(binwidth = 0.0175, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  ylim(0, 1700) +
  xlab("Ratio") +
  ylab("Frequency") +
  theme_bw() +
  theme(text = element_text(size = 16)) +
  facet_wrap(~ name, ncol = 1)
dev.off()


## sheltered vs non sheltered
full_rtl |>
  dplyr::select("RT II" = RATIO2s,
         "RT IV" = RATIO4s) |>
  tidyr::pivot_longer(cols = everything()) |>
  ggplot(aes(x = value)) +
  geom_histogram(binwidth = 0.0175, fill = "darkgrey",
                 color = "black", alpha = 0.7) +
  ylim(0, 1000) +
  xlab("Ratio") +
  ylab("Frequency") +
  theme_bw() +
  theme(text = element_text(size = 16)) +
  facet_wrap(~ name, ncol = 1)
dev.off()


full_rtl_box <- full_rtl |>
  dplyr::mutate(ECO3 = substr(ECO3, 1, regexpr("\\.", ECO3) - 1)) |>
  dplyr:: mutate(ECO3 = factor(ECO3, levels = c("5", "6", "7", "8", "9", "10",
                                        "11", "12", "13"))) |>
  dplyr::mutate(RATIO22 = RT_II/RT_2_shelt)



full_rtl_long <- pivot_longer(full_rtl_box, cols = c(RATIO2, RATIO22),
                              names_to = "Variable", values_to = "Value")

# Create the combined plot with facet wrapping
ggplot(full_rtl_long, aes(x = ECO3, y = Value, fill = Variable)) +
  geom_boxplot(position = position_dodge(width = 0.75)) +
  scale_fill_brewer(palette = "Dark2",
                    labels = c("Non Sheltered", "Sheltered")) +
  geom_vline(xintercept = seq(1.5, 12.5, 1), linetype = "solid",
             color = "gray50") +
  labs(title = NULL,
       x = "ECO3",
       y = "Ratio") +
  theme_bw() +
  theme(legend.title = element_blank(),
        axis.text = element_text(size = 12, face = "bold"),
        axis.title = element_text(size = 16, face = "bold"))


