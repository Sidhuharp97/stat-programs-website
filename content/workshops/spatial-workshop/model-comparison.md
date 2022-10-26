---
date: "2021-11-07"
title: Comparing Models
type: book
weight: 60
---

Now that we have built these spatial models, how do we pick the right one? Unfortunately, there is no one model that works best in all circumstances. In addition, there is no single way for choosing the best model. Some approaches include:

* Comparing model fitness (e.g. AIC, BIC, log likelihood). Although the methods are not nested, hence precluding a log likelihood ratio test, we can compare raw values for each fit statistic. Be careful doing this in R since linear modelling packages use different estimation procedures for maximum likelihood and REML estimation that are not comparable.  
* Comparing post-hoc power (that is, the p-values for the treatments)
* Comparing standard error of the estimates (i.e. precision)

{{% callout note %}}
Comparing changes in the coefficient of variation (CV, $\sigma/\mu$) is not recommended because in many spatial models, field variation has been re-partitioned to the error term when it was (erroneously) absorbed by the other experimental effects. As a result, the CV can increase in spatial models even when inclusion of spatial covariates results in better model fit. 
{{% /callout %}}

Unfortunately, there is no one method for unambiguously returning the the best estimates and true ranks of the treatments. Likewise, there is no one spatial method that works best in all situations and field trials.  

### Code for this section

{{< spoiler text="R" >}}
```
library(tidyr)

# remove some objects we don't need (and will interfere with downstream processes)
rm(nin_variofit, nin_vgm)
rm(nin_vgm, nin_variofit, nugget, sill, range, nugget.effect)

# assemble objects into a list
nlme_mods <- list(nin_lme, nin_exp, nin_gaus, nin_matern)
names(nlme_mods) <- c("LMM", "exponential", "gaussian", "matern")

# extract log likelihood, AIC, BIC
data.frame(loglik = sapply(nlme_mods, logLik),  
           AIC = sapply(nlme_mods, AIC),
           BIC = sapply(nlme_mods, AIC, k = log(nrow(Nin_na)))) %>% arrange(desc(loglik))
# (higher is better for loglik, lower is better for AIC and BIC)

# compare post-hoc power
# conduct ANOVA
anovas <- lapply(nlme_mods[-7], function(x){ 
  aov <- as.data.frame(anova(x))[2,]})
# bind all the output together
a <- bind_rows(anovas) %>% 
  mutate(model = c("LMM", "exponential", "gaussian", "matern", "row-col")) %>% 
  arrange(desc(`p-value`)) %>% select(c(model, 1:4)) 
rownames(a) <- 1:nrow(a)
a

## compare precision of estimates
all.preds <- mget(ls(pattern = "^preds_*"))
errors <- lapply(all.preds, "[", "SE")
pred.names <- gsub("preds_", "", names(errors))
error_df <- bind_cols(errors)
colnames(error_df) <- pred.names
boxplot(error_df, ylab = "standard errors", xlab = "linear model", 
        col = "dodgerblue3")

# compare predictions 
preds <- lapply(all.preds, "[", "emmean")
preds_df <- bind_cols(preds)
colnames(preds_df) <- pred.names
preds_df$gen <- preds_exp$gen

# plot changes in rank
lev <- c("lme", "exp", "gaus", "mat")
pivot_longer(preds_df, cols = !gen, names_to = "model", values_to = "emmeans") %>% 
  mutate(model = factor(model, levels = lev)) %>% 
  ggplot(aes(x = model, y = emmeans, group = gen)) +
  geom_point(size = 5, alpha = 0.5, col = "navy") +
  geom_line() +
  ylab("yield means for gen") + 
  theme_minimal()
``` 
{{< /spoiler >}}

{{< spoiler text="SAS" >}}
```
data NIN_RCBD_means (drop=tvalue probt alpha estimate stderr lower upper df);
	set NIN_RCBD_means;
	RCB_est = estimate;
	RCB_se = stderr;
run;

data NIN_Spatial_means (drop=tvalue probt alpha estimate stderr lower upper df);
	set NIN_Spatial_means;
	Sp_est = estimate;
	Sp_se = stderr;
run;

proc sort data=NIN_RCBD_means;
	by entry;
run;

proc sort data=NIN_Spatial_means;
	by entry;
run;

data compare;
	merge NIN_RCBD_means NIN_Spatial_means;
	by entry;
run;

proc rank data=compare out=compare descending;
	var RCB_est Sp_est;
	ranks RCB_Rank Sp_Rank;
run;

proc sort data=compare;
	by  Sp_rank;
run;

proc print data=compare(obs=15);
	var entry rcb_est Sp_est rcb_se sp_se rcb_rank sp_rank;
run;
``` 
{{< /spoiler >}}
