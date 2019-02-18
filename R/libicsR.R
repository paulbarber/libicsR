
if(!is.loaded("Ics_2D8_getDims", PACKAGE = "libicsR"))
  dyn.load("libicsR")

library(EBImage)

Ics_2D8_getDims <- function (file){
  
  out <- .C("Ics_2D8_getDims", 
            file,
            width = as.integer(0),
            height = as.integer(0),
            ret = as.integer(0),
            PACKAGE = "libicsR")
  
  
  if(out$ret==0)
    return(c(out$width, out$height))
  else
    return(c(NA,NA))
}

Ics_2D16_getDims <- function (file){
  
  out <- .C("Ics_2D16_getDims", 
            file,
            width = as.integer(0),
            height = as.integer(0),
            ret = as.integer(0),
            PACKAGE = "libicsR")
  
  
  if(out$ret==0)
    return(c(out$width, out$height))
  else
    return(c(NA,NA))
}

Ics_2D8_getData <- function (file){

  out <- .C("Ics_2D8_getDims", 
            file,
            width = as.integer(0),
            height = as.integer(0),
            ret = as.integer(0),
            PACKAGE = "libicsR")
  
  if(out$ret<0)
    return(NA)

  size = out$width * out$height
  data <- vector(length = size)
  
  d <- .C("Ics_2D8_getData", 
            file,
            data = as.integer(data),
            size = as.integer(size),
            ret = as.integer(0),
            PACKAGE = "libicsR")

  if(d$ret<0)
    return(NA)
  
  return(d)
}

Ics_2D16_getData <- function (file){

  out <- .C("Ics_2D16_getDims", 
            file,
            width = as.integer(0),
            height = as.integer(0),
            ret = as.integer(0),
            PACKAGE = "libicsR")
  
  if(out$ret<0)
    return(NA)

  size = out$width * out$height
  data <- vector(length = size)
  
  d <- .C("Ics_2D16_getData", 
            file,
            data = as.integer(data),
            size = as.integer(size),
            ret = as.integer(0),
            PACKAGE = "libicsR")

  if(d$ret<0)
    return(NA)
  
  return(d)
}

Ics_2D8_getEBImage <- function (file){

 out <- .C("Ics_2D8_getDims", 
           file,
           width = as.integer(0),
           height = as.integer(0),
           ret = as.integer(0),
           PACKAGE = "libicsR")
 
 if(out$ret<0)
   return(NA)
 
 size = out$width * out$height
 data <- vector(length = size)
 
 d <- .C("Ics_2D8_getData", 
           file,
           data = as.integer(data),
           size = as.integer(size),
           ret = as.integer(0),
           PACKAGE = "libicsR")
 
 if(d$ret<0)
   return(NA)
 
 i <- Image(data = d$data, dim = c(out$width, out$height), colormode = 0)
 
 return(i)
}

Ics_2D16_getEBImage <- function (file){

 out <- .C("Ics_2D16_getDims", 
           file,
           width = as.integer(0),
           height = as.integer(0),
           ret = as.integer(0),
           PACKAGE = "libicsR")
 
 if(out$ret<0)
   return(NA)
 
 size = out$width * out$height
 data <- vector(length = size)
 
 d <- .C("Ics_2D16_getData", 
           file,
           data = as.integer(data),
           size = as.integer(size),
           ret = as.integer(0),
           PACKAGE = "libicsR")
 
 if(d$ret<0)
   return(NA)
 
 i <- Image(data = d$data, dim = c(out$width, out$height), colormode = 0)
 
 return(i)
}

Ics_2dreal_writeEBImage <- function (img, file){
  
  img_data <- as.double(as.vector(img@.Data))
  
  d <- .C("Ics_2Dreal_writeData", 
     file,
     data = as.double(img_data),
     width = as.integer(dim(img)[1]),
     height = as.integer(dim(img)[2]),
     ret = as.integer(0),
     PACKAGE = "libicsR")
  
  return(d$ret)
}

Ics_2d8_writeEBImage <- function (img, file){
  
  img_data <- as.integer(as.vector(img@.Data))
  
  d <- .C("Ics_2D8_writeData", 
          file,
          data = as.integer(img_data),
          width = as.integer(dim(img)[1]),
          height = as.integer(dim(img)[2]),
          ret = as.integer(0),
          PACKAGE = "libicsR")
  
  return(d$ret)
}

Ics_2d16_writeEBImage <- function (img, file){
  
  img_data <- as.integer(as.vector(img@.Data))
  
  d <- .C("Ics_2D16_writeData", 
          file,
          data = as.integer(img_data),
          width = as.integer(dim(img)[1]),
          height = as.integer(dim(img)[2]),
          ret = as.integer(0),
          PACKAGE = "libicsR")
  
  return(d$ret)
}


# Test commands:
# dyn.load("libicsR")
# dyn.unload("libicsR")
#i <- Ics_2D16_getEBImage("Cy3_62.ics")
#i <- i/max(i)
#display(i)
#d <- Ics_2dreal_writeEBImage(i, "test.ics")
#d <- Ics_2d16_writeEBImage(i, "test16.ics")