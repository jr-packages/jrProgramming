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
library("dplyr")
library("ggplot2")
treat_a = filter(exper, treat == "A")
ggplot(treat_a, aes(x = time, y = values)) +
  geom_point()

## ----echo=FALSE---------------------------------
treatment = tail(exper, 1)$treat
group = filter(exper, treat == treatment)

## ----results='hide', fig.keep='none', tidy=FALSE, echo = TRUE, eval=FALSE----
#  for(treatment in unique(exper$treat)) {
#    group = filter(exper, treat == treatment)
#    g = ggplot(group, aes(x = time, y = values)) +
#      geom_point()
#    print(g)
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
ggplot(group, aes(x = time, y = values)) +
  geom_point() +
  xlab("Time") 

## ---- fig.keep="none"---------------------------
ggplot(group, aes(x = time, y = values)) +
  geom_point() +
  xlab("Time") + 
  ylab("Measurement")

## ----F2, tidy=FALSE, fig.keep="none", echo = TRUE----
ggplot(treat_a, aes(x = time, y = values)) +
  geom_point() +
  xlab("Time") +
  ylab("Measurement") +
  ggtitle("Treatment")

## -----------------------------------------------
paste("Treatment", treatment)

## ----fig.keep='none', tidy=FALSE----------------
ggplot(group, aes(x = time, y = values)) +
  geom_point() +
  xlab("Time") +
  ylab("Measurement") +
  ggtitle(paste0("Treament ", treatment))

## ----tidy=FALSE, fig.keep="none", echo = TRUE----
ggplot(treat_a, aes(x = time, y = values)) +
  geom_point() +
  ylim(-100,100)

## ----fig.keep='none', tidy=FALSE----------------
r = range(exper$values)
ggplot(group, aes(x = time, y = values)) +
  geom_point() +
  xlab("Time") +
  ylab("Measurement") +
  ggtitle(paste0("Treament ", treatment)) +
  ylim(r[1], r[2])

## ----results='hide', message=FALSE--------------
##Within the for loop have the line
message(mean(group$values))

## ----echo=TRUE, eval = FALSE--------------------
#  geom_point(data = outliers, aes(x = time, y = values))

## ----fig.keep='none', message=FALSE, tidy=FALSE----
r = range(exper$values)
g = ggplot(group, aes(x = time, y = values)) +
  geom_point() +
  xlab("Time") +
  ylab("Measurement") +
  ggtitle(paste0("Treament ", treatment)) +
  ylim(r[1], r[2])
print(g)

##Calculate the limits
values = group$values
message(mean(values))
upper_lim = mean(values) + sd(values)
lower_lim = mean(values) - sd(values)

##Extract the points
outliers = filter(group, values > upper_lim | values < lower_lim)
g = g +
  geom_point(data = outliers, aes(x = time, y = values),
             colour = "red")
print(g)

## ---- echo = TRUE, eval = FALSE-----------------
#  ggsave(filename = "treatment.pdf",
#           plot = g)

## ----eval=FALSE, echo=TRUE----------------------
#  vignette("solutions4", package = "jrProgramming")

## ----tidy=FALSE---------------------------------
## FULL SOLUTION
viewgraphs = function(data) {
  for (treatment in unique(data$treat)) {
    group = filter(data, treat == treatment)
    g = ggplot(group, aes(x = time, y = values)) +
      geom_point() +
      xlab("Time") +
      ylab("Measurement") +
      ggtitle(paste0("Treament ", treatment)) +
      ylim(r[1], r[2])
    
    ##Calculate the limits
    values = group$values
    message(mean(values))
    upper_lim = mean(values) + sd(values)
    lower_lim = mean(values) - sd(values)
    
    ##Extract the points
    outliers = filter(group, values > upper_lim | values < lower_lim)
    
    g = g +
      geom_point(data = outliers, aes(x = time, y = values), colour = "red")
    print(g)
    ggsave(filename = paste0("treatment", treatment, ".pdf"),
           plot = g)
    readline("Hit return for next plot")
  }
}

