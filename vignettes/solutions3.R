## ----echo=FALSE----------------------------------------------------------
library(tufte)
# knitr::opts_chunk$set(results = "hide", echo = FALSE

## ----echo=TRUE-----------------------------------------------------------
Fun4 = function(x) {
  if(x==5) {
    y = 0
  } else {
    y = 1
  }
  return(y)
}

## ------------------------------------------------------------------------
Fun4 = function(x) {
  rtn_value = 0
  if(x > 0) {
    rtn_value = 1 
  } else if (x < 0) {
    rtn_value = -1
  }
  return(rtn_value)
}

## ---- echo = TRUE--------------------------------------------------------
dd = data.frame(x = rnorm(10), y = rnorm(10), z = rnorm(10))
means = numeric(ncol(dd))
for(i in seq_along(dd)) {
  means[i] = mean(dd[, i])
}

## ---- echo = TRUE, message = TRUE----------------------------------------
x = 5
message("The value of x is ", x)

## ------------------------------------------------------------------------
means = numeric(ncol(dd))
for(i in seq_along(dd)) {
  m = mean(dd[,i])
  if(m > 0.3){
    message("Warning, the mean is greater than 0.3")
  }
  means[i] = mean(dd[, i])
}

## ------------------------------------------------------------------------
means = numeric(ncol(dd))
for(i in seq_along(dd)) {
  m = mean(dd[,i])
  if(m > 0.3){
    message("Warning, the mean of column ", i, " is greater than 0.3")
  }
  means[i] = mean(dd[, i])
}

## ------------------------------------------------------------------------
max_cols_limit = function(data, lim) {
  means = numeric(ncol(dd))
  for (i in seq_along(dd)) {
    m = mean(dd[, i])
    if (m > lim) {
      message("Warning, the mean of column ", i, " is greater than ", lim)
    }
    means[i] = mean(dd[, i])
  }
  return(means)
}
max_cols_limit(dd, 0.2)

## ----eval=FALSE, echo=TRUE-----------------------------------------------
#  vignette("solutions3", package = "jrProgramming")

