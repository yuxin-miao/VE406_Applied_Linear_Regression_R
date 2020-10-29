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



# VE406 Hw3

### Q1

By the least square principle 
$$
\begin{align*}
(b_0,b_1) = Argmin_{(\beta_0,\beta_1)} \sum^{n}_{i=1}e_i^2
\end{align*}
$$
For the given model, written as 
$$
\begin{align*}
(\hat{\theta},\hat{\phi}) &= Argmin_{(\theta,\phi)} \sum^{3}_{i=1}e_i^2 \\[1ex]
&= Argmin_{(\theta,\phi)} \sum^{3}_{i=1}(y_i-\hat{y}_i)^2 \\[1ex]
&= Argmin_{(\theta,\phi)} \{(y_1-\hat{\theta})^2+(y_2-2\hat{\theta}+\hat{\phi})^2+ (y_3-2\hat{\phi}-\hat{\theta})^2  \}
\end{align*}
$$
The we need to take partial dereivative with respect to $\hat{\theta}$ and $\hat{\phi}$ and let it be zero. 
$$
\begin{align*}
&\frac{\partial ((y_1-\hat{\theta})^2+(y_2-2\hat{\theta}+\hat{\phi})^2+ (y_3-2\hat{\phi}-\hat{\theta})^2 )}{ \partial \hat{\theta}} \\[1ex]
=& 2(\hat{\theta}-y_1) + (8\hat{\theta}-4\hat{\phi}-4y_2) +(2\hat{\theta}+4\hat{\phi}-2y_3) 
=0  \\[2ex]
&\frac{\partial ((y_1-\hat{\theta})^2+(y_2-2\hat{\theta}+\hat{\phi})^2+ (y_3-2\hat{\phi}-\hat{\theta})^2 )}{ \partial \hat{\phi}} \\[1ex]
=&0+(-4\hat{\theta}+2\hat{\phi}+2y_2) + (4\hat{\theta}+8\hat{\phi}-4y_3) 
=0 \\[1ex]
&\quad \qquad \qquad\qquad \big{\Downarrow} \\[1ex]
&\hat{\theta}=\frac{1}{6}y_1+\frac{1}{3}y_2 + \frac{1}{6} y_3  \\[1ex]
& \hat {\phi} = -\frac{1}{5}y_2 + \frac{2}{5}y_3
 
\end{align*}
$$

### Q2

1. First, to prove $\mathbf{P}$ is symmetric and idemopotent 

$$
\begin{align*}
\mathbf{P^T} &= (\mathbf{X}(\mathbf{X^TX})^{-1}\mathbf{X^T})^T \\[1ex]
&= \mathbf{X}((\mathbf{X^TX})^{-1})^T\mathbf{X^T} \\[1ex]
&= \mathbf{X}((\mathbf{X^TX})^{T})^{-1}\mathbf{X^T} \\[1ex]
&= \mathbf{X}(\mathbf{X^TX})^{-1}\mathbf{X^T} \\[1ex]
&= \mathbf{P} \Rightarrow \mathbf{P} \rm{\ is \ symmetric} \\[5ex]

\mathbf{P^2} &= (\mathbf{X}(\mathbf{X^TX})^{-1}\mathbf{X^T})(\mathbf{X}(\mathbf{X^TX})^{-1}\mathbf{X^T}) \\[1ex]
&= \mathbf{X}(\mathbf{X^TX})^{-1}(\mathbf{X^T}\mathbf{X})(\mathbf{X^TX})^{-1}\mathbf{X^T} \\[1ex]

&= \mathbf{P}  \Rightarrow \mathbf{P} \rm{\ is \ idempotent}
\end{align*}
$$

​		Then for $\mathbf{I-P}$, as $\mathbf{I}$ is the identity matrix, which is symmetric. So $\mathbf{I-P}$ is symmetric. 
$$
\begin{align*}
(\mathbf{I-P})^2 &= \mathbf{I}^2 + \mathbf{P}^2 - 2\mathbf{I}\mathbf{P} \\
&= \mathbf{I} + \mathbf{P} - 2\mathbf{P}\quad [\rm{symmetric}] \\
&= \mathbf{I-P}  \Rightarrow \mathbf{I-P} \rm{\ is \ idempotent}

\end{align*}
$$
​		Therefore, we prove that $\mathbf{P}, \mathbf{I-P}$ are both symmetric and idempotent.



2. $$ {!h}
   \begin{align*}
   \hat{e}^T\hat{y} &= ((\mathbf{I-P})y)^T\mathbf{P}y \\[1ex]
   &= y^T (\mathbf{I-P})\mathbf{P}y  \\[1ex]
   &= y^T (\mathbf{P-P^2})y \quad [\mathbf{P} \rm{\ is \ idempotent} ]\\[1ex] 
   &= 0
   \end{align*}
   $$

   Then we have proved. 

   

3. $$ {!h}
   \begin{align*}
   Var[\hat{e}] &= Var[\mathbf{(I-P)}y] \\[1ex]
   &= \mathbf{(I-P)}Var[y]  \mathbf{(I-P)}^T  \\[2ex]
   Cov[\mathbf{\hat{e}}|\mathbf{X}] &= Cov[\mathbf{(I-P)(X}\beta+\varepsilon)|\mathbf{X}] \\[1ex]
   &=\mathbf{(I-P)} Cov[\mathbf{}\varepsilon|\mathbf{X}]\mathbf{(I-P)}^T\\[1ex]
   &= \sigma^2\mathbf{(I-P)}
   \end{align*}
   $$

   so that $Cov[\hat{e}_i,\hat{e}_j|\mathbf{X}]=-\sigma^2p_{ij}$



4. 



### Q3

1. Proof

   As the F statistic is expressed as 
   $$
   F_{k,n-k-1} = \frac{(TSS - RSS)/k}{RSS/(n-k-1)}
   $$
   where $TSS$ is the total sum of square, $RSS$ is the residual sum of square.

   Also the 
   $$
   R^2 = 1 - \frac{RSS}{TSS} = \frac{TSS - RSS}{TSS}
   $$
   so we have 
   $$
   \frac{TSS - RSS}{RSS} = \frac{TSS - RSS}{TSS}\times \frac{TSS}{RSS}=\frac{R^2}{1-R^2}
   $$
   then conclude that 

$$
F = \frac{(TSS - RSS)/k}{RSS/(n-k-1)}=\frac{R^2/k}{(1-R^2)/(n-k-1)}
$$

2. Find Probability

   calculate that 
   $$
   F_{4,15}=\frac{R^2/k}{(1-R^2)/(n-k-1)}=\frac{0.9/4}{(1-0.9)/(20-4-1)}=33.75
   $$
   So we find the probability by 

   <img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/Assignment/image-20201028204130318.png" alt="image-20201028204130318" style="zoom:50%;" />

   then the probability is $4.90153 \times 10^{-7}$.

3. Conclusion

   There is evidence to reject that all the predictors are not significant, we could conclude that at least one of the four regressors is siginificant (i.e. $\beta_0=\beta_1=\beta_2=\beta_3=0$ do not hold )



### Q4

From the equation $x_{ij}=k_jw_{ij}$, as $\mathbf{K}$ is the diagonal matrix 
$$
\begin{align*}
\mathbf{K} &= \begin{pmatrix}
 k_1 & 0 &  \cdots & 0 \\
 0 & k_2 & \cdots & 0 \\
 \vdots  & \vdots & \ddots & \vdots \\
 0 & 0 & \cdots & k_k \\
\end{pmatrix} \\[2ex]
\mathbf{X}& = \mathbf{W}\mathbf{K}

\end{align*}
$$
Before scaling, if equal variance, we have
$$
\begin{align*}
Y_i &= \beta_0 + \beta_1X_{i1}+...+\beta_{k}X_{ik}+\varepsilon_{i} \quad \rm{where}\ \varepsilon_i\sim N(0, \sigma^2) \\[2ex]
\mathbf{\hat{Y}} &= \mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^Ty 

\end{align*}
$$
 Then replace $\mathbf{X}$ with $\mathbf{WK}$
$$ {!h}
\begin{align*}

\mathbf{\hat{Y}} &= \mathbf{X}(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^Ty  \\[1ex]
&=\mathbf{WK}(\mathbf{(WK)}^T\mathbf{WK})^{-1}\mathbf{(WK)}^Ty \quad \rm{as \ \mathbf{K}^T=\mathbf{K}} \\[1ex]
&= \mathbf{WK}(\mathbf{KW}^T\mathbf{WK})^{-1}\mathbf{KW}^Ty \\[1ex]
&= \mathbf{WW^{-1}}(\mathbf{W}^T)^{-1}\mathbf{W}^Ty \\[1ex]
&= \mathbf{W}(\mathbf{W}^T\mathbf{W})^{-1}\mathbf{W}^Ty

\end{align*}
$$
So the equation is unchanged.

### Q5

1. Based on the LSE principle $
   \left(
   \begin{array}
   {c}
   \hat{\beta}_0\\
   \hat{\beta}_1\\
   \end{array}
   \right) =(\mathbf{X^TX})^{-1}\mathbf{X^T}y $

   As for the model, we have $\mathbf{X} = \left(
   \begin{array}
   {ccc}
   1&-1\\
   1&0\\
   1&1
   \end{array}
   \right)$

   while the true mean given $\mathbf{X} = \left(
   \begin{array}
   {ccc}
   1&-1&1\\
   1&0&0\\
   1&1&1
   \end{array}
   \right)$

   So we could plug in the corresponding value and find $\hat{\beta}_0, \hat{\beta}_1$ and $\beta_0, \beta_1, \beta_2$ respectively. The result is 
   $$
   \begin{align*}
   \hat{\beta_0}&=\frac{1}{3}(y_1+y_2+y_3), \ \hat{\beta_1}=\frac{-1}{2}y_1+\frac{1}{2}y_3 \\[2ex]
   \beta_0&=y_2,\ \beta_1=\frac{-1}{2}y_1+\frac{1}{2}y_3 , \ \beta_2=\frac{1}{2}y_1-y_2+\frac{1}{2}y_3 \\[3ex]
   &\mathbb{E}[\hat{\beta}_0-\beta_0] = \mathbb{E}[\hat{\beta}_0]-\beta_0=\frac{1}{3}(y_1+y_3)-\frac{2}{3}y_2 &\Rightarrow biased \\[1ex]
   
   &\mathbb{E}[\hat{\beta}_1-\beta_1] = \mathbb{E}[\hat{\beta}_1]-\beta_1=0 &\Rightarrow unbiased 
   
   \end{align*}
   $$
   

2. Similar procedure, find that 
   $$
   \begin{align*}
   \hat{\beta_0}&=y_2, \ \hat{\beta_1}=\frac{-1}{2}y_1+\frac{1}{2}y_3,\ \hat{\beta}_2=\frac{1}{2}y_1-y_2+\frac{1}{2}y_3  \\[2ex]
   \beta_0&=\frac{1}{3}(y_1+y_2+y_3), \ \beta_1=\frac{-1}{2}y_1+\frac{1}{2}y_3 \\[3ex]
   
   &\mathbb{E}[\hat{\beta}_0-\beta_0] = \mathbb{E}[\hat{\beta}_0]-\beta_0=y_2-\frac{1}{3}(y_1+y_2+y_3) &\Rightarrow biased \\[1ex]
   
   &\mathbb{E}[\hat{\beta}_1-\beta_1] = \mathbb{E}[\hat{\beta}_1]-\beta_1=0 &\Rightarrow unbiased  \\[1ex]
   &\mathbb{E}[\hat{\beta}_2-\beta_2] = \mathbb{E}[\hat{\beta}_2]-0=\frac{1}{2}y_1-y_2+\frac{1}{2}y_3  &\Rightarrow biased 
   
   \end{align*}
   $$
   All unbiased .

3. 
   $$ {!ht}
   \begin{align*}
   Fisrt\ Case:&\\[1ex]
   Var[\hat{\beta}|\mathbf{X}]&=Var[(\mathbf{X^TX})^{-1}\mathbf{X^T}y ] \\[1ex]
   &=(\mathbf{X^TX})^{-1}\mathbf{X^T} Var[y ]\mathbf{X} (\mathbf{X^TX})^{-1} \\[1ex]
   &= (\mathbf{X^TX})^{-1}\mathbf{X^T} Var[\varepsilon ]\mathbf{X} (\mathbf{X^TX})^{-1} \\[1ex]
   &= \sigma^2(\mathbf{X^TX})^{-1} \\[1ex]
   &= \sigma^2  \left(
   \begin{array}
   {ccc}
   \frac{1}{3}&0\\
   0& \frac{1}{2}
   \end{array}
   \right) \Rightarrow Var[\hat{\beta}_1|\mathbf{X}]=\frac{\sigma^2}{2} \\[3ex]
   Second\ Case:&\\[1ex]
   Var[\hat{\beta}|\mathbf{X}]&=Var[(\mathbf{X^TX})^{-1}\mathbf{X^T}y ] \\[1ex]
   &= \sigma^2  \left(
   \begin{array}
   {ccc}
   1 &0&-1\\
   0& \frac{1}{2} &0 \\
   -1 &0 &\frac{3}{2}
   \end{array}
   \right) \Rightarrow Var[\hat{\beta}_1|\mathbf{X}]=\frac{\sigma^2}{2}
   \end{align*}
   $$
   

4. When the correct model used, the variance is same as calculated in **3**. So the variance of the estimator will not be affected by the incorrect model. 