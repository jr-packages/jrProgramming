## ----include = FALSE-----------------------
knitr::opts_chunk$set(results = "show", echo = TRUE)

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

