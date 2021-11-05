
#### Check Software Versions ####

# Check R Version: 
R.Version()
# if not 4.0 or newer, please upgrade

# check RStudio Version:
rstudioapi::versionInfo()
# if not 1.4 or newer, please upgrade


#### Install Needed Packages ####

package_list <- c("dplyr", "tidyr", "purrr",       # standard data manipulation
                  "ggplot2", "desplot",            # plotting
                  "nlme", "lme4", "emmeans",       # linear modelling
                  "SpATS",                         # fitting splines
                  "sp", "spdep", "gstat", "sf")    # spatial modelling

install.packages(package_list)
sapply(package_list, require, character.only = TRUE)

# Please note that the spatial packages may take awhile to install 
# and you may run into problems with the installation. 
# Please do this in advance and contact the workshop organizer if you 
# are unable to install and load all the packages, contact us! 
# (preferably before the workshop)

