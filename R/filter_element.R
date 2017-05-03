#' Remove Elements in a Vetor
#' 
#' Removes the matching elements of a vector.
#' 
#' @param x A character vector.
#' @param pattern A regex pattern to match for exclusion.
#' @param \ldots Other arguments passed to \code{\link[base]{grep}}.
#' @return Returns a vector with matching elements removed.
#' @export
#' @examples 
#' x <- c('dog', 'cat', 'bat', 'dingo', 'dragon', 'dino')
#' filter_element(x, '^d.+?g')
#' filter_element(x, 'at$')
#' filter_element(x, '^d')
#' filter_element(x, '\\b(dog|cat)\\b')
filter_element <- function(x, pattern, ...){
    warning("Deprecated, use textclean::drop_elements() instead.", call. = FALSE)
    
    grep(pattern, x, value =  TRUE, invert = TRUE, perl = TRUE, ...)
}




