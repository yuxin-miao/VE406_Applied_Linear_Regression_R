# Task 1 part(a) ---------------------------------------------------------
## ?round is used to look up to the specific documentation for 'round' in specific packages and libraries
##        so it only works with exact macthes.
## ??regression is used to help search. It will search R documentation for a phase or term.

# Task 1 part(b) ---------------------------------------------------------
x = 1/7
sprintf("%.15f",x)

# Task 1 part(c) ---------------------------------------------------------
# demo(graphics)
## When to use a coplot: For conditioning plots, such that the formula is in the form y~x/a
## we need to plot y versus x should be produced conditional on the variable a 

# Task 1 part(d) ---------------------------------------------------------
## It illustrates that in computer, float numbers are stored as 
## It illustrates that float numbers are stored as 64-bit binary numbers in the computer.
## Therefore, there will be small difference between .1+.2 and .3.

# Task 1 part(e) ---------------------------------------------------------
rep(1:100,each=2)*c(1,0)-c(0,1)


# Task 2 ---------------------------------------------------------
z = sample(c(sample(-100:100, 27), rep(NA, 3)))
tmp = runif(1, min = 3, max = 4)
m.mat = matrix(c(1:4, tmp, 6L:9L), nrow = 3)
colnames(m.mat) = c("A", "B", "A")
m.df = data.frame(A = 1:3, B = c(4, tmp, 6L), A = 7L:9L)

# Task 2 part(a)(i) ---------------------------------------------------------
z[1]

# Task 2 part(a)(ii) ---------------------------------------------------------
z[2:5]

# Task 2 part (a)(iii) ---------------------------------------------------------
z[1:(length(z)-2)]

# Task 2 part (a)(iv) ---------------------------------------------------------
z[seq(2,length(z),by=2)]

# Task 2 part (a)(v) ---------------------------------------------------------
z[z>0 & !is.na(z)]

# Task 2 part (a)(vi) ---------------------------------------------------------
z[!is.na(z)]

# Task 2 part (a)(vii) ---------------------------------------------------------
z[seq(2,length(z),by=3)]

# Task 2 part (b) ---------------------------------------------------------
z.named = setNames(z, state.name[1:length(z)])
z.named[c("Michigan")]
## Through setNames, each element of z is given a name, which corresponds to the first (length(z)) state names of US. 
## The second command returns the value in z whose name is "Michigan".

# Task 2 part (c)(i) ---------------------------------------------------------
m.mat[1:2,]

# Task 2 part (c)(ii) ---------------------------------------------------------
m.mat[col(m.mat)==2 & m.mat>log2(10)]

# Task 2 part (d) ---------------------------------------------------------
## the first 9 elements in m.mat, following column order.

# Task 2 part (e)(i) ---------------------------------------------------------
m.df[1:2,]

# Task 2 part (e)(ii) ---------------------------------------------------------
m.df[col(m.df)==2 & m.df>log2(10)]

# Task 2 part (f) ---------------------------------------------------------
## matrices are special vectors in R, m.mat stores numeric values, 
##    all the columns have the same type. two dimensional vector, the column name does not matter 
## for dataframe, different columns could have different type 
##    no column could have the same name, column name is an index 

# Task 3 part ( a) ---------------------------------------------------------
rm(list = ls())
grade_index = data.frame(gindex = c(1:5), grade = factor(c("A", "B", "C", "D", "F")),desc = factor(c("Excellent", "Good", "Satisfactory", "Poor", "Inadequate")))
grade = data.frame(grade_index[c(3,3,4,1,1,2,2,2,2,1,2,3,1,2,5,1,2,1,4,1,1,1,3,3,1,3,2,2,1,2,3,2,1,1,2,3,3,2,3,2), ])
fail = grade$gindex > 4 
gradebook.df = data.frame(grade, fail, gender = factor(c(rep("Female", 20), rep("Male", 20))) ,
                          proj = as.integer(c(rep(18,6), rep(17, 4), rep(16, 3), rep(15, 7), rep(18, 5), rep(17, 4), rep(16, 5), rep(15, 6))))
rownames(gradebook.df) = c(1:40)
sapply(gradebook.df, class)

# Task 3 part (b) ---------------------------------------------------------
data.frame(count = summary(gradebook.df$grade))

# Task 3 part (c) ---------------------------------------------------------
aggregate(gradebook.df$proj, by = gradebook.df['grade'], FUN = mean)
        
# Task 3 part (d) ---------------------------------------------------------
gradebook.df[sample(nrow(gradebook.df), 10), ]         

# Task 4 part (a) ---------------------------------------------------------
rsample = rnorm(100, mean = 4, sd = 2)
hist(rsample, freq = TRUE)

# Task 4 part (b) ---------------------------------------------------------
hist(rsample, freq = FALSE)
curve(dnorm(x,4,2), add = TRUE, main = "t")

# Task 4 part (c) ---------------------------------------------------------
sample_mix=rnorm(1000, 0, 1)
sample_mix=sample_mix*c(rep(1,700),rep(2,300))+c(rep(0,700),rep(4,300))

# Task 5 part (a) ---------------------------------------------------------
chisqdens.plot = function(nu) {
  x = seq(from = 0, to = qchisq(0.999,nu), by = 0.001)
  plot(x, dchisq(x, nu), type = "l", xlim = c(0, qchisq(0.999,nu)))
}
chisqdens.plot(2)

# Task 5 part (b) ---------------------------------------------------------
chisqdens.plot = function(nu.vec) {
  xmax = max(qchisq(0.999,nu.vec))
  x = seq(from = 0, to= xmax, by = 0.001)
  plot(density(rchisq(length(x),nu.vec[1])), type = "l", ylab = "density", xlim = c(0, xmax), main = "Chi-Squared", xlab = "x", lty = 1)
  col_all = rainbow(length(nu.vec))
  for (i in 2:length(nu.vec)) {
    curve(dchisq(x, nu.vec[i]), add = TRUE, col = col_all[i], lty = i*3)
  }
}
chisqdens.plot(c(2, 4, 6, 8))

# Task 5 part (c) ---------------------------------------------------------
chisqdens.plot = function(nu.vec) {
  xmax = max(qchisq(0.999,nu.vec))
  x = seq(from = 0, to= xmax, by = 0.001)
  y1 = density(rchisq(length(x),nu.vec[1]))
  plot(y1,  type = 'l',
       ylab = "density", xlim = c(0, xmax), main = "Chi-Squared", xlab = "x")
  polygon(y1, col = hsv(1,1,1, alpha = 0.25))
  for (i in 2:length(nu.vec)) {
    temp = curve(dchisq(x, nu.vec[i]), add = TRUE,  lty = i*3)
    polygon(temp, col = hsv(1/i, 1, 1/i, alpha = 0.25))
  }
}
chisqdens.plot(c(2, 4, 6, 8))

# Task 6 part (a) ---------------------------------------------------------
## "eruptions": Eruption time in mins, numeric values 
## "waiting": Waiting time to next eruption (in mins), numeric values 

# Task 6 part (b) ---------------------------------------------------------
hist(faithful[,2])
plot(density(faithful[,2]))
plot(density(faithful[,2], bw = 1.2)) # adjust the bandwidth, it gives more information

# Task 6 part (c) ---------------------------------------------------------
qqnorm(faithful[,2])
## It shows that 'waiting' does not follows a normal distribution.

# Task 6 part (d) ---------------------------------------------------------
plot(faithful[,1],faithful[,2],xlab="eruptions",ylab="waiting")
lines(lowess(faithful[,1],faithful[,2]))
## It shows that eruption and waiting is very likely to be positively correlated 

# Task 7  ---------------------------------------------------------
library(lattice)
xyplot(NOx ~ E, data = ethanol)
xyplot(NOx ~ C, data = ethanol)   

EE <- equal.count(ethanol$E, number=9, overlap=1/4)
plot(EE)
## The equal.count() function takes a numerical variable and divides its values into groups of approximately equal size. 
## The number of the groups is specified by the number argument. 

## Constructing panel functions on the fly; prepanel
xyplot(NOx ~ C | EE, data = ethanol,
       prepanel = function(x, y) prepanel.loess(x, y, span = 1),
       xlab = "Compression Ratio", ylab = "NOx (micrograms/J)",
       panel = function(x, y) {
         panel.grid(h = -1, v = 2)
         panel.xyplot(x, y)
         panel.loess(x, y, span=1)
       },
       aspect = "xy")
## displays the relationship between NOx and C for each level of factor EE
## At each level og equivalence ratio, increasing C, NOx increasing 
## While holding C constant, there is evidence that increasing E will affect NOx increase first then decrease, have a peak value around 0.9, such that they have quadratic relationship
## While holding E constant, there is evidence that increasing C will scattering NOx more, but no obvious value change 
