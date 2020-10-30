Based on l08 

1. datasize 是否小datasize无法用central limit theorem

2. descriptive analysis: look at the data 

3. explorative analysis: density plot of all variables 

   > binomal for independent variable: two 

4. scatterplot matrix: to see the relationship between dependent and independent variables, which may violate the assumption that (x are independent)
   lattice::splom 

5. shapiro-wilk test: for small data size: check normality (not y|x, but x)

6. F-test between models 

7. with the chosen model: do diagnotics 

8. Cook distance: the influential points 

9. detect multicollinearity: variance inflation factor (VIF)



# attention points

- lack of data: small data set leads to no strong evidence available
- do not use t-test to select variables
- select model: compare the full model with the submodel (adj. R squared)
- claim the purpose: to **explain** or to **predict** 
- to determine whether a polynomial term is needed: plot standardised residual against each of the regressor 
- only drop variables after checking the assumption
- The SE of the sample slope, the value under **SE** **Coef**. Again, the SE of any statistic is a measure of its accuracy. In this case, the SE of b1 gives, very roughly, the average difference between the sample b1b1and the true population slope β1β1, for random samples of this size (and with these *x*-values).
- shapiro.test: <0.1 -> not normal





1. $R^2$: a measure of goodness of fit when **all assumptions are satisfied**

   however, larger value of $R^2$ do not indicate: 

   - assumptions are satisfied
   - better predictive model
   - better model across all data set
   - better model when models have different number of parameters 

2. adjusted $R^2$: relative measure to address: *when models have different number of parameters*

   - Can not be interpreted alone
   - can not used for two models that have different response

   

# confused point

## Cook’s distance 

> L08 L10

- **outliers**: extreme response values $y_i|x_i$, possible large $\hat{e}_i$, 应该看vertical distance to the regression line

- **leverage point**: points with extreme $x_{ij}-values$ relative to others, (may not have large residuals)， 所以不一定为outlier，看的是横向的是否x与其他的点偏离

  <img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201026101841265.png" alt="image-20201026101841265" style="zoom:50%;" />

  <img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201026102453480.png" alt="image-20201026102453480" style="zoom:50%;" />

  但这并不一定不好，如果该数据样本与得到的预测模型相符合时，（利比亚对其周边国家）这个样本即可进行核实和加强。但差别较大（利比亚与发达国家）时，会使其偏离真实模型。

  所以要比较移除/保留leverage point会造成怎样的影响，是否要进行transformation

- **influential point** : a point whose deletion would significantly alter the regression surface. 

  - Quantification methods: 

    1. Standardized difference in coefficients 

       <img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201026102835300.png" alt="image-20201026102835300" style="zoom:50%;" />

    2. <img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201026102902271.png" alt="image-20201026102902271" style="zoom:50%;" />

    3. Cook’s distance: based on the idea of *confidence ellipsoid* 

- Cook's distance：Cook’s D measures how much the model coefficient estimates would change if an observation were to be removed from the data set. higher cook’s D, higher influnce.

  Generally accepted rules of thumb are that Cook’s D values above 1.0 indicate influential values, and any values that stick out from the rest might also be influential.

  意义依然是将原模型得到的预测值和移除第个样本后的预测值进行比较，从调参经验中我们将设置阈值设为，高于阈值的数据样本需要移除。

## interaction

> L08

The interaction term has this meaning or interpretation: consider the relationship between Y and Z. So far in this course, this relationship has been measured by b , the regression coefficient of Y on Z. This coefficient Z is a partial coefficient in that it measures the impact of Z on Y when other variables have been held constant. But suppose *the effect of Z on Y depends on the level of another variable, say X*. Then, bZ by itself would not be enough to describe the relationship because there is no simple relationship between Y and Z. It depends on the level of X. This is the idea of interaction. 

So a **interaction variable** by multiplying, **W = XZ**. Then add the term into model 

- add the interaction term, based on the t-test p_value determine whether the interation term is significant
- visualize through interaction plot 

## stability problem

> L10

from the $Var[\hat{\beta_1}]$, it has two parts, and the accuracy of our model is determined by 

- the amout of scatter about the true regression line, measured by $\sigma$, 
- “configuration” of observed $x_i$, that is, the spread of the observed $x_i$

**Analyze the configuration**

1. With one predictor 
   - spread out $x_i$ -> *well supported regression line*, little change under resampling.
   - bunched up $x_i$ -> *unstable regression line*, like a seesaw 

<img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201026093940046.png" alt="image-20201026093940046" style="zoom:50%;" />

2. two predictor $X_1$ and $X_2$

   the **spread** and **correlation** are both important 

   - strong relationship -> tends to have a “knife edge”
   - uncorrelated/orthogonal -> spread out, support the fitted plane

3. in general 

   <img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201026094703334.png" alt="image-20201026094703334" style="zoom:50%;" />



**Multicollinearity** occurs when the column of the data matrix are almost linearly dependent

https://statisticsbyjim.com/regression/multicollinearity-in-regression-analysis/

- happens when 

  1. One or more predictors have very **little variation** (this predictor almost constant compared to others *can’t explain variation in y*)
  2. One or more predictors have vey **large mean** (they should have same scale *leave residuals small*)
  3. Two or more predictors have a **linear relationship** 

  The frist two (inessential) could be removed by **standardising the data**

  The last one (essential) could not be reduced by standardising.

- How to detect multicollinearity? 

  1. general method: looking at the standard error of slope, 

  2. through variation inflation model (VIF): *1: no correlation, 1-5:moderate correlatoin, >5: critical*



## Heteroskedasticity

*constant variance is violated*

<img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201027135844740.png" alt="image-20201027135844740" style="zoom:50%;" />

do not care about fit model but care about prediction, this problem could be ignored. because it





## studentized residuals

A studentized residual is calculated by dividing the residual by an estimate of its standard deviation. The standard deviation for each residual is computed with the observation excluded. For this reason, studentized residuals are sometimes referred to as *externally* studentized residuals.

With **weighted least squares**, it is crucial that we use studentized residuals to evaluate the aptness of the model, since these take into account the weights that are used to model the changing variance. The usual residuals don't do this and will maintain the same non-constant variance pattern no matter what weights have been used in the analysis.

## VIF

*variance inflation factor*: This is a measure of how much the standard error of the estimate of the coefficient is inflated due to multicollinearity. 

1.0: no collinearity: orthogonal 

5-10: might problematic 

$>10$ : severe. when VIF=100, this would mean that the other predictors explain 99% of the variation in the given predictor. 



## auxiliary response

When do  **weighted least squares**, to determine the appropriate weights 

<img src="/Users/yuxinmiao/Documents/JI/JI2020Fall/VE406/R code/image-20201029153130141.png" alt="image-20201029153130141" style="zoom:50%;" />

> https://online.stat.psu.edu/stat501/lesson/13/13.1

- Store the residuals and the fitted values from the ordinary least squares (OLS) regression.
- Calculate the absolute values of the OLS residuals. $[z=2*(log(abs(lm\$residuals)))]\rightarrow auxiliary \ response$
- Regress the absolute values of the OLS residuals versus the OLS fitted values and store the fitted values from this regression.$[auxiliary \ regression]$ These fitted values are **estimates of the error standard deviations**.
- Calculate weights equal to $1/fits^2$, where "$fits$" are the fitted values from the regression in the last step.

We then refit the original regression model but using these weights this time in a weighted least squares (WLS) regression.

