\name{affectClinic}
\title{Affect clinical data}
\alias{affectClinic<-}
\alias{affectClinic<-,MRIaggr-method}
\description{
Affect clinical data to a \code{\linkS4class{MRIaggr}} object.
}
\usage{
\S4method{affectClinic}{MRIaggr}(object,add=FALSE,overwrite=FALSE,trace=TRUE) <- value
}
\arguments{
  \item{object}{an object of class \code{\linkS4class{MRIaggr}}. REQUIRED.}
  \item{value}{the clinical data. A one row \emph{data.frame}. REQUIRED.}
  \item{add}{should \code{value} be added to the existing clinical slot ? \emph{logical}.}
  \item{overwrite}{if clinical parameters with the same names are already stored in \code{object@clinic}, can they be overwritten ? \emph{logical}.}  
  \item{trace}{should the execution of the function be traced ? \emph{logical}.}
}
\seealso{ 
 \code{\link{selectClinic}} to extract the clinical data.
}
\value{
  None.
}
\examples{
## load a MRIaggr object
data("MRIaggr.Pat1_red", package="MRIaggr")

## affect clinical data
affectClinic(MRIaggr.Pat1_red) <- data.frame(Age=32,Gender="Male",NIHSS_H0="5")
selectClinic(MRIaggr.Pat1_red,param="Age")

## add a new parameter
affectClinic(MRIaggr.Pat1_red,add=TRUE,overwrite=TRUE) <- data.frame(City="Lyon")
selectClinic(MRIaggr.Pat1_red)
}
\concept{affect.}
\keyword{methods}

