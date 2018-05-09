## ----echo=FALSE----------------------------------------------------------
library(tufte)
# knitr::opts_chunk$set(results = "hide", echo = FALSE

## ----setup, include=FALSE, cache=FALSE----------
library(knitr)
# opts_knit$set(out.format = "latex")
knit_theme$set(knit_theme$get("greyscale0"))

options(replace.assign=FALSE,width=50)

opts_chunk$set(fig.path='figure/graphics-', 
               cache.path='cache/graphics-', 
               fig.align='center', 
               dev='pdf', fig.width=5, fig.height=5, 
               fig.show='hold', cache=FALSE, par=TRUE)
knit_hooks$set(crop=hook_pdfcrop)

knit_hooks$set(par=function(before, options, envir){
  if (before && options$fig.show!='none') {
    #par(mar=c(3,3,2,1),cex.lab=.95,cex.axis=.9, mgp=c(2,.7,0),tcl=-.01, las=1)
  }}, crop=hook_pdfcrop)

## ----echo=TRUE----------------------------------
v = 5
Fun1 = function() {
  v = 0
  return(v)
}
Fun1()

## -----------------------------------------------
## Fun1 uses the local variable v

## -----------------------------------------------
Fun1 = function(v) {
  return(v)
}
Fun1(10)

## ----echo=TRUE----------------------------------
Fun2 = function(x = 10) {
  return(x)
}

Fun3 = function(x) {
  return(x)
}

## ----echo=TRUE----------------------------------
Fun2()

## ----eval=FALSE, echo=TRUE----------------------
#  Fun3()

## -----------------------------------------------
## Fun3 expects an argument x, but 
## we haven't given one and there is
## no default.

## -----------------------------------------------
Fun2 = function(x = 10) {
  return(x*x)
}

## ----echo=TRUE----------------------------------
Fun4 = function(x) {
  if(x==5) {
    y = 0
  } else {
    y = 1
  }
  return(y)
}

## -----------------------------------------------
Fun4 = function(x) {
  rtn_value = 0
  if(x > 0) {
    rtn_value = 1 
  } else if (x < 0) {
    rtn_value = -1
  }
  return(rtn_value)
}

## ----results="hide", echo=TRUE------------------
total = 0
for(i in 1:5) {
  total = total + i
}
total

## -----------------------------------------------
total

## -----------------------------------------------
total = 0
for(i in 1:20) {
  total = total + (i + 1)
}
total

## -----------------------------------------------
total = 0
for(j in -10:15) {
  total = total + j
}
total

## -----------------------------------------------
sum(2:21)
sum(-10:15)

## ----echo=TRUE----------------------------------
a = 2
total = 0
for(blob in a:5) {
  total = total + blob
}

## -----------------------------------------------
Fun5 = function(a) {
  total = 0
  for(blob in a:5){
    total = total + blob
  }
  return(total)
}
Fun5(1)

## -----------------------------------------------
Fun5 = function(a, b) {
  total = 0
  for(blob in a:b){
    total = total + blob
  }
  return(total)
}
Fun5(1, 5)

## -----------------------------------------------
Fun5 = function(a=1, b=10) {
  total = 0
  for(blob in a:b) {
    total = total + blob
  }
  return(total)
}
Fun5(5)

## ----echo=TRUE----------------------------------
dd = data.frame(x = rnorm(10), y = rnorm(10), z = rnorm(10))

max_cols = numeric(ncol(dd))
for(i in seq_along(dd)) {
  max_cols[i] = max(dd[, i])
}
max_cols

## -----------------------------------------------
means = sds = numeric(ncol(dd))
for(i in seq_along(dd)) {
  means[i] = mean(dd[, i])
  sds[i] = sd(dd[, i])
}

## ----eval=FALSE, echo = TRUE--------------------
#  library(jrProgramming)
#  vignette("solutions1", package = "jrProgramming")

