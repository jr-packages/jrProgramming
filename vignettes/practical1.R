## ----echo=FALSE----------------------------
# pfft old way to do things or what?
# results = "hide"; echo = FALSE

library(tufte)
knitr::opts_chunk$set(results = "hide", echo = FALSE)
# gets rid of all the echo = echo, results = results
# also makes it easier to be flexible about what shows where

## ----results="hide", echo=TRUE-------------
total = 0
for(i in 1:5) {
  total = total + i
}
total

## ------------------------------------------
total

## ------------------------------------------
total = 0
for(i in 1:20) {
  total = total + (i + 1)
}
total

## ------------------------------------------
total = 0
for(j in -10:15) {
  total = total + j
}
total

## ------------------------------------------
sum(2:21)
sum(-10:15)

## ----echo=TRUE-----------------------------
dd = data.frame(x = rnorm(10), y = rnorm(10), z = rnorm(10))

max_cols = numeric(ncol(dd))
for(i in seq_along(dd)) {
  max_cols[i] = max(dd[, i])
}
max_cols

## ------------------------------------------
means = sds = numeric(ncol(dd))
for(i in seq_along(dd)) {
  means[i] = mean(dd[, i])
  sds[i] = sd(dd[, i])
}

## ----eval=FALSE, echo=TRUE-----------------
#  vignette("solutions1", package = "jrProgramming")

