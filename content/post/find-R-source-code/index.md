---
title: "How to Find Function Source Code in R"
authors:
- jpiaskowski
categories: ["R"]
draft: true
date: "2021-11-17T00:00:00Z"
image:
  caption: "Codex Sinaiticus Syriacus"
  focal_point: ""
lastMod: "2021-11-17T00:00:00Z"
projects: []
subtitle: 
summary: 
tags: ["source code", "pryr"]
---




## Source code in the console

Sometimes this is an easy as typing the function name into the console:


```r
lm
```

```
## function (formula, data, subset, weights, na.action, method = "qr", 
##     model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
##     contrasts = NULL, offset, ...) 
## {
##     ret.x <- x
##     ret.y <- y
##     cl <- match.call()
##     mf <- match.call(expand.dots = FALSE)
##     m <- match(c("formula", "data", "subset", "weights", "na.action", 
##         "offset"), names(mf), 0L)
##     mf <- mf[c(1L, m)]
##     mf$drop.unused.levels <- TRUE
##     mf[[1L]] <- quote(stats::model.frame)
##     mf <- eval(mf, parent.frame())
##     if (method == "model.frame") 
##         return(mf)
##     else if (method != "qr") 
##         warning(gettextf("method = '%s' is not supported. Using 'qr'", 
##             method), domain = NA)
##     mt <- attr(mf, "terms")
##     y <- model.response(mf, "numeric")
##     w <- as.vector(model.weights(mf))
##     if (!is.null(w) && !is.numeric(w)) 
##         stop("'weights' must be a numeric vector")
##     offset <- model.offset(mf)
##     mlm <- is.matrix(y)
##     ny <- if (mlm) 
##         nrow(y)
##     else length(y)
##     if (!is.null(offset)) {
##         if (!mlm) 
##             offset <- as.vector(offset)
##         if (NROW(offset) != ny) 
##             stop(gettextf("number of offsets is %d, should equal %d (number of observations)", 
##                 NROW(offset), ny), domain = NA)
##     }
##     if (is.empty.model(mt)) {
##         x <- NULL
##         z <- list(coefficients = if (mlm) matrix(NA_real_, 0, 
##             ncol(y)) else numeric(), residuals = y, fitted.values = 0 * 
##             y, weights = w, rank = 0L, df.residual = if (!is.null(w)) sum(w != 
##             0) else ny)
##         if (!is.null(offset)) {
##             z$fitted.values <- offset
##             z$residuals <- y - offset
##         }
##     }
##     else {
##         x <- model.matrix(mt, mf, contrasts)
##         z <- if (is.null(w)) 
##             lm.fit(x, y, offset = offset, singular.ok = singular.ok, 
##                 ...)
##         else lm.wfit(x, y, w, offset = offset, singular.ok = singular.ok, 
##             ...)
##     }
##     class(z) <- c(if (mlm) "mlm", "lm")
##     z$na.action <- attr(mf, "na.action")
##     z$offset <- offset
##     z$contrasts <- attr(x, "contrasts")
##     z$xlevels <- .getXlevels(mt, mf)
##     z$call <- cl
##     z$terms <- mt
##     if (model) 
##         z$model <- mf
##     if (ret.x) 
##         z$x <- x
##     if (ret.y) 
##         z$y <- y
##     if (!qr) 
##         z$qr <- NULL
##     z
## }
## <bytecode: 0x7fec4a60b418>
## <environment: namespace:stats>
```

But, this fails often


```r
mean
```

```
## function (x, ...) 
## UseMethod("mean")
## <bytecode: 0x7fec4ce24770>
## <environment: namespace:base>
```

or, it works, but the functon calls another internal function that you can't access easily


```r
var
```

```
## function (x, y = NULL, na.rm = FALSE, use) 
## {
##     if (missing(use)) 
##         use <- if (na.rm) 
##             "na.or.complete"
##         else "everything"
##     na.method <- pmatch(use, c("all.obs", "complete.obs", "pairwise.complete.obs", 
##         "everything", "na.or.complete"))
##     if (is.na(na.method)) 
##         stop("invalid 'use' argument")
##     if (is.data.frame(x)) 
##         x <- as.matrix(x)
##     else stopifnot(is.atomic(x))
##     if (is.data.frame(y)) 
##         y <- as.matrix(y)
##     else stopifnot(is.atomic(y))
##     .Call(C_cov, x, y, na.method, FALSE)
## }
## <bytecode: 0x7fec4be95ad8>
## <environment: namespace:stats>
```



what methods are out there?

```r
methods(mean)
```

```
## [1] mean.Date     mean.default  mean.difftime mean.POSIXct  mean.POSIXlt 
## [6] mean.quosure*
## see '?methods' for accessing help and source code
```


```r
mean.default
```

```
## function (x, trim = 0, na.rm = FALSE, ...) 
## {
##     if (!is.numeric(x) && !is.complex(x) && !is.logical(x)) {
##         warning("argument is not numeric or logical: returning NA")
##         return(NA_real_)
##     }
##     if (na.rm) 
##         x <- x[!is.na(x)]
##     if (!is.numeric(trim) || length(trim) != 1L) 
##         stop("'trim' must be numeric of length one")
##     n <- length(x)
##     if (trim > 0 && n) {
##         if (is.complex(x)) 
##             stop("trimmed means are not defined for complex data")
##         if (anyNA(x)) 
##             return(NA_real_)
##         if (trim >= 0.5) 
##             return(stats::median(x, na.rm = FALSE))
##         lo <- floor(n * trim) + 1
##         hi <- n + 1 - lo
##         x <- sort.int(x, partial = unique(c(lo, hi)))[lo:hi]
##     }
##     .Internal(mean(x))
## }
## <bytecode: 0x7fec4e252320>
## <environment: namespace:base>
```
by looking at this, you can see there is considerable error checking. If you are confident that error checking is not needed for a particular data set, you can rewrite the function to skip those steps. 

This one is really handy

```r
methods(class = "aov")
```

```
##  [1] coef         coerce       extractAIC   initialize   model.tables
##  [6] print        proj         se.contrast  show         slotsFromS3 
## [11] summary      TukeyHSD     vcov        
## see '?methods' for accessing help and source code
```

Much of R source code is written in C (.Internal and .Primitive calls). As such, it's likely to be very efficient already. Altering this is difficult. But, you can  look for that code with this function:

This will search github and open a browser where that code might be

```r
library(pryr)
show_c_source(.Internal(mean(x)))
```

honestly, one of best ways to find R code is 






