\name{affectHemisphere}
\title{Affect the position of the mid-saggital plan}
\alias{affectHemisphere<-}
\alias{affectHemisphere<-,MRIaggr-method}
\usage{
\S4method{affectHemisphere}{MRIaggr}(object,overwrite=FALSE,trace=TRUE) <- value
}
\description{
Affect information about the position of the mid-saggital plan to a \code{\linkS4class{MRIaggr}} object.
}
\arguments{
  \item{object}{an object of class \code{\linkS4class{MRIaggr}}. REQUIRED.}
  \item{value}{a \emph{list} of \emph{data.frame}. Names must be among \code{"midplane"}, \code{"hemispheres"} \code{"data"}. See the Details section. REQUIRED.}  
  \item{overwrite}{if the characteristics of a mid-saggital plan are already stored in \code{object}, can they be overwritten ? \emph{logical}.}  
  \item{trace}{should the execution of the function be traced ? \emph{logical}.}
}
\details{
ARGUMENTS: \cr
The \code{"midplane"} element indicates the position of the observations of the mid-saggital plan. 
It has to be a two columns \emph{data.frame} with the coordinates \code{("i","j")} in columns and the observations in rows. 

The \code{"data"} element must contains the position of each voxel relatively to the mid-saggital plan (column \code{"i_hemisphere"} and \code{"j_hemisphere"}) the hemisphere (\code{"left"}, \code{"right"} or \code{"undefined"}) to which the voxel belongs (column \code{"hemisphere"}). 

The \code{"hemispheres"} element indicates in which hemisphere is the lesion (denoted by \code{"lesion"}). The others hemispheries are denoted by \code{"controlateral"}.
It has to be a one line two columns \emph{data.frame} with names \code{"left"} \code{"right"}.
}
\seealso{
 \code{\link{calcHemisphere}} to obtain the position of the mid-saggital plan and the position of the lesion in the hemispheres. \cr
 \code{\link{selectParameter}} to extract the previous elements.
}
 \value{
  None.
}
\examples{
## load a MRIaggr object
data("MRIaggr.Pat1_red", package="MRIaggr")

## automatic affectation
\dontrun{
calcHemisphere(MRIaggr.Pat1_red,param="T2_GRE_t0",num=1,i_test=2,j_test=2,angle_test=2,
                          update.object=TRUE,overwrite=TRUE)
}
\dontshow{
resHemi <- calcHemisphere(MRIaggr.Pat1_red,param="T2_GRE_t0",num=1,i_test=1,j_test=1,angle_test=1,
                          update.object=TRUE,overwrite=TRUE)
}		

## manual affectation
\dontrun{
resHemi <- calcHemisphere(MRIaggr.Pat1_red,param="T2_GRE_t0",num=1,i_test=2,j_test=2,angle_test=2)
}
affectHemisphere(MRIaggr.Pat1_red,overwrite=TRUE) <- list(midplane=resHemi$midplane,
                                                          data=resHemi$data)

## display
index1 <- data.frame(selectMidplane(MRIaggr.Pat1_red),15)
names(index1) <- c("i","j","k")
multiplot(MRIaggr.Pat1_red,param="T2_GRE_t0",num=1,midplane=TRUE,window=FALSE,
             index1=list(coords=index1,pch=20,cex=2,col="purple")
             
)

selectMidplane(MRIaggr.Pat1_red)
selectHemispheres(MRIaggr.Pat1_red)
}
\concept{affect.}
\keyword{methods}

