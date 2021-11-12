---
date: "2021-11-07"
title: Why Care about Spatial Variation?
type: book
weight: 10
---

#### Agricultural field trials

{{< figure src="Parker_farm.png" caption="University Research Farm" >}}

The goal of many agricultural field trials is to provide information about crop response to a set a treatments such as soil treatments, disease pressure or crop genetic variation. 

{{< figure src="variety_testing.JPG" id="vartest">}}

#### Field variation

Agricultural field trials often employ popular experimental designs such as randomized complete block design to account for environmental heterogeneity. However, those techniques are quite often inadequate to fully account for spatial heterogeneity that arises due to field position, soil conditions, disease, wildlife impacts and more. 

Here is the a map of a wheat variety trial conducted in Idaho with a chloropleth map indicating plot yield. Each square represents a plot. 

{{< figure src="Kimberly2013.png" >}}

#### Blocking in a field trial

Block is not always sufficient to account for spatial variation. Here is the same Idaho variety trial with block information overlaid:

{{< figure src="Kimberly2013_blocking.png" >}}

The block arrangement is clearly not aligning with the field variation. 

#### When Spatial Variation is not Fully Accounted For

* The treatment rankings can be wrong. Here is a plot of the cultivar ranks for yield from the Idaho variety trial when analysed with a standard linear mixed model and the same model augmented with spatial covariates. 

{{< figure src="Kimberly2013_ranks.png" >}}

* Error terms are often correlated with each other, invalidating the downstream analysis

{{< figure src="resids.png" >}}

* high error/low precision/wide confidence intervals/low experimental power

#### Blocking versus spatial statistics

{{< figure src="boyfriend_meme.jpg" caption="another distracted boyfriend meme!" >}}

Researchers do not have to abandon blocking when incorporating spatial covariates into analysis of a field trial. In fact, using blocking or other experimental designs combined with spatial modelling has been shown improve the quality of the final estimates. 
