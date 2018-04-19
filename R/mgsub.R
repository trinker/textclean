#' Multiple \code{\link[base]{gsub}}
#' 
#' \code{mgsub} - A wrapper for \code{\link[base]{gsub}} that takes a vector 
#' of search terms and a vector or single value of replacements.
#' 
#' @param x A character vector.
#' @param pattern Character string to be matched in the given character vector. 
#' @param replacement Character string equal in length to pattern or of length 
#' one which are a replacement for matched pattern. 
#' @param leadspace logical.  If \code{TRUE} inserts a leading space in the 
#' replacements.
#' @param trailspace logical.  If \code{TRUE} inserts a trailing space in the 
#' replacements.
#' @param fixed logical. If \code{TRUE}, pattern is a string to be matched as is. 
#' Overrides all conflicting arguments.
#' @param trim logical.  If \code{TRUE} leading and trailing white spaces are 
#' removed and multiple white spaces are reduced to a single white space.
#' @param order.pattern logical.  If \code{TRUE} and \code{fixed = TRUE}, the 
#' \code{pattern} string is sorted by number of characters to prevent substrings 
#' replacing meta strings (e.g., \code{pattern = c("the", "then")} resorts to 
#' search for "then" first).
#' @param safe logical.  If \code{TRUE} then the \pkg{mgsub} package is used as
#' the backend and performs safe substitutions.  The trade-off is that this mode
#' will slow the replacements down considerably.
#' @param \dots Additional arguments passed to \code{\link[base]{gsub}}. In 
#' \code{mgsub_regex_safe} this is other arguments passed to \code{\link[mgsub]{mgsub}}.
#' @return \code{mgsub} - Returns a vector with the pattern replaced.
#' @seealso \code{\link[textclean]{replace_tokens}}
#' \code{\link[base]{gsub}}
#' @export
#' @rdname mgsub
#' @examples
#' mgsub(DATA$state, c("it's", "I'm"), c("it is", "I am"))
#' mgsub(DATA$state, "[[:punct:]]", "PUNC", fixed = FALSE)
#' \dontrun{
#' library(textclean)
#' hunthou <- replace_number(seq_len(1e5)) 
#' 
#' textclean::mgsub("'twenty thousand three hundred five' into 20305", hunthou, seq_len(1e5))
#' ## "'20305' into 20305"
#' 
#' ## Larger example from: https://stackoverflow.com/q/18332463/1000343
#' ## A slower approach
#' fivehunthou <- replace_number(seq_len(5e5)) 
#' 
#' testvect <- c("fifty seven", "four hundred fifty seven", "six thousand four hundred fifty seven", 
#'     "forty six thousand four hundred fifty seven", "forty six thousand four hundred fifty seven", 
#'     "three hundred forty six thousand four hundred fifty seven"
#' )
#' 
#' textclean::mgsub(testvect, fivehunthou, seq_len(5e5))
#' 
#' ## Safe substitution: Uses the mgsub package as the backend
#' dubious_string <- "Dopazamine is a fake chemical"
#' pattern <- c("dopazamin","do.*ne")
#' replacement <- c("freakout","metazamine")
#' 
#' mgsub(dubious_string, pattern, replacement, ignore.case = TRUE, fixed = FALSE)
#' mgsub(dubious_string, pattern, replacement, safe = TRUE, fixed = FALSE)
#' }
mgsub <- function (x, pattern, replacement, leadspace = FALSE, 
    trailspace = FALSE, fixed = TRUE, trim = FALSE, order.pattern = fixed, 
    safe = FALSE, ...) {

    if (!is.null(list(...)$ignore.case) & fixed) {
        warning('`ignore.case = TRUE` can\'t be used with `fixed = TRUE`.\nDo you want to set `fixed = FALSE`?')    
    }
    
    if (safe) {
        return(mgsub_regex_safe(x = x, pattern = pattern, replacement = replacement, ...))
    }
    
    if (leadspace | trailspace) replacement <- spaste(replacement, trailing = trailspace, leading = leadspace)

    if (fixed && order.pattern) {
        ord <- rev(order(nchar(pattern)))
        pattern <- pattern[ord]
        if (length(replacement) != 1) replacement <- replacement[ord]
    }
    if (length(replacement) == 1) replacement <- rep(replacement, length(pattern))
    if (any(!nzchar(pattern))) {
        good_apples <- which(nzchar(pattern))  
        pattern <- pattern[good_apples]
        replacement <- replacement[good_apples]      
        warning('Empty pattern found (i.e., `pattern = ""`).\nThis pattern and replacement have been removed.')
    }
    for (i in seq_along(pattern)){
        x <- gsub(pattern[i], replacement[i], x, fixed = fixed, ...)
    }

    if (trim) x <- gsub("\\s+", " ", gsub("^\\s+|\\s+$", "", x, perl=TRUE), perl=TRUE)
    x
}

#' Multiple \code{\link[base]{gsub}}
#' 
#' \code{mgsub_fixed} - An alias for \code{mgsub}.
#' 
#' @export
#' @rdname mgsub
mgsub_fixed <- mgsub 

#' Multiple \code{\link[base]{gsub}}
#' 
#' \code{mgsub_regex} - An wrapper for \code{mgsub} with \code{fixed = FALSE}.
#' 
#' @export
#' @rdname mgsub
mgsub_regex <- function(x, pattern, replacement, leadspace = FALSE, 
    trailspace = FALSE, fixed = FALSE, trim = FALSE, order.pattern = fixed, 
    ...) {
    
    mgsub(x = x, pattern = pattern, replacement = replacement, leadspace = leadspace, 
        trailspace = trailspace, fixed = fixed, trim = trim, order.pattern = order.pattern, 
        ...
    )
    
}

#' Multiple \code{\link[base]{gsub}}
#' 
#' \code{mgsub_regex_safe} - An wrapper for \code{\link[mgsub]{mgsub}}.
#' 
#' @export
#' @rdname mgsub
mgsub_regex_safe <- function(x, pattern, replacement, ...){
    mgsub::mgsub(string = x, pattern = pattern, replacement = replacement, ...)
}
    
    
spaste <-
function (terms, trailing = TRUE, leading = TRUE) {
    if (leading) {
        s1 <- " "
    }     else {
        s1 <- ""
    }
    if (trailing) {
        s2 <- " "
    } else {
        s2 <- ""
    }
    pas <- function(x) paste0(s1, x, s2)
    if (is.list(terms)) {
        z <- lapply(terms, pas)
    } else {
        z <- pas(terms)
    }
    return(z)
}


