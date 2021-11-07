---
date: "2021-11-01"
title: Comparing Models
type: book
weight: 60
---

{{% callout note %}}
*Under Construction...*
{{% /callout %}}


### Code for this section

{{< spoiler text="R" >}}
```
here it is.
more code
``` 
{{< /spoiler >}}

{{< spoiler text="SAS" >}}
```
data NIN_RCBD_means (drop=tvalue probt alpha estimate stderr lower upper df);
	set NIN_RCBD_means;
	RCB_est = estimate;
	RCB_se = stderr;
run;

data NIN_Spatial_means (drop=tvalue probt alpha estimate stderr lower upper df);
	set NIN_Spatial_means;
	Sp_est = estimate;
	Sp_se = stderr;
run;

proc sort data=NIN_RCBD_means;
	by entry;
run;

proc sort data=NIN_Spatial_means;
	by entry;
run;

data compare;
	merge NIN_RCBD_means NIN_Spatial_means;
	by entry;
run;

proc rank data=compare out=compare descending;
	var RCB_est Sp_est;
	ranks RCB_Rank Sp_Rank;
run;

proc sort data=compare;
	by  Sp_rank;
run;

proc print data=compare(obs=15);
	var entry rcb_est Sp_est rcb_se sp_se rcb_rank sp_rank;
run;
``` 
{{< /spoiler >}}
