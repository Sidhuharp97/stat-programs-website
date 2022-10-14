---
title: Design and the anatomy of a study
authors:
- bprice
categories:
- design
- statistics
- experiment
- treatment
date: "2022-08-17T00:00:00Z"
draft: false
featured: false
image:
  caption: 'Image credit: [**JJ Ying**](https://unsplash.com)'
  focal_point: ""
  placement: 2
  preview_only: false
lastmod: "2021-04-15T00:00:00Z"
projects: [Reproducible Research]
subtitle: "Use of design in experimental research."
summary: "In describing an experiment, we often use the word *design*. Design, however, can take on several meanings within the structure of a research study. Understanding the types of design is not only useful for reporting on the study, but can also inform the analysis of the associated data."
---

In describing an experiment, we often use the word *design*. Design, however, can take on several meanings within the structure of a research study. This work summarizes an older article that describes this structure and the levels of design it is composed of (Urquhart, N. S. 1981). Understanding the types of design is not only useful for reporting on the study, but can also inform the analysis of the associated data.

### Levels of Design

There are three main levels of design in a study: *Treatment*, *Experimental*, and *Response*. These each relate to the relationships between and among the treatments and their arrangement in the study.

#### Treatment Design

Treatment design describes how the experimental treatments relate to one another. The simplest treatment design is unstructured where there are no dependencies or relatedness among treatments. These could, for example, be various varieties, herbicides, or dietary supplement types. Alternatively, there may be an implied structure among the treatments such as rates or dosages where the treatments incrementally change by specified amounts. Another common treatment design is the complete factorial design where there are two or more types of treatments and all levels of each treatment type occur at all levels of the other types. They are typically denoted by the number of levels for each treatment type, e.g. a 2x3 factorial design or 3x4x2 factorial design. This structure is often modified by the addition of an untreated or standard control treatment, and in that case, we might describe the treatment design as a 2x3 + 1 factorial. There are also some specialized alternatives to the factorial where some treatment combinations are left out which are referred to as incomplete factorials.

#### Experimental Design

This is probably the most commonly used term for describing an experiment, however, it often confused with treatment design. Experimental design refers to how the treatments are randomized and organized physically relative to each other. It does not address how the treatments might be related, but only to how they are arranged in the experiment. The simplest experimental design is the *Completely Random Design*, or *CRD*. Here all treatments and their replications are assigned random positions within the experiment. There is no imposed structure to the arrangement. A very common modification of this has the treatments randomly assigned to positions within each replication. This randomization changes from replication to replication. This is the *Randomized Complete Block* or *RCB* design. Blocks here refer to groups or aggregations of complete sets of treatments. The randomization process is "restricted" to once per replication. With multiple factors such as a factorial treatment design, this can be extended to two or more restrictions on randomization within each replication leading to *Split Plot* and *Split Block* experimental designs. It is important to note, however, that this is independent of the treatment design. That is, a factorial such as the 2x3 above, could be imposed over any of these experimental designs, e.g. CRD or RCB, or Split Plot, etc.

#### Response Design

Last category is the response design. This describes how the samples or observations relate to each other. A simple response design, for example, would have one sample/observation per treatment per replication. Or, we might have a sub-sampling response design where there are multiple samples or observations on each treatment in each replication. Another common response design is the repeated measures design where observations are taken sequentially through time on the same sampling unit. *Sampling units* are what the observations or samples themselves are made on. Examples here might be single pots or plants in a greenhouse study, plots in a field experiment, or animals in a feeding study. A similar concept is the *experimental unit*. This refers to what level of the experiment we draw inferences to. The experimental unit may be the same as the sampling unit, or it may be an aggregation of sampling units. For example, the experimental unit might be a single plot in a field experiment, however, we might take multiple soil samples from each plot (sampling units) which are then aggregated to a single value for the plot, the experimental unit. Typically this is done to mitigate or account for variability within the experimental unit.

#### Putting this together

Descriptions of a study for reporting or presentation should include all three levels of design. Doing so informs the audience as to what the treatment structure was, how it was arranged or randomized, and how it was sampled. This can be done in a few sentences. For example, we might say *"Treatments consisted of Factor A at two levels and Factor B at three levels arranged in a 2x3 factorial treatment design. The experimental design was a randomized complete block with 4 blocks and three samples were taken from each experimental unit."*

Analyses of the study design will also incorporate and utilize all three levels of design. The details of this, however, are beyond the scope here and the reader is referred to the referenced article.

#### References

Urquhart, N. S. (1981). *The anatomy of a study.* HortScience, 16(5), 621-627.
