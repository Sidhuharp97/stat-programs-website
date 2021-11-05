---
date: "2021-11-01"
linkTitle: Spatial Statistics in Field Trials
summary: Routine inclusion of spatial statistics in planned field experiments
title: "Spatial Recipes for Field Trials"
type: book
---

{{< figure src="featured.jpg" >}}

## Location

Sunday, November 7  
9:00am - 4:00pm  
Salt Palace Convention Center, 250D 

## What you will learn

* how to diagnose spatial covariance in field trial data
* how to model spatial covariance in a linear model in R and SAS
* how to model an empirical variogram
* how to pick the "best" spatial model

## Workshop overview

Agricultural field experiments commonly employ standard experimental designs such as randomized complete block to control for field heterogeneity.  However, there is often substantial spatial variation not fully captured by blocking, particularly in large experiments. Although spatial statistics have demonstrated effectiveness in controlling localized spatial variation, they are rarely integrated into analysis of agricultural field experiments. The purpose of this workshop is to provide tools for diagnosing with-field spatial variation and accounting for that spatial variation in statistical analysis of trial data. 

## Intended Audience

This workshop is open to scientists, students, technicians and anyone else who conducts planned field experiments that are arranged in a regular gridded layout. Attendees will need a laptop with R or SAS installed. Some knowledge of programming in R (if you follow the R track) or SAS (if you follow the SAS track) is assumed: setting a working directory, importing files, loading libraries, calling functions. Familiarity with randomized complete block design and how to analyze that design is also assumed.

## How to Prepare

**R**

You will need a recent version of R, available free through the [Comprehensive R Archive Network](https://cran.r-project.org/) (CRAN). While this is sufficient for running R scripts, You may also find it helpful to use RStudio, which provides a nice graphical user interface for R. RStudio can be downloaded [here](https://www.rstudio.com/products/rstudio/download/). Additionally, there are several package to download:  

{{< cta cta_text="check your system" cta_link="prep-work" >}}

**SAS**

In order to run the SAS portion of this tutorial, a valid copy of SAS Base and Stat products and a current SAS license are required. This tutorial was built using SAS 9.4 (TS1M5). Although older versions of SAS may also work, we have not evaluated this. Users can also consider downloading and using a free version of [SAS® On Demand for Academics: Studio](https://www.sas.com/en_us/software/on-demand-for-academics/references/getting-started-with-sas-ondemand-for-academics-studio.html).

The workshop will use Rstudio and the standard SAS interface for R and SAS code demonstrations, respectively. 

## Draft Schedule

| Time  |      Topic   | 
|-------|:-------------|
| 9:00  |  welcome/intro | 
| 9:20  |  diagnosing spatial autocorrelation |   
| **10:00** | **10-minute break** | 
| 10:10 | code demo |
| 11:05 | row-by-column designs |
| 11:30 | empirical variograms |
| **12:00** | **1-hour lunch** |
| 13:00 | questions |
| 13:15 | code demo |
| **14:00** | **10-minute break** |
| 14:10 | splines + code demo |
| 14:40 | model compariso + code demo |
| 15:00 | augmented designn + code demo |
| 16:00 | Adjourn |

*This schedule may be adjusted as the workshop unfolds.* 

## Meet Your Instructors

{{< mention "jpiaskowski" >}} is an agricultural statistician at the University of Idaho, Software Carpentry Certified Instructor and long-time R programmer. 


{{< mention "xdai" >}} is consulting statistician at Utah Agricultural Experiment Station, Utah State University with 12 years of experience in SAS programming.  


{{< cta cta_text="begin the workshop" cta_link="why-spatial" >}}

*This workshop is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/4.0/.*
