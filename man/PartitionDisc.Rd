% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PartitionDisc.R
\name{PartitionDisc}
\alias{PartitionDisc}
\title{PartitionDisc: Leave-one-disc-out cross-validation}
\usage{
PartitionDisc(.data, radius = 2, buffer = 1, seed = NULL)
}
\arguments{
\item{.data}{\strong{Internal parameter, do not use in the workflow function}. \code{.data} is a list of a data frame and a raster object returned from occurrence modules and covariate modules respectively. \code{.data} is passed automatically in workflow from the occurrence and covariate modules to the process module(s) and should not be passed by the user.}

\item{radius}{Numeric the radius of the disc, in degrees}

\item{buffer}{Numeric, the size of the buffer zone in degrees}

\item{seed}{Numeric used with \code{\link[sperrorest]{partition.disc}}}
}
\description{
This process module partitions the sample into training and tests set by selecting circular test areas (possibly surrounded by an exclusion buffer) and using the remaining samples as training samples. See function partition.disc in package sperrorest for more details
}
\details{
Module type: Process
}
\section{Version}{
 1.0
}

\section{Date submitted}{
 2015-11-13
}

\section{Data type}{
 presence-only, presence/absence, abundance, proportion
}
\author{
Tom August' \email{tomaug@ceh.ac.uk'}
}
\seealso{
Other process: \code{\link{BackgroundAndCrossvalid}},
  \code{\link{Background}}, \code{\link{Crossvalidate}},
  \code{\link{NoProcess}},
  \code{\link{OneHundredBackground}},
  \code{\link{OneThousandBackground}}
}

