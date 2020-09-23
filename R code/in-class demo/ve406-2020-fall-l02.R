################################################################################
## class notes for ve406 - 02
## writtenn by: tong zhu
## date: sep 10


###############################################################################
## binomial example - president case study
rm(list = ls())  # clean working environment

## set up hypothesis
theta <- 1/2  ## assume equal chance 50-50
n <- 158  ## total number of trials
x <- 0:n  ## all possible number
x1 <- seq(0, n, by = 1)  # alternative way of set up sequence
fX <- dbinom(x, size = n, prob = theta)  ## pdf of x
? dbinom  ## getting help with ?
obs <- 67
p.lowerTail <- pbinom(obs, size = n, prob = theta)
## under the assumption of theta = 0.5
p.value <- 2 * p.lowerTail

## visulisation
tmpL <- fX[x <= 67]  ## as extreme as what we observed
x.upperTail <- 1 + qbinom(p.lowerTail, 
                          size = n, prob = theta, lower.tail = FALSE)
tmpU <- fX[x >= x.upperTail]

M <- x[x > 67 & x < x.upperTail]
tmpM <- fX[x > 67 & x < x.upperTail]

plot(x, fX, type = "n", 
     xlab = "observed number of daughter", ylab = "probability mass")
lines(0:obs, tmpL,type = "h", col = "red")
lines(x.upperTail:n, tmpU,type = "h", col = "red")
lines(M, tmpM, tmpM,type = "h")
points(0:obs, tmpL, col = "red")
points(x.upperTail:n, tmpU, col = "red")
points(M, tmpM)
legend("topright", legend = "P-value", col = "red", lty = 1, pch = 1)


## p-value of the deep-sea divers case study
2 * pbinom(65, size = 190, p = 0.5)
