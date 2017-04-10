#' Replace First/Last Names
#' 
#' Replaces first/last names.  
#' 
#' @param x  The text variable.
#' @param names A vector of names to replace.  This may be made more custom 
#' through a vector provided from a named entity extractor.
#' @param replacement A string to replace names with.
#' @param \dots Other arguments passed to \code{\link[textclean]{replace_tokens}}.
#' @return Returns a vector with names replaced.
#' @export
#' @import lexicon
#' @examples
#' x <- c(
#'     "Mary Smith is not here",
#'     "Karen is not a nice person",
#'     "Will will do it",
#'     NA
#' )
#' 
#' replace_names(x)
#' replace_names(x, replacement = '<<NAME>>')
replace_names  <- function(x, 
    names = gsub("(^.)(.*)", "\\U\\1\\L\\2", c(lexicon::freq_last_names[[1]], lexicon::common_names), perl = TRUE), 
    replacement = "",  ...) {

    replace_tokens(x, names, replacement, ...)
}




