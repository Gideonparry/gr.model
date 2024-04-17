## Modeling work
library(glmnet)
library(GGally)
library(ggplot2)
library(rpart)
library(rpart.plot)
library(car)
library(cowplot)
library(RColorBrewer)
library(partykit)

# version 1 of data
# gr_total <- read.csv("data-raw//wind_all.csv")

# version 2 of data
gr_total <- read.csv("data-raw//updated_data.csv")



null_model <- lm(sqrtgr ~ 1, gr_total)
summary(null_model)

## running models with wind
model1 <- lm(sqrtgr ~ logground, gr_total)
model2 <- lm(sqrtgr ~ logground + winter_wind, gr_total)
model3 <- lm(sqrtgr ~ logground + winter_wind_all, gr_total)
model4 <- lm(sqrtgr ~ logground + winter_wind_3month, gr_total)
model5 <- lm(sqrtgr ~ logground + winter_wind_snow, gr_total)
summary(model1)
summary(model2)
summary(model3)
summary(model4)
summary(model5)



ggplot(gr_total[gr_total$gr <= 2, ], aes(x = logground, y = sqrtgr)) +
  geom_point() +
  labs(
    title = "",
    x = "log ground snow load",
    y = expression(sqrt(g[r]))
  ) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.5) +
  geom_segment(aes(x = min(logground), y = min(logground) * -0.12 + 0.63,
                   xend = 0.87, yend = 0.87 * -0.12 + 0.63),
               color = "red", linewidth = 1.5) +
  geom_segment(aes(x = 0.87, y = 0.87 * -0.12 + 0.63, xend = max(logground),
                   yend = 0.87 * -0.12 + 0.63),
               color = "red", linewidth = 1.5) +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 12, face = "bold")
  )


### Now running model with ERA5 wind
model_grid <- lm(sqrtgr ~ logground + est_wind, gr_total)
summary(model_grid)

## obtaining resids from original model
gr_total$resid <- residuals(model1)

resid_data <- gr_total |> dplyr::select(
  wind_avg, temp_avg, Slope,
  roofflat, Size, exposed, sheltered, Heated,
  Insulated, Parapet, winter_wind_all,
  above_freeze_all, slope15, resid
)



resid_no_na <- na.omit(resid_data)


### Creating tree to look for interactions

tree <- rpart(formula = resid ~ ., data = resid_no_na)
prp(tree)

pruned_tree <- prune(tree, cp = 0.04)


# Plot the tree
plot(pruned_tree)
text(pruned_tree, use.n=FALSE, pretty = TRUE)


## Setting up
## Starts as all variables, plus interactions
resid_all <- lm(
  resid ~ . + roofflat * winter_wind_all + roofflat * wind_avg +
    roofflat * sheltered + slope15 * winter_wind_all +
    slope15 * wind_avg + slope15 * sheltered,
  resid_no_na
)
resid_int <- lm(resid ~ 1, resid_no_na)

## Running forward and backward regression
resid_forward <- step(resid_int,
  direction = "both", scope = formula(resid_all),
  trace = 1
)
resid_backward <- step(resid_all,
  direction = "both", scope = formula(resid_all),
  trace = 1
)
summary(resid_forward)
summary(resid_backward)


## Running Lasso regression here
## Adding interaction columns to resid_no_na
resid_no_na$w2rf <- resid_no_na$winter_wind_all * resid_no_na$roofflat
resid_no_na$warf <- resid_no_na$wind_avg * resid_no_na$roofflat
resid_no_na$shrf <- resid_no_na$sheltered * resid_no_na$roofflat


colnames(resid_no_na)

y <- resid_no_na$resid
x <- data.matrix(resid_no_na[, c(1:12, 15:17)])
cv_model <- cv.glmnet(x, y, alpha = 1)


best_lambda <- cv_model$lambda.min
best_lambda


best_model <- glmnet(x, y, alpha = 1, lambda = best_lambda)
coef(best_model)


remove_model <- glmnet(x, y, alpha = 1, lambda = 0.002)
coef(remove_model)


cv_model2 <- cv.glmnet(x, y, alpha = 0.5)


best_lambda2 <- cv_model2$lambda.min
best_lambda2


best_model2 <- glmnet(x, y, alpha = 0.5, lambda = best_lambda2)
coef(best_model2)

################################################################################

#Density plots of each exposure level with GR
ggplot(na.omit(gr_total[,c("Exposure", "sqrtgr")]),
       aes(x = sqrtgr, color = factor(Exposure,
                                      levels = unique(gr_total$Exposure),
                                      labels =
                                        c("exposed", "sheltered", "normal")))) +
  geom_density(alpha = 0.5, linewidth = 1) +
  labs(
       x = expression(sqrt(g[r])),
       y = "Density",
       fill = "Exposure") +
  theme_bw() +
  scale_color_brewer(palette = "Dark2", name = "Exposure")  +
  theme(legend.position = c(0.9, 0.8))





#Density plots of sheltered level with GR
ggplot(na.omit(gr_total[,c("sheltered", "sqrtgr")]),
       aes(x = sqrtgr, color = factor(sheltered))) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of sqrtgr by Exposure Level",
       x = "sqrtgr",
       y = "Density",
       fill = "Exposure") +
  theme_bw()

###############################################################################

## Setting up, drop exposed and slope15, add back Slope and wind_avg to check
resid_all2 <- lm(
  resid ~ roofflat + sheltered + winter_wind_all + Slope + wind_avg +
     temp_avg + above_freeze_all + Size + Parapet +
    Heated + Insulated  + roofflat:winter_wind_all +
    roofflat:sheltered,
  resid_no_na
)
resid_int <- lm(resid ~ 1, resid_no_na)

## Running forward and backward regression
resid_forward2 <- step(resid_int,
                       direction = "both", scope = formula(resid_all2),
                       trace = 1
)
resid_backward2 <- step(resid_all2,
                        direction = "both", scope = formula(resid_all2),
                        trace = 1
)
summary(resid_forward2)
summary(resid_backward2)



################################################################################



################################################################################
# looking at correlations
gr_vars <- gr_total |> dplyr::select(
  sqrtgr, logground, roofflat, sheltered,
  winter_wind_all, temp_avg,
  above_freeze_all, Size, Parapet
)

ggpairs(na.omit(gr_vars))




################################### Checking assumptions of liner fit #########
######################## plot side by side  ##################################
df <- structure(list(var1 = 1:5, var2 = 4:8, var3 = 6:10),
                .Names = c("var1", "var2", "var3"),
                row.names = c(NA, -5L), class = "data.frame"
)


non_weather_cont <- ggpairs(gr_total |> dplyr::select(
  sqrtgr,
  logground, logsize
)) + theme_bw() +
  theme(
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank()
  )

weather_cont <- ggpairs(gr_total |> dplyr::select(
  sqrtgr, winter_wind_all, temp_avg,
  above_freeze_all
)) + theme_bw() +
  theme(
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank()
  )



cowplot::plot_grid(
  GGally::ggmatrix_gtable(non_weather_cont),
  GGally::ggmatrix_gtable(weather_cont),
  nrow = 2,
  rel_heights = c(4, 6)
)






## running model to fit assumption of linear fit
mod1 <- lm(sqrtgr ~ logground + roofflat + sheltered + winter_wind_all +
                  temp_avg + above_freeze_all + logsize + Parapet +
                  roofflat:winter_wind_all + roofflat:sheltered, gr_total)

summary(mod1)





######################## Residual and QQ plot ################################

resid_gg <- ggplot(mod1, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(x = "Fitted Values", y = "Residuals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 14, face = "bold")
  )

residuals <- resid(mod1)

qq_data <- qqplot(qnorm(ppoints(length(residuals))), residuals)

# Convert the output of qqplot to a data frame
qq_data_df <- data.frame(Theoretical = qq_data$x, Residuals = qq_data$y)

# Plot the QQ plot using ggplot2
qq_gg <- ggplot(qq_data_df, aes(x = Theoretical, y = Residuals)) +
  geom_point() +
  geom_abline(intercept = mean(residuals), slope = sd(residuals)) +
  labs(x = "Theoretical Quantiles", y = "Residuals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 14, face = "bold")
  )




gridExtra::grid.arrange(resid_gg, qq_gg, ncol = 2)

shapiro.test(mod1$residuals)

## Trying with temp_avg
mod2 <- lm(sqrtgr ~ logground + roofflat + sheltered + winter_wind_all +
             temp_avg +  logsize + Parapet +
             roofflat:winter_wind_all + roofflat:sheltered, gr_total)



## Trying with above_freeze_all
mod3 <- lm(sqrtgr ~ logground + roofflat + sheltered + winter_wind_all +
              above_freeze_all + logsize + Parapet +
             roofflat:winter_wind_all + roofflat:sheltered, gr_total)



###############################################################################

######################## Residual and QQ plot other models ####################

resid_gg2 <- ggplot(mod2, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(x = "Fitted Values", y = "Residuals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 14, face = "bold")
  )

residuals2 <- resid(mod2)

qq_data2 <- qqplot(qnorm(ppoints(length(residuals2))), residuals2)

# Convert the output of qqplot to a data frame
qq_data_df2 <- data.frame(Theoretical = qq_data2$x, Residuals = qq_data2$y)

# Plot the QQ plot using ggplot2
qq_gg2 <- ggplot(qq_data_df2, aes(x = Theoretical, y = Residuals)) +
  geom_point() +
  geom_abline(intercept = mean(residuals), slope = sd(residuals)) +
  labs(x = "Theoretical Quantiles", y = "Residuals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 14, face = "bold")
  )




gridExtra::grid.arrange(resid_gg2, qq_gg2, ncol = 2)

shapiro.test(mod2$residuals)

########################### mod3 ##############################################
resid_gg3 <- ggplot(mod3, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(x = "Fitted Values", y = "Residuals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 14, face = "bold")
  )

residuals3 <- resid(mod3)

qq_data3 <- qqplot(qnorm(ppoints(length(residuals3))), residuals3)

# Convert the output of qqplot to a data frame
qq_data_df3 <- data.frame(Theoretical = qq_data3$x, Residuals = qq_data3$y)

# Plot the QQ plot using ggplot3
qq_gg3 <- ggplot(qq_data_df3, aes(x = Theoretical, y = Residuals)) +
  geom_point() +
  geom_abline(intercept = mean(residuals), slope = sd(residuals)) +
  labs(x = "Theoretical Quantiles", y = "Residuals") +
  theme_bw() +
  theme(
    axis.text = element_text(size = 12, face = "bold"),
    axis.title = element_text(size = 14, face = "bold")
  )




gridExtra::grid.arrange(resid_gg3, qq_gg3, ncol = 2)

shapiro.test(mod3$residuals)

################################################################################
summary(mod1)
summary(mod2)
summary(mod3)



################################ building only model ###########################
building_data <- gr_total |> dplyr::select(
  sqrtgr,
  logground, logsize, Parapet, Heated, Insulated, roofflat, Slope, sheltered
)

## setting up step regression
build_all <- lm(
  sqrtgr ~ . +
    roofflat:sheltered,
  na.omit(building_data)
)
build_int <- lm(sqrtgr ~ 1, na.omit(building_data))

## Running forward and backward regression
build_forward <- step(build_int,
                       direction = "both", scope = formula(build_all),
                       trace = 1
)
build_backward <- step(build_all,
                        direction = "both", scope = formula(build_all),
                        trace = 1
)
summary(build_forward)
summary(build_backward)

#### Drop slope due to insignificance and having roofflat
build_mod <- lm(formula = sqrtgr ~ logground + logsize + Parapet + roofflat +
     sheltered + roofflat:sheltered, data = gr_total)
summary(build_mod)

### Using ERA 5 for weather

era_both <- lm(
  sqrtgr ~ logground + roofflat + sheltered + est_wind +
    est_temp_avg + logsize + Parapet +
    roofflat:est_wind + roofflat:sheltered, gr_total
)


summary(era_both)

era_temp <- lm(
  sqrtgr ~ logground + roofflat + sheltered +
    est_temp_avg + logsize + Parapet +
    roofflat:sheltered, gr_total
)
summary(era_temp)


sum(is.na(gr_total$winter_wind_all))
sum(is.na(gr_total$est_wind))
