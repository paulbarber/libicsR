
if(!is.loaded("Ics_2D16_getDims", PACKAGE = "libicsR"))
  dyn.load("libicsR")

library(EBImage)

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
  
  out <- .C("Ics_2D16_getData", 
            file,
            data = as.integer(data),
            size = as.integer(size),
            ret = as.integer(0),
            PACKAGE = "libicsR")

  if(d$ret<0)
    return(NA)
  
  return(out)
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