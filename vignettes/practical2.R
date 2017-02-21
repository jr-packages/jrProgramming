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

## -----------------------------------------------
library("jrProgramming")
data(dummy_data)
dd = dummy_data

## ----F1, fig.keep='none', tidy=FALSE------------
plot(dd[dd$treatments=="A",]$time, 
     dd[dd$treatments=="A",]$measurement)

## ----ref.label='F1', dev='pdf', out.width='\\textwidth', echo=FALSE----
plot(dd[dd$treatments=="A",]$time, 
     dd[dd$treatments=="A",]$measurement)

## -----------------------------------------------
colnames(dd) = c("m", "t", "trts")

## ----results='hide', fig.keep='none', tidy=FALSE----
for(treat in unique(dd$trts)) {
  plot(dd[dd$trts==treat,]$t, 
       dd[dd$trts==treat,]$m)
  readline("Hit return for next plot\n")
}

## ----echo=echo, results=results-----------------
## It gives all treatments.

## ----echo=echo, results=results-----------------
#The treat variable is changing. It goes through the different treatments.

## ----fig.keep='none', tidy=FALSE, echo=c(1*!echo, 2*echo)----
plot(dd[dd$trts==treat,]$t, 
       dd[dd$trts==treat,]$m,
     xlab="Time")
plot(dd[dd$trts==treat,]$t, 
     dd[dd$trts==treat,]$m,
     xlab="Time", ylab="Measurement")

## ----F2, fig.keep='none', tidy=FALSE------------
plot(dd[dd$trts=="A",]$t, 
     dd[dd$trts=="A",]$m, 
     main="Treatment", 
     xlab="Time", ylab="Measurement")

## ----ref.label='F2', dev='pdf', out.width='\\textwidth', echo=FALSE----
plot(dd[dd$trts=="A",]$t, 
     dd[dd$trts=="A",]$m, 
     main="Treatment", 
     xlab="Time", ylab="Measurement")

## -----------------------------------------------
paste("Treatment", treat)

## ----fig.keep='none', tidy=FALSE, echo=echo-----
plot(dd[dd$trts==treat,]$t, 
     dd[dd$trts==treat,]$m, 
     main=paste("Treament", treat),
     xlab="Time", ylab="Measurement")

## ----fig.keep='none', tidy=FALSE, echo=echo, results=results----
range(dd$m)
plot(dd[dd$trts==treat,]$t, 
     dd[dd$trts==treat,]$m, 
     main=paste("Treament", treat), 
     xlab="Time", ylab="Measurement",
     ylim=c(-2, 10))

## ----results='hide', echo=echo, results=results, message=FALSE----
##Within the for loop have the line
message(mean(dd[dd$trts==treat,]$m))

## ----echo=-1, fig.keep='none'-------------------
plot(0)
points(c(1, 3), c(2, 4), col=2)

## ----fig.keep='none', echo=ifelse(echo,-1:-2, FALSE), message=FALSE, tidy=FALSE----
sel = (dd$trts == treat)
plot(dd[sel,]$t, dd[sel,]$m,
         ylab=treat, xlab="Time",
         main=paste("Treatment", treat))
##Select a particular treament
sel = (dd$trts == treat)

##Calculate the limits
values = dd[sel,]$m
message(mean(values))
upper_lim = mean(values) + sd(values)
lower_lim = mean(values) - sd(values)

##Extract the points
up_row = dd[sel & dd$m > upper_lim,]
low_row = dd[sel & dd$m < lower_lim,]

##pch=19 gives a solid dot
##See ?points
points(up_row$t, up_row$m, col=4, pch=19)
points(low_row$t, low_row$m, col=4, pch=19)

## -----------------------------------------------
filename = paste("file", treat, ".pdf", sep="")

## ----tidy=FALSE, echo=echo, results=results-----
viewgraphs = function(dd, colour=TRUE, save=FALSE) {
  for(treat in unique(dd$trts)) {
    if(save) {
      filename = paste("file", treat, ".pdf", sep="")
      pdf(filename)
    }
    
    ##Use a different shape in the points
    if(colour) pch = 19
    else pch = 22
    
    ##Do selection one
    sel = (dd$trts == treat)
    plot(dd[sel,]$t, dd[sel,]$m,
         ylab=treat, xlab="Time",
         main=paste("Treatment", treat))
    
    ##Calculate the limits
    values = dd[sel,]$m
    message(mean(values))
    upper_lim = mean(values) + sd(values)
    lower_lim = mean(values) - sd(values)
    
    ##Extract the points
    up_row = dd[sel & dd$m > upper_lim,]
    low_row = dd[sel & dd$m < lower_lim,]
    
    ##pch=19 gives a solid dot
    ##See ?points
    points(up_row$t, up_row$m, col=4, pch=19)
    points(low_row$t, low_row$m, col=4, pch=19)
    if(save){
      dev.off()
    } else {  
      readline("Hit return for next plot\n")
    }
  }
}

## ----eval=FALSE---------------------------------
#  vignette("solutions2", package = "jrProgramming")

