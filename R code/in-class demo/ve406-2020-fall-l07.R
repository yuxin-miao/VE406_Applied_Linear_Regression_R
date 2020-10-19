################################################################################
##  VE406 on variance bias trade-off
##  written by Tong Zhu

################################################################################
require(graphics)
## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept

anova(lm.D9)
summary(lm.D90)

opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)


################################################################################
## regression estimates
x0 <- rep(1, 20)
x1 <- c(rep(0, 10), rep(1, 10))
x <- cbind(x0, x1)
fvs <- fitted.values(lm.D9)
res <- residuals(lm.D9)

## parameter estimation
beta_hat <- solve(t(x) %*% x) %*% t(x) %*% weight
sigma_s_hat <- sum(res^2) / (length(weight) - 2)  ## estimated variance sigma
sqrt(sigma_s_hat)  ## residual standard error
beta_hat_se <- sqrt(sigma_s_hat * solve(t(x) %*% x))  ## var-cov of beta_hat

## hypothesis testing
t_beta_0 <- (beta_hat[1] - 0)/beta_hat_se[1, 1]
t_beta_1 <- (beta_hat[2] - 0)/beta_hat_se[2, 2]

p_beta_0 <- 2 * (1 - pt(q = t_beta_0, df = dim(x)[1] - dim(x)[2], 
               lower.tail = TRUE, log.p = FALSE))
p_beta_1 <- 2*pt(q = t_beta_1, df = dim(x)[1] - dim(x)[2], 
                  lower.tail = TRUE, log.p = FALSE)


################################################################################
## estimation errors
rss <- sum(res^2)
ess <- sum((fvs - mean(weight))^2)
tss <- sum((weight - mean(weight))^2)
multi_r_squared <- (tss - rss)/tss
multi_r_squared_check <- ess/tss

f_stat <- (ess/(dim(x)[2] - 1))/(rss/(dim(x)[1] - dim(x)[2]))
f_test_p <- 1 - pf(f.lm.D9, df1 = dim(x)[2] - 1, df2 = dim(x)[1] - dim(x)[2])

