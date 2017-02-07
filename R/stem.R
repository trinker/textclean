#' Stem a Vector of Words
#' 
#' Stem a vector of words.
#' 
#' @param x A vector of words.
#' @param language The name of a recognized language (see 
#' \code{\link[SnowballC]{wordStem}}).
#' @param \ldots ignored.
#' @return Returns a vector of stemmed words.
#' @export
#' @seealso \code{\link[textclean]{stem_strings}}
#' @examples 
#' stem_words(c("the", 'doggies', ',', 'well', 'they', 'aren\'t', 'Joyfully', 'running', '.'))
stem_words <- function(x, language = "porter", ...) {
    stem(x, language = language)
}


#' Stem a Vector of Strings
#' 
#' Stem a vector of strings.
#' 
#' @param x A vector of strings.
#' @param language The name of a recognized language (see 
#' \code{\link[SnowballC]{wordStem}}).
#' @param \ldots Other arguments passed to \code{\link[textshape]{split_token}}.
#' @return Returns a vector of stemmed strings.
#' @export
#' @seealso \code{\link[textclean]{stem_words}}
#' @examples 
#' stem_strings(
#'     c(
#'         NA, 
#'         "The doggies, well they aren't joyfully running.", 
#'         "The daddies are coming over...", 
#'         "This is 34.546 above"
#'     )
#' )
stem_strings <- function(x, language = "porter", ...) {

    na_locs <- is.na(x)
    tokens <- textshape::split_token(x, lower = FALSE, ...)
    locs <- textshape::starts(sapply(tokens, length))[-1]
    
    stemmed <- textshape::split_index(stem_words(unlist(tokens), language = language), locs)
    stemmed[na_locs] <- x[na_locs]
    stemmed[!na_locs] <- sapply(stemmed[!na_locs],function(x) {
        gsub("(\\s+)([.!?,;:])", "\\2", paste(x, collapse = " "), perl = TRUE)
    })
    stemmed
}

stem <- function(x, language = "porter") SnowballC::wordStem(x, language)
