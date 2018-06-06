#' Add Missing Endmarks
#' 
#' Detect missing endmarks and replace with the desired symbol.
#' 
#' @param x  The text variable.
#' @param replacement Character string equal in length to pattern or of length 
#' one which are  a replacement for matched pattern.
#' @param endmarks The potential ending punctuation marks.
#' @param \dots Additional arguments passed to 
#' \code{\link[textclean]{has_endmark}}.
#' @return Returns a vector with missing endmarks added.
#' @export
#' @examples 
#' x <- c(
#'     "This in a", 
#'     "I am funny!", 
#'     "An ending of sorts%", 
#'     "What do you want?"
#' )
#' 
#' add_missing_endmark(x)
add_missing_endmark <- function(x, replacement = "|", 
    endmarks = c("?", ".", "!"), ...){

    locs <- which(!has_endmark(x, ...))
    x[locs] <- paste0(x[locs], replacement)
    x

}

