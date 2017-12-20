#' Replace Kerning Space with No Space
#' 
#' In typography kerning is the adjustment of spacing.  Often in informal writing 
#' a form of kerning and all capital letters is used for emphasis.  This tool looks 
#' for 3 or mor consecutive capital letters with spaces in between and removes the 
#' spaces.  The kerned version is replaced with the word equivalent.
#' 
#' @param x  The text variable.
#' @param \ldots ignored.
#' @return Returns a vector with kern spaces removed.
#' @references \url{https://stackoverflow.com/a/47438305/1000343}
#' @author StackOverflow user @ctwheels 
#' @export
#' @examples
#' x <- c(
#'     "Welcome to A I: the best W O R L D!",
#'     "Hi I R is the B O M B for sure: we A G R E E indeed.",
#'     "A sort C A T indeed!",
#'     NA
#' )
#' 
#' replace_kerning(x)
replace_kerning <- function(x, ...){
    gsub("(?:(?=\\b(?:\\p{Lu}\\h+){2}\\p{Lu})|\\G(?!\\A))\\p{Lu}\\K\\h+(?=\\p{Lu})", "", x, perl=TRUE)
}