#' Replace Tokens
#' 
#' Replace tokens with a single substring.  This is much faster than 
#' \code{\link[textclean]{mgsub}} if one wants to replace fixed tokens
#' with a single value or remove them all together.  This can be useful
#' for quickly replacing tokens like names in string with a single
#' value in order to reduce noise.
#' 
#' @param x A character vector.
#' @param tokens A vector of token to be replaced.
#' @param replacement A single character string to replace the tokens with.
#' The default, \code{NULL}, replaces the tokens with nothing.
#' @param ignore.case logical.  If \code{TRUE} the case of the tokens will 
#' be ignored.
#' @param \ldots ignored.
#' @return Returns a vector of strings with tokens replaced.
#' @note The function splits the string apart into tokens for speed
#' optimization.  After the replacement occurs the strings are pasted back
#' together.  The strings are not guaranteed to retain exact spacing of the
#' original.
#' @export
#' @seealso \code{\link[textclean]{mgsub}}, \code{\link[textclean]{match_tokens}}
#' @examples 
#' replace_tokens(DATA$state, c('No', 'what', "it's"))
#' replace_tokens(DATA$state, c('No', 'what', "it's"), "<<TOKEN>>")
#' replace_tokens(
#'     DATA$state, 
#'     c('No', 'what', "it's"), 
#'     "<<TOKEN>>", 
#'     ignore.case = TRUE
#' )
#' 
#' \dontrun{
#' ## Now let's see the speed
#' ## Set up data
#' library(textshape)
#' data(hamlet)
#' set.seed(11)
#' tokens <- sample(unique(unlist(split_token(hamlet$dialogue))), 2000)
#' 
#' tic <- Sys.time()
#' head(replace_tokens(hamlet$dialogue, tokens))
#' (toc <- Sys.time() - tic)
#' 
#' 
#' tic <- Sys.time()
#' head(mgsub(hamlet$dialogue, tokens, ""))
#' (toc <- Sys.time() - tic)
#' 
#' 
#' ## Amp it up 20x more data
#' tic <- Sys.time()
#' head(replace_tokens(rep(hamlet$dialogue, 20), tokens))
#' (toc <- Sys.time() - tic)
#'
#' ## Replace names example
#'
#' library(lexicon)
#' library(textshape)
#' nms <- gsub("(^.)(.*)", "\\U\\1\\L\\2", common_names, perl = TRUE)
#' x <- split_portion(
#'     sample(c(sample(grady_augmented, 5000), sample(nms, 10000, TRUE))), 
#'     n.words = 12
#' )
#' x$text.var <- paste0(
#'     x$text.var, 
#'     sample(c('.', '!', '?'), length(x$text.var), TRUE)
#'  )
#' replace_tokens(x$text.var, nms, 'NAME')
#' }
replace_tokens  <- function(x, tokens, replacement = NULL, 
    ignore.case = FALSE, ...) {
    
    replace_string_elements_generic(x = x, y = tokens, z = replacement, 
        ignore.case = ignore.case, ...)
    
}
