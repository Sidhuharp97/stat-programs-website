---
title: Interpreting p-values
authors:
- bprice
categories:
- p-values
- statistics
- reproducible research
date: "2022-09-22T00:00:00Z"
draft: false
image:
  caption: 'Image credit: DALLE-2'
  focal_point: ""
  placement: 2
  preview_only: false
lastmod: "2021-04-15T00:00:00Z"
projects: [Reproducible Research]
subtitle: 
summary: "Some lessons on proper interpretation and use of p-values"
tags:
---

## What to make of p-values

Among various scientific communities there have been questions and concerns raised regarding hypothesis testing and, specifically, the interpretation and use of the p-value. The p-value is a number that results from a statistical test of a hypothesis and can be generally described as: The probability of a specified hypothesis given an observed set of data and the assumptions underlying the hypothesis. The hypothesis in question is typically the *NULL* hypothesis, which in controlled experiments is that there are no differences among treatments.  Problems from p-values have come about from a variety of reasons including over reliance on statistical testing, misunderstanding and misinterpreting the meaning of a p-value, and deliberate or unconscious manipulation of results and analyses to obtain “desirable” p-values, a process referred to as p-hacking (see [Greenland, et al. 2016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4877414/) for a more comprehensive list of problems with p-values). 

One common practice in research, including agriculture, is that of *“bright line”* testing where decisions on statistical significance and relevance are based strictly on p-values being greater or less than a specified value such as 0.05. Unfortunately, such decision rules have been repeatedly shown to perform poorly. Many aspects such as sample size, inaccurate hypotheses, incorrect analyses, violated assumptions and a slew of other, often uncontrollable, factors can interfere with this decision-making process. For many of us, this is a bitter pill to swallow. We, and I include myself here, have been trained or lulled into using statistical results in this manner and our minds naturally gravitate to this simplistic binary, accept/reject paradigm. The real world, however, is more complex and we should accommodate those complexities into our interpretations of research results. The question is then, how we should move forward.

## How should we use p-values, or more importantly, how should we present research results.

Some journals have taken the extreme step of banning p-values completely, i.e., *Basic and Applied Social Psychology*, while others have suggested methods such as applying multiple analytical techniques to the data to assess consistency in results, using more sophisticated Bayesian techniques to quantify the probability that a hypothesis is true, or emphasizing model estimates and their confidence bounds, rather than outcomes of testing. In most cases, practitioners generally agree that p-values can still play a role in model evaluation, but they are not the end of the story. A complete assessment of data should consider effect size (how different the estimates are in real terms), agreement with previous data/studies, and expert opinion in addition to p-values.
The American Statistical Association lists [6 basic principles](https://www.tandfonline.com/doi/full/10.1080/00031305.2016.1154108#_i28) when considering p-values:

1)	P-values can indicate how incompatible the data are with a specified statistical model.
2)	P-values do not measure the probability that the studied hypothesis is true, or the probability that the data were produced by random chance alone.
3)	Scientific conclusions and business or policy decisions should not be based only on whether a p-value passes a specific threshold.
4)	Proper inference requires full reporting and transparency.
5)	A p-value, or statistical significance, does not measure the size of an effect or the importance of a result.
6)	By itself, a p-value does not provide a good measure of evidence regarding a model or hypothesis.

## How to not say Significant or Nonsignificant.

OK, that’s all well and fine, but when it comes down to it, what do we write when reporting our analyses? There are many ways to answer this, and ultimately, the style will be up to the author. I find it useful to first recall and follow the distinction between *Results* and *Discussion* sections of the standard scientific reporting format. Results are for describing what you saw, while Discussions are for interpreting, speculating, and applying your scientific expertise to those results. Some examples:


Suppose we have two dairy supplement treatments, A and B. An Analysis of Variance estimates the average milk production for the treatments in 3900 dairy cows as A: 30.30 kg/d and B: 31.83 kg/d; p = 0.0001. In a Results section, we might say something like *“Treatment B was estimated to have greater mean milk production than treatment A (31.83 and 30.30, respectively; p=0.0001)”*. However, in the Discussion section we could elaborate further with *“While treatment B gave a higher milk yield than treatment A, the difference of 1.53 kg/d is not of practical importance and likely due to the large number of animals used.”*


Alternatively, suppose the estimated means were A: 30.30 kg/d and B: 45.62 kg/d; p=0.4328 in 34 dairy cows. Again, in the Results section, we could say *“A higher milk yield was observed in treatment B compared to treatment A, although the difference was not detectable in this data (45.62 and 30.30 kg/d, respectively; p=0.4328).”* A Discussion of these data could further explain *“Although evidence for the difference in treatments A and B is limited, the 15.32 kg/d increase in milk yield of treatment B over A may warrant further investigation with a larger sample size.”*


Points to remember: A small p-value does not indicate the strength of an effect and is not sufficient for drawing conclusions on treatment effects. Alternatively, a large p-value is not evidence of “no difference” in treatments. It simply implies that, with the data at hand and the model assumed, a difference could not be detected. 


In general, employing common sense with professional modesty and avoiding strong declarative statements when reporting and discussing experimental results can go a long way towards averting p-value abuse. It may be useful to recall the research by Philip Tetlock regarding expert opinions [Why Foxes Are Better Forecasters Than Hedgehogs](https://longnow.org/seminars/02007/jan/26/why-foxes-are-better-forecasters-than-hedgehogs/): Pundants that make assertive statements with over confidence tend to be wrong in the long run, while those that are more tentative and conditional in their statements have a better track record. As scientists, we should strive to be a fox, not a hedgehog.

![A fox and hedgehog (DALLE-2)](a_hedgehog_and_fox_on_grass.png)


