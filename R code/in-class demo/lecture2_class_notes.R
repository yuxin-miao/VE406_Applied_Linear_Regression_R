3.14
?is.logical
is.integer(18L)
is.integer(18)

x <- 1
1 -> x

x = 1

c()

month <- c("Jan", "Feb", "Dec")
month
class(month)

num <- 1:50

num_seq <- seq(1, 50, by = 2)
num_seq

?seq

month
month.factor <- factor(month, order = TRUE, levels = c("Jan", "Feb", "Dec"))
month.factor.1 <- factor(month)
month.factor

vec.month <- c(11, month)
vec.month.factor <- c(11, month.factor)
class(vec.month); class(vec.month.factor)

vec <- c(1:90)
mat <- matrix(vec, nrow = 10,
              byrow = 2)
mat
?matrix
dim(mat)


mat
df.mat <- data.frame(mat)
df.mat
names(df.mat) <- c("Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep")

mean(df.mat$Jan)
sd(df.mat$Jan)

class(df.mat$Jan)
df.mat$Jan <- factor(df.mat$Jan)


dataFrameMonth <- data.frame(mat)

c(1,2) + c(1,2,3,4)
