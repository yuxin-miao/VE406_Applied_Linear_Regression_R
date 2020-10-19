## this function creates two vectors (x, y) store numeric values, each has length n
## the first element of x and y is by default 0, and for each element afterwards, 
## 2 <= i <= n, there are four possibilities 
## P[(xpos[i] = xpos[i-1] + 1) && (ypos[i] = ypos[i-1])] = 0.25
## P[(xpos[i] = xpos[i-1] - 1) && (ypos[i] = ypos[i-1])] = 0.25
## P[(xpos[i] = xpos[i-1]) && (ypos[i] = ypos[i-1] + 1)] = 0.25
## P[(xpos[i] = xpos[i-1]) && (ypos[i] = ypos[i-1] - 1)] = 0.25
myfunc1 = function(n) {
  xpos = ypos = double(n)
  xdir = c(T,F)
  plusminus1 = c(1,-1)
  for (i in 2:n)
    if (sample(xdir,1)) {
      xpos[i] = xpos[i-1] + sample(plusminus1, 1)
      ypos[i] = ypos[i-1]
    }
  else {
    xpos[i] = xpos[i-1] 
    ypos[i] = ypos[i-1] + sample(plusminus1,1)
  }
  list(x = xpos, y = ypos)
}


myfunc2 = function(n) {
  xpos = ypos = double(n)
  choice = sample(4, n, T) # use one sample only, randomly generate 1, 2, 3, 4; as each of them 
  for (i in 2:n) { 
    if (choice[i] == 1) {
      xpos[i] = xpos[i-1] + 1
      ypos[i] = ypos[i-1]
    }
    else if (choice[i] == 2) {
      xpos[i] = xpos[i-1] - 1 
      ypos[i] = ypos[i-1]
    }
    else if (choice[i] == 3) {
      xpos[i] = xpos[i-1] 
      ypos[i] = ypos[i-1] + 1
    }
    else if (choice[i] == 4) {
      xpos[i] = xpos[i-1] 
      ypos[i] = ypos[i-1] - 1
    }
  }
  list(x = xpos, y = ypos)
}


myfunc3 = function(n) {
  xpos = ypos = double(n)
  xpos[1] = ypos[1] = 0
  c1 = sample(c(-1,1),n-1,T)
  c2 = sample(c(0,1),n-1,T)
  xpos[2:n] = cumsum(c1 * c2)
  ypos[2:n] = cumsum((1-c2)*c1)
  list(x = xpos, y = ypos)
}

system.time(myfunc1(1000000))
system.time(myfunc2(1000000))
system.time(myfunc3(1000000))
