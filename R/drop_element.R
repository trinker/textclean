#' Filter Elements in a Vetor
#' 
#' \code{drop_element} - Filter to drop the matching elements of a vector.
#' 
#' @param x A character vector.
#' @param pattern A regex pattern to match for exclusion.
#' @param regex logical.  If setting this to \code{TRUE} please use 
#' \code{drop_element_regex} or \code{keep_element_regex} directly as this will
#' provide better control and optimization.
#' @param \ldots Other arguments passed to \code{\link[base]{grep}} if 
#' \code{regex}.  If \code{fixed}, then elements to drop/keep.
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
#' 
#' drop_element_fixed(x, 'bat', 'cat')
#' drops <- c('bat', 'cat')
#' drop_element_fixed(x, drops)
drop_element <- function(x, pattern, regex = TRUE, ...){

    if (isTRUE(regex)) {
        drop_element_regex(x, pattern, ...)
    } else {
        message('Please use `drop_element_fixed` for better control.')
        drop_element_fixed(x, ...) 
    }
}

#' @rdname drop_element
#' @export
drop_element_regex  <- function(x, pattern, ...){

    grep(pattern, x, value =  TRUE, invert = TRUE, perl = TRUE, ...)
}

#' @rdname drop_element
#' @export
drop_element_fixed  <- function(x, ...){

    x[!x %in% unlist(list(...))]
}

#' Filter Elements in a Vetor
#' 
#' \code{keep_element} - Filter to keep the matching elements of a vector.
#' 
#' @rdname drop_element
#' @export
keep_element  <- function(x, pattern, regex = TRUE, ...){

    if (isTRUE(regex)) {
        keep_element_regex(x, pattern, ...)
    } else {
        message('Please use `keep_element_fixed` for better control.')        
        keep_element_fixed(x, ...)    
    }
}

#' @rdname drop_element
#' @export
keep_element_fixed  <- function(x, ...){

    x[x %in% unlist(list(...))]
}


#' @rdname drop_element
#' @export
keep_element_regex <- function(x, pattern, ...){

    grep(pattern, x, value =  TRUE, perl = TRUE, ...)
}



