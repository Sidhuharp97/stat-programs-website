
---
date: "2021-11-01"
title: Computational Set-up
type: book
weight: 1
---

Here are instructions for how check your R installation and install packages needed for the workshop.  

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
                  "sp", "spdep", "gstat", "sf")    # for spatial modelling

install.packages(package_list)
sapply(package_list, require, character.only = TRUE)
```

Please note that the spatial packages may take awhile to install, and you may run into problems with the installation. Please install these in advance of the workshop. If you have problems installing and/or loading any of these packages that you are not able to resolve, contact us so we can help you, preferably *before* the workshop.

### Download files for workshop

The following files are used in the workshop: 
 
[Nebraska Interstate Nursery](https://raw.githubusercontent.com/IdahoAgStats/guide-to-field-trial-spatial-analysis/master/data/stroup_nin_wheat.csv), a wheat variety trial arranged in a randomised complete block design with 4 blocks. This data set was first described by W. Stroup (2004) and has been used extensively for spatial analysis. 

[Lind](https://raw.githubusercontent.com/IdahoAgStats/guide-to-field-trial-spatial-analysis/master/data/AB19F5_LIND.csv), a winter wheat variety trial from Washington using an augmented design. This data set was kindly donated by [Kimberly Garland Campbell](https://www.ars.usda.gov/pacific-west-area/pullman-wa/whgq/people/kimberly-garland-campbell/) of the USDA-ARS. 

Please download these in advance so you can run the R and/or SAS scripts in the workshop.


