#' @title Model module: MachineLearn
#'
#' @description Model module to fit a very large number of machine learning models.
#' 
#' @param .df \strong{Internal parameter, do not use in the workflow function}.
#' \code{.df} is data frame that combines the occurrence
#'
#' @param method The machine learning method to use. Common examples are "glm", 
#'  "nnet", "gbm", "glmnet", "rf". See 
#'  http://topepo.github.io/caret/modelList.html for a full list. Only 
#'  classification or dual use models are useable.
#'
#' @param tuneLength How many values of each tuning/hyperparameter should be tried?
#'
#' @param metric a string that specifies what summary metric will be used to
#'          select the optimal model. Options are "ROC", "Accuracy" and
#'          "Kappa".
#'
#' @param number How many folds to use in cross validation.
#'
#' @param repeats How many times should the entire cross validation process be 
#'  repeated. Increasing this will reduce instability in your model performace,
#'  but will take longer to run.
#'
#' @param tuneGrid Explicitely pass a data frame of tuning/hyperparameter combinations. If
#'  NULL, tuneLength will be used instead.
#'
#' @param trControl A named list of further arguments to pass to trainControl. See 
#'  \code{\link[caret]{trainControl}} for details.
#'
#' @param ... Other arguments passed to \code{\link[caret]{train}}.
#'
#' @seealso \code{\link{caret::train}} \code{\link{trainControl}}
#' @author Tim CD Lucas, \email{timcdlucas@@gmail.com}
#' @section Version: 1.0
#' @section Date submitted: 2015-11-13
#' @section Data type: presence/absence
#' @name MachineLearn
#' @family model
MachineLearn <-
  function (.df, 
            method = 'glmnet', 
            tuneLength = 8, 
            metric = 'ROC', 
            number = 5, 
            repeats = 1, 
            tuneGrid = NULL, 
            trControl = NULL, ...) {
    
    # pbkrtest is not noted on caret's CRAN page but I get errors if it 
    # is not installed prior to caret. Could be a missing dependency...
    zoon:::GetPackage('pbkrtest')
    zoon:::GetPackage('caret')
    
    # so that it runs automatically on testing with defaults I specify
    # to install the required package for the default
    if(method == 'glmnet') zoon:::GetPackage('glmnet')

    
    if (!all(.df$type %in% c('presence', 'absence', 'background'))) {
      stop ('only for presence/absence or presence/background data')
    }
    

    # get the covariates
    covs <- as.data.frame(.df[, 6:ncol(.df)])
    names(covs) <- names(.df)[6:ncol(.df)]

    if(NCOL(covs) == 1){
      warning('Only 1 covariate available. Some models do not work with only 1 covariate.')
    }

    # Change value to a factor so caret knows to do classification
    if(any(.df$type == 'abundance')){
      stop("MachineLearn module doens't know how to deal with abundance data.")
    }


    .df$value <- factor(ifelse(.df$value, 'pres', 'abs'))

    trContr <- caret::trainControl(method = 'repeatedcv', 
                            number = number, 
                            summaryFunction = twoClassSummary,
                            repeats = repeats,
                            classProbs = TRUE)

    if(!is.null(trContr)){
      # Train control add use inputted vars.
      

    }

    
    # Do cross validation to select hyperparameters
    # And fit fully model
    m <- caret::train(x = as.matrix(covs),
                      y = .df$value,
                      method = method,
                      tuneLength = tuneLength,
                      tuneGrid = tuneGrid,
                      trControl = trContr,
                      metric = metric, ...)

    ZoonModel(model = m,
              code = {
                # create empty vector
                p <- rep(NA, nrow(newdata))
                # omit NAs in new data
                newdata_clean <- na.omit(newdata)
                # get their indices
                na_idx <- attr(newdata_clean, 'na.action')
                if (is.null(na_idx)){
                  idx <- 1:nrow(newdata)
                } else {
                  idx <- -na_idx
                }
                caretP <- caret::predict.train(model,
                                               newdata_clean,
                                               type = 'prob')
		            p[idx] <- caretP$pres
                return (p)
              },
              packages = c('caret', m$modelInfo$library))
}
