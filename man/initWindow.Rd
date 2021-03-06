\name{initWindow}
\title{Display initialization}
\alias{initWindow}
\description{
Check and initialize display arguments. For internal use.
}
\usage{
initWindow(window,filename,path,width,height,unit,res,
		 n.plot,mfrow,xlim,ylim,method)
}
\arguments{
  \item{window}{the type of device on which the plot will be displayed. \emph{logical}, \code{NULL} or \code{character}.}
  \item{filename}{the name of the file used to export the plot. \emph{character}.}
  \item{path}{the directory where the plot file will be created. \emph{character}.}
  \item{width}{the width of the device used to export the plot. \emph{postive numeric}.}
  \item{height}{the height of the device used to export the plot. \emph{postive numeric}.}
  \item{unit}{the units in which \code{height} and \code{width} are given. \emph{character}.}
  \item{res}{the nominal resolution in ppi which will be recorded in the bitmap file. \emph{positive integer}.}
  \item{n.plot}{the number of images to display. \emph{integer}.}
  \item{mfrow}{the division of the device in plot region. \emph{numeric vector of size 2}.}
  \item{xlim}{the x limits of the plot. \emph{numeric vector of size 2}.}
  \item{ylim}{the y limits of the plot. \emph{numeric vector of size 2}.}
  \item{method}{the name of the function that called the initializer. \emph{character}.}
}
\details{
ARGUMENTS: \cr
Possible values for \code{windows} are:
\itemize{
\item \code{NULL} : the plot is displayed on the current device with no reshape. 
\item \code{FALSE} : the plot is displayed on the current device with the appropriate reshape.
\item \code{TRUE} : a new graphical device is open.
\item \code{"eps"} : the plot is displayed in an image file using \code{\link{postscript}}.
\item \code{"svg"} : the plot is displayed in an image file using \code{\link{svg}}.
\item \code{"png"} : the plot is displayed in an image file using \code{\link{png}}.
\item \code{"pdf"} : the plot is displayed in an image file using \code{\link{pdf}}.
}

If \code{path} is set to \code{NULL}, the image file is exported in the current working directory. \cr

\code{unit} can be any of \code{"px"}, \code{"in"}, \code{"cm"} or \code{"mm"}. \cr

Information about the \code{filename}, \code{width}, \code{height}, \code{path}, \code{unit} and \code{res} arguments can be found in \code{\link{postscript}}, \code{\link{svg}} and \code{\link{png}}.

FUNCTION: \cr
The arguments \code{filename}, \code{width}, \code{height}, \code{path}, \code{unit} and \code{res} are only active if \code{window} is \code{"eps"}, \code{"svg"} or \code{"png"}. \cr
}
\concept{init.}
\keyword{function,internal}
