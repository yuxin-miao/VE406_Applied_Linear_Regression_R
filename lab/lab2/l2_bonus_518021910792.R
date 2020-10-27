# Task 1 --------------------------------------------------------
library(MASS)
Sigma <- matrix(c(4,3.6,3.6,9),2,2)
Mu <- c(3, 1)
x1_x2 <- mvrnorm(n=1000, Mu, Sigma)
x1 <- x1_x2[,1]
x2 <- x1_x2[,2]
x3 <- rnorm(1000, 0, 1)
x4 <- rnorm(1000, 0, 1)
epsilon <- rnorm(1000, 0, 0.1)
y <- 1 + 0.1*x1 + 0.1*x2 + 0.1*x2^2 + 0.1*x3 + 0.1*x3^2 + epsilon

# Task 2 --------------------------------------------------------
groupvars  <- c("x1","x2", "I(x2^2)","x3", "I(x3^2)", "x4", "I(x4^2)")
m4 <- paste("y", paste(groupvars, collapse=" + "), sep=" ~ ")

data.df<-data.frame(y, x1, x2, x3, x4)
lm(y ~ . + .^2, data=df)
variab <- c('x1', 'x2', 'x3', 'x4')
formula.lst = list("y~x1+x2+I(x2^2)+x3+I(x3^2)", "y~x2+I(x2^2)+x3+I(x3^2)", "y~x1+x2+x3+I(x3^2)", "y~x1+x2+I(x2^2)+x3", "y~x1+x2+I(x2^2)+x3+I(x3^2)+x4+I(x4^2)")
formula.lst = lapply(formula.lst, as.formula)
model0.LM = lm(y~x1+x2+I(x2^2)+x3+I(x3^2), data = data.df) 
model1.LM = lm(y~x2+I(x2^2)+x3+I(x3^2), data = data.df)
model2.LM = lm(y~x1+x2+x3+I(x3^2), data = data.df)
model3.LM = lm(y~x1+x2+I(x2^2)+x3, data = data.df)
model4.LM = lm(y~x1+x2+I(x2^2)+x3+I(x3^2)+x4+I(x4^2), data = data.df)
model.lst = list(model0.LM, model1.LM, model2.LM, model3.LM, model4.LM)

# Task 3 --------------------------------------------------------
nm = lapply(model.lst, function(x) coefficients(x))
max_length <- max(unlist(lapply(nm,length)))
nm_filled <- lapply(nm,function(x) {ans <- rep(0,length=max_length);
ans[1:length(x)]<- x;
return(ans)})
res.mat = do.call(rbind, nm_filled)
# colnames(res.mat) <- colnames(nm)
print(res.mat, digits = 4)

