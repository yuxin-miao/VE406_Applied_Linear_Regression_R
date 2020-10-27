################################################################################
## VE406 classnotes 08
## date: sept 28 2020
## written by: tong zhu
require(graphics)
require(pastecs)  ## for stat.desc
require(lattice)  ## for lattice plot
require(MASS)  ## for boxcox
require(car)  ## for vif


################################################################################
## Analysis of the life-cycle savings data
## given in Belsley, Kuh and Welsch.
## LifeCycleSavings
##    sr: numeric aggregate personal savings
##    pop15: numeric % of population under age 15
##    pop75: numeric % of population over age 75
##    dpi: numeric real per-capita disposable income
##    ddpi: numeric % growth rate of dpi
str(LifeCycleSavings)
dim(LifeCycleSavings)


################################################################################
## descriptive analysis
summary(LifeCycleSavings)  ## box-plot stats
pastecs::stat.desc(LifeCycleSavings)  ## distribution stats
## note, we often use xxx::yyy to call for function yyy from lib xxx
## in this way we can reinforce R to call the right function
## as functions with the same name from different libs will be masked by
## the order of lib loading.
## in this example, we called "stat.desc" from "pastecs"
# var: 20.0740459: total variation of y. Then variation in other variables.
# So to explain 20 variation in y, x at least need to have as much as variation as y, so pop15 and dpi might explain much variation

################################################################################
## explorative analysis
## sr is the dependent variable of interest
## with 4 independent variables
## all variables are on continuous scales
## let's take a look at their kernel density distributions
densityplot(~ sr, data = LifeCycleSavings,
            main = "Density plot",
            xlab = "Personal savings",
            plot.points = FALSE)

densityplot(~ pop15, data = LifeCycleSavings,
            main = "Density plot",
            xlab = "% of population under age of 15",
            plot.points = FALSE)

densityplot(~ pop75, data = LifeCycleSavings,
            main = "Density plot",
            xlab = "% of population over age of 75",
            plot.points = FALSE)

densityplot(~ dpi, data = LifeCycleSavings,
            main = "Density plot",
            xlab = "real per-capita disposable income",
            plot.points = FALSE)

densityplot(~ ddpi, data = LifeCycleSavings,
            main = "Density plot",
            xlab = "Rate of change in real per-capita disposable income",
            plot.points = FALSE)

# scatterplot matrix
lattice::splom(LifeCycleSavings[c(1:5)], main = "LifeCycleSavings Data")


## shapiro-wilk test
## given that Xs all seem to fail to follow a normal distribution
## and sample size is only 50
shapiro.test(LifeCycleSavings$sr)  # no evidence against it
shapiro.test(LifeCycleSavings$pop15)
shapiro.test(LifeCycleSavings$pop75)
shapiro.test(LifeCycleSavings$dpi)
shapiro.test(LifeCycleSavings$ddpi)


################################################################################
## fit multiple linear regression model
## from empty to full
lm_SR_fit0 <- lm(sr ~ 1, data = LifeCycleSavings) # just intercept 
anova(lm_SR_fit0)  ## F-test statistics on RSS and ESS
summary(lm_SR_fit0)  ## summary output of the fit
sd(LifeCycleSavings$sr)
## note that RSS of the empty model is the same as the TSS of dependent var: sr

## add one independent variable at a time
lm_SR_fit1 <- lm(sr ~ pop15, data = LifeCycleSavings)
lm_SR_fit2 <- lm(sr ~ pop15 + pop75, data = LifeCycleSavings)
lm_SR_fit3 <- lm(sr ~ pop15 + pop75 + dpi, data = LifeCycleSavings)
lm_SR_fit4 <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)

car::vif(lm_SR_fit4)
## f tests on model selections
anova(lm_SR_fit0, lm_SR_fit1)  ## model 1 is significantly better
anova(lm_SR_fit1, lm_SR_fit2)  ## model 2 is only marginally better
anova(lm_SR_fit1, lm_SR_fit3)  ## model 3 does not improve much
anova(lm_SR_fit1, lm_SR_fit4)  ## model 4 is significantly better
anova(lm_SR_fit0, lm_SR_fit4)  ## p-value should agree to summary F p-value
summary(lm_SR_fit4)  ## only pop15 and ddpi is significant

lm_SR_fit5 <- lm(sr ~ pop15 + ddpi, data = LifeCycleSavings)
anova(lm_SR_fit4, lm_SR_fit5)  ## prefer model 4
anova(lm_SR_fit1, lm_SR_fit5)  ## prefer model 5
anova(lm_SR_fit0, lm_SR_fit5)  ## prefer model 5
summary(lm_SR_fit5)  ## adjusted R2 = 0.2575 < adj R2 of fit4 (0.2797)
## therefore, our overall judgement is to use lm_SR_fit4


################################################################################
## diagnostic testings of fit 4
## assumption of linearity
## assumption of constant variable around zero
plot(fitted.values(lm_SR_fit4), residuals(lm_SR_fit4),
     xlab = "Fitted values", ylab = "Residuals",
     main = "Residual plot", sub = "lm(sr ~ .)")
abline(a = 0, b = 0, lty = 2, col = "red")
## residual plot reads well despite the potential problems


## assumption of independence of Xs
plot(LifeCycleSavings$pop15, residuals(lm_SR_fit4),
     xlab = "pop15", ylab = "Residuals",
     main = "Residual plot", sub = "lm(pop15 ~ redisual.)")
abline(a = 0, b = 0, lty = 2, col = "red")

plot(LifeCycleSavings$pop75, residuals(lm_SR_fit4),
     xlab = "pop75", ylab = "Residuals",
     main = "Residual plot", sub = "lm(pop75 ~ redisual.)")
abline(a = 0, b = 0, lty = 2, col = "red")

plot(LifeCycleSavings$dpi, residuals(lm_SR_fit4),
     xlab = "dpi", ylab = "Residuals",
     main = "Residual plot", sub = "lm(sr ~ .)")
abline(a = 0, b = 0, lty = 2, col = "red")
# some point is very far away 

plot(LifeCycleSavings$ddpi, residuals(lm_SR_fit4),
     xlab = "ddpi", ylab = "Residuals",
     main = "Residual plot", sub = "lm(sr ~ .)")
abline(a = 0, b = 0, lty = 2, col = "red")

## assumption of independence of themselves
plot(residuals(lm_SR_fit4)[-dim(LifeCycleSavings)[1]], residuals(lm_SR_fit4)[-1],
     xlab = "Previous", ylab = "Residual",
     main = "Serial Correlation in Residuals", sub = "lm(sr ~ .)")
acf(residuals(lm_SR_fit4))  ## 2 out 17 are significant, potential limitation

## assumption of normality
qqnorm(residuals(lm_SR_fit4))
qqline(residuals(lm_SR_fit4), col = "red")
shapiro.test(residuals(lm_SR_fit4))

## there is no evidence against linearity assumption
## there is also no evidence against independence
## residuals also form a random scatter around 0
## how could we improve our model given its low multiple R2?
## let's look at the multicolinearity and inflence points


################################################################################
## take a look at the influence points
inflm_SR <- influence.measures(lm_SR_fit4)  ## find the influ
which(apply(inflm_SR$is.inf, 1, any))
# which observations 'are' influential
summary(inflm_SR) # only these
inflm_SR          # all

## visulisations of the linear model
plot(lm_SR_fit4, which = 1)  ## residual vs fitted
plot(lm_SR_fit4, which = 2)  ## normal q-q plot of residuals
plot(lm_SR_fit4, which = 3)  ## scale-location

plot(lm_SR_fit4, which = 4)  ## cook's distance
## Used to detect highly influential data points, i.e. data points that 
## can have a large effect on the outcome and accuracy of the regression. 
## For large sample sizes, a rough guideline is to consider values above 
## 4/(n-p), where n is the sample size and p is the number of predictors 
## including the intercept, to indicate highly influential points.
## 4/(50-4) = 0.09

plot(lm_SR_fit4, which = 5)  ## an enhanced version of that via plot(<lm>)

plot(lm_SR_fit4, which = 6)  ## cock's distance vs leverage
## Cook's distance and leverage are used to detect highly influential 
## data points, i.e. data points that can have a large effect on the 
## outcome and accuracy of the regression.
## For large sample sizes, a rough guideline is to consider Cook's distance 
## values above 1 to indicate highly influential points and leverage 
## values greater than 2 times the number of predictors divided by the 
## sample size to indicate high leverage observations. 
## High leverage observations are ones which have predictor values 
## very far from their averages, which can greatly influence the fitted model.
## The contours in the scatterplot are standardized residuals labelled 
## with their magnitudes.

plot(rstudent(lm_SR_fit4) ~ hatvalues(lm_SR_fit4))  ## recommended by some

## what can we do?
## perhaps transformation on X?
boxcox(lm_SR_fit4)
boxcox(lm(LifeCycleSavings$sr ~ 1))  ## lambda = 1
boxcox(lm(LifeCycleSavings$pop15 ~ 1))  ## lambda = 0.5 but includes 1
boxcox(lm(LifeCycleSavings$pop75 ~ 1))  ## lambda = 0.2
boxcox(lm(LifeCycleSavings$dpi ~ 1))  ## lambda = 0
boxcox(lm(LifeCycleSavings$ddpi ~ 1))  ## lambda = 0.25

LifeCycleSavings["pop75_bc"] <- (LifeCycleSavings["pop75"]^0.2 - 1)/0.2
LifeCycleSavings["dpi_bc"] <- log(LifeCycleSavings["dpi"])
LifeCycleSavings["ddpi_bc"] <- (LifeCycleSavings["ddpi"]^0.25 - 1)/0.25
# after transformation 
lm_SR_fit4_bc <- lm(sr ~ pop15 + pop75_bc + 
                      dpi_bc + ddpi_bc, data = LifeCycleSavings)
summary(lm_SR_fit4_bc)

lm_SR_fit3_bc <- lm(sr ~ pop15 + pop75_bc + 
                       ddpi_bc, data = LifeCycleSavings)
summary(lm_SR_fit3_bc)
anova(lm_SR_fit3_bc, lm_SR_fit4_bc)

lm_SR_fit2_bc <- lm(sr ~ pop15 + ddpi_bc, data = LifeCycleSavings)
summary(lm_SR_fit2_bc)
anova(lm_SR_fit2_bc, lm_SR_fit3_bc)


plot(lm_SR_fit3_bc, which = 1)
plot(lm_SR_fit3_bc, which = 2)
plot(lm_SR_fit3_bc, which = 3)
plot(lm_SR_fit3_bc, which = 4)
plot(lm_SR_fit3_bc, which = 5)
plot(lm_SR_fit3_bc, which = 6)  # lybia still leverage point, but its influence is decreased. 
shapiro.test(residuals(lm_SR_fit3_bc))

cor(LifeCycleSavings) # (Correlation, Variance and Covariance (Matrices))
## very high correlation between pop15 and pop75
car::vif(lm_SR_fit4_bc) # multi corralation 
car::vif(lm_SR_fit3_bc)
#create vector of VIF values
vif_values <- car::vif(lm_SR_fit3_bc)
#create horizontal bar chart to display each VIF value
barplot(vif_values, main = "VIF Values", horiz = TRUE, col = "steelblue")
#add vertical line at 5
abline(v = 5, lwd = 3, lty = 2)
## multicollinearity in regression analysis occurs when two or more 
## predictor variables are highly correlated to each other, such that they 
## do not provide unique or independent information in the regression model.
## If the degree of correlation is high enough between variables, it 
## can cause problems when fitting and interpreting the regression model.
## The most common way to  is by using the 
## variance inflation factor (VIF), which measures the correlation and 
## strength of correlation between the predictor variables in a 
## regression model.
## The value for VIF starts at 1 and has no upper limit.
## A general rule of thumb for interpreting VIFs is as follows:
##  ** A value of 1 indicates there is no correlation between a given 
##     predictor variable and any other predictor variables in the model.
##  ** A value between 1 and 5 indicates moderate correlation between 
##     a given predictor variable and other predictor variables in the model, 
##     but this is often not severe enough to require attention.
##  ** A value greater than 5 indicates potentially severe correlation 
##     between a given predictor variable and other predictor variables in 
##     the model. In this case, the coefficient estimates and p-values in 
##     the regression output are likely unreliable.
##  Note that there are some cases in which high VIF values can 
##  safely be ignored.
##  
##  