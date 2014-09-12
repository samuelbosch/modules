#'Output module: SurfaceMap
#'
#'Make a png of a map of predicted surface.
#'
#'@param dir Where to save figures. Defaults to the working directory. 

#'@name SurfaceMap
SurfaceMap <-
function (model, ras, dir='.') {
  
  vals <- data.frame(getValues(ras))
  colnames(vals) <- names(ras)
  
  pred <- predict(model$model,
                  newdata = vals,
                  type = 'response')
  
  pred_ras <- ras[[1]]
  
  pred_ras <- setValues(pred_ras, pred)

  png(paste0(dir,"/ZoonMap", Sys.time(), ".png"))
  plot(ras) 
  dev.off()
  
  return(NULL)
  
}