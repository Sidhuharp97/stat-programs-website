---
authors:
- jpiaskowski
categories:
- R
- reproducible research
date: "2021-04-15T00:00:00"
draft: false
featured: false
image:
  caption: 
  focal_point: ""
  placement: 2
  preview_only: false
lastmod: "2021-04-15T00:00:00"
projects: [Reproducible Research]
subtitle: "A few steps you can take to make your workflow in R more reproducible and less painful for you to deal with."
summary: "A few steps you can take to make your workflow in R more reproducible and less painful for you to deal with."
tags:
- R
- Reproducible Research
title: Quick Tricks and Tips for Reproducible Research in R
---


### Make sure your Rstudio session is not saving .RData automatically:

*Note: this step requires the* **usethis** *package; please install this package if you do not already have it installed.*

Step 1 is to disable automatic saving of your objects to a *.RData* file. This file is automatically loaded when R restarts. Since we often create all sorts of miscellaneous objects during a session with a clear record of why, loading all objects without a clear sense of their provenance is often not reproducible by other.

```
usethis::use_blank_slate()
```

You can read more about this function in its [documentation](https://usethis`.R`-lib.org/reference/use_blank_slate.html). 

You can disable this across all projects in R with the drop-down menu **Tools** --> *Global Options...* --> unclick '*Restore .RData into workspace at startup*' and set '*Save workspace to .rRData on exit*' to '*Never*'. 

### Save all code you run in an *.R* or *.Rmd* file

This is your source code. It's as real and as important as your input data. This file should capture a set of actions that can be repeated by another person (e.g. your PI, other colleagues yourself in the future) including packages loaded, files imported, all data manipulations and the outputs from these actions (e.g. visualisations, analytical outcomes). The idea is to capture your thought process and specific actions so this can be repeated in full. In most analyses, it is extremely likely* you will revisit a project and need to repeat what has already been done! Keeping a record of actions will save you considerable time because you will not have to attempt to recall and/or reconstruct exactly what you did in previous sessions.   

\**Consider yourself very lucky if this does not happen!*

### Regularly restart your R session

Yes, that means wiping all the loaded packaged and objects from the session (if you followed the first recommendation in these instructions), but the upside is that your analysis are reproducible. This means future you can repeat those analyses and get the same results back you did earlier. 

You can restart R by manually closing and opening RStudio. You can also restart the R session with RStudio by navigating to the menu item **Session** --> **Restart R**.

### Use R projects

This is optional, but it will make your life easier. Whenever you start a new analytical endeavor in R, create an R project by navigating to **File** --> **New Project** in RStudio. There are many options available for setting the [project directory (where the *.Rproj* file lives), the type of project (e.g. R package, Shiny app or blank), and options to initialise a git repo. The simplest option is to choose **New Project** (no special type) in a dedicated directory. The main advantage of projects is that by opening an *.Rproj* file, the working directory is automatically set to that directory. If you are using a cloud solution for working across different computers or working with collaborators, this will make things easier because you can use relative paths for importing data and outputting files. There would be no more need for this at the top of your script:

```
setwd("specific/path/to/my/computer")
```

Additionally, for setting up gitbooks through 'bookdown', R packages, Shiny apps, and other complicated R endeavors, the automated set-up through R projects can be immensely helpful.  This is sometimes referred to as "project-oriented workflow." In addition to using R projects with a dedicated directory for each research project, I also prefer to have a consistent directory structure for each project like this one:

```
top-level-directory
│   README.md
│
└───data
│   │   file011.txt
│   │   file012.txt
│   │
│   └───spatial_files
│       │   file208.dbf
│       │   file208.shp
│       │   file208.shx
│   
└───scripts
│   │   eda.R
│   │   analysis.R
│   │   plots.R
│   │   final_report.Rmd
|
└───outputs
│   │   plot1.png
│   │   blups.csv
|
└───extra
    │   some_paper.pdf
    │   ...
```

I put all raw data needed for analysis into the 'data' directory, any and all programming scripts in the 'scripts' directory, all outputs (plots, tables, intermediate data object) in the 'outputs' directory and everything else ends up 'extra'. Naturally, there are many different directory structures to use and this is just one example. Find something that works best for your needs!

### Use the 'here' package.

This is also optional. It works like R projects for setting the working directory. However, for an R project to work, you have to open the .Rproj file in RStudio. What if you or your collaborators prefer to open R files directly and start using those? Here will look for the next directory level which there is a .Rproj file and set the working directory there.

If you want to import a file, "datafile.csv" that located in the data directory. Your .R script is actually located in the 'scripts' directory. Normally, if you try to read that in, you need to specify the full path to "mydata.csv" or set the working directory and use a relative path. Again, these paths will not work if you switch computers or your collaborators are running these scripts on their own systems. This system gets even more complicated when working with an .Rmd file. Here's an alternative approach that works the same across files and systems:  

First, make sure you have .Rproj file to define the top-level directory.
```
library(here)
mydata <- read.csv(here("data", "datafile.csv"))
```

This code will construct this path: "data/datafile.csv" and execute that command under the assumption that wherever that .rproj is located (going up one directory at a time until it finds it) is where the working directory is set. Putting `library(here)` into every .R or .Rmd file in a project will resolve these issues.

### Use R environments.

Again: optional, but it will make your life easier.

Often in academia, I might do an analysis, move on to something else and then have to return that analysis months or years later. I probably will have updated R and some or all of the packages used in that analysis. As a result of these updates, my original code may not work at all or may not do the intended actions. What I need are both the older version of R and the older packages. The package 'renv' is a solution. It captures the versions of R and the loaded packages. It also builds a custom package library for your package (and caches this information across other projects using `renv`).

Start here:
*(you need to also be using Rprojects since* **renv** *is searching for .Rproj file)*
```
library(renv)
renv::init()
```
If you have a mature project that's not undergoing any further development at this time, this is all you need to do.

If you continue to develop your project and install new packages, update your R environment like thus to ensure new or updated packaged are included:
```
renv::snapshot()
```

If you're familiar with **Packrat**, this is a replacement for that. This is particularly helpful for things that may have a long life span, like Shiny apps. The [renv package](https://rstudio.github.io/renv/articles/renv.html) has extensive documentation worth reading. 

### Final Comments

There are many more resources and recommendations for conducting reproducible research in R. There an entire [CRAN task view](https://cran`.R`-project.org/web/views/ReproducibleResearch.html) devoted to this!