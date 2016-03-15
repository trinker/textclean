#' Test for Incomplete Sentences
#' 
#' A logical test of missing sentence ending punctuation.
#' 
#' @param x A character vector.
#' @param endmarks The potential ending punctuation marks
#' @param \dots ignored.
#' @return Returns a logical vector.
#' @keywords incomplete
#' @export
#' @examples
#' x <- c(
#'     "I like it.", 
#'     "Et tu?",  
#'     "Not so much", 
#'     "Oh, I understand.",  
#'     "At 3 p.m., we go"
#' )
#' has_endmark(x)
has_endmark <- function(x, endmarks = c('?', '.', '!'), ...){
    !grepl(sprintf('[%s]\\s*$', paste(endmarks, collapse = "")), x, ...)
}







