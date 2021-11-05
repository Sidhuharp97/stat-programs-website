---
date: "2021-11-01"
title: Row-and-Column Models
type: book
weight: 30
---

The spatial models we will introduce later in this workshop assume that spatial variation is localised and within a trial, plots located sufficiently far apart are independent of each other with no apparent spatial correlation. However, sometimes that is accurately describe a field trial. There can be experiment-wide gradients due to position on a slope, proximity to an influential environmental factor (e.g. a road), and so on. In these instances, those gradients should be modelled as a trend. 

### Blocking 

Blocking is one example of modelling an experiment wide-trend:

$$Y_ij = \mu + \alpha_i + \beta_j + \epsilon_{ij}$$

$Y_ij$ is the independent variable   
$\mu$ is the overall mean   
$\alpha_i$ is the effect due to the $i^{th}$ treatment   
$\beta_j$ is the effect due to the $j^{th}$ block   
$\epsilon_ij$ are the error terms distributed as $N ~\sim (0,\sigma)$    

{{< figure src="blocking.png" >}}

The expectation is that each block will capture and model existing variation  within it. This becomes difficult to justify as blocks become large. 

### Rows & Ranges

Trials rows and ranges can likewise be modelled directly in a model:

$$Y_ijk = \mu + \alpha_i + \beta_j + \gamma_k + \epsilon_{ijk}$$

$\beta_j$ is the effect due to the $j^{th}$ row   
$\beta_j$ is the effect due to the $k^{th}$ range (or column)

### Code for this section

*The following scripts build upon work done in previous section(s).* 

{{< spoiler text="R" >}}
```
# load libraries
library(lme4)

# exploratory plots 
boxplot(yield ~ rep, data = Nin, xlab = "block", col = "red2")
boxplot(yield ~ row, data = Nin, xlab = "row", col = "dodgerblue2")
boxplot(yield ~ col, data = Nin, xlab = "column", col = "gold")

## row/column model ##

# data prep
Nin$rowF = as.factor(Nin$row)
Nin$colF = as.factor(Nin$col)

# specify model
nin.rc <- lmer(yield ~ gen + (1|colfF) + (1|rowF),
              data = Nin, na.action = na.exclude)
# extract random effects for row and column
ranef(nin_rc)
``` 
{{< /spoiler >}}

{{< spoiler text="SAS" >}}
```
# exploratory boxplots
proc sgplot data=alliance;
    vbox yield/category=rep FILLATTRS=(color=red) LINEATTRS=(color=black) WHISKERATTRS=(color=black);
run;

proc sgplot data=alliance;
    vbox yield/category=Col FILLATTRS=(color=yellow) LINEATTRS=(color=black) WHISKERATTRS=(color=black);
run;

proc sgplot data=alliance;
    vbox yield/category=Row FILLATTRS=(color=blue) LINEATTRS=(color=black) WHISKERATTRS=(color=black);
run;

# row/column model
proc mixed data=alliance ;
	class entry rep;
	model yield = entry  row col/ddfm=kr;
	random rep;
	lsmeans entry/cl;
	ods output LSMeans=NIN_row_col_means;
	title1 'NIN data: RCBD';
run;
``` 
{{< /spoiler >}}
