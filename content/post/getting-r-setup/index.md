---
authors:
- jpiaskowski
categories:
- R
- reproducible research
date: "2021-04-15T00:00:00Z"
draft: false
featured: false
image:
  caption: 'Image credit: [**autoevolution**](https://www.autoevolution.com/news/lego-for-grown-ups-or-automotive-ikea-how-to-spend-the-perfect-day-assembling-a-car-101191.html#)'
  focal_point: ""
  placement: 2
  preview_only: false
lastmod: "2021-04-15T00:00:00Z"
projects: [Reproducible Research]
subtitle: "Some instructions for R installation and your R setup to support reproducible research."
summary: "Some instructions for R installation and your R setup to support reproducible research."
tags:
title: Getting R Set Up
---



### Installing R:

You can download R [here](https://cloud.r-project.org/). Get the correct R distribution for your operating system. Once downloaded, click on downloaded file, and follow the installation instructions.
  
Note that R is updated several times per year. If your installation is a year old or more, consider updating your version of R to the latest version.

### Installing RStudio

Rstudio is not R, rather, it is a user interface for accessing R. It is a complicated interface with many features for developers. Despite its complexity, RStudio is nevertheless a very helpful R user interface for users of all abilities. It can downloaded [here](https://www.rstudio.com/products/rstudio/download/). For most users, the free version of "RStudio Desktop" should be chosen. Once downloaded, click on downloaded file, and follow the installation instructions.

### Installing Rtools (optional)

Only Windows users need to consider this step. This app is for compiling R packages with C, C++ and Fortran code. It is a separate piece of software that has to be downloaded and installed (it is not an R package). Rtools is not needed by all users and if you don't know if you need this, it is absolutely fine to skip this step.  If you do think you need this, You can find it [here](https://cran.r-project.org/bin/windows/Rtools/). Download and install.

### Setting up RStudio Setup (optional)

This is an optional step, but it is highly recommended. This step will prevent RStudio from saving all of your objects in a session to *.Rdata* file that is then automatically loaded whenever you open R.  

```
install.packages("usethis"); library(usethis)
usethis::use_blank_slate()
```

You can disable this across all projects in R with the drop-down menu **Tools** --> **Global Options...** --> unclick '**Restore .RData into workspace at startup**' and set '**Save workspace to .rRData on exit**' to '**Never**'. 

Why is automatic loading of an *.Rdata* file not recommended? Because it makes your work less reproducible. You may have created test objects that will unexpectedly interfere with downstream operations or analysis. You may have changed the original data source, but an older version is saved in the *.Rdata* file. More explanation is given by [RStudio](https://usethis.r-lib.org/reference/use_blank_slate.html).

If you are used to opening R and seeing all of your previous objects automatically loaded into the objects pane, this will be an adjustment. The solution is to save your processes into *.R* scripts that capture all information from packages loaded, file import, all data manipulations and other operations important. If these steps are slow and there is a need to access intermediate objects, these can be saved in tabular formats readable by many applications (e.g. *.txt* or *.csv*) or saved as a specific R object (see `saveRDS()` in the R help files) and reloaded in another session.

#### Set up version control (optional)

If you use Git or SVN, you can perform Git operations directions from RStudio and interact with remote repositories. If you don't use version control, this step can be skipped. If you do use version control, the command line or other third-party software (e.g. Gitkraken) are fine to use instead or in addition to RStudio's interface. The implementation of git in R is very minimal and supports only a limited number of actions, so you are likely to need other software to perform complicated git actions. It is useful for file additions, commits, pushes and pulls.

You can set up Git by going to **Tools** --> **Global Options** --> **Git/SVN**.

This is not the right space to provide detailed instructions for using git as an R user, but Jenny Bryan has written a very helpful [tutorial](https://happygitwithr.com/index.html) covering this subject.
