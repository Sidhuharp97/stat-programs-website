---
date: "2021-11-01"
title: Linear Models with Correlated Errors
type: book
weight: 40
---

Now that we have a sense of how to model spatial variation, the next step is to incorporate that into a linear model. The starting point is the linear mixed model. In RCBD design, often the treatments are treated as fixed and the block effect as random.

$$Y_ij = \mu + \alpha_i + \beta_j + \epsilon_{ij}$$

$Y_ij$ is the independent variable   
$\mu$ is the overall mean   
$\alpha_i$ is the effect due to the $i^{th}$ treatment   
$\beta_j$ is the effect due to the $j^{th}$ block   
$\epsilon_{ij}$ are the error terms distributed as $N ~\sim (0,\sigma)$    

Here is an expanded version of the last term: 

$$  \epsilon_{ij} ~\sim N \Bigg( 0,
\left[ { \begin{array}{ccc} \sigma & \cdots & 0 \\\\
   \vdots & \ddots & \vdots \\\\
   0 & \cdots & \sigma \end{array} } \right] \Bigg) $$
   
This is a mathematically representation of **iid**, independent and identically distributed, an assumption of linear models. When there is spatial autocorrelation, observations closer to one another are correlated, so the off-diagonals in the variance-covariance matrix are not zero. 

Spatial models seek to mathematically model this covariance so it is properly accounted for during hypothesis testing and prediction. 

### Code for this section

*The following scripts build upon work done in previous section(s).* 

{{< spoiler text="R" >}}
```
library(emmeans); library()
# (nlme and gstat should already be loaded)
library(spaMM) # for running `corMatern()`

# standard linear model
nin_lme <- lme(yield ~ gen, random = ~1|rep,
              data = Nin,
              na.action = na.exclude)
              
# extract the least squares means for variety
preds_lme <- as.data.frame(emmeans(nin_lme, "gen"))

# use information from the variogram fitting for intialising the parameters
nugget <- Nin_variofit_gau$psill[1] 
range <- Nin_variofit_gau$range[2]  
sill <- sum(Nin_variofit_gau$psill) 
nugget.effect <-  nugget/sill

# initalise the covariance structure (from the nlme package)
cor.gaus <- corSpatial(value = c(range, nugget.effect), 
                  form = ~ row.length + col.width, 
                  nugget = T, fixed = F,
                  type = "gaussian", 
                  metric = "euclidean")

# update the rcbd model
nin_gaus <- update(nin_lme, corr = cor.gaus)

# a similar procedure can be follow for other models
# but we are going to take a shortcut and not specify the parameters

# exponential
cor.exp <- corSpatial(form = ~ row.length + col.width, 
                      nugget = T, fixed = F)

nin_exp <- update(nin_lme, corr = cor.exp)
preds_exp <- as.data.frame(emmeans(nin_exp, "gen"))

# Matern structure
cor.mat <- corMatern(form = ~ row.length + col.width, 
                     nugget = T, fixed = F)
nin_matern <- update(nin_lme, corr = cor.mat)
``` 
{{< /spoiler >}}

{{< spoiler text="SAS" >}}
```
proc mixed data=alliance ;
	class entry rep;
	model yield = entry ;
	random rep;
	lsmeans entry/cl;
	ods output LSMeans=NIN_RCBD_means;
	title1 'NIN data: RCBD';
run;

proc mixed data=alliance maxiter=150;
	class entry;
	model yield = entry /ddfm=kr;
	repeated/subject=intercept type=sp(gau) (Row Col) local;
	parms (11) (22) (19);
	lsmeans entry/cl;
	ods output LSMeans=NIN_Spatial_means;
	title1 'NIN data: Gaussian Spatial Adjustment';
run;
``` 
{{< /spoiler >}}
