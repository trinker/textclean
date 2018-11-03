#' Replace Emojis With Words/Identifier
#'
#' Replaces emojis with word equivalents or a token identifier for use in the
#' \pkg{sentimentr} package.  Not that this function will coerce the text to 
#' ASCII using 
#' \code{Encoding(x) <- "latin1"; iconv(x, "latin1", "ASCII", "byte")}.
#' The function \code{replace_emoji} replaces emojis with text representations
#' while \code{replace_emoji_identifier} replaces with a unique identifier that
#' corresponds to \code{lexicon::hash_sentiment_emoji} for use in the 
#' \pkg{sentimentr} package.
#' 
#' @param x The text variable.
#' @param emoji_dt A \pkg{data.table} of emojis (ASCII byte representations)
#' and corresponding word/identifier meanings.  
#' @param \ldots Other arguments passed to \code{.mgsub} (see
#' \code{textclean:::.mgsub} for details).
#' @return Returns a vector of strings with emojis replaced with word
#' equivalents.
#' @keywords emoji
#' @export
#' @rdname replace_emoji
#' @examples
#' fls <- system.file("docs/emoji_sample.txt", package = "textclean")
#' x <- readLines(fls)[1]
#' replace_emoji(x)
#' replace_emoji_identifier(x)
replace_emoji <- function(x, emoji_dt = lexicon::hash_emojis, ...){
    
    gsub("\\s+", " ", .mgsub(emoji_dt[["x"]], paste0(" ", emoji_dt[["y"]], " "), 
        to_byte(x), ...))
    
}

lexicon_available_data <- lexicon::available_data

#' @export
#' @rdname replace_emoji
replace_emoji_identifier <- function(x, 
    emoji_dt = lexicon::hash_emojis_identifier, ...){
    
    gsub("\\s+", " ", .mgsub(emoji_dt[["x"]], paste0(" ", emoji_dt[["y"]], " "), 
        to_byte(x), ...))
    
}


