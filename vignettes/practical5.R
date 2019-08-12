## ----echo=FALSE----------------------------------------------------------
results = "hide"; echo = FALSE

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
        par(mar=c(3,3,2,1),cex.lab=.95,cex.axis=.9,
            mgp=c(2,.7,0),tcl=-.01, las=1)
}}, crop=hook_pdfcrop)

## ----results='hide'-----------------------------
sample(1:6, 1)

## -----------------------------------------------
RollTwoDice = function() {
  total = sample(1:6, 1) + sample(1:6, 1)
  return(total)
}

## -----------------------------------------------
## This creates a vector of 40 values;
## All values are initially zero
landings = numeric(40)

## -----------------------------------------------
landings[2] = landings[2] + 1

## -----------------------------------------------
SimulateMonopoly = function(no_of_rolls) {    
  landings = numeric(40)
  ## Start at GO
  current = 1
  for(i in 1:no_of_rolls) {
    current = current + RollTwoDice()
    if(current > 40) {
      current = current - 40
    }
    landings[current] = landings[current] + 1
  }
  return(landings)
}
no_of_rolls = 50000

## ----echo=FALSE---------------------------------
no_of_rolls = 100

## -----------------------------------------------
sim = SimulateMonopoly(no_of_rolls)

## ----echo=FALSE---------------------------------
# no_of_rolls = 2000000
# sim1 = SimulateMonopoly(no_of_rolls)
# saveRDS(sim1, file="vignettes/sim1.RData")
sim = readRDS("sim1.RData")

## ----F1, fig.keep='none', tidy=FALSE, message = FALSE----
library("ggplot2")
library("tibble")
monopoly = tibble(index = seq_along(sim),
                  sim = sim/sum(sim))
ggplot(monopoly) + 
  geom_line(aes(x = index, 
                y = sim)) + 
  ylim(0, 0.06) +
  labs(x = "Square", 
       y = "Probability")

## ----ref.label='F1', dev='pdf', out.width='\\textwidth', echo=FALSE----
library("ggplot2")
library("tibble")
monopoly = tibble(index = seq_along(sim),
                  sim = sim/sum(sim))
ggplot(monopoly) + 
  geom_line(aes(x = index, 
                y = sim)) + 
  ylim(0, 0.06) +
  labs(x = "Square", 
       y = "Probability")

## -----------------------------------------------
CommunityChest = function(current) {
  goto = current
  u = runif(1)
  if(u < 1/16) {
    goto = 1#Move to Go
  }else if(u < 2/16) {
    goto = 11#Go To Jail  :(
  }
  return(goto)
}

## -----------------------------------------------
SimulateMonopoly = function(no_of_rolls) {    
  landings = numeric(40)
  ## Start at GO
  current = 1
  for(i in 1:no_of_rolls) {
    current = current + RollTwoDice()
    if(current > 40) {
      current = current - 40
    }
    landings[current] = landings[current] + 1
    if(current == 3) {
      cc_move = CommunityChest(current)
      if(cc_move != current){
        current = cc_move
        landings[current] = landings[current] + 1
      }
    }
  }
  return(landings)
}

## -----------------------------------------------
sim2 = SimulateMonopoly(no_of_rolls)

## ----echo=FALSE---------------------------------
# no_of_rolls = 2000000
# sim2 = SimulateMonopoly(no_of_rolls)
# saveRDS(sim2, file="vignettes/sim2.RData")
sim2 = readRDS("sim2.RData")

## ----F2, fig.keep='none', tidy=FALSE------------
monopoly2 = tibble(index = seq_along(sim2),
                  sim = sim/sum(sim2))
ggplot(monopoly2) + 
  geom_line(aes(x = index, 
                y = sim)) + 
  ylim(0, 0.06) +
  labs(x = "Square", 
       y = "Probability")

## ----ref.label='F2', dev='pdf', out.width='\\textwidth', echo=FALSE----
monopoly2 = tibble(index = seq_along(sim2),
                  sim = sim/sum(sim2))
ggplot(monopoly2) + 
  geom_line(aes(x = index, 
                y = sim)) + 
  ylim(0, 0.06) +
  labs(x = "Square", 
       y = "Probability")

## ----eval=FALSE---------------------------------
#  vignette("monopoly_solutions", package = "jrProgramming")

