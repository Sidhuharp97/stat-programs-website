---
date: "2021-11-01"
title: Diagnosing Spatial Autocorrelation
type: book
weight: 20
---

Spatial autocorrelation refers to similarity between points that are close to one another.  That correlation is expected to decline with distance. Note that is different from experiment-wide gradients, such as a salinity gradient or position on a slope. 

### Plotting

One of the easiest ways to diagnose spatial autocorrelation is by plotting data by its spatial position and using a heat map to indicate values:

{{< figure src="SOS_2017.png" >}}

### Moran's I

Moran's I, sometimes called "Global Moran's I" is similar to a correlation coefficient. It is a test for correlation between units (plots in our case). 

$$ I = \frac{N}{W}\frac{\sum_i \sum_j w_{ij} (x_i - \bar{x})(x_j - \bar{x})}{\sum_i(x_i - \bar{x})^2} 
\qquad i \neq j$$

Where N is total number of spatial locations indexed by $i$ and $j$, x is the variable of interest, $w_{ij}$ are a spatial weights between each $i$ and $j$, and W is the sum of all weights. The expected values of Moran's I is $-1/(N-1)$. Values greater than that indicate positive spatial correlation (areas close to each other are similar), while values less than the expected Moran's I indicate dissimilarity as spatial distance between points decreases. 

There are several options for defining adjacent neighbors and how to weight each neighbor's influence. The two common configurations for defining neighbors are the rook and queen configurations. These are exactly what their chess analogy suggest: "rook" defines neighbors in an row/column fashion, while "queen" defines neighbors in a row/column configuration an also neighbors located diagonally at a 45 degree angle from the row/column neighbors. Determining this can be somewhat complicated when working with irregularly-placed data (e.g. county seats), but is quite unambiguous for lattice data common in planned field experiments:






