#' Filter Elements in a Vetor
#' 
#' \code{drop_element} - Filter to drop the matching elements of a vector.
#' 
#' @param x A character vector.
#' @param pattern A regex pattern to match for exclusion.
#' @param \ldots Other arguments passed to \code{\link[base]{grep}}.
#' @return Returns a vector with matching elements removed.
#' @rdname drop_element
#' @export
#' @examples 
#' x <- c('dog', 'cat', 'bat', 'dingo', 'dragon', 'dino')
#' drop_element(x, '^d.+?g')
#' keep_element(x, '^d.+?g')
#' drop_element(x, 'at$')
#' drop_element(x, '^d')
#' drop_element(x, '\\b(dog|cat)\\b')
drop_element <- function(x, pattern, ...){

    grep(pattern, x, value =  TRUE, invert = TRUE, perl = TRUE, ...)
}

#' Filter Elements in a Vetor
#' 
#' \code{keep_element} - Filter to keep the matching elements of a vector.
#' 
#' @rdname drop_element
#' @export
keep_element <- function(x, pattern, ...){

    grep(pattern, x, value =  TRUE, perl = TRUE, ...)
}


