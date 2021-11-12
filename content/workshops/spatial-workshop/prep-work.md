
---
date: "2021-11-07"
title: Computational Set-up
type: book
weight: 1
---

{{< icon name="r-project" pack="fab" >}} Here are instructions for how check your R installation and install packages needed for the workshop.  

### Check software versions 

Open R and run this code to check what version of R your system is running: 
```
R.Version()
```
If the version printed is not 4.0 or newer, please [upgrade R](https://cran.r-project.org/). 

*This step is not required if you do not use RStudio.* Open RStudio and run this code to check what version of RStudio is installed on your system: 

```
rstudioapi::versionInfo()
```

If the version printed is not 1.4 or newer, please [upgrade Rstudio](https://www.rstudio.com/products/rstudio/download/). 


### Install workshop packages 

Open R and run this script:  
```
package_list <- c("dplyr", "tidyr", "purrr",       # for standard data manipulation
                  "ggplot2", "desplot",            # for plotting
                  "nlme", "lme4", "emmeans",       # for linear modelling
                  "SpATS",                         # for fitting splines
                  "sp", "spdep", "gstat", "spaMM", "sf")    # for spatial modelling

install.packages(package_list)
sapply(package_list, require, character.only = TRUE)
```

{{% callout warning %}}
Please note that the spatial packages may take awhile to install, and you may run into problems with the installation. Please attempt installation *in advance* of the workshop. The packages have all been successfully installed if after the `sapply(package_list, require, character.only = TRUE)` is run, the R output is "TRUE" for each package. If you have problems installing and/or loading any of these packages that you are not able to resolve, contact us so we can help you, preferably *before* the workshop.
{{% /callout %}}

### Library Information

|package |usage |
|-------------|-------------|
|[dplyr](https://dplyr.tidyverse.org/), [tidyr](https://tidyr.tidyverse.org/), | standard data manipulation |
|[purrr](https://purrr.tidyverse.org/)  | for repeat functions |
| [nlme](https://CRAN.R-project.org/package=nlme) | mixed linear models with options for spatial covariates |
|[lme4](https://CRAN.R-project.org/package=lme4) | mixed linear models with crossed random effects |
| [ggplot](https://ggplot2-book.org/), [desplot](http://kwstat.github.io/desplot/index.html)| standard plotting packge and extension for plotting block outlines |
|[SpATS](https://CRAN.R-project.org/package=SpATS) | spline-fitting |
|[sp](https://CRAN.R-project.org/package=sp) | preparation of spatial objects |
|[spdep](https://r-spatial.github.io/spdep/) |  Moran's I test|
| [gstat](https://CRAN.R-project.org/package=gstat) | for fitting empirical variogram |
| [spaMM](https://gitlab.mbb.univ-montp2.fr/francois/spamm-ref) | fits Matern covariances structure for mixed linear models |
| [emmeans](https://github.com/rvlenth/emmeans) | extracts marginal means from linear model objects | 

