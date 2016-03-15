#' Remove Escaped Characters
#' 
#' Preprocess data to replace one or more white space character with a single 
#' space.
#' 
#' @param x The character vector.
#' @param \dots ignored.
#' @return Returns a vector of character strings with escaped characters removed.
#' @keywords escaped character
#' @export
#' @examples
#' x <- "I go \r
#'     to   the \tnext line"
#' x
#' replace_white(x)
replace_white <- function(x, ...) {
    gsub("\\s+", " ",  x)
}
