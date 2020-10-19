<p align="right">Yu xinmiao 于欣淼 518021910792</p>

# VE406 Hw2

### Q1

1.  There is no strong evidence against linearity. Because the residual points randomly scatter around line 0 and the mean residual value within each group is close to 0. 

2. There is evidence against equal variance assumption. Because the range of each group differs much. The spread of residuals should be approximately the same across line 0.

3. Because plot the current residual vs. previous residual mainly shows relationship between two neighbor residuals, and we expect to see a randomly scattered plot. The autocorrelation function do **not only consider the neighboring residuals,** as the current residual may not only correlates to the previous one, but maybe previous residuals. It will be especially useful for time series and more likely to detect some underlying pattern. 

   As the residual vs. previous residual plot do not show any particular pattern, the ACF has two exceed the threshold and indicate the violation of independence.

4. There is no evidence against the normality. The points generally coincide with line and no much difference shows. 

5. The $100(1-\alpha)\%$ confidence interval for $\mathbb{E}[W|Z=1]$ is 
$$
   \hat{\mu}_{W|Z} \pm t_{\alpha/2,n-2}S\sqrt{\frac{1}{n}+\frac{(z-\bar{z})^2}{\sum_{i=1}^n(z_i-\bar{z})^2}}
   $$
   From the output, obtain the estimate as 
   
   $$W = 0.39198 + 0.45234Z$$, then $\hat{\mu}_{W|Z} = 0.39198+0.45234=0.84432$,

   From the R output
$$
   \begin{aligned} 
   S&=1.039,\quad n-2=198, & \rm{so} & \quad t_{\alpha/2,n-2}=t_{0.025,198} = 1.96 \\
   Var[\hat{\beta_1}] &=\frac{\sigma^2 }{ \sum_{i=1}^n(z_i-\bar{z})^2} = \frac{1.039^2}{\sum(z_i-\bar{z})^2} = 0.05339^2 & \rm{so} &\sum_{i=1}^n(z_i-\bar{z})^2 =378.71\\
   Var[\hat{\beta_0}] &=\frac{\sigma^2 \sum_{i=1}^n z_i^2}{n \sum_{i=1}^n(z_i-\bar{z})^2} =\frac{1.039^2 \cdot \sum_{i=1}^n z_i^2}{200 \cdot378.71}=0.12941^2 &\rm{so}&\sum_{i=1}^n z_i^2=1175.02 \\[10pt]
   \rm{Therefore}&\sum_{i=1}^n(z_i-\bar{z})^2=\sum(z_i^2+\bar{z}^2-2z_i\bar{z})=\sum z_i^2+200\bar{z}^2-400\bar{z}^2 &\rm{so} & \bar{z}=1.995
   \end{aligned}
   $$
   calculate that 
   $$
   \begin{aligned}
   \hat{\mu}_{W|Z} \pm t_{\alpha/2,n-2}S\sqrt{\frac{1}{n}+\frac{(z-\bar{z})^2}{\sum_{i=1}^n(z_i-\bar{z})^2}}&=0.84432\pm 1.96*1.039*\sqrt{\frac{1}{200}+\frac{(1-1.995)^2}{378.71}}\\
   &= 0.84432\pm 0.17770
   \end{aligned}
   $$
   
   The interval is $[0.67, 1.02]$

6. The $100(1-\alpha)\%$ prediction interval for $\widehat{W|Z}$ is
   $$
   \begin{align*}
   &\widehat{W|Z} \pm t_{\alpha/2,n-2}S\sqrt{1+\frac{1}{n}+\frac{(z-\bar{z})^2}{\sum_{i=1}^n(z_i-\bar{z})^2}} \\
   &= 0.84432 \pm  1.96*1.039*\sqrt{1+ \frac{1}{200}+\frac{(1-1.995)^2}{378.71}}\\
   &= 0.84432\pm 2.04418
   \end{align*}
   $$
   
   The interval is $[-1.20, 2.89]$

<div style="page-break-after: always; break-after: page;"></div> 

### Q2

As the formula is $$\hat{R}(k)=\frac{(n-1)\sum_{i=1}^{n-k}\hat{e_i}\hat{e}_{i+k}}{(n-k)\sum_{i=1}^{n}\hat{e_i}^2}$$ , then for each lag, current value is followed by an opposite sign value means the residual of a given sign tend to be followed by a residual of the opposite sign. That indicates relation between errors is negative autocorrelation.

### Q3

$Var[Y_{n+1} - \hat{Y}_{n+1}^*|X_1, X_2,…,X_n,X_{n+1}] =\sigma^2[1+\frac{1}{n}+\frac{(X_{n+1} - \bar{X}_n)^2}{\sum_{i=1}^n (X_i - \bar{X}_n)^2}] $ which is the variance of prediction error.

$Var[Y_{i} - \hat{Y}_{i}|X_1, X_2,…,X_n] = \sigma^2[1-\frac{1}{n}-\frac{(X_i - \bar{X}_n)^2}{\sum_{i=1}^n (X_i - \bar{X}_n)^2}]$, which is the variance of residuals. 

$E[Y_i|X_i = x_i] = \beta_0 + \beta_1x_i, \quad Var[\varepsilon_i|X_i] = \sigma^2$,    so $Var[Y_{n+1}] = Var[Y_i] = \sigma^2$

$e_i$ could not be observec directly, we need to use residuals such that $\hat{e}_i = y_i - \hat{y}_i=\beta_0 + \beta_1x_i + e_i - \hat{\beta_0} - \hat{\beta_1}x_i $

Then $Var[Y_{i} - \hat{Y}_{i}] =Var[\beta_0+\beta_1X_i+e_i-( \hat{\beta_0} + \hat{\beta_1}X_i)]$

$Var[Y_{n+1} - \hat{Y}_{n+1}^*] =Var[\beta_0+\beta_1X_{n+1}+\varepsilon_{n+1}-( \hat{\beta_0} + \hat{\beta_1}X_{n+1})]  $

The major difference is that the data for $X_i, Y_i$ is used to fit the model, but no information is teken from $X_{n+1},Y_{n+1}$ when fit the model. So it has the true error. 

### Q4

Through the equation, $\mathbf{y} = \mathbf{X}\mathbf{\alpha} + \mathbf{Z}\mathbf{\beta}+\mathbf{\varepsilon}$
$$
\begin{aligned}y_{11} &= \alpha_{0} + \alpha_{1} + \beta_{1} + \varepsilon_{11} \\y_{12} &= \alpha_{0} + \alpha_{1} + \beta_{2} + \varepsilon_{12}\\y_{21} &= \alpha_{0} + \alpha_{2} + \beta_{1} + \varepsilon_{21}\\y_{22} &= \alpha_{0} + \alpha_{2} + \beta_{2} + \varepsilon_{22}\\y_{13} &= \alpha_{0} + \alpha_{1} + \beta_{3} + \varepsilon_{13}\\y_{23} &= \alpha_{0} + \alpha_{2} + \beta_{3} + \varepsilon_{23}\end{aligned}
$$

Then **X** and **Z** could written as 

$$
\mathbf{X} = \left[ \matrix{  1 & 1 & 0\\  1 & 0 &1\\  1 & 1 &0 \\1&0&1\\1&1&0\\1&0&1  } \right]  \qquad  \mathbf{Z} = \left[ \matrix{  1 & 0 & 0\\  1 & 0 &0\\  0 & 1 &0 \\0&1&0\\0&0&1\\0&0&1  } \right]
$$

Then for the variance 
$$
\begin{aligned}
Var[\mathbf{y}] &= Var[\mathbf{X}\mathbf{\alpha} + \mathbf{Z}\mathbf{\beta}+\mathbf{\varepsilon}] \\[10pt]
&= \mathbf{Z}\cdot Var[\mathbf{\beta}]\cdot \mathbf{Z}^T + Var[\mathbf{\varepsilon}] \\[10pt]
&= \left[ \matrix{  1 & 0 & 0\\  1 & 0 &0\\  0 & 1 &0 \\0&1&0\\0&0&1\\0&0&1  } \right] \cdot \left[ \matrix{  \sigma_{\beta}^2 & 0 & 0\\  0& \sigma_{\beta}^2 &0\\  0 & 0 &\sigma_{\beta}^2  } \right] \cdot \left[ \matrix{  1&1&0&0&0&0\\0&0&1&1&0&0\\0&0&0&0&1&1  } \right] + \left[ \matrix{  \sigma_{\varepsilon}^2 & 0 & 0&0&0&0\\  0&\sigma_{\varepsilon}^2 &0&0& 0 &0\\  0 &0&\sigma_{\varepsilon}^2& 0&0 &0 \\0&0&0&\sigma_{\varepsilon}^2&0&0\\0&0&0&0&\sigma_{\varepsilon}^2&0\\0&0&0&0&0&\sigma_{\varepsilon}^2  } \right] \\[10pt]
&=\left[ \matrix{\sigma_{\beta}^2+  \sigma_{\varepsilon}^2 & \sigma_{\beta}^2 & 0&0&0&0\\  \sigma_{\beta}^2&\sigma_{\beta}^2+\sigma_{\varepsilon}^2 &0&0& 0 &0\\  0 &0&\sigma_{\beta}^2+\sigma_{\varepsilon}^2& \sigma_{\beta}^2&0 &0 \\0&0&\sigma_{\beta}^2&\sigma_{\beta}^2+\sigma_{\varepsilon}^2&0&0\\0&0&0&0&\sigma_{\beta}^2+\sigma_{\varepsilon}^2&\sigma_{\beta}^2\\0&0&0&0&\sigma_{\beta}^2&\sigma_{\beta}^2+\sigma_{\varepsilon}^2  } \right] 
\end{aligned}
$$


### Q5

Because it is only the confidence interval for the regression function at each $x$, shows the variation in inference on the regression parameter at every $x$ value (such that, caused by the variation of parameter). So it do not indicate that any random variable $Y$ would be in the confidence interval. 


