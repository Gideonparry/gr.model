# Assumes a constant standard error for our model.
se <- 0.1578

usa_data <- read.csv("data-raw/usa_data.csv")
gr_total <- read.csv("data-raw//updated_data.csv")

era_both <- lm(
  sqrtgr ~ logground + est_wind + est_temp_avg + sheltered + exposed + Parapet +
    Heated + Insulated + roofflat + roofflat:est_wind + roofflat:sheltered,
  data = gr_total
)


summary(era_both)

usa_preds <- (0.711117 -0.084083*usa_data$logPPTWT -0.236735*usa_data$w2 +
                0.003786*usa_data$est_temp_avg -0.095041 + 0.062683 + 0.059377
              + 0.093180*usa_data$w2)
# Creates a vector of changing means (would be replaced with the predictions)
# from your GR model based on the variables you have derived.
tmean <- seq(100, 1000, 100)

# Simulates exactly one value per element in the vector. Thus, the first value
# comes from a normal distribution with a mean of 100 and an sd of 10, while
# the second value comes from a normal distribution with a mean of 200 and
# and standard deviation of 10 (and so on)
final_sim <- rnorm(length(usa_preds), usa_preds, se)
