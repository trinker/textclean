#' Find Tokens that Match a Regex
#' 
#' Given a text, find all the tokens that match a regex(es).  This function is
#' particularly useful with \code{\link[textclean]{replace_tokens}}.
#' 
#' @param x A character vector.
#' @param pattern Character string(s) to be matched in the given character vector. 
#' @param ignore.case logical.  If \code{TRUE} the case of the tokens/patterns 
#' will be ignored.
#' @param \ldots ignored.
#' @return Returns a vector of tokens from a text matching a specific regex 
#' pattern.
#' @export
#' @seealso \code{\link[textclean]{replace_tokens}}
#' @examples
#' with(DATA, match_tokens(state, c('^li', 'ou')))
#' 
#' with(DATA, match_tokens(state, c('^Th', '^I'), ignore.case = TRUE))
#' with(DATA, match_tokens(state, c('^Th', '^I'), ignore.case = FALSE))
match_tokens <- function(x, pattern, ignore.case = TRUE, ...){

    if (!is.atomic(x)) stop('`x` should be a character vector')
    y <- rm_na(unique(unlist(textshape::split_token(x, lower = ignore.case))))
    if (isTRUE(ignore.case)) pattern <- tolower(pattern)
    
    y[grepl(paste(paste0('(', pattern, ')'), collapse = '|'), y)]
    
}


