#' Replace Kerned (Spaced) with No Space Version
#' 
#' In typography kerning is the adjustment of spacing.  Often, in informal writing, 
#' adding manual spaces (a form of kerning) coupled with all capital letters is 
#' used for emphasis.  This tool looks for 3 or more consecutive capital letters 
#' with spaces in between and removes the spaces.  Essentially, the capitalized,
#' kerned version is replaced with the word equivalent.
#' 
#' @param x  The text variable.
#' @param \ldots ignored.
#' @return Returns a vector with kern spaces removed.
#' @references \url{https://stackoverflow.com/a/47438305/1000343}
#' @author StackOverflow user @@ctwheels 
#' @export
#' @examples
#' x <- c(
#'     "Welcome to A I: the best W O R L D!",
#'     "Hi I R is the B O M B for sure: we A G R E E indeed.",
#'     "A sort C A T indeed!",
#'     NA
#' )
#' 
#' replace_kern(x)
replace_kern <- function(x, ...){
    ## a possible second approach from: https://stackoverflow.com/a/47438305/1000343
    ## '(?:(?<=\\P{L})(?=(?:\\p{Lu}\\h+){2}\\p{Lu})|\\G(?!\\A))\\p{Lu}\\K\\h+(?=\\p{Lu}(?!\\p{L}))'
    gsub("(?:(?=\\b(?:\\p{Lu}\\h+){2}\\p{Lu})|\\G(?!\\A))\\p{Lu}\\K\\h+(?=\\p{Lu})", "", x, perl=TRUE)
}
