% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/like.R
\name{\%like\%}
\alias{\%like\%}
\alias{\%LIKE\%}
\alias{\%slike\%}
\alias{\%SLIKE\%}
\title{SQL Style LIKE}
\usage{
var \%like\% pattern

var \%LIKE\% pattern

var \%slike\% pattern

var \%SLIKE\% pattern
}
\arguments{
\item{var}{A variable/column.}

\item{pattern}{A search pattern.}
}
\description{
Use like as a SQL-esque opertator for pattern matching.  \code{\%like\%} is
case insensitive while \code{\%slike\%} is case sensitive.  This is most useful 
in a \code{dplyr::filter}.
}
\examples{
state.name[state.name \%like\% 'or']
state.name[state.name \%LIKE\% 'or']
state.name[state.name \%slike\% 'or'] ## No Oregon
}
