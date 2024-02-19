## Modeling work
library(glmnet)
library(GGally)
library(ggplot2)
library(rpart)
library(rpart.plot)
library(car)

gr_total <- read.csv("data-raw//wind_all.csv")
## adding above or below 15 slope
gr_total$slope15 <- ifelse(gr_total$Slope > 15, 1, 0)

gr_total <- gr_total[gr_total$gr <= 2,]

model1 <- lm(sqrtgr ~ logground, gr_total)
## obtaining resids from original model
gr_total$resid <- residuals(model1)

resid_data <- gr_total |> select(wind_avg, temp_avg, Slope,
                                 roofflat, Size, Exposure, Heated, Insulated,
                                 Parapet, winter_wind_all, above_freeze_all,
                                 slope15, resid)



resid_no_na <- na.omit(resid_data)



## Setting up
resid_all <- lm(resid ~ ., resid_no_na)
resid_int <- lm(resid ~ 1, resid_no_na)

## Running forward and backward regression
resid_forward <- step(resid_int, direction='both', scope=formula(resid_all),
                      trace=0)
resid_backward <- step(resid_all, direction='both', scope=formula(resid_all),
                       trace=0)
resid_forward
resid_backward


## Running Lasso regression here
y <- resid_no_na$resid
x <- data.matrix(resid_no_na[, 1:12])
cv_model <- cv.glmnet(x, y, alpha = 1)


best_lambda <- cv_model$lambda.min
best_lambda


best_model <- glmnet(x, y, alpha = 1, lambda = best_lambda)
coef(best_model)


## subset for vars in step regression
gr_vars <- resid_no_na |> select(wind_avg, temp_avg,
                              roofflat, Size, Exposure, Insulated,
                              Parapet, winter_wind_all,
                               resid)
resid_vars <- na.omit(gr_vars)
ggpairs(gr_vars)

## look at tree to see interactions
tree <- rpart(formula = resid ~ ., data = resid_vars)
prp(tree)

pruned_tree <- prune(tree, cp = 0.04)
prp(pruned_tree)

## Running model based on selector methods
model_new <- lm(sqrtgr ~ logground + wind_avg + temp_avg +
                roofflat + Size + Exposure +  Insulated +
                Parapet + roofflat*Exposure + roofflat*wind_avg,
                data = gr_total)
summary(model_new)


og_mod <- lm(sqrtgr ~ logground, data = gr_total)
summary(og_mod)

ggpairs(gr_total |> select(sqrtgr, logground, wind_avg, temp_avg,
                              Size))


plot(model_new)
shapiro.test(model_new$residuals)

## Trying with winter_wind_all
mod2 <- lm(sqrtgr ~ logground + winter_wind_all + temp_avg +
             roofflat + Size + Exposure +  Insulated +
             Parapet + roofflat*Exposure + roofflat*winter_wind_all,
           data = gr_total)

summary(mod2)

ggpairs(gr_total |> select(sqrtgr, logground, winter_wind_all, temp_avg,
                           Size))

par(mfrow = c(1,3))

plot(gr_total$sqrtgr, gr_total$winter_wind_all, xlab= "sqrtgr", ylab = "W2",
     main = "W2 and sqrt GR plot")
qqnorm(resid(mod2))
qqline(mod2$residuals)
plot(mod2$fitted.values, mod2$residuals, xlab = "Fitted values",
     ylab = "Residuals", main = "W2 redsidual plot")
abline(0,0)


## Comaring metrics
AIC(model_new)
AIC(mod2)
AIC(og_mod)

BIC(model_new)
BIC(mod2)
BIC(og_mod)




