## ----include = FALSE-----------------------
knitr::opts_chunk$set(results = "hide", echo = FALSE)

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
data(GoTRating, package = "jrProgramming")
head(GoTRating)

## ----F1, echo=TRUE, eval=TRUE, tidy=FALSE, message=FALSE, fig.keep="none"----
library(dplyr)
s_1 = filter(GoTRating, Season == 1)
plot(s_1$Episode, s_1$Rating)

## ----results='hide', fig.keep='none', tidy=FALSE, echo = TRUE----
for(i in unique(GoTRating$Season)) {
  group = filter(GoTRating, Season == i)
  plot(group$Episode, group$Rating)
  readline("Hit return for next plot")
}

## -----------------------------------------------
## It gives all Seasons.

## -----------------------------------------------
## The Season variable is changing. 
## It goes through the different Seasons.

## -----------------------------------------------
## It halts execution, waits for user input

## ----fig.keep='none', tidy=FALSE, echo=TRUE-----
plot(group$Episode, group$Rating, xlab="Episode")

## ---- fig.keep="none"---------------------------
plot(group$Episode, group$Rating,
     xlab="Episode", ylab="Rating")

## ----F2, tidy=FALSE, fig.keep="none"------------
     plot(group$Episode, group$Rating, 
      main="Season", xlab="Episode", ylab="Rating")

## -----------------------------------------------
    paste("Season", i)

## ----fig.keep='none', tidy=FALSE----------------
     plot(group$Episode, group$Rating, main = paste("Season", i),
      xlab = "Episode", ylab = "Rating")

## ----fig.keep='none', tidy=FALSE----------------
range(GoTRating$Rating)
plot(group$Episode, group$Rating, 
  main=paste("Season", i), xlab="Episode", ylab="Rating",
  ylim=c(0, 10))

## ----fig.keep='none', message=FALSE, tidy=FALSE----
plot(group$Episode, group$Rating,
ylab = "Rating", xlab="Episode",
main=paste("Season", i))

## fit the model
fit = lm(Rating ~ Episode, data = group)
abline(fit, col = "red", lty = 2)

## ----results='hide', message=FALSE--------------
sfit = summary(fit)
p = sfit$coefficients[,4][2]
message("p = ", p)
message("The adj R squared is: ", sfit$adj.r.squared)

## ---- echo = TRUE, eval = FALSE-----------------
#  text(1, 2, "Hello")

## ----message=FALSE, eval = FALSE----------------
#  text(5, 9, paste("p =", p))

## -----------------------------------------------
filename = paste0("Season", i, ".pdf")

## ----eval=FALSE, echo=TRUE----------------------
#  vignette("solutions2", package = "jrProgramming")

## ----tidy=FALSE---------------------------------
## FULL SOLUTION
viewgraphs = function(GoTRating,  save=FALSE) {
  for(i in unique(GoTRating$Season)) {
    if(save) {
      filename = paste("Season", i, ".pdf", sep="")
      pdf(filename)
    }
    
    group = filter(GoTRating, Season == i)
    plot(group$Episode, group$Rating,
         ylab="Rating", xlab="Episode",
         main=paste("Season", i), 
         ylim = c(0,10))
    
    ## fit the model
    fit = lm(Rating ~ Episode, data = group)
    abline(fit, col = "red", lty = 2)
    
    ## add text to the graph
    sfit = summary(fit)
    p = sfit$coefficients[,4][2]
    text(5, 9, paste("p =", p))
    
    if(save){
      dev.off()
    } else {  
      readline("Hit return for next plot\n")
    }
  }
}

