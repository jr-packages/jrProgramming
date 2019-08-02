## ----include = FALSE-----------------------
knitr::opts_chunk$set(results = "hide", echo = FALSE)

## ----echo=TRUE-----------------------------
v = 5
Fun1 = function() {
  v = 0
  return(v)
}
Fun1()

## ------------------------------------------
## Fun1 uses the local variable v

## ------------------------------------------
Fun1 = function(v) {
  return(v)
}
Fun1(10)

## ----echo=TRUE-----------------------------
Fun2 = function(x = 10) {
  return(x)
}

Fun3 = function(x) {
  return(x)
}

## ----echo=TRUE-----------------------------
Fun2()

## ----eval=FALSE, echo=TRUE-----------------
#  Fun3()

## ------------------------------------------
## Fun3 expects an argument x, but 
## we haven't given one and there is
## no default.

## ------------------------------------------
Fun2 = function(x = 10) {
  return(x*x)
}

## ----echo=TRUE-----------------------------
a = 2
total = 0
for(blob in a:5) {
  total = total + blob
}

## ------------------------------------------
Fun5 = function(a) {
  total = 0
  for(blob in a:5){
    total = total + blob
  }
  return(total)
}
Fun5(1)

## ------------------------------------------
Fun5 = function(a, b) {
  total = 0
  for(blob in a:b){
    total = total + blob
  }
  return(total)
}
Fun5(1, 5)

## ------------------------------------------
Fun5 = function(a=1, b=10) {
  total = 0
  for(blob in a:b) {
    total = total + blob
  }
  return(total)
}
Fun5(5)

## ----eval=FALSE, echo=TRUE-----------------
#  vignette("solutions2", package = "jrProgramming")

