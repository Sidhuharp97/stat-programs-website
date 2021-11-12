---
date: "2021-11-07"
title: Augmented Designs
type: book
weight: 70
---

The augmented experimental design is a special design where there is a large number of unreplicated plots interspersed with frequent checks that are replicated. This type of model is  useful when the number of treatments is very large and/or replication is either impossible or unfeasible. Often, the primary goal of the studies using this design is to rank or select genotypes. 

Augmented models are analyzed in a fundamentally different method than RCBD models due to the large number of unreplicated observations. To adjust for the lack of replication, only a select set of treatments, usually of known performance, are replicated in the experiments. The error estimated from these replicated treatments is used in the analysis to evaluate the remaining genotypes. 

There are multiple way to specify an augmented model depending on what the researcher wants to know.

### Model specification \#1

$$ Y_{ij} = \tau_i + \beta(\tau)_{ij} $$

where:

* $ Y_{ij}$ is the response variable    
* $ \tau_i$ is the effect of each check and the average effect of all unreplicated treatments    
* $ \beta(\tau)_{ij}$ is is the effect of the $j^{th}$ unreplicated treatment nested within the overall effect of unreplicated treatments    

This model evaluates:

1. The difference between all checks and the average of the unreplicated treatments.
1. The difference between the unreplicated treatments. 

### Model specification \#2

$$ Y_{ij} = \delta_i + \gamma(\delta)_{ij} $$

where:

* $ Y_{ij}$ is the response variable   
* $ \delta_i$ is the average effect of all checks and the average effect of all unreplicated treatments (so there are only 2 treatment levels)   
* $ \gamma(\delta)_{ij}$ is is the effect of the $j^{th}$ treatment nested within the either unreplicated treatments or the check observations   

This model evaluates:

1. The difference between the average of the checks and the average of the unreplicated treatments
1. The difference between all treatments
 
These models are described more in depth in [Burgueño et al, 2018](https://doi.org/10.2134/appliedstatistics.2016.0005.c13), along with a helpful discussion on when to treat any of these effects as fixed or random

The data used here refer to a wheat genotype evaluation study carried out near Lind Washington. The study looked at 922 unreplicated genotypes (‘name’) accompanied by 9 replicated check wheat cultivars.  

### Code for this section

*The following scripts build upon work done in previous section(s).* 

{{< spoiler text="R" >}}
```
# (if not already loaded)
library(dplyr); library(nlme); library(ggplot2)
library(gstat); library(sp)

# read in data
aug_data_origin <- read.csv("data/AB19F5_LIND.csv", 
                     na.strings = c("", "NA", ".", "999999")) %>% 
  slice(-1) %>% # first line not needed
  mutate(yieldkg = yieldg/1000)  # to prevent overflow

# summarise the genoytypic data by checks/not checks
gen_sum <- group_by(aug_data_origin, name) %>% summarise(counts = n()) %>% 
  mutate(delta =  case_when(
    counts > 1 ~ "check",
    counts == 1 ~ "unrep"))

# need info on just the checks
checks <- gen_sum %>% filter(delta == "check") 

# more summarise steps for different augmented modes
gen_sum2 <- gen_sum  %>%  mutate(gamma = name) %>% 
  mutate(tau = case_when(
    delta == "check" ~ gamma,
    delta == "unrep" ~ "unreplicate_obs")) %>% 
  mutate(beta = case_when(
    delta == "unrep" ~ gamma,
    delta == "check" ~ NA_integer_)) # or maybe "check"

# merge original data set with info on treatment levels
aug_data <- aug_data_origin %>% 
  select(name, prow, pcol, yieldg) %>%
  mutate(row = prow*11.7, col = pcol*5.5) %>% 
  full_join(gen_sum2, by = "name") 

# calculate denominator degrees of freedom
ddf = sum(checks$counts) - nrow(checks) - 1

## initial linear model:

# tau estimates effects of checks versus all unreplicated genotypes)
# beta predicts effects each unreplicated genotypes, nested in tau 
aug1 <- lme(fixed = yieldg ~ tau,
                 random = ~ 1|tau/beta,
                 data = aug_data, na.action = na.exclude)

# another formulation
# delta estimates effects of replicated versus unreplicated genotypes
# gamma estimates the effecs of all genotypes evaluated in the trial
aug2 <- lme(fixed = yieldg ~ delta,
                 random = ~ 1|delta/gamma,
                 data = aug_data, na.action = na.exclude)

# extract residuals
aug_data$res <- residuals(aug1)

# plot residual chlorpleth map:
ggplot(aug_data, aes(y = row, x = col)) +
  geom_tile(aes(fill = res)) +
  scale_fill_gradient(low = "yellow", high = "black") +
  scale_x_continuous(breaks = seq(1,max(aug_data$row), 1)) +
  scale_y_continuous(breaks = 1:max(aug_data$col)) +
  coord_equal() +
  theme_void() 

# add spatial covariates
aug_spatial <- aug_data %>% filter(!is.na(res))
coordinates(aug_spatial) <- ~ col + row
max_dist = 0.5*max(dist(coordinates(aug_spatial)))

aug_vario <- gstat::variogram(res ~ 1, 
                               cutoff = max_dist,
                               width = max_dist/10, # 20 is the number of bins
                               data = aug_spatial)
plot(aug_vario)

# optional to run: 
# nugget_start <- min(aug_vario$gamma)
# aug_vgm <- vgm(model = "Exp", nugget = nugget_start) 
# aug_variofit <- fit.variogram(aug_vario, aug_vgm)
# plot(aug_vario, aug_variofit, main = "Exponential model")     

cor_exp <- corSpatial(form = ~ row + col, 
                      nugget = T, fixed = F,
                      type = "exponential")

aug1_sp <- update(aug1, corr = cor_exp)

# spatial parameters:
aug1_sp$modelStruct$corStruct

# extract BLUPs for unreplicated lines:
aug_blups <- ranef(aug1_sp)$beta %>% rename(yieldg = '(Intercept)')

# look at variance components
VarCorr(aug1_sp)
``` 
{{< /spoiler >}}

{{< spoiler text="SAS" >}}
```
filename AUG url "https://raw.githubusercontent.com/IdahoAgStats/guide-to-field-trial-spatial-analysis/master/data/AB19F5_LIND.csv";

PROC IMPORT OUT= WORK.augmented
     DATAFILE= AUG
     DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

data augmented;
	set augmented;
	if yieldg = 999999 or yieldg=. then delete; /* Remove missing values */
	prow=prow*11.7; /*convert row and column indices to feet */
	pcol=pcol*5.5;
run;

proc freq noprint data=augmented;
	tables name/out=controls;
run;

data controls;
	set controls;
	if count >1;
run;

proc sort data=controls;
	by name;
run;
     
proc sort data=augmented;
	by name;
run;

data augmented;
	merge augmented controls;
	by name;
	if count=. then d2=2; /* Unreplicated */
	else d2=1;            /* Replicated */
	yieldkg=yieldg/1000;
run;

PROC mixed data=augmented;
	class name d2;
	model yieldkg = d2/noint outp=residuals ddf=229 229;
	lsmeans d2;
	*lsmeans name(d2)/slice = d2;
run;

proc sgplot data=residuals;
	HEATMAPPARM y=pRow x=pCol COLORRESPONSE=resid/ colormodel=(cx014458 cx1E8C6E cxE1FE01); 
title1 'Field Map';
run;

proc variogram data=residuals plots(only)=(fitplot);
   where yieldkg ^= .;
   coordinates xc=pcol yc=pRow;
   compute lagd=6.6 maxlags=25;
   model form=auto(mlist=(gau, exp, pow, sph) nest=1);
  var resid;
run;

PROC mixed data=augmented;
	class name d2;
	model yieldkg = d2 name(d2)/outp=adjresiduals ddf=229 229;
	lsmeans d2;
	repeated/subject=intercept type=sp(pow)(prow pcol) local;
	ods output SolutionR =parms;
	parms (0.074) (0.0051)(0.475)  ;
	*lsmeans name(d2)/slice = d2;  # alot of output!!
run;
``` 
{{< /spoiler >}}

