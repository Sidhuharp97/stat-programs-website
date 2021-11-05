---
date: "2021-11-01"
title: Empirical Variograms
type: book
weight: 40
---






### Code for this section

*The following scripts build upon work done in previous section(s).* 

{{< spoiler text="R" >}}
```
# set up spatial object
Nin_spatial <- Nin_na
coordinates(Nin_spatial) <- ~ col.width + row.length
class(Nin_spatial)

# establish max distance for variogram estimation
max_dist = 0.5*max(dist(coordinates(Nin_spatial)))


``` 
{{< /spoiler >}}

{{< spoiler text="SAS" >}}
```
here it is.
more code
``` 
{{< /spoiler >}}
