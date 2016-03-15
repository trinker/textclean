#' Replace Non-ASCII Characters
#' 
#' Replaces non-ascii characters.
#' 
#' @param x  The text variable.
#' @param replacement A string to replace incomplete punctuation marks with.
#' @param \dots ignored.
#' @return Returns a text variable (character sting) with non-ascii characters 
#' replaced.
#' @keywords ascii
#' @export
#' @examples
#' x <- c("Hello World", "6 Ekstr\xf8m", "J\xf6reskog", "bi\xdfchen Z\xfcrcher")
#' Encoding(x) <- "latin1"
#' x
#' 
#' replace_non_ascii(x)
#' replace_non_ascii(x, replacement="<<FLAG>>")
replace_non_ascii <-
function(x, replacement = "", ...) {
    gsub('[^ -~]', replacement, x)
}




