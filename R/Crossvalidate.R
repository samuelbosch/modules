#'Process module: Crossvalidate
#'
#'Run k fold crossvalidation. If presence absence, split presences and absences separately so folds have equally balanced data. Otherwise just sample.
#'
#'@param k Positive integer number of folds to split the data into. Default is 5. 
#'
#'@name Crossvalidate
Crossvalidate <-
function (data, k=5) {
  
  occurrence <- data$df
  ras <- data$ras

  
  if (all(occurrence$value == 1)) {
    warning ('You currently only have presence points. Unless you are using presence only modelling, create some pseudoabsence points before this module.')
  }

  # if presence absence, create folds separately to give well balanced groups
  # if presence only or abundance etc., just split randomly into folds.
  if (all(c(1,2) %in% occurrence$value) & all(occurrence$value %in% c(1,2) )){
    fold <- rep(NA, NROW(occurrence))
    fold[occurrence$value == 1] <- sample(1:k, sum(occurrence$value == 1), replace=TRUE)
    fold[occurrence$value == 0] <- sample(1:k, sum(occurrence$value == 0), replace=TRUE)
  } else {
    fold <- sample(1:k, NROW(occurrence), replace=TRUE)
  }

  # extract covariates
  covs <- as.matrix(extract(ras, occurrence[, c('longitude', 'latitude')]))


  # combine with the occurrence data
  df <- data.frame(value = occurrence$value,
                   type = occurrence$type,
                   fold = fold,
                   longitude = occurrence$longitude,
                   latitude = occurrence$latitude,
                   covs)
  
  names(df)[6:ncol(df)] <- names(ras)
  
  df <- na.omit(df)

  return(list(df=df, ras=ras))
  
}