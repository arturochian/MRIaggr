\name{calcGR}
\title{Interface to the Growing Region algorithm}
\alias{calcGR}
\description{
Call the \code{\link{GRalgo}} function to perform the Growing Region algorithm.
}
\usage{
calcGR(contrast,W,seed,sigma_max,range=c(-Inf,+Inf),range.seed=c(-Inf,+Inf),
         breaks=100,scale=FALSE,iter_max=100,sd.robust=FALSE,trace=TRUE,
         history_sigma=FALSE,history_step=FALSE,history_front=FALSE)
}
\arguments{
  \item{contrast}{the contrast value of each observation. \emph{numeric vector}. REQUIRED.}
  \item{W}{the neighborhood matrix. \code{dgCMatrix}. REQUIRED.}
  \item{seed}{the index of the initial seeds or a binary indicator of the initial seeds. \code{positive integer vector} or \code{logical vector}. REQUIRED.}
  \item{sigma_max}{the maximum admissible value for the variability of the group contrast. \code{positive numeric}. REQUIRED.}
  \item{range}{the range of acceptable contrast values for the growing region group. \code{numeric vector of size 2}.}
  \item{range.seed}{the range of acceptable contrast values for the seeds. \code{numeric vector of size 2}.}
 
  \item{breaks}{the break points or the number of break points to use to categorize the contrast distribution. \code{numeric vector} or \code{postive integer}.}
  \item{scale}{should the contrast be scaled ? \code{logical}.}  
  \item{iter_max}{the maximum number of iterations for the expansion of the growing region. \code{postive integer}.}  
  \item{sd.robust}{should the median absolute deviation be used to estimte the variability of the group contrast, or the standard deviation ? \code{logical}.}
  \item{trace}{should the execution of the function be traced ? \emph{logical}.}  
  
  \item{history_sigma}{should the values of sigma be recorded ? \emph{logical}.}
  \item{history_step}{should the number of observations included in the growing region set be recorded ? \emph{logical}.}
  \item{history_front}{should the propagation front of the GR set be recorded ? \emph{logical}.}
}
\details{
FUNCTION: \cr
This version of the Growing Region algorithm was been proposed by (Revol et al. 1997).
}
\value{
  An \emph{list} containing :
  \itemize{
  \item\code{[[GR]]} : the index of the observations in the growing region. \emph{integer vector}.
  \item\code{[[test.break]]} : whether the GR algorithm was interrupted an during execution. \emph{logical}.
  \item\code{[[iter]]} : the number of the last iteration of the algorithm. \emph{integer}.
  \item\code{[[test.id]]} : whether the GR set has stabilised during the last iteration. \emph{logical}.
  \item\code{[[sigma]]} : if \code{history_sigma} was set to \code{TRUE}, the value of the homogeneity criteria at the begining and the end of each step (in columns) for all steps (in row). \emph{numeric matrix}.
  \item\code{[[history_GR]]} : if \code{history_step} was set to \code{TRUE}, the step when each GR observation was included in the GR set. \emph{integer vector}.
  \item\code{[[breaks]]} : if \code{history_front} was set to \code{TRUE}, the values used to categorize the contrast. \emph{numeric vector}.
 }
}
\references{
Chantal Revol and Michel Jourlin. \emph{A new minimum varance region growing algorithm for image segmentation}. Pattern Recognition Letters, 18(3):249-258,1997.
}
\seealso{
\code{\link{calcSigmaGR}} to find the optimal \code{sigma} value for a given clustering criterion.
}
\examples{
## load a MRIaggr object
data(MRIaggr.Pat1_red, package="MRIaggr")

calcThresholdMRIaggr(MRIaggr.Pat1_red,param=c("TTP_t0","MTT_t0"),threshold=1:10,
                     name_newparam=c("TTP.th_t0","MTT.th_t0"),
                     update.object=TRUE,overwrite=TRUE)
					 
## display raw parameter
multiplot(MRIaggr.Pat1_red,param="TTP.th_t0",num=3,as.logical=TRUE,
          index1=list(coords="MASK_DWI_t0",outline=TRUE))

## extract raw parameter, coordinates and compute the neighborhood matrix
carto <- selectContrast(MRIaggr.Pat1_red,num=3,hemisphere="lesion",
                         param=c("TTP.th_t0","TTP_t0","MASK_DWI_t0"))
coords <- selectCoords(MRIaggr.Pat1_red,num=3,hemisphere="lesion")
W <- calcW(coords,distband=sqrt(2))

## the seed is taken to be the point with the largest TTP in the lesion mask
indexN <- which(carto$MASK_DWI_t0==1)
seed <- indexN[which.max(carto[indexN,"TTP_t0"])]

## Display step by step the GR algorithm with sigma = 1
for(iter in c(0,1,2,5,10)){
  resGR1 <- calcGR(contrast=carto$TTP.th_t0, W=W, 
                   seed=seed, sigma_max=1, iter_max=iter,trace=FALSE)
  
  multiplot(MRIaggr.Pat1_red,param="TTP.th_t0",num=3,hemisphere="lesion",legend=FALSE,
         breaks=seq(0,10,0.1),as.logical=TRUE,cex=2,
		 main=paste("iteration=",iter," - slice ",sep=""),          
         index1=list(coords=coords[resGR1$GR,],pch=20,cex=1),
         index2=list(coords=coords[seed,],pch=20,cex=1)
  )
}

\dontrun{
## GR with sigma = 2
resGR2 <- calcGR(contrast=carto$TTP.th_t0, W=W, 
                 seed=seed,sigma_max=2,iter_max=50,
                 history_step=TRUE,history_front=TRUE)

## display 
# display the GR over the raw contrast
multiplot(MRIaggr.Pat1_red,param="TTP.th_t0",num=3,hemisphere="lesion",legend=FALSE,
             breaks=seq(0,10,0.1),as.logical=TRUE,cex=2,            
             index1=list(coords=coords[resGR2$GR,],pch=20,cex=1)
)

# display the step of inclusion in GR group for each observation
multiplot(coords[resGR2$GR,],
             resGR2$history_step,breaks=0:10,
             index1=list(coords=coords[seed,]),
             palette=rainbow(10)
)

# display the front propagation 
multiplot(coords[resGR2$GR,],
             resGR2$Mfront[,10],
             index1=list(coords=coords[seed,])
)

## GR with  sigma = 2 and range 6 to 10
resGR3 <- calcGR(contrast=carto$TTP.th_t0, W=W, 
                 seed=seed, range=c(6,Inf),
                 sigma_max=2, 
                 iter_max=20)

## display
multiplot(MRIaggr.Pat1_red,param="TTP.th_t0",num=3,hemisphere="lesion",legend=FALSE,
             breaks=seq(0,10,0.1),as.logical=TRUE,cex=2,            
             index1=list(coords=coords[resGR3$GR,],pch=20,cex=1)
)
}
}
\concept{calc.}
\keyword{functions}