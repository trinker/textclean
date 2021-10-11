#' SQL Style LIKE
#' 
#' Use like as a SQL-esque opertator for pattern matching.  \code{%like%} is
#' case insensitive while \code{%slike%} is case sensitive.  This is most useful 
#' in a \code{dplyr::filter}.
#' 
#' @param var A variable/column.
#' @param pattern A search pattern.
#' @export
#' @rdname like
#' @examples
#' state.name[state.name %like% 'or']
#' state.name[state.name %LIKE% 'or']
#' state.name[state.name %slike% 'or'] ## No Oregon
`%like%` <- function(var, pattern){
    stringi::stri_detect_regex(var, pattern, case_insensitive = TRUE)
}

#' @rdname like
#' @export
`%LIKE%` <- `%like%`

#' @rdname like
#' @export
`%slike%` <- function(var, pattern){
    stringi::stri_detect_regex(var, pattern, case_insensitive = FALSE)
}

#' @rdname like
#' @export
`%SLIKE%` <- `%slike%`