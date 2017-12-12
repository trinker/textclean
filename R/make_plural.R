#' Make Plural (or Verb to Singular) Versions of Words
#' 
#' Add -s, -es, or -ies to words.
#' 
#' @param x A vector of words to make plural.
#' @param keep.original logical.  If \code{TRUE} the original words are kept in 
#' the return vector.
#' @param irregular A \code{data.frame} of singular and plural conversions for 
#' irregular nouns.  The first column should be singular and the second plural 
#' form of the irregular noun.
#' @return Returns a vector of plural words.
#' @keywords plural
#' @export
#' @examples 
#' x <- c('fox', 'sky', 'dog', 'church', 'fish', 'miss', 'match', 'deer', 'block')
#' make_plural(x)
make_plural <- function (x, keep.original = FALSE, 
    irregular = lexicon::pos_df_irregular_nouns) {
   
    stopifnot(is.data.frame(irregular))
    
    hits <- match(tolower(x), tolower(irregular[[1]]))
    
    ends <- "(sh?|x|z|ch)$"
    pluralify <- ifelse(grepl(ends, x), "es", "s")
    out <- gsub("ys$", "ies", paste0(x, pluralify))
    out[which(!is.na(hits))] <- irregular[[2]][hits[which(!is.na(hits))]]
    
    c(if (keep.original) {
        x
    }, out)
    
}
