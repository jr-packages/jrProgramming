## ----echo=FALSE----------------------------
# pfft old way to do things or what?
# results = "hide"; echo = FALSE

library(tufte)
knitr::opts_chunk$set(results = "hide", echo = FALSE)
# gets rid of all the echo = echo, results = results
# also makes it easier to be flexible about what shows where

## ---- echo = TRUE--------------------------
create_workflow = function(project_name){
  dir.create(project_name)
}

## ---- echo = TRUE--------------------------
file.path("project", "directory")

## ------------------------------------------
create_workflow = function(project_name){
  dir.create(project_name)
    for (directory in c("input", "R", "graphics", "output")) {
    dir.create(path = file.path(project_name, directory))
  }
}

## ---- eval = FALSE, echo = TRUE------------
#  file.create("load.R")

## ------------------------------------------
create_workflow = function(project_name) {
  dir.create(path = project_name)
  for (directory in c("input", "R", "graphics", "output")) {
    dir.create(path = file.path(project_name, directory))
  }
  for(rfile in c("load", "clean", "func", "do", "graphics")){
    fname = paste0(rfile, ".R")
    fpath = file.path(project_name, "R", fname)
    file.create(fpath)
  }
}

## ---- eval = FALSE-------------------------
#  file.create("clean.R")
#  fileConn = file("clean.R")
#  writeLines('source("load.R")', fileConn)
#  close(fileConn)

## ------------------------------------------
create_workflow = function(project_name) {
  dir.create(path = project_name)
  for (directory in c("input", "R", "graphics", "output")) {
    dir.create(path = file.path(project_name, directory))
  }
  for(rfile in c("load", "clean", "func", "do", "graphics")){
    fname = paste0(rfile, ".R")
    fpath = file.path(project_name, "R", fname)
    file.create(fpath)
    if (exists("code")) {
      print(exists("code"))
      fileConn = file(fpath)
      writeLines(code, fileConn)
      close(fileConn)
    }
    code = paste0('source("', fpath, '")')
  }
}

