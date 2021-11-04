
---
date: "2021-11-01"
title: Computation Set-up
type: book
weight: 1
---

Check R installation and install needed packages. 

### Check software versions 

Check R Version: 

```
R.Version()
```
If the version printed is not 4.0 or newer, please [upgrade R](https://cran.r-project.org/). 

Check RStudio version

```
rstudioapi::versionInfo()
```

If the version printed is not 1.4 or newer, please [upgrade Rstudio](https://www.rstudio.com/products/rstudio/download/). 


### Install workshop packages 

```
package_list <- c("dplyr", "tidyr", "purrr",       # for standard data manipulation
                  "ggplot2", "desplot",            # for plotting
                  "nlme", "lme4", "emmeans",       # for linear modelling
                  "SpATS",                         # for fitting splines
                  "sp", "spdep", "gstat", "sf")    # for spatial modelling

install.packages(package_list)
sapply(package_list, require, character.only = TRUE)
```

Please note that the spatial packages may take awhile to install and you may run into problems with the installation. Please install these in advance of the workshop and contact the workshop organizer if you are not able to install and load all packages. Please contact to us *before* the workshop so we can help you.

