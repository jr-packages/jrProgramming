## ----echo=FALSE----------------------------------------------------------
results = "show"; echo = TRUE

## ----setup, include=FALSE, cache=FALSE----------
library(knitr)
opts_knit$set(out.format = "latex")
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

## ---- results="hide"----------------------------
v = 5
Fun1 = function() {
  v = 0
  return(v)
}
Fun1()
v

## ----echo=echo, results=results-----------------
## Fun1 uses the local variable v

## ----echo=echo, results=results-----------------
Fun1 = function(v) {
  return(v)
}
Fun1(10)

## ----echo=echo, results=results-----------------
Fun1 = function(v=0) {
  return(v)
}

## -----------------------------------------------
Fun2 = function(x=10) {
  return(x)
}

Fun3 = function(x) {
  return(x)
}

## ----eval=FALSE---------------------------------
#  Fun2()

## ----eval=FALSE, echo=c(1,2*echo)---------------
#  Fun3()
#  ## Fun1()} has a default argument

## ----echo=echo----------------------------------
Fun2 = function(x=10) {
  return(sqrt(x))
}

## -----------------------------------------------
Fun4 = function(x) {
  if(x==5) {
    y = 0
  } else {
    y = 1
  }
  return(y)
}

## ----echo=echo----------------------------------
Fun4 = function(x) {
  rtn_value = 0
  if(x > 0) {
    rtn_value = 1 
  } else if (x < 0) {
    rtn_value = -1
  }
  return(rtn_value)
}

## ----results="hide"-----------------------------
total = 0
for(i in 1:5) {
  total = total + i
}
total

## ----echo=echo, results=results-----------------
total

## ----echo=echo, results=results-----------------
total = 0
for(i in 1:20) {
  total = total + (i + 1)
}
total

## ----echo=echo, results=results-----------------
total = 0
for(j in -10:15) {
  total = total + j
}
total

## -----------------------------------------------
a = 2
total = 0
for(blob in a:5) {
  total = total + blob
}

## ----echo=echo, results=results-----------------
Fun5 = function(a) {
  total = 0
  for(blob in a:5){
    total = total + blob
  }
  return(total)
}
Fun5(1)

## ----echo=echo, results=results-----------------
Fun5 = function(a, b) {
  total = 0
  for(blob in a:b){
    total = total + blob
  }
  return(total)
}
Fun5(1, 5)

## ----echo=echo, results=results-----------------
Fun5 = function(a=1, b=10) {
  total = 0
  for(blob in a:b) {
    total = total + blob
  }
  return(total)
}
Fun5(5)

## ----eval=FALSE---------------------------------
#  library(jrProgramming)
#  vignette("solutions1", package = "jrProgramming")

