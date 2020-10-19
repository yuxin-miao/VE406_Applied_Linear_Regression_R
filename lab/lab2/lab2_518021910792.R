# Task 1 part(a) ---------------------------------------------------------
deb.df = read.table('~/Documents/JI/JI2020Fall/VE406/lab/lab2/debonding.txt', header=TRUE, sep="")

# Task 1 part (b) ---------------------------------------------------------
deb.full.LM = lm(debonding~., data=deb.df)
# = -96.51219 + 0.06252*time + 0.00163*voltage -0.2665*ph + 0.3305*temp

# Task 1 part (c) ---------------------------------------------------------
summary(deb.full.LM)$r.square

# Task 1 part (d) ---------------------------------------------------------
plot(fitted.values(deb.full.LM), rstandard(deb.full.LM), xlab = "Fitted values", ylab = "Standardised Residuals", main = "Residual Plot", sub = "lm(deboding~)")

# Task 1 part (e) ---------------------------------------------------------
res = residuals(deb.full.LM)
plot(res[-nrow(deb.df)], res[-1], xlab = "Previous", ylab = "Residuals", main = "Residuals vs. Previous Residual", sub = "lm(formula=debonding~.,data = deb.df)")

# Task 1 part (f) ---------------------------------------------------------
acf(res, main = "ACF plot for residuals")

# Task 1 part (g) ---------------------------------------------------------
qqnorm(res, main = "for residuals")
qqline(res, col = 2, lty = 2) 

# Task 1 part (h) ---------------------------------------------------------
qqnorm(rstandard(deb.full.LM), main = "for standardised residuals")
qqline(rstandard(deb.full.LM), col = 2, lty = 2) 

# Task 1 part (i) ---------------------------------------------------------
library(MASS)
bc = boxcox(deb.full.LM)
mylambda = bc$x[which.max(bc$y)]
debonding.bc = (deb.df[,"debonding"] ^ mylambda- 1) / mylambda

# Task 1 part (j) ---------------------------------------------------------
deb.full.bc.LM = lm(debonding.bc~(time+voltage+ph+temp), data=deb.df)
# summary(deb.full.bc.LM)
# summary(deb.full.LM)
# from R-squared, no more variation has been explained by using the tranformed response.

# Task 1 part (k) ---------------------------------------------------------
summary(deb.full.bc.LM)
# the F-test is for the null hypothesis that all the coefficients are zero (the model is significant).
# p-value is 0.001224, which is really small (smaller than the critical value).
# so these is evidence to reject this hypothesis and the model is siginificant.

# Task 1 part (l) ---------------------------------------------------------
# With the T-test performed for each regressor, compare the p-Value for each one.
# there is evidence that time and temp, with a p-Value smaller than 0.01, are significant. 
# for ph, the p-Value is larger than 0.1. But voltage has a pValue much larger, 
# it is extremely likely to be not siginificant in this model. So we may delete voltage and fit the model again,
# to see whether ph is still shows insignificance. 

# Task 1 part (m) ---------------------------------------------------------
confint(deb.full.LM, "time", level=0.95)

# Task 1 part (n) ---------------------------------------------------------
predict(deb.full.LM, data.frame(time=30, voltage=1350, ph=4, temp=300), interval = "confidence")

# Task 1 part (o) ---------------------------------------------------------
predict(deb.full.LM, data.frame(time=30, voltage=1350, ph=4, temp=300), interval = "prediction")

# Task 1 part (p) ---------------------------------------------------------
deb.no.v.LM = lm(debonding~(time+ph+temp), data=deb.df)
summary(deb.no.v.LM)
deb.no.v.p.LM = lm(debonding~(time+temp), data=deb.df)
summary(deb.no.v.p.LM)
# Adjusted R-squared could be used to as the basis to decide which model is better. 
# model with higher ajdusted R-squared value could be treated as a better model, 
# so (deb.no.v.LM) is a better model compared to (deb.no.v.p.LM). (0.4067 > 0.358)
# It could be used to compare between models and do the model selection.

# Task 2 part (a) ---------------------------------------------------------
sim.df = read.csv('~/Documents/JI/JI2020Fall/VE406/lab/lab2/sim_lab2.csv.bz2')
sim.LM = lm(y ~.+ x1*x3+x1*x4+x2*x3+x2*x4+x3*x4 , data = sim.df)
summary(sim.LM)
sim.LM$coefficients
# some coefficients are undefined because of singularity, not linearly independent,
# as some of the variables have perfect collinearity, so the variables with NA coefficient could be removed, 
# and other result will not change, information has been provided. 

# Task 2 part (b) ---------------------------------------------------------
# Given other regressors the same, the conditional mean of Y should be significantly different
# for x4=B and x4=C. Because from the summary, x1:x4B is 3.50857 and x1:x4C is 1.42294,
# x2:x4B is 1.20964 and x2:x4C is -2.19601. y will change a lot given same x1.

# Task 2 part (c) ---------------------------------------------------------
anova(sim.LM)
# The F-test on the anova() indicates whether the added variable significantly reduces the residual sum of squares
# it will ignore other predictors. So the null hypothesis could be expressed as the term do not have relationship with y
# with a large p-Value, we could not reject the hypothesis, so we may drop the term with large p-Value

# Task 2 part (d) ---------------------------------------------------------
source("~/Documents/JI/JI2020Fall/VE406/lab/lab2/lab2_func.R")
f.vec = replicate(1e4, sim.p.func(n=200)); sim.plot()
# the p-value is really small for all the observations, and follow a normal distribution
# however, the fitted model is y~x 
# and the sample is taken from exponential distribution.
# so a small p-value might not indicates the model is correct. 
# need to check assumptions first.
# and without checking assumption, pValue has no use. 