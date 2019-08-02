## ----include = FALSE-----------------------------------------------------
knitr::opts_chunk$set(results = "show", echo = TRUE)

## ---- include = FALSE, cache = FALSE------------
library(knitr)
# opts_knit$set(out.format = "latex")
knit_theme$set(knit_theme$get("greyscale0"))

options(replace.assign=FALSE,width=50)

opts_chunk$set(fig.path='figure/graphics-', 
               cache.path='cache/graphics-', 
               fig.align='center', 
                fig.width=4, fig.height=4, 
               fig.show='hold', cache=FALSE, par=TRUE)
knit_hooks$set(crop=hook_pdfcrop)

## ----echo=TRUE----------------------------------
data(experiment, package = "jrProgramming")
head(exper)

## ----F1, echo=TRUE, eval=TRUE, tidy=FALSE, message=FALSE, fig.keep="none"----
library(dplyr)
treat_a = filter(exper, treat == "A")
plot(treat_a$time, treat_a$values)

## ----echo=FALSE---------------------------------
treatment = tail(exper, 1)$treat
group = filter(exper, treat == treatment)

## ----results='hide', fig.keep='none', tidy=FALSE, echo = TRUE, eval=FALSE----
#  for(treatment in unique(exper$treat)) {
#    group = filter(exper, treat == treatment)
#    plot(group$time, group$values)
#    readline("Hit return for next plot")
#  }

## -----------------------------------------------
## It gives all treatments.

## -----------------------------------------------
## The treat variable is changing. 
## It goes through the different treatments.

## -----------------------------------------------
## It halts execution, waits for user input

## ----fig.keep='none', tidy=FALSE, echo=TRUE-----
 plot(group$time, group$values, xlab="Time")

## ---- fig.keep="none"---------------------------
plot(group$time, group$values,
     xlab="Time", ylab="Measurement")

## ----F2, tidy=FALSE, fig.keep="none"------------
 plot(group$time, group$values, 
  main="Treatment", xlab="Time", ylab="Measurement")

## -----------------------------------------------
paste("Treatment", treatment)

## ----fig.keep='none', tidy=FALSE----------------
 plot(group$time, group$values, main = paste("Treament", treatment),
  xlab = "Time", ylab = "Measurement")

## ----fig.keep='none', tidy=FALSE----------------
range(exper$values)
plot(group$time, group$values, 
  main=paste("Treament", treatment), xlab="Time", ylab="Measurement",
  ylim=c(-2, 10))

## ----results='hide', message=FALSE--------------
##Within the for loop have the line
message(mean(group$values))

## ----echo=-1, fig.keep='none'-------------------
plot(0)
points(c(1, 3), c(2, 4), col=2)

## ----fig.keep='none', message=FALSE, tidy=FALSE----
 plot(group$time, group$values,
  ylab = "Measurement", xlab="Time",
  main=paste("Treatment", treatment))

##Calculate the limits
values = group$values
message(mean(values))
upper_lim = mean(values) + sd(values)
lower_lim = mean(values) - sd(values)

##Extract the points
outliers = filter(group, values > upper_lim | values < lower_lim)
##pch=19 gives a solid dot
##See ?points
points(outliers$time, outliers$values, col=4, pch=19)

## -----------------------------------------------
filename = paste0("file", treatment, ".pdf")

## ----eval=FALSE, echo=TRUE----------------------
#  vignette("solutions4", package = "jrProgramming")

## ----tidy=FALSE---------------------------------
## FULL SOLUTION
viewgraphs = function(exper,  save=FALSE) {
  for(treat in unique(exper$treat)) {
    if(save) {
      filename = paste("file", treat, ".pdf", sep="")
      pdf(filename)
    }
    
   plot(group$time, group$values,
      ylab="Measurement", xlab="Time",
      main=paste("Treatment", treat))

    ##Calculate the limits
    values = group$values
    message(mean(values))
    upper_lim = mean(values) + sd(values)
    lower_lim = mean(values) - sd(values)
    
    ##Extract the points
    outliers = filter(group, values > upper_lim | values < lower_lim)
    ##pch=19 gives a solid dot
    ##See ?points
    points(outliers$time, outliers$values, col=4, pch=19)
    if(save){
      dev.off()
    } else {  
      readline("Hit return for next plot\n")
    }
  }
}

