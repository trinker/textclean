#' Swap Two Patterns Simultaneously
#' 
#' Swap pattern x for pattern y and pattern y for pattern x in one fell swoop.
#' 
#' @param x A text variable.
#' @param pattern1 Character string to be matched in the given character vector.
#' This will be replaced by \code{pattern2}.
#' @param pattern2 Character string to be matched in the given character vector.
#' This will be replaced by \code{pattern1}.
#' @param \ldots ignored.
#' @return Returns a vector with patterns 1 & 2 swapped.
#' @export
#' @examples 
#' x <- c("hash_abbreviation", "hash_contractions", "hash_grade", "key_emoticons", 
#'     "key_power", "key_sentiment", "key_sentiment_nrc", "key_strength", 
#'     "key_syllable", "key_valence_shifters")
#' 
#' x
#' swap(x, 'hash_', 'key_')
swap <- function(x, pattern1, pattern2, ...){

    y <- mgsub(x, pattern1, "zzzplaceholderaazzz", ...)
    y <- mgsub(y, pattern2, pattern1,...)
    mgsub(y, "zzzplaceholderaazzz", pattern2,...)

}
