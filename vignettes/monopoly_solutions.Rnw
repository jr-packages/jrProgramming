%\VignetteIndexEntry{monopoly_solutions}
%!Snw weave = knitr
%\VignetteEngine{knitr::knitr}

\documentclass[a4paper,justified,openany]{tufte-handout}

<<setup, include=FALSE, cache=FALSE>>=
library(knitr)
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
@

\usepackage{amsmath,graphicx}
\setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}
\title{Programming: Practical 3 solutions} 
%\author[Dr Colin Gillespie]{Dr Colin Gillespie}
\date{}  % if the \date{} command is left out, the current date will be used

% The following package makes prettier tables.  We're all about the bling!
\usepackage{booktabs}
\usepackage{units}

% The fancyvrb package lets us customize the formatting of verbatim
% environments.  We use a slightly smaller font.
\usepackage{fancyvrb}
\fvset{fontsize=\normalsize}
\newcommand{\cc}{\texttt}
\setcounter{secnumdepth}{2}
\usepackage{microtype}
\begin{document}
\maketitle% this prints the handout title, author, and date

<<echo=FALSE>>=
no_of_turns = 50000
@ 


\begin{figure}[h]
  \centering
  \includegraphics[clip=]{monopoly.pdf}
  \caption{Distribution of resting places in a game of monopoly using
    \Sexpr{no_of_turns} rolls.}
\label{fig:1}
\end{figure}

<<>>=
##Dice function
RollTwoDiceWithDoubles = function(current) {

  df = data.frame(d1 = sample(1:6, 3, replace=TRUE), 
    d2 = sample(1:6, 3, replace=TRUE))
  
  df$Total = apply(df, 1, sum)
  df$IsDouble = df$d1 == df$d2

  if(df$IsDouble[1] & df$IsDouble[2] & df$IsDouble[3]) {
    current = 11#Go To Jail
  } else if(df$IsDouble[1] & df$IsDouble[2]) {
    current = current + sum(df$Total[1:2])
  } else {
    current = current + df$Total[1]
  }
  return(current)
}

@ 

<<>>=
##Helper function to avoid code replication
CheckState = function(current) {
  if(current > 40) {
    current = current - 40
  } else if(current < 1) {
    current = current + 40 
  }
  return(current)
}
@ 

<<>>=
UpdateStateVector = function(current, move, landings) {
  if(move != current){
    landings[current] = landings[current] + 1
  }
  return(landings)
}
@ 

<<>>=
CommunityChest = function(current) {
  u = runif(1)
  goto = current#Default. Do nothing
  if(u < 1/16) {
    goto = 1#Go
  }else if(u < 2/16) {
    goto = 11#Jail
  }else if(u < 3/16) {
    goto = 2#Old Kent Rd
  }else if(u < 4/16) {
    goto = Chance(current)
  }
  return(goto)
}

Chance = function(current) {
  u = runif(1)
  goto = current#Default. Do nothing
  if(u < 1/16){
    goto = 1#Go
  }else if(u < 2/16){
    goto = 25#Tra Square
  }else if(u < 3/16){
    goto = 12#Pall Mall
  }else if(u < 4/16){
    goto = 11#Jail
  }else if(u < 5/16){
    goto = 16#Mary' Stat
  }else if(u < 6/16){
    goto = 40#Mayfair
  }else if(u < 7/16) {
    goto = CheckState(current - 3)#Must check, since goto maybe negative!
  }else if(u < 8/16){
    if(current > 29  | current < 13){
      goto = 13
    }else {
      goto = 29
    }
  }
  return(goto)
}
@ 

<<>>=
SimulateMonopoly = function(no_of_turns) {    
  landings = numeric(40)
  ##Start GO
  current = 1
  for(i in 1:no_of_turns) {
    current = RollTwoDiceWithDoubles(current)
    current = CheckState(current)
    landings = UpdateStateVector(current, -1, landings)

    if(current == 8 | current == 23 | current == 37) {#Chance
      move = Chance(current)
      landings = UpdateStateVector(move, current, landings)
      current = move
    }

    if(current == 3 | current == 18 | current == 34) {#Community Chest
      move = CommunityChest(current)
      landings = UpdateStateVector(move, current, landings)
      current = move
    } 
    
    ##Go To Jail. Chance could also send you here by 
    ##going back three places
    if(current == 31) {
      current = 11
      landings = UpdateStateVector(current, -1, landings)
    }

  }
  return(landings)
}
@ 

<<eval=FALSE, echo=FALSE>>=
set.seed(1)
sim  = SimulateMonopoly(no_of_turns)
pdf("vignettes/monopoly.pdf")
setnicepar()
plot(sim/sum(sim), ylim=c(0,0.08), ylab="Probability", xlab="Square", 
     type="o", panel.first=grid(), 
     bg=rgb(170,93,152, maxColorValue=255), 
     pch=19)
abline(h=1/40, col=2, lty=2)
dev.off()
@ 


\clearpage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\section*{Neater Solutions}

Some of the functions could be simplified.

<<>>=
## Rather than if statements, just work to mod 40
CheckState = function(current) {
  current = current %% 40
  if(current == 0)
    current = 40 
  return(current)
}
@ 

<<>>=
## Use the sample command to move square
CommunityChest = function(current) {
  u = runif(1)
  goto = current#Default. Do nothing
  if(u < 3/16) {
    goto = sample(c(1, 11, 2), 1)
  } else if(u < 4/16) {
    goto = Chance(current)
  }
  return(goto)
}
@ 

<<>>=
## Use the sample command to move square
Chance = function(current) {
  u = runif(1)
  goto = current#Default. Do nothing
  if(u < 6/16){
    goto = sample(c(1, 25, 12, 11, 16, 50), 1)
  }else if(u < 7/16) {
    goto = CheckState(current - 3)#Must check, since goto maybe negative!
  }else if(u < 8/16){
    if(current > 29  | current < 13){
      goto = 13
    }else {
      goto = 29
    }
  }
  return(goto)
}
@ 



\end{document}


