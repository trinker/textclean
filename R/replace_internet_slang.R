#' Replace Internet Slang
#' 
#' Replaces Internet slang.  
#' 
#' @param x  The text variable.
#' @param slang A vector of slang strings to replace. 
#' @param replacement A vector of string to replace slang with.
#' @param ignore.case logical.  If \code{TRUE} the case of \code{slang} will be 
#' ignored (replacement regardless of case).
#' @param \dots Other arguments passed to \code{\link[textclean]{replace_tokens}}.
#' @return Returns a vector with names replaced.
#' @export
#' @examples
#' x <- c(
#'     "Marc the n00b needs to RTFM otherwise ymmv.",
#'     "TGIF and a big w00t!  The weekend is GR8!",
#'     "Will will do it",
#'     'w8...this PITA needs me to say LMGTFY...lmao.',
#'     NA
#' )
#' 
#' replace_internet_slang(x)
#' replace_internet_slang(x, ignore.case = FALSE)
#' replace_internet_slang(x, replacement = '<<SLANG>>')
#' replace_internet_slang(
#'     x, 
#'     replacement = paste0('{{ ', lexicon::hash_internet_slang[[2]], ' }}')
#' )
replace_internet_slang  <- function(x, 
    slang = paste0('\\b', lexicon::hash_internet_slang[[1]], '\\b'),
    replacement = lexicon::hash_internet_slang[[2]], ignore.case = TRUE, ...) {

    mgsub(x, slang, replacement, fixed = FALSE, ignore.case = ignore.case, ...)
}

im_his <- lexicon::hash_internet_slang


