sim.d.func = function(n){
  x = rexp(n,rate=0.5)
  y = (x-1)^2 * runif(n, min=0.8, max=1.2)
  return(data.frame(x=x,y=y)) 
}

sim.p.func = function(n){
  x = rexp(n,rate=0.5)
  y = (x-1)^2 * runif(n, min=0.8, max=1.2)
  return(anova(lm(y~x))[["Pr(>F)"]][1])
}

sim.plot = function(x = f.vec){
  hist(log10(f.vec), breaks = 30, probability = TRUE, 
       main = "Simulation Study", xlab = "log of p-value")
}
