---
date: "2021-11-01"
title: Final thoughts
type: book
weight: 80
---

Spatial analysis can be challenging, but I think it is worth the effort to learn and implement in analysis of field trials. Incorporating spatial statistics into analysis of feel trials can be overwhelming at time. However, investigating spatial correlation in a field trial and controlling for it if necessary using *any* of the methods developed for this is recommended over doing nothing.

There is no denying that work is needed to develop scripts that automate this process so researchers can routinely incorporate spatial covariance into field trial analysis. Many current R tools are unwieldy to use and have insufficient options to support variety trial analysis.

Until this situation is improved, it is probably wisest to focus on using spatial models that are well-supported at this time. Any of the options implemented in the **nlme** package (or that work with that package) are decent choices with excellent support for extracting least-squares means, running ANOVA, and standard model diagnostics. Furthermore, **nlme** supports generalized linear models. **INLA** is established is supported by a large and growing user base, and **breedR** is likewise well established. 

### Other resources

* [Incorporating Spatial Analysis into Agricultural Field Experiments](https://idahoagstats.github.io/guide-to-field-trial-spatial-analysis/), a more comprehensive version of this tutorial

* CRAN task view on [analysis of spatial data](https://cran.r-project.org/web/views/Spatial.html)

* Other R packages

|package |usage |
|-------------|-------------|
|[breedR](http://famuvie.github.io/breedR/) | mixed modelling with AR1xAR1 estimation |
|[inla](https://www.r-inla.org)  | Bayesian modelling with options for spatial covariance structure |
| [Mcspatial](https://github.com/cran/McSpatial) | nonparametric spatial analysis, (no longer on CRAN) |
|[ngspatial](https://CRAN.R-project.org/package=ngspatial) | spatial models with a focus on generalized linear models |
| [sommer](https://CRAN.R-project.org/package=sommer) | mixed models, including an AR1xAr1 model |
|[spamm](https://gitlab.mbb.univ-montp2.fr/francois/spamm-ref) | Matérn covariance structure |
|[spANOVA](https://github.com/lrcastro/spANOVA) | spatial lag models for field trials |
| [spatialreg](https://r-spatial.github.io/spatialreg/) | spatial functions for areal data |


The package **sommer** implements a version of the AR1xAR1 covariance structure. However, it does not estimate the parameter $\rho$. The user must specify the $\rho$ and that value is not optimized in the restricted maximum likelihood estimation. Both **BreedR** and **inla** implement an AR1xAR1 covariance structure. Additional, SAS and the proprietary software [asreml](https://asreml.kb.vsni.co.uk/) can implement a mixed model with this covariance structure.

### Books for the deep dive

{{< figure src="cressie_revised.jpg" >}}

* [**Statistics for Spatial Data**](https://onlinelibrary.wiley.com/doi/book/10.1002/9781119115151)

* **Applied Spatial Data Analysis with R**, available for [free](https://asdar-book.org/)

* [**Spatio-Temporal Statistics With R**](https://spacetimewithr.org/) (also free)

* [**Spatial Data Analysis in Ecology and Agriculture Using R**](https://www.routledge.com/Spatial-Data-Analysis-in-Ecology-and-Agriculture-Using-R/Plant/p/book/9780367732325)
