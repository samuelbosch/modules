% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GBM.R
\name{GBM}
\alias{GBM}
\title{Model module: GBM}
\usage{
GBM(.df, max.trees = 1000, interaction.depth = 5, shrinkage = 0.001)
}
\arguments{
\item{.df}{\strong{Internal parameter, do not use in the workflow function}.
\code{.df} is data frame that combines the occurrence}

\item{max.trees}{The maximum number of trees to fit.
The number of trees is equivalent to the number of iterations and
 the number of basis functions in the additive expansion. The optimal
 number will be selected by cross-validation, but this sets an upper limit.}

\item{interaction.depth}{The maximum depth of variable interactions.
1 implies an additive model, 2 implies a model with up to 2-way interactions,
 etc.}

\item{shrinkage}{a shrinkage parameter applied to each tree in the expansion.
Also known as the learning rate or step-size reduction.}
}
\description{
Model module to fit a generalized boosted regression (aka boosted regression
trees) model
}
\section{Version}{
 1.0
}

\section{Date submitted}{
 2015-11-13
}

\section{Data type}{
 presence/absence
}
\author{
ZOON Developers, \email{zoonproject@gmail.com}
}
\seealso{
Other model: \code{\link{BiomodModel}},
  \code{\link{LogisticRegression}},
  \code{\link{MachineLearn}}, \code{\link{MaxEnt}},
  \code{\link{OptGRaF}}, \code{\link{QuickGRaF}},
  \code{\link{RandomForest}}, \code{\link{mgcv}}
}

